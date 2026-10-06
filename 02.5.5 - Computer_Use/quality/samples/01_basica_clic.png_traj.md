# Muestra: aku_cu_000290
- **Objetivo:** Haz clic en el icono de calc de la barra de tareas.
- **Plataforma/Aplicación:** ubuntu_24_04 / desktop (desktop)
- **Dominio/Tipo/Dificultad/Horizonte:** operating_system · atomic_action · basic · short (2 pasos)
- **Desenlace:** success (verificado: True) · entregables: —
- **Tags:** atomic_action, basic, operating_system, visual_pixels

### Paso 1 · t=0.7s
- **Observación:** Vista: desktop (desktop) en pantalla 1280x720. Cursor en (640, 360). `[screenshot PNG 1280x720, sha256:4d5f623b5c3f…]`
- **Decisión (open_app, estrategia keyboard_first):** Localizo el icono en la barra de tareas y pulso su centro; la posición pertenece al screenshot actual.
- **Acción:** `CLICK` {"button": "left", "x": 202, "y": 698}
  - OpenAI: `[{"type": "click", "button": "left", "x": 202, "y": 698}]`
  - Anthropic: `[{"toolset_name": "computer", "name": "left_click", "input": {"coordinate": [202, 698]}}]`
- **Resultado:** [success] se abre calc
- **Verificación:** ✔ (visual_state) Estado verificado visualmente: calc se abre en primer plano.
### Paso 2 · t=1.7s
- **Observación:** Vista: calc (calc) en pantalla 1280x720. Celda activa: A1; hoja: Hoja1. La interfaz está cargando (no actuar aún). Cursor en (202, 698). `[screenshot PNG 1280x720, sha256:461f74b59402…]`
- **Decisión (wait_for_ui, estrategia mouse_direct):** Espero 0.8 s a que la interfaz termine de cambiar antes de actuar.
- **Acción:** `WAIT` {"ms": 800, "until": "aplicación cargada"}
  - OpenAI: `[{"type": "wait", "time": 0.8}]`
  - Anthropic: `[{"toolset_name": "computer", "name": "wait", "input": {"duration": 0.8}}]`
- **Resultado:** [success] la carga terminó; la interfaz queda estable
- **Verificación:** ✔ (visual_state) El screenshot posterior muestra aplicación estable.
## Recuperaciones

- Sin fallos inyectados en esta trayectoria.

## Verificación final
- Plan: —
- Checks superados: 2/2
- Estado final: calc se abre en primer plano; aplicación estable
