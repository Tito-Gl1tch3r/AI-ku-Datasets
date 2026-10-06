# AI-ku MultiAPI Dataset

Dataset de entrenamiento de alta calidad para enseñar a **AI-ku** a comunicarse correctamente
mediante dos ecosistemas de API de modelos: **OpenAI (Responses API)** y **Anthropic (Messages API)**.

> **Principio rector**: la API es una interfaz/protocolo. AI-ku sigue siendo AI-ku
> independientemente de la interfaz por la que hable. El objetivo no es memorizar
> "OpenAI = JSON A / Anthropic = JSON B", sino aprender a **identificar la interfaz por su
> estructura, aplicar su protocolo sin mezclarlo con el otro, y corregir cuando algo falla**.

**Snapshot de especificaciones**: octubre 2026 (verificación contra documentación oficial;
ver `sources.md`).

## Capacidades que entrena

1. **Reconocimiento de API** — a partir de payloads, eventos de streaming, errores, ids y
   metadatos; incluye expresar **incertidumbre** cuando la evidencia no basta.
2. **Comprensión estructural** — equivalencias y NO-equivalencias (instructions↔system,
   function_call_output↔tool_result, cached_tokens↔cache_read_input_tokens, audio, caching…).
3. **Conversión semántica** — la misma intención representada correctamente en cada interfaz,
   en ambos sentidos, con las claves y shapes nativos de cada uno.
4. **Diferenciación activa** — pares contrastivos con mezclas plausibles, detección y corrección.
5. **Tool calling / ciclo agentic** — definición, llamada, resultado, paralelismo, errores de
   negocio, validación de argumentos, recuperación de ids huérfanos, cambio de estrategia.
6. **Streaming** — flujos de eventos de ambos protocolos, acumulación tipada, errores en medio
   del stream, finales (completed/incomplete/failed/error vs message_delta/message_stop).
7. **Errores y recuperación** — clasificación por planos (payload / servicio / capacidad /
   desconocido) con la política correcta por clase.
8. **Versiones** — Assistants API retirada (26-08-2026), Chat Completions legacy, formato
   legacy de herramientas de Anthropic, cadenas de versión y snapshots de modelo.
9. **Multimodalidad** — imágenes, PDFs y límites reales (el audio de entrada no existe en
   Messages ni en Responses; la generación de imágenes solo en OpenAI).
10. **Estado** — `previous_response_id`/Conversations (`conv_…`) frente a stateless + caché
    explícita (`cache_control`), bifurcación, migración entre ecosistemas.
11. **Planificación agentic** — fingerprinting del runtime, capa de abstracción propia,
    orquestación multi-protocolo, identidad independiente de la interfaz.

## Filosofía de calidad

- **Calidad > cantidad (absoluto)**: 150 ejemplos de autoría curada; cada uno enseña una
  habilidad concreta. Cero inflado: sin reformulaciones triviales ni variantes cosméticas.
- **Diversidad conceptual**, no superficial: los datos cubren 12 tipos de tarea, 5 grupos
  contrastivos de 4 miembros, negativos adversariales plausibles con explicación verificable
  y corrección, y 2 casos de incertidumbre honesta.
- **Verificado contra fuentes primarias**: los hechos del dataset (formas de eventos, códigos
  de error, nombres de parámetros, modelos vigentes) fueron contrastados con la documentación
  oficial en la fecha del snapshot (ver `sources.md`). Los payloads de las **respuestas
  correctas** (`target`) se validan estructuralmente con los scripts de `validation/`.
- **Negativos adversariales pero plausibles**: errores que un modelo razonable cometería
  (usar `input_schema` en OpenAI, `msg_` como discriminador, `is_error` para errores HTTP),
  nunca errores absurdos.
- **Sin chain-of-thought privado**: las justificaciones son análisis estructural original,
  no razonamiento extraído de otros modelos.

## Estructura del repositorio

```
AI-ku_MultiAPI/
├── README.md                  ← este archivo
├── sources.md                 ← registro de fuentes y versiones
├── LICENSE                    ← licencia del dataset
├── requirements.txt
├── dataset/
│   ├── aiku_multiapi-train.parquet            (91)
│   ├── aiku_multiapi-validation.parquet       (20)
│   ├── aiku_multiapi-test.parquet             (29)
│   ├── aiku_multiapi-adversarial_test.parquet (10)
│   └── schema.json                            (esquema machine-readable)
├── scripts/
│   ├── build_dataset.py       ← reconstruye los Parquet desde los módulos de datos
│   ├── fix_nested_json.py     ← herramienta de higiene (escapado JSON anidado)
│   └── data/                  ← 12 módulos de contenido (d01…d12) + _common.py
├── validation/
│   ├── validate_all.py        ← validación integral (informe txt/json)
│   ├── checks.py              ← clasificador de payloads + detectores de mezcla
│   └── validation_report.txt / .json
├── eval/
│   ├── benchmark.jsonl        ← 30 ítems NUEVOS (12 dimensiones + generalización)
│   ├── answer_key.jsonl       ← respuestas de referencia
│   ├── run_benchmark.py       ← harness (auto-grading + rúbricas + self-check)
│   └── _build_benchmark.py    ← regenera los JSONL
└── docs/
    ├── api_notes_openai.md    ← hechos verificados OpenAI Responses API
    ├── api_notes_anthropic.md ← hechos verificados Anthropic Messages API
    ├── esquema.md             ← documentación de columnas y valores
    ├── metodologia.md         ← diseño, splits, negativos, planos de fallo
    └── cobertura.md           ← matrices de cobertura
```

