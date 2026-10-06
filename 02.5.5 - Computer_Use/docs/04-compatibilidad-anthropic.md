# 04 — Compatibilidad con Anthropic

## Superficie representada

El dataset representa el toolset cliente **`computer_toolset_20260801`** según la documentación oficial (septiembre de 2026): una única entrada `{"type": "computer_toolset_20260801"}` expone **17 herramientas miembro**; cada llamada es un bloque `tool_use` cuyo `name` es el miembro y que lleva `"toolset_name": "computer"`, frecuentemente varias por turno (**batch action**). Las coordenadas —`coordinate`, `start_coordinate`, `region`— están **siempre en píxeles del screenshot recibido**. El toolset sucede a `computer_20251124`.

## Los 17 miembros y su correspondencia semántica

| Miembro | Entrada | Origen semántico |
|---|---|---|
| `screenshot` | `{}` | `SCREENSHOT` |
| `zoom` | `region: [x0,y0,x1,y1]` | `ZOOM` |
| `left_click` / `right_click` / `middle_click` | `coordinate?`, `text?` (modificadores) | `CLICK` (button) |
| `double_click` / `triple_click` | `coordinate?` | `DOUBLE_CLICK` / `TRIPLE_CLICK` |
| `left_click_drag` | `start_coordinate`, `coordinate`, `text?` | `DRAG` |
| `mouse_move` | `coordinate` | `MOVE_CURSOR` |
| `left_mouse_down` / `left_mouse_up` | `{}` | drags que `left_click_drag` no expresa |
| `cursor_position` | `{}` | utilidad de anclaje |
| `scroll` | `scroll_direction`, `scroll_amount`, `coordinate?` | `SCROLL` |
| `type` | `text` | `TYPE` |
| `key` | `text` ("ctrl+s", "alt+Tab"), `repeat?` | `KEY` |
| `hold_key` | `text`, `duration` (s ≤ 300) | `HOLD_KEY` (nativo) |
| `wait` | `duration` (s ≤ 300) | `WAIT` |

## Misma capacidad semántica, distinta superficie

El núcleo no memoriza "Anthropic = esto": cada paso lleva en `action.adapters.anthropic.calls` su proyección exacta al toolset (miembro + input + `toolset_name`), generada por el mismo traductor que proyecta a OpenAI. Ejemplo: la intención *abrir el menú contextual* aprende que puede viajar como `right_click{coordinate}` (Anthropic) o `click{button:"right"}` (OpenAI), o como `key{text:"shift+F10"}` en ambas: la estrategia es del agente; el formato, del adaptador.

## Detalles que el dataset enseña explícitamente

- **Batch actions**: intenciones que se materializan como varias llamadas miembro en un turno.
- **zoom para percepción**: las trayectorias usan `zoom` cuando el texto/controles pequeños no son legibles en el screenshot completo, antes de decidir coordenadas (validado por el tag `zoom_use`).
- **hold_key nativo** para control de juegos, con la acción concurrente documentada.
- **seguridad**: los mismos ejemplos incluyen las recomendaciones oficiales del toolset — sandbox, confirmación humana de acciones con consecuencias y pantalla como contenido no confiable — incorporadas al esquema (`sandboxed`, `risk`, `irreversible`, `ask_human`).

Cobertura: 100 % de los 9.629 pasos.
