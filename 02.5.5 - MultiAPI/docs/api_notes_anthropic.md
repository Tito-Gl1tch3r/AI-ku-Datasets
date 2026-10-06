# Notas de especificación — Anthropic Messages API

Snapshot de investigación: **2026-10-04**. Todas las afirmaciones de este documento fueron
verificadas contra la documentación oficial (ver `sources.md`, entradas `ANTH-*`).
Este documento resume los hechos que el dataset utiliza como verdad de referencia.
No reproduce texto de la documentación: solo registra firmas estructurales y comportamientos.

## Identificación de la interfaz

| Aspecto | Valor verificado |
|---|---|
| Endpoint | `POST https://api.anthropic.com/v1/messages` |
| Cabeceras | `x-api-key`, `anthropic-version` (cadena de versión vigente: `2023-06-01`), `content-type` |
| Modelo de estado | Sin estado (stateless): cada petición reenvía el historial completo |
| Modelo flagship vigente | `claude-opus-5-5` |
| Otros modelos vigentes | `claude-sonnet-5-5`, `claude-haiku-4-5` (generaciones anteriores: `claude-opus-4-5`, `claude-sonnet-4-5-20250929`) |

## Parámetros de petición

- `model` (obligatorio), **`max_tokens` (obligatorio)** — su ausencia produce `400 invalid_request_error`.
- `messages`: array de turnos; roles válidos **solo `user` y `assistant`**. No existe rol `system`
  dentro de `messages` (las instrucciones de sistema van en el parámetro de nivel superior `system`).
- `system`: string o array de bloques `{type: "text", text, cache_control?}` — parámetro de nivel superior.
- `tools`: array de `{name, description, input_schema}` — el esquema de entrada se llama
  **`input_schema`** (JSON Schema). No existe campo `parameters` en la definición de tool.
- `tool_choice`: `{type: "auto"}` / `{type: "any"}` / `{type: "tool", name}` / `{type: "none"}`,
  todos con `disable_parallel_tool_use` opcional.
- `stop_sequences` (no `stop`), `temperature`, `top_p`, `top_k`, `stream`, `metadata` (solo `user_id`),
  `thinking` `{type: "enabled", budget_tokens}` (el budget debe ser menor que `max_tokens`),
  `output_format` / formato JSON estructurado con `schema` (soporte JSON out del modelo).

## Bloques de contenido

- `text`, `image` (source `base64` con `media_type` image/jpeg|png|gif|webp, o source `url`),
  `document` (PDF; base64/url), `tool_use`, `tool_result`, `thinking` (con `signature`),
  `redacted_thinking`, y bloques de server tools (`server_tool_use`, `web_search_tool_result`).
- **`tool_result` va SIEMPRE dentro de un mensaje con rol `user`**, inmediatamente después del
  turno `assistant` que contiene el bloque `tool_use` correspondiente. Campos:
  `{type: "tool_result", tool_use_id, content: string | bloques text/image, is_error?}`.
- Los argumentos de la herramienta llegan como objeto en `tool_use.input`; en streaming se
  acumulan mediante fragmentos `input_json_delta.partial_json` que se parsean al cerrar el bloque.

## Respuesta y condiciones de parada

- Objeto: `{id: "msg_01…", type: "message", role: "assistant", model, content: [bloques],
  stop_reason, stop_sequence, usage}`.
- `stop_reason` (valores verificados): `end_turn`, `max_tokens`, `stop_sequence`, `tool_use`,
  `pause_turn`, `refusal`, `model_context_window_exceeded`.
- `usage`: `{input_tokens, output_tokens, cache_creation_input_tokens, cache_read_input_tokens, …}`;
  detalle de salida incluye `thinking_tokens`.
- `max_tokens` alcanzado **no es un error**: es un `stop_reason` normal.

## Streaming (SSE)

Eventos verificados (nombre `event:` + `data.type` coinciden):

1. `message_start` (Message con `content` vacío)
2. `content_block_start` (índice + bloque inicial)
3. `content_block_delta` (delta: `text_delta` / `input_json_delta` / `thinking_delta` /
   `signature_delta`; la firma precede a `content_block_stop` en bloques `thinking`)
4. `content_block_stop`
5. `message_delta` (`delta.stop_reason`, `usage.output_tokens` acumulado)
6. `message_stop`
7. `ping` (mantener viva la conexión; se ignora)
8. `error` — puede llegar **en medio del stream** (p. ej. `overloaded_error`, que en
   no-streaming corresponde a HTTP 529).

## Errores (verificados)

| HTTP | `error.type` | Causa típica |
|---|---|---|
| 400 | `invalid_request_error` | formato/contenido de la petición |
| 401 | `authentication_error` | API key inválida/revocada |
| 402 | `billing_error` | facturación/pago |
| 403 | `permission_error` | sin permisos sobre el recurso |
| 404 | `not_found_error` | recurso/endpoint inexistente |
| 409 | `conflict_error` | conflicto con estado actual |
| 413 | `request_too_large` | petición excede tamaño máximo |
| 429 | `rate_limit_error` | rate limit / spend cap |
| 500 | `api_error` | fallo interno de Anthropic |
| 529 | `overloaded_error` | servicio sobrecargado (único de Anthropic) |

Cuerpo de error: `{type: "error", error: {type, message}}`.

## Prompt caching

- Marcadores explícitos `cache_control: {type: "ephemeral"}` (breakpoints), con TTL de
  **5 minutos o 1 hora**.
- Hasta 4 breakpoints; el orden del prefijo cacheado es tools → system → messages.
- Métricas: `cache_creation_input_tokens` (escritura) y `cache_read_input_tokens` (lectura).

## Capacidades multimodales (relevantes para discriminación)

- Imagen: soportada (base64 o URL). PDF: soportado (bloque `document`).
- **Audio: NO soportado como entrada** en Messages API (a fecha del snapshot).
- Salida de imágenes: no generada por el modelo base (usa server tools si procede).

## Server tools (ejecución en infraestructura de Anthropic)

`web_search`, `web_fetch`, `code_execution`, `tool_search` — el cliente no ejecuta nada:
los resultados llegan como bloques (`server_tool_use` / `web_search_tool_result`) y no se
envían `tool_result` manuales para estas herramientas.
