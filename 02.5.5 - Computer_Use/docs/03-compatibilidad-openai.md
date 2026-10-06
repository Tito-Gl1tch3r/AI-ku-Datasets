# 03 — Compatibilidad con OpenAI

## Superficie representada

El dataset representa la interfaz actual de Computer Use de OpenAI según la documentación oficial consultada (septiembre de 2026): la herramienta `computer` en el **Responses API** (`tools: [{type: "computer"}]`). El modelo devuelve `computer_call` con un **array ordenado de acciones**, la aplicación las ejecuta en orden y devuelve el estado actualizado (normalmente un screenshot) mediante `computer_call_output`, continuando la conversación. La primera llamada puede contener solo `screenshot`; el estado de cada llamada es `completed` aunque su ejecución siga pendiente del cliente.

## Action space mapeado

| Acción OpenAI | Núcleo semántico de origen |
|---|---|
| `click {button, x, y}` | `CLICK` (left/right/middle→wheel) |
| `double_click {x, y}` | `DOUBLE_CLICK` |
| `drag {path: [{x,y}…]}` | `DRAG` (se reconstruye la trayectoria) |
| `move {x, y}` | `MOVE_CURSOR` |
| `scroll {scroll_x, scroll_y, x?, y?}` | `SCROLL` (dirección+ticks → ejes) |
| `keypress {keys: [...]}` | `KEY` |
| `type {text}` | `TYPE` |
| `wait` | `WAIT` |
| `screenshot` | `SCREENSHOT` |

## Emulaciones documentadas (campo `notes`)

Tres primitivas semánticas carecen de equivalente nativo y el adaptador las emite con notas explícitas, para que el modelo aprenda la diferencia entre capacidad semántica y superficie de API:

- `TRIPLE_CLICK` → tres `click` consecutivos en el mismo `computer_call` (acciones ordenadas).
- `HOLD_KEY` → `keypress` + `wait` + nota: el hold real exige handler de cliente (keydown/keyup nativo).
- `ZOOM` → `screenshot` + nota: recorte de la región del lado del cliente.

## Qué enseña el dataset sobre el flujo OpenAI

Las trayectorias modelan el bucle completo `intención → computer_call → acciones → ejecución → screenshot → análisis → siguiente computer_call`. Los ejemplos enseñan explícitamente que **una acción no implica éxito**: cada `computer_call_output` se analiza contra la expectativa (`result.status: success|unexpected`), y los resultados inesperados activan el ciclo de diagnóstico en lugar de la repetición ciega. Cada paso incluye la llamada equivalente exacta en `action.adapters.openai.calls`, lista para entrenar tanto el núcleo como la proyección a esta API. Cobertura: 100 % de los 9.629 pasos.
