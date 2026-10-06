# Muestra: aku_cu_000106
- **Objetivo:** En «pixel_hunt» (ya abierto), elimina los 5 objetivos que aparecen en la arena.
- **Plataforma/Aplicación:** windows_11 / game (game)
- **Dominio/Tipo/Dificultad/Horizonte:** games · game_control · basic · short (7 pasos)
- **Desenlace:** success (verificado: True) · entregables: pixel_hunt: oleada 5/5
- **Tags:** basic, game_control, games, visual_pixels

### Paso 1 · t=0.7s
- **Observación:** Vista: game (pixel_hunt) en pantalla 1280x720. Cursor en (640, 360). `[screenshot PNG 1280x720, sha256:e4e038b6e09b…]`
- **Decisión (observe_state, estrategia keyboard_first):** Observo la arena: cinco objetivos repartidos en dos alturas; disparo al más aislado para no arrastrar el cursor sobre otros.
- **Acción:** `SCREENSHOT` {}
  - OpenAI: `[{"type": "screenshot"}]`
  - Anthropic: `[{"toolset_name": "computer", "name": "screenshot", "input": {}}]`
- **Resultado:** [success] captura obtenida
### Paso 2 · t=1.6s
- **Observación:** Vista: game (pixel_hunt) en pantalla 1280x720. Cursor en (640, 360). `[screenshot PNG 1280x720, sha256:e4e038b6e09b…]`
- **Decisión (shoot, estrategia hybrid):** Apunto al objetivo 1 en (140, 110) y disparo: el clic debe coincidir con su centro, no con el borde.
- **Acción:** `CLICK` {"button": "left", "x": 140, "y": 110}
  - OpenAI: `[{"type": "click", "button": "left", "x": 140, "y": 110}]`
  - Anthropic: `[{"toolset_name": "computer", "name": "left_click", "input": {"coordinate": [140, 110]}}]`
- **Resultado:** [success] clic registrado sobre 'arena'
- **Verificación:** ✔ (visual_state) Confirmado en la observación siguiente: objetivo 1 eliminado de la arena.
### Paso 3 · t=2.9s
- **Observación:** Vista: game (pixel_hunt) en pantalla 1280x720. Cursor en (140, 110). `[screenshot PNG 1280x720, sha256:4045f0058aa4…]`
- **Decisión (shoot, estrategia hybrid):** Apunto al objetivo 2 en (390, 283) y disparo: el clic debe coincidir con su centro, no con el borde.
- **Acción:** `CLICK` {"button": "left", "x": 390, "y": 283}
  - OpenAI: `[{"type": "click", "button": "left", "x": 390, "y": 283}]`
  - Anthropic: `[{"toolset_name": "computer", "name": "left_click", "input": {"coordinate": [390, 283]}}]`
- **Resultado:** [success] clic registrado sobre 'arena'
- **Verificación:** ✔ (visual_state) El screenshot posterior muestra objetivo 2 eliminado de la arena.
### Paso 4 · t=4.0s
- **Observación:** Vista: game (pixel_hunt) en pantalla 1280x720. Cursor en (390, 283). `[screenshot PNG 1280x720, sha256:337d9087a22a…]`
- **Decisión (shoot, estrategia mouse_direct):** Apunto al objetivo 3 en (640, 116) y disparo: el clic debe coincidir con su centro, no con el borde.
- **Acción:** `CLICK` {"button": "left", "x": 640, "y": 116}
  - OpenAI: `[{"type": "click", "button": "left", "x": 640, "y": 116}]`
  - Anthropic: `[{"toolset_name": "computer", "name": "left_click", "input": {"coordinate": [640, 116]}}]`
- **Resultado:** [success] clic registrado sobre 'arena'
- **Verificación:** ✔ (visual_state) Confirmado en la observación siguiente: objetivo 3 eliminado de la arena.
### Paso 5 · t=4.8s
- **Observación:** Vista: game (pixel_hunt) en pantalla 1280x720. Cursor en (640, 116). `[screenshot PNG 1280x720, sha256:8821a1d48096…]`
- **Decisión (shoot, estrategia mouse_direct):** Apunto al objetivo 4 en (890, 275) y disparo: el clic debe coincidir con su centro, no con el borde.
- **Acción:** `CLICK` {"button": "left", "x": 890, "y": 275}
  - OpenAI: `[{"type": "click", "button": "left", "x": 890, "y": 275}]`
  - Anthropic: `[{"toolset_name": "computer", "name": "left_click", "input": {"coordinate": [890, 275]}}]`
- **Resultado:** [success] clic registrado sobre 'arena'
- **Verificación:** ✔ (visual_state) Confirmado en la observación siguiente: objetivo 4 eliminado de la arena.
### Paso 6 · t=5.8s
- **Observación:** Vista: game (pixel_hunt) en pantalla 1280x720. Cursor en (890, 275). `[screenshot PNG 1280x720, sha256:eec288e2b1fb…]`
- **Decisión (shoot, estrategia keyboard_first):** Apunto al objetivo 5 en (1140, 107) y disparo: el clic debe coincidir con su centro, no con el borde.
- **Acción:** `CLICK` {"button": "left", "x": 1140, "y": 107}
  - OpenAI: `[{"type": "click", "button": "left", "x": 1140, "y": 107}]`
  - Anthropic: `[{"toolset_name": "computer", "name": "left_click", "input": {"coordinate": [1140, 107]}}]`
- **Resultado:** [success] clic registrado sobre 'arena'
- **Verificación:** ✔ (visual_state) Confirmado en la observación siguiente: objetivo 5 eliminado de la arena.
### Paso 7 · t=6.8s
- **Observación:** Vista: game (pixel_hunt) en pantalla 1280x720. Cursor en (1140, 107). `[screenshot PNG 1280x720, sha256:ea31478e7e1f…]`
- **Decisión (verify_result, estrategia hybrid):** Verificación final sobre el HUD: la puntuación y el mensaje del juego deben confirmar el objetivo; la acción ejecutada no es el objetivo conseguido.
- **Acción:** `SCREENSHOT` {}
  - OpenAI: `[{"type": "screenshot"}]`
  - Anthropic: `[{"toolset_name": "computer", "name": "screenshot", "input": {}}]`
- **Resultado:** [success] captura obtenida
- **Verificación:** ✔ (visual_state) El screenshot posterior muestra HUD final: 125 puntos y «oleada completada».
## Recuperaciones

- Sin fallos inyectados en esta trayectoria.

## Verificación final
- Plan: observar oleada, eliminar cada objetivo, verificar HUD
- Checks superados: 6/6
- Estado final: objetivo 4 eliminado de la arena; objetivo 5 eliminado de la arena; HUD final: 125 puntos y «oleada completada»
