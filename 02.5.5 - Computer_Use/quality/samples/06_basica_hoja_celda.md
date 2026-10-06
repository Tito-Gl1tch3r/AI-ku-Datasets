# Muestra: aku_cu_000397
- **Objetivo:** Pon el valor 15 en la celda C2 de la hoja de cálculo.
- **Plataforma/Aplicación:** windows_11 / calc (calc)
- **Dominio/Tipo/Dificultad/Horizonte:** spreadsheets · atomic_action · basic · short (7 pasos)
- **Desenlace:** success (verificado: True) · entregables: —
- **Tags:** atomic_action, basic, spreadsheets

### Paso 1 · t=0.7s
- **Observación:** Vista: desktop (desktop) en pantalla 1280x720. Cursor en (640, 360). `[observación estructurada sin píxeles]`
- **Decisión (open_app, estrategia keyboard_first):** Abro calc; si tarda en cargar, espero antes de interactuar para no pulsar sobre una interfaz a medio renderizar.
- **Acción:** `KEY` {"keys": ["win"]}
  - OpenAI: `[{"type": "keypress", "keys": ["win"]}]`
  - Anthropic: `[{"toolset_name": "computer", "name": "key", "input": {"text": "win"}}]`
- **Resultado:** [success] menú de inicio abierto con buscador
- **Verificación:** ✔ (visual_state) Confirmado en la observación siguiente: menú de inicio abierto con buscador visible.
### Paso 2 · t=1.5s
- **Observación:** Vista: desktop (desktop) en pantalla 1280x720. Superpuestos activos: start 'Inicio'. Cursor en (640, 360). `[observación estructurada sin píxeles]`
- **Decisión (open_app, estrategia hybrid):** Escribo el contenido en el campo activo; evito enviar Enter hasta verificar que está completo.
- **Acción:** `TYPE` {"text": "calc"}
  - OpenAI: `[{"type": "type", "text": "calc"}]`
  - Anthropic: `[{"toolset_name": "computer", "name": "type", "input": {"text": "calc"}}]`
- **Resultado:** [success] texto introducido en 'start_search'
### Paso 3 · t=1.9s
- **Observación:** Vista: desktop (desktop) en pantalla 1280x720. Superpuestos activos: start 'Inicio'. Cursor en (640, 360). `[observación estructurada sin píxeles]`
- **Decisión (open_app, estrategia keyboard_first):** Confirmo la búsqueda con Enter para lanzar calc.
- **Acción:** `KEY` {"keys": ["enter"]}
  - OpenAI: `[{"type": "keypress", "keys": ["enter"]}]`
  - Anthropic: `[{"toolset_name": "computer", "name": "key", "input": {"text": "Return"}}]`
- **Resultado:** [success] Enter confirmó el diálogo activo
- **Verificación:** ✔ (visual_state) Confirmado en la observación siguiente: ventana de calc abierta y con foco.
### Paso 4 · t=3.0s
- **Observación:** Vista: calc (calc) en pantalla 1280x720. Celda activa: A1; hoja: Hoja1. La interfaz está cargando (no actuar aún). Cursor en (640, 360). `[observación estructurada sin píxeles]`
- **Decisión (wait_for_ui, estrategia mouse_direct):** Espero 0.8 s a que la interfaz termine de cambiar antes de actuar.
- **Acción:** `WAIT` {"ms": 800, "until": "hoja estable"}
  - OpenAI: `[{"type": "wait", "time": 0.8}]`
  - Anthropic: `[{"toolset_name": "computer", "name": "wait", "input": {"duration": 0.8}}]`
- **Resultado:** [success] la carga terminó; la interfaz queda estable
- **Verificación:** ✔ (visual_state) El screenshot posterior muestra rejilla visible y estable.
### Paso 5 · t=4.1s
- **Observación:** Vista: calc (calc) en pantalla 1280x720. Celda activa: C2; hoja: Hoja1. Cursor en (640, 360). `[observación estructurada sin píxeles]`
- **Decisión (set_focus, estrategia hybrid):** Muevo la celda activa a C2 con un clic en la rejilla.
- **Acción:** `CLICK` {"button": "left", "x": 166, "y": 121}
  - OpenAI: `[{"type": "click", "button": "left", "x": 166, "y": 121}]`
  - Anthropic: `[{"toolset_name": "computer", "name": "left_click", "input": {"coordinate": [166, 121]}}]`
- **Resultado:** [success] clic registrado sobre 'rejilla'
- **Verificación:** ✔ (visual_state) Estado verificado visualmente: celda activa C2.
### Paso 6 · t=4.7s
- **Observación:** Vista: calc (calc) en pantalla 1280x720. Celda activa: C2; hoja: Hoja1. Cursor en (166, 121). `[observación estructurada sin píxeles]`
- **Decisión (fill_field, estrategia mouse_direct):** Escribo 15: la entrada queda en la barra de fórmulas y se confirma al mover la celda.
- **Acción:** `TYPE` {"text": "15"}
  - OpenAI: `[{"type": "type", "text": "15"}]`
  - Anthropic: `[{"toolset_name": "computer", "name": "type", "input": {"text": "15"}}]`
- **Resultado:** [success] celda C2 = '15'; celda activa avanza
- **Verificación:** ✔ (formula_recalc) Estado verificado visualmente: C2 = 15 confirmado en la barra de fórmulas.
### Paso 7 · t=5.3s
- **Observación:** Vista: calc (calc) en pantalla 1280x720. Celda activa: C3; hoja: Hoja1. Cursor en (166, 121). `[observación estructurada sin píxeles]`
- **Decisión (verify_result, estrategia keyboard_first):** Verificación final: vuelvo a la celda y compruebo el contenido.
- **Acción:** `CLICK` {"button": "left", "x": 166, "y": 121}
  - OpenAI: `[{"type": "click", "button": "left", "x": 166, "y": 121}]`
  - Anthropic: `[{"toolset_name": "computer", "name": "left_click", "input": {"coordinate": [166, 121]}}]`
- **Resultado:** [success] clic registrado sobre 'rejilla'
- **Verificación:** ✔ (formula_recalc) Confirmado en la observación siguiente: C2 muestra 15.
## Recuperaciones

- Sin fallos inyectados en esta trayectoria.

## Verificación final
- Plan: abrir hoja, ir a la celda, escribir valor, verificar
- Checks superados: 6/6
- Estado final: celda activa C2; C2 = 15 confirmado en la barra de fórmulas; C2 muestra 15