## Esquema (resumen)

18 columnas orientadas a entrenamiento y auditoría (detalle completo en `docs/esquema.md`):

| Columna | Tipo | Contenido |
|---|---|---|
| `id` | string | Identificador estable (prefijo por capacidad: `rec-`, `map-`, `cnv-`, `ctr-`, `tool-`, `str-`, `err-`, `rep-`, `ver-`, `mm-`, `st-`, `plan-`) |
| `split` | string | `train` / `validation` / `test` / `adversarial_test` |
| `task_type` | string | Taxonomía cerrada de 12 capacidades |
| `api` | string | `openai` / `anthropic` / `both` / `unknown` |
| `api_version_or_snapshot` | string | Snapshot del contrato (p. ej. `responses-2026-10`, `messages-2026-10`) |
| `intent` | string | Objetivo del ejemplo en una frase |
| `context` | string | Escenario de runtime (quién llama, qué evidencia hay) |
| `input` | string | Datos presentados al modelo (payloads/eventos/errores; pueden contener mezclas **a propósito**, que es lo que se enseña a detectar) |
| `expected_behavior` | string | Criterios que una buena respuesta debe cubrir |
| `target` | string | Respuesta ideal: análisis + payload/acción correcta + corrección. Sus bloques JSON son **protocolo limpio** (validado) |
| `difficulty` | string | `easy` / `medium` / `hard` / `adversarial` |
| `source`, `source_type` | string | Procedencia (ver `sources.md`) |
| `validation_status` | string | `validated` / `needs_review` |
| `quality_notes` | string | Notas de calidad del ejemplo |
| `skills` | list\<string\> | Descriptores finos multi-label para auditoría y filtrado |
| `contrast_pair_id` | string? | Id del grupo contrastivo (sus miembros viajan SIEMPRE al mismo split) |
| `negative` | struct? | `{attempt, why_wrong, correction}` — negativo embebido |

## Cómo cargarlo

```python
import pandas as pd

train = pd.read_parquet("dataset/aiku_multiapi-train.parquet")
val   = pd.read_parquet("dataset/aiku_multiapi-validation.parquet")
test  = pd.read_parquet("dataset/aiku_multiapi-test.parquet")
adv   = pd.read_parquet("dataset/aiku_multiapi-adversarial_test.parquet")

# dataset lógico completo
full = pd.concat([train, val, test, adv], ignore_index=True)
full["task_type"].value_counts()
```

Con `datasets` (Hugging Face):

```python
from datasets import load_dataset
ds = load_dataset("parquet", data_files={
    "train": "dataset/aiku_multiapi-train.parquet",
    "validation": "dataset/aiku_multiapi-validation.parquet",
    "test": "dataset/aiku_multiapi-test.parquet",
    "adversarial_test": "dataset/aiku_multiapi-adversarial_test.parquet",
})
```

## Cómo validarlo

```bash
pip install -r requirements.txt
python3 validation/validate_all.py       # informe en validation/validation_report.txt
```

El validador comprueba: esquema y campos obligatorios, validez JSON de los bloques ```json`,
consistencia de API (los `target` deben ser protocolo limpio según el ecosistema reclamado),
ausencia de mezclas en las correcciones, duplicados, vacíos, integridad de grupos contrastivos,
leakage entre splits, distribución por tarea/API/dificultad, presencia de negativos, y
coherencia de fuentes y versiones contra `sources.md`. Estado actual: **0 errores** (1 warning
documentado: el `input` híbrido de `ctr-g2-mix` es material didáctico intencional).

Para reconstruir los Parquet desde los módulos de contenido:

```bash
python3 scripts/build_dataset.py
```

## Cómo entrenar con él

Formato conversacional recomendado (SFT): `context` + `input` → turno del usuario;
`target` → respuesta del asistente; `expected_behavior` como guía del prompt de sistema de
entrenamiento. Sugerencia de prompt de sistema que preserva la identidad:

> "Eres AI-ku. La interfaz de API que uses es un protocolo de transporte, no tu identidad:
> identifica la interfaz disponible por su evidencia estructural, aplica su protocolo sin
> mezclarlo con otros, usa herramientas cuando aporten datos, detecta y corrige errores,
> y mantén tu objetivo y tu comportamiento en cualquier ecosistema."

