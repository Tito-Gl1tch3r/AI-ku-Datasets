# Esquema del dataset

Esquema PyArrow canónico (también en `dataset/schema.json`). 18 columnas, todas con propósito
de entrenamiento o auditoría; sin columnas decorativas.

## Columnas

| Columna | Tipo PyArrow | Nulable | Descripción |
|---|---|---|---|
| `id` | string | no | Identificador estable. Prefijos por módulo: `rec-` reconocimiento, `map-` mapeo estructural, `cnv-` conversión, `ctr-` contrastivos, `tool-` tool calling, `str-` streaming, `err-` errores, `rep-` reparación, `ver-` versiones, `mm-` multimodal, `st-` estado, `plan-` planificación. |
| `split` | string | no | `train` / `validation` / `test` / `adversarial_test`. Coincide con el shard donde vive el ejemplo. |
| `task_type` | string | no | Taxonomía cerrada (12 valores, ver abajo). |
| `api` | string | no | `openai`, `anthropic`, `both`, `unknown`. `both` = el ejemplo protagoniza las dos interfaces (conversión, contrastivos, planificación). `unknown` = casos de incertidumbre honesta. |
| `api_version_or_snapshot` | string | no | Registro cerrado: `responses-2026-10`, `chat-completions-2026-10-legacy`, `assistants-v1-retired-2026-08-26`, `messages-2026-10`, `messages-pre-tool-use-legacy`, `both-current`. |
| `intent` | string | no | Objetivo del ejemplo en una frase. |
| `context` | string | no | Escenario: quién llama, qué evidencia de runtime hay, restricciones. |
| `input` | string | no | Datos presentados al modelo. Puede contener payloads mezclados/erróneos **a propósito** (material de auditoría). |
| `expected_behavior` | string | no | Criterios verificables de una respuesta correcta. |
| `target` | string | no | Respuesta ideal: análisis estructural + payload/acción correcta + corrección cuando aplica. Sus bloques JSON son protocolo limpio (validados). |
| `difficulty` | string | no | `easy` / `medium` / `hard` / `adversarial`. |
| `source` | string | no | Id de `sources.md` (p. ej. `OAI-01`, `ANTH-04`) o `aiku-original`. |
| `source_type` | string | no | `official_docs` / `secondary_docs` / `original_examples` / `synthetic_curated`. |
| `validation_status` | string | no | `validated` (todo el dataset) / `needs_review` (reservado). |
| `quality_notes` | string | no | Notas de calidad o limitaciones del ejemplo concreto (puede quedar vacío). |
| `skills` | list\<string\> | no | Descriptores finos multi-label (365 únicos) para filtrado fino y auditoría. La cobertura de cobertura nominal se mide sobre `task_type`. |
| `contrast_pair_id` | string | sí | Id del grupo contrastivo (`g1-tools`, `g2-toolround`, `g3-system`, `g4-image`, `g5-stream`). Nulo fuera de los grupos. |
| `negative` | struct | sí | `{attempt: string, why_wrong: string, correction: string}` — intento plausible-incorrecto, motivo verificable y corrección. |

## Taxonomía `task_type` (cerrada)

| Valor | Módulo | # |
|---|---|---|
| `api_recognition` | d01 | 12 |
| `structural_mapping` | d02 | 12 |
| `semantic_conversion` | d03 | 14 |
| `contrastive_discrimination` | d04 | 20 |
| `tool_calling` | d05 | 20 |
| `streaming` | d06 | 13 |
| `error_handling` | d07 | 16 |
| `protocol_repair` | d08 | 10 |
| `versioning` | d09 | 8 |
| `multimodal` | d10 | 10 |
| `state_management` | d11 | 8 |
| `agentic_planning` | d12 | 7 |

## Convención de formatos dentro de los textos

- Payloads, eventos y errores: bloques ```` ```json ```` (parseables; validados donde aplica).
- Streams: array de objetos `{"event": <nombre>, "data": <payload>}` — mapeo directo a las
  líneas `event:`/`data:` de SSE reales, manteniendo el orden y la semántica.
- Prosa en español; claves, valores y vocabulario de protocolo en inglés (es el idioma del
  wire format).

## Mapeo a formato de entrenamiento (SFT)

```
system:    prompt de identidad de AI-ku (ver README §Cómo entrenar) [+ expected_behavior como criterio]
user:      context + "\n\n" + input
assistant: target
```

Para entrenamientos focados por habilidad, filtra por `task_type` o por `skills`.
Los miembros de un grupo contrastivo NO deben separarse entre shards (ya garantizado).
