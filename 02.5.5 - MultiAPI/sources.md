# Fuentes

Registro de fuentes utilizadas para construir el **AI-ku MultiAPI Dataset**.
Fecha de consulta de todas las fuentes: **2026-10-04** (salvo indicación contraria).

## Política de uso

- La documentación se usó como **referencia de hechos** (firmas de campos, nombres de eventos,
  códigos de error, comportamientos). No se copian párrafos ni bloques de documentación al
  dataset; todos los ejemplos son **autoría original** construidos sobre esos hechos.
- Los hechos de una API (nombres de campos, formas de eventos, códigos de estado) son
  elementos funcionales de una interfaz pública y no constituyen contenido creativo protegible;
  aun así, mantenemos la cita de procedencia para auditoría.
- Las fuentes secundarias solo se usaron para localizar/confirmar páginas oficiales o cruzar
  detalles; **ningún hecho del dataset se basa únicamente en fuentes secundarias**.

## Documentación oficial (base de hechos del dataset)

| ID | Fuente | Editor | URL | Uso |
|---|---|---|---|---|
| OAI-01 | Migrate to the Responses API (Responses vs Chat Completions) | OpenAI | https://platform.openai.com/docs/guides/responses-vs-chat-completions | Items, `function_call(_output)`, `previous_response_id`, Conversations API, `text.format` vs `response_format`, diferencias de shape de tools |
| OAI-02 | Function calling guide | OpenAI | https://platform.openai.com/docs/guides/function-calling | Shape plano de tool defs, `strict`, `tool_choice` (`auto`/`none`/`required`/`{type:"function",name}`), ciclo `call_id` |
| OAI-03 | Conversation state guide | OpenAI | https://platform.openai.com/docs/guides/conversation-state | `previous_response_id`, Conversations API, facturación de tokens con estado |
| OAI-04 | Streaming model responses guide | OpenAI | https://platform.openai.com/docs/guides/streaming-responses | Eventos SSE `response.created`, `response.output_text.delta`, `response.completed`, `error` |
| OAI-05 | Error codes guide | OpenAI | https://platform.openai.com/docs/guides/error-codes | Códigos HTTP y causas (401 autenticación, 429 rate limit/quota, 400 petición inválida, 5xx servidor) |
| OAI-06 | Models | OpenAI | https://platform.openai.com/docs/models | Catálogo vigente: `gpt-6-astra` (flagship), `gpt-6.1-sol`, `gpt-6-luna`, `gpt-5.6-cyber` |
| OAI-07 | Assistants migration guide | OpenAI | https://developers.openai.com/api-docs/assistants/migration | Retiro de Assistants API el 2026-08-26; ruta de migración a Responses/Conversations |
| OAI-08 | Responses API reference | OpenAI | https://developers.openai.com/api-reference/responses | Parámetros de `create`, tipos de items, `input` (texto/imágenes/archivos) |
| ANTH-01 | Tool use with Claude | Anthropic | https://docs.claude.com/en/docs/build-with-claude/tool-use | `input_schema`, ciclo `tool_use`/`tool_result`, `tool_choice` + `disable_parallel_tool_use`, server tools (`web_search`, `web_fetch`, `code_execution`, `tool_search`) |
| ANTH-02 | Streaming | Anthropic | https://docs.claude.com/en/docs/build-with-claude/streaming | `message_start`/`content_block_*`/`message_delta`/`message_stop`/`ping`/`error`, deltas `text_delta`, `input_json_delta`, `thinking_delta`, `signature_delta`, `overloaded_error` en stream |
| ANTH-03 | Claude API errors | Anthropic | https://docs.claude.com/en/api/errors | Tabla completa: 400/401/402/403/404/409/413/429/500/529 con `error.type` |
| ANTH-04 | Messages API reference | Anthropic | https://docs.claude.com/en/api/messages | Parámetros (`max_tokens` obligatorio, `system`, `metadata.user_id`, `tool_choice` con `none`), `stop_reason` (7 valores), `output_format` JSON |
| ANTH-05 | Models overview | Anthropic | https://docs.claude.com/en/docs/about-claude/models/overview | Catálogo vigente: `claude-opus-5-5`, `claude-sonnet-5-5`, `claude-haiku-4-5`; strings históricos |
| ANTH-06 | Prompt caching | Anthropic | https://docs.claude.com/en/docs/build-with-claude/prompt-caching | `cache_control` ephemeral, breakpoints, TTL 5 min / 1 h, `cache_creation_input_tokens` / `cache_read_input_tokens` |

## Documentación secundaria (solo para localización/cruce, no base de hechos)

| ID | Fuente | URL |
|---|---|---|
| SEC-01 | "How to stream LLM responses with server-sent events" (confirmación del formato SSE de Responses) | https://flaviocopes.com |
| SEC-02 | Conversations API quickstart (terceros; confirmación del uso de `conversation: "conv_…"`) | https://docs.kindo.ai |
| SEC-03 | Comparativa Responses vs Chat Completions (terceros; confirmación del sunset de Assistants) | https://benchlm.ai |

## Datos propios y sintéticos

| Tipo | Descripción |
|---|---|
| `original_examples` | Ejemplos escritos por el equipo AI-ku para este dataset, con payloads coherentes con las especificaciones citadas arriba. |
| `synthetic_curated` | Variantes generadas y verificadas manualmente a partir de los originales (misma cobertura conceptual, distinta superficie). |
| `official_docs` (source_type) | Se reserva para ejemplos cuyo contenido es una ilustración directa de un hecho verificado en las fuentes oficiales; el payload es original pero el hecho proviene de la fuente citada en `source`. |

## Versiones registradas en el dataset (`api_version_or_snapshot`)

- `responses-2026-10` — OpenAI Responses API, snapshot octubre 2026.
- `chat-completions-2026-10-legacy` — OpenAI Chat Completions, disponible como legacy.
- `assistants-v1-retired-2026-08-26` — OpenAI Assistants API, retirada.
- `messages-2026-10` — Anthropic Messages API, snapshot octubre 2026 (header `anthropic-version: 2023-06-01` vigente).
- `messages-pre-tool-use-legacy` — formato legacy de Anthropic anterior al actual ciclo `tool_use`/`tool_result` (solo casos de discriminación/migración).
