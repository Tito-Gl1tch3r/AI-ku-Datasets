# 05 · Estructura del dataset SFT

> Todo este dataset es **para el SFT de AI-ku** (fase 2 del pipeline:
> Merge ✓ → **SFT** → ROUTER → OMNI → prompt baking → MTP x4 → RL condicional).
> Formato pensado para consumo directo por el entrenador, con variantes generadas por script.

## 1. Contrato de tokens V4X (innegociable)

```
<|V4X_think>   … razonamiento …   <V4X_thought|>
```

- Apertura EXACTA `<|V4X_think>`; cierre EXACTO `<V4X_thought|>`; en ese orden; asimétricos.
- Ejemplos de esfuerzo `none` (cola trivial) **no contienen ninguna de las dos cadenas**.
- `scripts/validate_jsonl.py` hace cumplir este contrato (falla si hay cierre sin apertura,
  apertura sin cierre, orden invertido, o `effort: none` con bloques de think).

## 2. Esquema JSONL

```json
{
  "id": "aiku-v1-ver-0001",
  "meta": {
    "classes": ["B", "H"],              // clasificación A–H (docs/04)
    "loop_phases": ["verification", "correction"],
    "task_family": "coding-terminal",
    "effort": "high",                    // none | low | mid | high | ado
    "difficulty": 4,                     // 1..5, estratificación de la Cadena 4
    "lane_hints": ["qwen-coder", "phi-reasoning"],
    "dialect": "canonical",              // canonical | anthropic | openai
    "acs_variant": false,                // true = historial purgado
    "counterfactual_of": null,           // id del ejemplo del que es variante
    "language": "es",
    "provenance": "original-synthetic",  // NUNCA "copied"
    "license": "CC-BY-4.0",
    "injection": null                    // descriptores de trampas sembradas
  },
  "messages": [ {"role": "system|user|assistant|tool", "content": "…"} ]
}
```

Reglas:
- `provenance: original-synthetic` obligatorio; ningún ejemplo replica ítems de benchmarks.
- `injection` documenta qué trampa lleva sembrada (auditable, evita contaminación accidental).
- Tool calls en `dialect: canonical` (representación neutra del runtime); los dialectos
  `anthropic`/`openai` se derivan con `build_variants.py --mode dialect`.

## 3. Taxonomía de ejemplos (14 en `data/taxonomy.json`)

**Dimensión 1 — Fase del bucle de decisión** (multi-etiqueta):
`comprehension · requirements · strategy_selection · tool_selection · execution ·
observation · verification · correction · adaptation · completion`

**Dimensión 2 — Familia de tarea**:
`coding-terminal · coding-build · data-analysis · research-web · professional-es ·
math-science · ops-sre · creative-writing · multimodal-omni (fase posterior)`

**Dimensión 3 — Esfuerzo/dificultad**: `none(1) · low(2) · mid(3) · high(4) · ado(5)`
— el par (effort, difficulty) debe ser consistente salvo casos de *mismatch etiquetado*
(p. ej. `effort: none` en dificultad 2 por ser mecánica) que enseñan la función, no el mapa.

**Dimensión 4 — Modificadores**:
`CF-*` (contrafáctico) · `INJ-*` (fallo/trampa inyectada) · `ACS-*` (historial purgado) ·
`DIA-*` (variante de dialecto) · `MV` (múltiples soluciones válidas) · `U` (incertidumbre explícita)

## 4. Contenido del bloque `<|V4X_think>`

El razonamiento visible modela el bucle de decisión, nunca relleno:
1. Re-anclaje (objetivo + restricciones + criterio de done)
2. Requisitos y supuestos explícitos
3. Estrategia elegida **con alternativas descartadas y por qué**
4. Criterios de abandono (qué evidencia mataría esta estrategia)
5. (post-observación) lectura honesta del resultado, verificación ejecutada o aplazada con criterio
6. (final) estado durable: decisiones, estado actual, siguiente paso

En esfuerzo `none`: sin bloque. En `low`: 1-3 líneas. En `ado`: estructura completa con
auto-crítica rúbricada.

## 5. Proporciones recomendadas (v1, router-aware)

| Bloque | % tokens | Familias | Alimenta |
|---|---|---|---|
| Trazas agénticas multi-paso (bucle completo con herramientas) | 30% | coding-terminal, ops-sre, coding-build | B, lanes Qwen |
| Contracfácticos + patch-trap + pivotes | 15% | coding, data | B (P3, V2) |
| Verificación/autocorrección con anomalías sembradas | 12% | data-analysis, coding | B (V1-V3) |
| Think adaptivo estratificado (incl. 8-10% del TOTAL en cola trivial `none`) | 12% | todas | A (C4) |
| Horizonte largo + variantes ACS | 10% | coding-build, research | B (P2), G (ACS) |
| Research profundo con triaje (ES) | 8% | research-web | B (C7) |
| Profesional ES con citas | 5% | professional-es | A, E (C6) |
| Replay general/chat/español neutro (recovery del merge) | 5% | chat | A (re-homogeneización) |
| Persona AI-ku + identidad + honestidad epistémica | 3% | transversal | baking posterior |

**Balanceo router-aware**: estos % YA están sesgados hacia tool-calls (lanes 129-176) y
razonamiento profundo (lane 177) frente a la distribución natural. Medir activación de lanes
por época y corregir el muestreo (mecanismo H).

## 6. Contrato ACS (jinja) y qué exige al dataset

ACS vive en el jinja del runtime: tras completar una tarea, purga el razonamiento histórico
dejando decisiones y restricciones. El dataset **acompaña** ese contrato:

1. **Sesiones multi-tarea** donde el historial intermedio llega YA purgado (el modelo debe
   continuar sin referencias muertas y re-anclando objetivo+restricciones).
2. **Generación gratuita**: `build_variants.py --mode acs` produce la variante purgada de
   cualquier sesión larga (no consume recolección nueva).
3. **Restricciones = estado durable**: jamás se purgan; si una purga las tocara, la traza
   correcta las re-declara (lección AISI).

## 7. Criterios de calidad (quality bar)

- **Originalidad**: 0 ítems de benchmarks; scanner de n-gramas contra benchmarks públicos en QA.
- **Informatividad**: cada ejemplo entrena ≥1 patrón de `docs/03` con contraste (no obediencia).
- **Variedad mínima por familia**: ≥1 variante CF, ≥1 INJ, ≥1 MV, ≥1 U por cada 20 ejemplos.
- **Consistencia (effort, difficulty)**: mapa explícito + mismatches etiquetados.
- **Paridad de dialecto**: comportamiento idéntico entre `anthropic`/`openai` (eval dialect_parity).
- **ACS-limpieza**: en variantes purgadas, cero referencias a pensamientos inexistentes (regex + eval).
- **10.000 informativos > millones redundantes**: el seed v1 (~15 ejemplos canónicos +
  variantes) define el molde; el escalado replica el molde, no el relleno.
