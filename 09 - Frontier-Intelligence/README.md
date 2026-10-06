# AI-ku Frontier Intelligence Research

**Investigación competitiva de modelos frontier → capacidades transferibles → dataset SFT original para AI-ku V4X Thinker Max.**

> La pregunta central no es "¿cómo hacemos que AI-ku imite a Gemini 4 / Fable / GPT-6?".
> Es: **¿qué hacen estos sistemas cuando funcionan excepcionalmente bien, qué hacen cuando
> fallan, qué principios podemos extraer de ambos casos y cómo enseñárselos a AI-ku de forma
> original y generalizable?**

---

## Qué es este repositorio

Este proyecto estudia los modelos frontier actuales (Gemini 4 Argón, GPT-6 Astra, GPT-6.1 Sol,
Claude Fable 5.1, Claude Opus 5.5, y el frente abierto: GLM-5.3, DeepSeek V4/V4.1, Kimi K3,
Qwen 3.8, MiMo V2.6) para extraer **principios de decisión transferibles**, no imitaciones.

No se copian respuestas, trazas privadas, prompts propietarios ni datos de terceros.
Cada ejemplo de entrenamiento de este repo es **original** y está diseñado para entrenar la
*capacidad subyacente*, no la tarea concreta donde se observó.

## Entregables (mapa de los 19 requisitos → archivos)

| # | Requerimiento | Archivo |
|---|---|---|
| 1 | Mapa competitivo de capacidades | `docs/01-mapa-competitivo.md` |
| 2 | Fortalezas de cada modelo | `docs/01-mapa-competitivo.md` §2 |
| 3 | Fallos de cada modelo | `docs/01-mapa-competitivo.md` §3 |
| 4 | Capacidades transferibles a AI-ku | `docs/02-hipotesis-capacidades.md` |
| 5 | Capacidades NO transferibles directamente | `docs/02-hipotesis-capacidades.md` §5 |
| 6 | Patrones agénticos a enseñar | `docs/03-patrones-entrenables.md` |
| 7 | Patrones de autocorrección/verificación | `docs/03-patrones-entrenables.md` §2 |
| 8 | Patrones de uso de herramientas | `docs/03-patrones-entrenables.md` §3 |
| 9 | Ideas para Skills | `docs/04-clasificacion-ideas.md` §2 |
| 10 | Ideas para expertos | `docs/04-clasificacion-ideas.md` §3 |
| 11 | Ideas para router | `docs/04-clasificacion-ideas.md` §4 |
| 12 | Ideas de arquitectura/runtime | `docs/04-clasificacion-ideas.md` §5 |
| 13 | Estructura del dataset | `docs/05-estructura-dataset.md` |
| 14 | Taxonomía de ejemplos | `docs/05-estructura-dataset.md` §3 + `data/taxonomy.json` |
| 15 | Proporciones recomendadas | `docs/05-estructura-dataset.md` §5 |
| 16 | Ejemplos completos originales | `data/examples/*.jsonl` |
| 17 | Evaluaciones inéditas de transferencia | `docs/06-evaluaciones-ineditas.md` + `evals/` |
| 18 | Riesgos: overfitting, contaminación, imitación | `docs/07-riesgos.md` |
| 19 | Prioridad experimental | `docs/08-prioridad-experimental.md` |

Metodología y registro de fuentes con fecha y tipo (oficial / independiente / tercero /
comunidad): `docs/09-metodologia-fuentes.md` y `research/fuentes/registro-fuentes.md`.

## Estructura

```
AI-ku-Frontier-Intelligence-Research/
├── README.md                     ← este archivo
├── LICENSE / DATA_LICENSE        ← MIT (código) · CC-BY-4.0 (datos)
├── docs/                         ← análisis, hipótesis, taxonomía, metodología
├── data/
│   ├── taxonomy.json             ← taxonomía machine-readable + proporciones
│   └── examples/*.jsonl          ← muestras SFT originales (formato V4X)
├── evals/                        ← especificaciones + skeletons de evaluaciones inéditas
├── scripts/
│   ├── validate_jsonl.py         ← validación de esquema + tokens V4X exactos
│   └── build_variants.py         ← generador de variantes ACS (purga) y bilingües
└── research/
    ├── fuentes/                  ← registro de fuentes con fecha y tipo
    └── raw/                      ← capturas JSON de búsquedas/páginas (reproducibilidad)
```

## Contrato de formato V4X (innegociable)

Los bloques de razonamiento usan tokens personalizados **exactamente así**, en este orden:

```
<|V4X_think>   ... razonamiento ...   <V4X_thought|>
```

- Apertura: `<|V4X_think>` · Cierre: `<V4X_thought|>` (asimétricos, como están definidos).
- Un ejemplo **sin** bloque de razonamiento (modo sin pensar) no debe contener ninguna de las dos cadenas.
- ACS (AI-ku Context Saver) vive en el **jinja/chat-template** del runtime: el dataset
  acompaña ese contrato con sesiones de historial purgado (ver `docs/05-estructura-dataset.md` §6).

## Cómo usar este repo

1. Lee `docs/05-estructura-dataset.md` para el esquema JSONL y las proporciones.
2. Valida cualquier JSONL antes de entrenar: `python scripts/validate_jsonl.py data/examples/*.jsonl`
3. Genera variantes (purga ACS, re-serialización bilingüe de tool calls):
   `python scripts/build_variants.py --input data/examples/v1_seed_agentic.jsonl --outdir data/derived/`
4. Las especificaciones de evaluación están en `evals/` con skeletons ejecutables.

## Estado

- [x] Investigación competitiva con fuentes
- [x] Hipótesis de capacidades y mecanismos
- [x] Taxonomía y clasificación A–H
- [x] Estructura, taxonomía y proporciones del dataset
- [x] Muestras seed originales (v1)
- [x] Evaluaciones inéditas (specs + skeletons)
- [x] Riesgos y prioridad experimental
- [ ] Escalado a 10.000 ejemplos (siguiente fase, tras validar seed con el router)

## Licencias

- Código (`scripts/`, `evals/`): MIT — ver `LICENSE`.
- Datos y documentación: CC-BY-4.0 — ver `DATA_LICENSE`.
- Todas las muestras de `data/examples/` son originales; las referencias a benchmarks y
  modelos son nominativas y citadas con fuente.
