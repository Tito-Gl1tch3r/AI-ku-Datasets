# Notas de especificación — OpenAI Responses API

Snapshot de investigación: **2026-10-04**. Todas las afirmaciones de este documento fueron
verificadas contra la documentación oficial (ver `sources.md`, entradas `OAI-*`).
Resume los hechos que el dataset usa como verdad de referencia; no reproduce texto de la doc.

## Identificación de la interfaz

| Aspecto | Valor verificado |
|---|---|
| Endpoint | `POST https://api.openai.com/v1/responses` |
| Autenticación | `Authorization: Bearer <OPENAI_API_KEY>` |
| Modelo de estado | Con estado opcional: `store`, `previous_response_id`, y **Conversations API** (`conv_…`, se envía con el parámetro `conversation`) |
| Modelo flagship vigente | `gpt-6-astra` |
| Otros modelos vigentes | `gpt-6.1-sol` (equilibrio inteligencia/coste), `gpt-6-luna`, generación previa `gpt-5.6-cyber` |

## Petición

- `input`: string **o** array de *Items* (unidad básica de contexto, distinta del `Message`
  monolítico de Chat Completions).
  - Item `message`: `{type: "message", role, content}` con roles `system`, `developer`, `user`,
    `assistant`; `content` puede ser string o array de partes (`input_text`, `input_image`,
    `input_file`).
  - Item `function_call`: `{type, id: "fc_…", call_id: "call_…", name, arguments}` —
    `arguments` es un **string JSON**.
  - Item `function_call_output`: `{type, call_id, output}` — respuesta del cliente a un
    `function_call`; `output` es string (JSON o texto plano).
  - Item `reasoning` (contexto de razonamiento; en modo stateless se usa contenido cifrado).
- `instructions`: guía a nivel de sistema (equivale funcional al `system` de Anthropic, con
  otra forma y otra semántica de persistencia).
- `tools`: definición de función **plana**: `{type: "function", name, description, parameters,
  strict}` — NO anidada bajo una clave `function` (eso es Chat Completions).
- `tool_choice`: `"auto"` / `"none"` / `"required"` / `{"type": "function", "name": "…"}`;
  existe además el concepto de restringir llamadas a un subconjunto (`allowed_tools`).
- `text.format` para salidas estructuradas (**no** `response_format`, que es de Chat Completions).
- `max_output_tokens`, `temperature`, `top_p`, `stream`, `store`, `parallel_tool_calls`,
  `reasoning` (`effort`, `summary`), `metadata` (mapa libre), `background` (modo asíncrono).
- Entrada multimodal soportada: **texto, imágenes y archivos. El audio NO es un tipo de
  entrada de Responses API** (el audio como entrada pertenece a endpoints/modelos específicos
  de audio vía Chat Completions; no confundir con salida de audio).

## Respuesta

- Objeto `{id: "resp_…", object: "response", status, output: [Items], usage, …}`.
- `status`: `queued` / `in_progress` / `completed` / `failed` / `incomplete`.
- Corte por longitud **no es un error**: `status: "incomplete"` con
  `incomplete_details: {reason: "max_output_tokens"}`.
- `usage`: `{input_tokens, output_tokens, total_tokens, input_tokens_details: {cached_tokens},
  output_tokens_details: {reasoning_tokens}}`.
- `output_text` es una **comodidad del SDK** (agrega los `output_text` de los items); el JSON
  crudo del endpoint contiene `output: [...]`, no un campo `output_text` plano.
- Billed tokens: incluso encadenando con `previous_response_id`, todos los tokens de entrada
  previos se facturan como input en cada turno.

## Ciclo de herramientas (client-side functions)

1. El modelo emite item `function_call` (con `call_id`).
2. El cliente ejecuta la función y devuelve un item `function_call_output` con el mismo `call_id`.
3. Con `previous_response_id` basta enviar solo los `function_call_output`; en modo stateless
   hay que reenviar también el item `function_call` original (o usar contenido cifrado de
   razonamiento si aplica).
4. Los **built-in tools** (`web_search`, `file_search`, `code_interpreter`, `image_generation`,
   `mcp`, `computer_use_preview`) se ejecutan del lado del servidor: el output contiene items
   como `web_search_call` y NO se les envía `function_call_output`.

## Streaming (SSE)

Formato verificado: eventos SSE con nombre (`event: response.…`) y `data.type` idéntico al
nombre del evento. Secuencia típica de texto:

1. `response.created`
2. `response.in_progress`
3. `response.output_item.added` → `response.content_part.added`
4. `response.output_text.delta` (campo `delta`) → … → `response.output_text.done`
5. `response.content_part.done` → `response.output_item.done`
6. `response.completed` (incluye el objeto `response` completo)

Para function calls: `response.output_item.added` (item `function_call`) +
`response.function_call_arguments.delta` (fragmentos del string JSON) +
`response.function_call_arguments.done`. Eventos de fallo: `response.failed`,
`response.incomplete`, y evento genérico `error`.

## Errores

- Envoltorio: `{error: {message, type, code, param}}`.
- Tipos habituales: `invalid_request_error` (400), autenticación inválida (401),
  `insufficient_quota` / rate limit (429), `server_error` (5xx). Autenticación 401 →
  no reintentar sin corregir la key; 429 → respetar retry-after/backoff.

## Interfaces históricas (para discriminación de versiones)

- **Chat Completions** (`/v1/chat/completions`): sigue disponible como interfaz legacy:
  `messages` + roles `system`/`user`/`assistant`/`tool`, tool defs anidadas
  `{type:"function", function:{name, parameters}}`, respuesta en `choices[].message`,
  `finish_reason` (`stop`/`length`/`tool_calls`/`content_filter`), audio de entrada con
  modelos de audio vía parte `input_audio`, streaming por chunks `delta` terminado en `data: [DONE]`.
- **Assistants API**: retirada el **26 de agosto de 2026** (threads/runs/vector stores).
  No es una interfaz vigente; solo aparece en el dataset como caso de migración a Responses.

## Conversations API

- Conversaciones persistentes identificadas por `conv_…`; se usan enviando
  `conversation` en la petición a `/v1/responses`; los items de entrada/salida se registran
  en la conversación automáticamente.