Recomendaciones:
- Entrena con `train` (91) y ajusta hiperparámetros mirando `validation` (20).
- Reserva `test` (29) para la evaluación final y **no** lo toques durante el desarrollo.
- `adversarial_test` (10) sirve para medir resistencia a mezclas y falsos amigos: un modelo
  que memoriza plantillas fallará aquí.
- Los `skills` permiten filtrar el train por habilidad (p. ej. solo ciclos de herramientas o
  solo streaming) para entrenamientos focados.

## Cómo ejecutar la evaluación

```bash
# 1) self-check del harness (las referencias deben puntuar 1.0 en los ítems auto)
python3 eval/run_benchmark.py --self-check

# 2) evaluar un modelo: genera predicciones JSONL {"id": "...", "answer": "..."}
python3 eval/run_benchmark.py --predictions respuestas.jsonl --out reporte.json
```

- 30 ítems **nuevos** (no copias del entrenamiento) que cubren las 12 dimensiones de evaluación
  del brief: identificación, incertidumbre, generación por API, conversión, mezclas, tool
  calling, continuación tras tool result, detección/corrección de errores, versiones,
  preservación de significado y generalización a estructuras no vistas (MCP, `pause_turn`,
  server tools, migración de estado…).
- 27 ítems son auto-calificables (substrings, JSON parseable, validación estructural de los
  payloads generados reutilizando los validadores de `validation/checks.py`).
- 3 ítems son de rúbrica (identidad, planificación, planos de fallo): se califican con juez
  humano o LLM-judge usando los criterios incluidos.

## Cobertura (resumen)

| task_type | ejemplos | | api | ejemplos |
|---|---|---|---|---|
| tool_calling | 20 | | both | 62 |
| contrastive_discrimination | 20 | | anthropic | 44 |
| error_handling | 16 | | openai | 42 |
| semantic_conversion | 14 | | unknown | 2 |
| streaming | 13 | | | |
| api_recognition | 12 | | dificultad | |
| structural_mapping | 12 | | medium | 76 |
| multimodal | 10 | | hard | 48 |
| protocol_repair | 10 | | easy | 14 |
| state_management | 8 | | adversarial | 12 |
| versioning | 8 | | | |
| agentic_planning | 7 | | | |

Negativos: 9 `negative` embebidos + 5 miembros "mix" contrastivos + 12 adversariales.
Cobertura detallada en `docs/cobertura.md`.

## Versiones de API utilizadas

- **OpenAI Responses API** — snapshot `responses-2026-10`; modelos vigentes usados:
  `gpt-6-astra` (flagship), `gpt-6.1-sol`, `gpt-6-luna`; generación previa `gpt-5.6-cyber`.
- **OpenAI Chat Completions** — `chat-completions-2026-10-legacy` (solo discriminación/migración).
- **OpenAI Assistants API** — `assistants-v1-retired-2026-08-26` (solo casos de migración).
- **Anthropic Messages API** — snapshot `messages-2026-10` (header `anthropic-version: 2023-06-01`);
  modelos vigentes usados: `claude-opus-5-5`, `claude-sonnet-5-5`, `claude-haiku-4-5`.
- **Anthropic legacy** — `messages-pre-tool-use-legacy` (solo discriminación de versiones).

## Limitaciones

1. **Tamaño**: 150 ejemplos priorizan profundidad conceptual sobre volumen; un modelo puede
   necesitar más variaciones superficiales para generalizar de forma robusta (por diseño,
   esas variantes NO se inflaron aquí).
2. **Snapshot**: las capacidades multimodales, modelos y betas evolucionan rápido; la matriz
   de capacidades es válida para octubre 2026 y debe re-verificarse antes de extenderla.
3. **Contenido en español** con payloads canónicos en inglés: si el despliegue de AI-ku exige
   comprensión de instrucciones en inglés, conviene generar una variante bilingüe del
   lenguaje natural (los payloads no cambian).
4. **Streaming representado como arrays de eventos** `{event, data}`: fiel al orden y
   estructura de los SSE reales, pero omite el formato de línea cruda (`event:`/`data:`),
   que se explica en los ejemplos pero no se entrena byte a byte.
5. **Server tools cubiertas de forma conceptual** (web_search en ambos; no se enumeran todos
   los parámetros de cada built-in).
6. **Idempotencia del entrenamiento**: los casos adversariales son finitos; un modelo puede
   sobreajustar a los patrones adversariales concretos — la evaluación de generalización
   (ítems b22/b25/b27/b29/b30) existe precisamente para detectarlo.

## Fuentes y licencia

- Registro completo de fuentes oficiales y secundarias, con URLs, fecha de consulta y uso:
  **`sources.md`**. Ninguna porción de documentación se copió al dataset; los hechos de las
  APIs se usan como referencia funcional con procedencia registrada.
- Licencia del dataset y del código: **CC-BY-4.0** (ver `LICENSE`).
