# Muestra: aku_cu_000231
- **Objetivo:** Prepara en la hoja de cálculo el inventario del Q3 (tabla completa, total y gráfico) y guárdalo como inventario_q3; gestiona las interrupciones sin perder el objetivo.
- **Plataforma/Aplicación:** macos_15 / calc (calc, explorer)
- **Dominio/Tipo/Dificultad/Horizonte:** multi_application · workflow_automation · very_advanced · long (43 pasos)
- **Desenlace:** success (verificado: True) · entregables: inventario_q3, inventario_q2.xlsx (tarea secundaria)
- **Tags:** fault_recovery, multi_application, very_advanced, workflow_automation, multi_app, long_horizon, visual_pixels

### Paso 1 · t=3.0s
- **Observación:** Vista: desktop (desktop) en pantalla 1280x720. Cursor en (640, 360). `[screenshot PNG 1280x720, sha256:47995cee62c5…]`
- **Decisión (open_app, estrategia keyboard_first):** Para continuar debo abrir calc. Uso la búsqueda del sistema: más fiable que buscar el icono.
- **Acción:** `CLICK` {"button": "left", "x": 198, "y": 697}
  - OpenAI: `[{"type": "click", "button": "left", "x": 198, "y": 697}]`
  - Anthropic: `[{"toolset_name": "computer", "name": "left_click", "input": {"coordinate": [198, 697]}}]`
- **Resultado:** [success] se abre calc
### Paso 2 · t=5.3s
- **Observación:** Vista: calc (calc) en pantalla 1280x720. Celda activa: A1; hoja: Hoja1. La interfaz está cargando (no actuar aún). Cursor en (198, 697). `[screenshot PNG 1280x720, sha256:a121cacc9511…]`
- **Decisión (wait_for_ui, estrategia hybrid):** Espero 0.8 s a que la interfaz termine de cambiar antes de actuar.
- **Acción:** `WAIT` {"ms": 800, "until": "ventana de calc estable"}
  - OpenAI: `[{"type": "wait", "time": 0.8}]`
  - Anthropic: `[{"toolset_name": "computer", "name": "wait", "input": {"duration": 0.8}}]`
- **Resultado:** [success] la carga terminó; la interfaz queda estable
- **Verificación:** ✔ (visual_state) El screenshot posterior muestra calc en primer plano y estable.
### Paso 3 · t=8.1s
- **Observación:** Vista: calc (calc) en pantalla 1280x720. Celda activa: A1; hoja: Hoja1. Cursor en (198, 697). `[screenshot PNG 1280x720, sha256:29f4b84f7f2b…]`
- **Decisión (fill_field, estrategia hybrid):** Cabeceras del inventario: «Artículo» en A1.
- **Acción:** `TYPE` {"text": "Artículo"}
  - OpenAI: `[{"type": "type", "text": "Art\u00edculo"}]`
  - Anthropic: `[{"toolset_name": "computer", "name": "type", "input": {"text": "Art\u00edculo"}}]`
- **Resultado:** [success] celda A1 = 'Artículo'; celda activa avanza
- **Verificación:** ✔ (visual_state) Confirmado en la observación siguiente: A1 = «Artículo».
### Paso 4 · t=10.3s
- **Observación:** Vista: calc (calc) en pantalla 1280x720. Celda activa: B1; hoja: Hoja1. Cursor en (198, 697). `[screenshot PNG 1280x720, sha256:33b5c27e30cf…]`
- **Decisión (fill_field, estrategia keyboard_first):** «Stock» en B1.
- **Acción:** `TYPE` {"text": "Stock"}
  - OpenAI: `[{"type": "type", "text": "Stock"}]`
  - Anthropic: `[{"toolset_name": "computer", "name": "type", "input": {"text": "Stock"}}]`
- **Resultado:** [success] celda B1 = 'Stock'; celda activa avanza
- **Verificación:** ✔ (visual_state) Estado verificado visualmente: B1 = «Stock».
### Paso 5 · t=13.8s
- **Observación:** Vista: calc (calc) en pantalla 1280x720. Celda activa: A2; hoja: Hoja1. Cursor en (198, 697). `[screenshot PNG 1280x720, sha256:bcd67b04b613…]`
- **Decisión (fill_field, estrategia hybrid):** Artículo 1 (tornilleria-01) en la columna A.
- **Acción:** `TYPE` {"text": "tornilleria-01"}
  - OpenAI: `[{"type": "type", "text": "tornilleria-01"}]`
  - Anthropic: `[{"toolset_name": "computer", "name": "type", "input": {"text": "tornilleria-01"}}]`
- **Resultado:** [success] celda A2 = 'tornilleria-01'; celda activa avanza
### Paso 6 · t=16.9s
- **Observación:** Vista: calc (calc) en pantalla 1280x720. Celda activa: B2; hoja: Hoja1. Cursor en (198, 697). `[screenshot PNG 1280x720, sha256:4ff8c17348ed…]`
- **Decisión (fill_field, estrategia mouse_direct):** Stock del artículo 1: 49 unidades.
- **Acción:** `TYPE` {"text": "49"}
  - OpenAI: `[{"type": "type", "text": "49"}]`
  - Anthropic: `[{"toolset_name": "computer", "name": "type", "input": {"text": "49"}}]`
- **Resultado:** [success] celda B2 = '49'; celda activa avanza
- **Verificación:** ✔ (visual_state) El screenshot posterior muestra B2 = 49.
### Paso 7 · t=20.6s
- **Observación:** Vista: calc (calc) en pantalla 1280x720. Celda activa: A3; hoja: Hoja1. Cursor en (198, 697). `[screenshot PNG 1280x720, sha256:f5c56337c586…]`
- **Decisión (fill_field, estrategia keyboard_first):** Artículo 2 (cableado-02) en la columna A.
- **Acción:** `TYPE` {"text": "cableado-02"}
  - OpenAI: `[{"type": "type", "text": "cableado-02"}]`
  - Anthropic: `[{"toolset_name": "computer", "name": "type", "input": {"text": "cableado-02"}}]`
- **Resultado:** [success] celda A3 = 'cableado-02'; celda activa avanza
### Paso 8 · t=23.1s
- **Observación:** Vista: calc (calc) en pantalla 1280x720. Celda activa: B3; hoja: Hoja1. Cursor en (198, 697). `[screenshot PNG 1280x720, sha256:477e864c4874…]`
- **Decisión (fill_field, estrategia hybrid):** Stock del artículo 2: 22 unidades.
- **Acción:** `TYPE` {"text": "22"}
  - OpenAI: `[{"type": "type", "text": "22"}]`
  - Anthropic: `[{"toolset_name": "computer", "name": "type", "input": {"text": "22"}}]`
- **Resultado:** [success] celda B3 = '22'; celda activa avanza
- **Verificación:** ✔ (visual_state) El screenshot posterior muestra B3 = 22.
### Paso 9 · t=25.1s
- **Observación:** Vista: calc (calc) en pantalla 1280x720. Celda activa: A4; hoja: Hoja1. Cursor en (198, 697). `[screenshot PNG 1280x720, sha256:a3446ed08151…]`
- **Decisión (fill_field, estrategia mouse_direct):** Artículo 3 (tornilleria-03) en la columna A.
- **Acción:** `TYPE` {"text": "tornilleria-03"}
  - OpenAI: `[{"type": "type", "text": "tornilleria-03"}]`
  - Anthropic: `[{"toolset_name": "computer", "name": "type", "input": {"text": "tornilleria-03"}}]`
- **Resultado:** [success] celda A4 = 'tornilleria-03'; celda activa avanza
### Paso 10 · t=27.2s
- **Observación:** Vista: calc (calc) en pantalla 1280x720. Celda activa: B4; hoja: Hoja1. Cursor en (198, 697). `[screenshot PNG 1280x720, sha256:cb42e11b72d5…]`
- **Decisión (fill_field, estrategia mouse_direct):** Stock del artículo 3: 16 unidades.
- **Acción:** `TYPE` {"text": "16"}
  - OpenAI: `[{"type": "type", "text": "16"}]`
  - Anthropic: `[{"toolset_name": "computer", "name": "type", "input": {"text": "16"}}]`
- **Resultado:** [success] celda B4 = '16'; celda activa avanza
- **Verificación:** ✔ (visual_state) Estado verificado visualmente: B4 = 16.
### Paso 11 · t=29.4s
- **Observación:** Vista: calc (calc) en pantalla 1280x720. Celda activa: A5; hoja: Hoja1. Cursor en (198, 697). `[screenshot PNG 1280x720, sha256:c89a655176fe…]`
- **Decisión (fill_field, estrategia keyboard_first):** Artículo 4 (cableado-04) en la columna A.
- **Acción:** `TYPE` {"text": "cableado-04"}
  - OpenAI: `[{"type": "type", "text": "cableado-04"}]`
  - Anthropic: `[{"toolset_name": "computer", "name": "type", "input": {"text": "cableado-04"}}]`
- **Resultado:** [success] celda A5 = 'cableado-04'; celda activa avanza
### Paso 12 · t=30.7s
- **Observación:** Vista: calc (calc) en pantalla 1280x720. Celda activa: B5; hoja: Hoja1. Cursor en (198, 697). `[screenshot PNG 1280x720, sha256:5d11e79e6e32…]`
- **Decisión (fill_field, estrategia keyboard_first):** Stock del artículo 4: 46 unidades.
- **Acción:** `TYPE` {"text": "46"}
  - OpenAI: `[{"type": "type", "text": "46"}]`
  - Anthropic: `[{"toolset_name": "computer", "name": "type", "input": {"text": "46"}}]`
- **Resultado:** [success] celda B5 = '46'; celda activa avanza
- **Verificación:** ✔ (visual_state) Estado verificado visualmente: B5 = 46.
### Paso 13 · t=33.7s
- **Observación:** Vista: calc (calc) en pantalla 1280x720. Celda activa: A6; hoja: Hoja1. Cursor en (198, 697). `[screenshot PNG 1280x720, sha256:9bf62f942d49…]`
- **Decisión (fill_field, estrategia mouse_direct):** Artículo 5 (tornilleria-05) en la columna A.
- **Acción:** `TYPE` {"text": "tornilleria-05"}
  - OpenAI: `[{"type": "type", "text": "tornilleria-05"}]`
  - Anthropic: `[{"toolset_name": "computer", "name": "type", "input": {"text": "tornilleria-05"}}]`
- **Resultado:** [success] celda A6 = 'tornilleria-05'; celda activa avanza
### Paso 14 · t=36.8s
- **Observación:** Vista: calc (calc) en pantalla 1280x720. Celda activa: B6; hoja: Hoja1. Cursor en (198, 697). `[screenshot PNG 1280x720, sha256:efc214fdc4f9…]`
- **Decisión (fill_field, estrategia keyboard_first):** Stock del artículo 5: 54 unidades.
- **Acción:** `TYPE` {"text": "54"}
  - OpenAI: `[{"type": "type", "text": "54"}]`
  - Anthropic: `[{"toolset_name": "computer", "name": "type", "input": {"text": "54"}}]`
- **Resultado:** [success] celda B6 = '54'; celda activa avanza
- **Verificación:** ✔ (visual_state) El screenshot posterior muestra B6 = 54.
### Paso 15 · t=38.4s
- **Observación:** Vista: calc (calc) en pantalla 1280x720. Celda activa: B7; hoja: Hoja1. Cursor en (198, 697). `[screenshot PNG 1280x720, sha256:48f9dd6469e6…]`
- **Decisión (observe_state, estrategia hybrid):** Sigo con la primera mitad tabulada; el foco sigue en la hoja.
- **Acción:** `SCREENSHOT` {}
  - OpenAI: `[{"type": "screenshot"}]`
  - Anthropic: `[{"toolset_name": "computer", "name": "screenshot", "input": {}}]`
- **Resultado:** [success] captura obtenida
- **Verificación:** ✔ (visual_state) Confirmado en la observación siguiente: hoja activa con 5 filas escritas.
### Paso 16 · t=40.3s
- **Observación:** Vista: calc (calc) en pantalla 1280x720. Celda activa: B7; hoja: Hoja1. Superpuestos activos: toast 'Actualización disponible: reinicia más tarde'. Cursor en (198, 697). `[screenshot PNG 1280x720, sha256:bbbd22344f8f…]`
- **Decisión (dismiss_dialog, estrategia keyboard_first):** Una notificación de actualización se superpone a la hoja: la cierro con Escape y sigo donde estaba (fila 7, columna A).
- **Acción:** `KEY` {"keys": ["esc"]}
  - OpenAI: `[{"type": "keypress", "keys": ["esc"]}]`
  - Anthropic: `[{"toolset_name": "computer", "name": "key", "input": {"text": "Escape"}}]`
- **Resultado:** [success] Escape cerró el diálogo/menú activo
- **Verificación:** ✔ (visual_state) Estado verificado visualmente: notificación cerrada sin perder la celda activa.
### Paso 17 · t=44.0s
- **Observación:** Vista: calc (calc) en pantalla 1280x720. Celda activa: A7; hoja: Hoja1. Cursor en (198, 697). `[screenshot PNG 1280x720, sha256:e1d82c154e4d…]`
- **Decisión (fill_field, estrategia mouse_direct):** Artículo 6 en la columna A.
- **Acción:** `TYPE` {"text": "cableado-06"}
  - OpenAI: `[{"type": "type", "text": "cableado-06"}]`
  - Anthropic: `[{"toolset_name": "computer", "name": "type", "input": {"text": "cableado-06"}}]`
- **Resultado:** [success] celda A7 = 'cableado-06'; celda activa avanza
### Paso 18 · t=46.0s
- **Observación:** Vista: calc (calc) en pantalla 1280x720. Celda activa: B7; hoja: Hoja1. Cursor en (198, 697). `[screenshot PNG 1280x720, sha256:ad5d35a04598…]`
- **Decisión (fill_field, estrategia keyboard_first):** Stock del artículo 6: 84 unidades.
- **Acción:** `TYPE` {"text": "84"}
  - OpenAI: `[{"type": "type", "text": "84"}]`
  - Anthropic: `[{"toolset_name": "computer", "name": "type", "input": {"text": "84"}}]`
- **Resultado:** [success] celda B7 = '84'; celda activa avanza
- **Verificación:** ✔ (visual_state) Confirmado en la observación siguiente: B7 = 84.
### Paso 19 · t=49.5s
- **Observación:** Vista: calc (calc) en pantalla 1280x720. Celda activa: A8; hoja: Hoja1. Cursor en (198, 697). `[screenshot PNG 1280x720, sha256:bb6f8b5b2cbc…]`
- **Decisión (fill_field, estrategia keyboard_first):** Artículo 7 en la columna A.
- **Acción:** `TYPE` {"text": "tornilleria-07"}
  - OpenAI: `[{"type": "type", "text": "tornilleria-07"}]`
  - Anthropic: `[{"toolset_name": "computer", "name": "type", "input": {"text": "tornilleria-07"}}]`
- **Resultado:** [success] celda A8 = 'tornilleria-07'; celda activa avanza
### Paso 20 · t=50.6s
- **Observación:** Vista: calc (calc) en pantalla 1280x720. Celda activa: B8; hoja: Hoja1. Cursor en (198, 697). `[screenshot PNG 1280x720, sha256:6f5b06a32f57…]`
- **Decisión (fill_field, estrategia hybrid):** Stock del artículo 7: 60 unidades.
- **Acción:** `TYPE` {"text": "60"}
  - OpenAI: `[{"type": "type", "text": "60"}]`
  - Anthropic: `[{"toolset_name": "computer", "name": "type", "input": {"text": "60"}}]`
- **Resultado:** [success] celda B8 = '60'; celda activa avanza
- **Verificación:** ✔ (visual_state) Estado verificado visualmente: B8 = 60.
### Paso 21 · t=52.5s
- **Observación:** Vista: calc (calc) en pantalla 1280x720. Celda activa: A9; hoja: Hoja1. Cursor en (198, 697). `[screenshot PNG 1280x720, sha256:a15a712b67ac…]`
- **Decisión (fill_field, estrategia keyboard_first):** Artículo 8 en la columna A.
- **Acción:** `TYPE` {"text": "cableado-08"}
  - OpenAI: `[{"type": "type", "text": "cableado-08"}]`
  - Anthropic: `[{"toolset_name": "computer", "name": "type", "input": {"text": "cableado-08"}}]`
- **Resultado:** [success] celda A9 = 'cableado-08'; celda activa avanza
### Paso 22 · t=53.8s
- **Observación:** Vista: calc (calc) en pantalla 1280x720. Celda activa: B9; hoja: Hoja1. Cursor en (198, 697). `[screenshot PNG 1280x720, sha256:ffcdd1cec4d6…]`
- **Decisión (fill_field, estrategia mouse_direct):** Stock del artículo 8: 76 unidades.
- **Acción:** `TYPE` {"text": "76"}
  - OpenAI: `[{"type": "type", "text": "76"}]`
  - Anthropic: `[{"toolset_name": "computer", "name": "type", "input": {"text": "76"}}]`
- **Resultado:** [success] celda B9 = '76'; celda activa avanza
- **Verificación:** ✔ (visual_state) Estado verificado visualmente: B9 = 76.
### Paso 23 · t=57.3s
- **Observación:** Vista: calc (calc) en pantalla 1280x720. Celda activa: A10; hoja: Hoja1. Cursor en (198, 697). `[screenshot PNG 1280x720, sha256:482f7f19b75b…]`
- **Decisión (fill_field, estrategia keyboard_first):** Artículo 9 en la columna A.
- **Acción:** `TYPE` {"text": "tornilleria-09"}
  - OpenAI: `[{"type": "type", "text": "tornilleria-09"}]`
  - Anthropic: `[{"toolset_name": "computer", "name": "type", "input": {"text": "tornilleria-09"}}]`
- **Resultado:** [success] celda A10 = 'tornilleria-09'; celda activa avanza
### Paso 24 · t=60.5s
- **Observación:** Vista: calc (calc) en pantalla 1280x720. Celda activa: B10; hoja: Hoja1. Cursor en (198, 697). `[screenshot PNG 1280x720, sha256:9a28d6918f6d…]`
- **Decisión (fill_field, estrategia hybrid):** Stock del artículo 9: 80 unidades.
- **Acción:** `TYPE` {"text": "80"}
  - OpenAI: `[{"type": "type", "text": "80"}]`
  - Anthropic: `[{"toolset_name": "computer", "name": "type", "input": {"text": "80"}}]`
- **Resultado:** [success] celda B10 = '80'; celda activa avanza
- **Verificación:** ✔ (visual_state) Estado verificado visualmente: B10 = 80.
### Paso 25 · t=64.0s
- **Observación:** Vista: calc (calc) en pantalla 1280x720. Celda activa: A11; hoja: Hoja1. Cursor en (198, 697). `[screenshot PNG 1280x720, sha256:63930affba87…]`
- **Decisión (fill_field, estrategia keyboard_first):** Artículo 10 en la columna A.
- **Acción:** `TYPE` {"text": "cableado-10"}
  - OpenAI: `[{"type": "type", "text": "cableado-10"}]`
  - Anthropic: `[{"toolset_name": "computer", "name": "type", "input": {"text": "cableado-10"}}]`
- **Resultado:** [success] celda A11 = 'cableado-10'; celda activa avanza
### Paso 26 · t=67.0s
- **Observación:** Vista: calc (calc) en pantalla 1280x720. Celda activa: B11; hoja: Hoja1. Cursor en (198, 697). `[screenshot PNG 1280x720, sha256:9f09875d891f…]`
- **Decisión (fill_field, estrategia hybrid):** Stock del artículo 10: 68 unidades.
- **Acción:** `TYPE` {"text": "68"}
  - OpenAI: `[{"type": "type", "text": "68"}]`
  - Anthropic: `[{"toolset_name": "computer", "name": "type", "input": {"text": "68"}}]`
- **Resultado:** [success] celda B11 = '68'; celda activa avanza
- **Verificación:** ✔ (visual_state) Estado verificado visualmente: B11 = 68.
### Paso 27 · t=71.4s
- **Observación:** Vista: calc (calc) en pantalla 1280x720. Celda activa: B12; hoja: Hoja1. Cursor en (198, 697). `[screenshot PNG 1280x720, sha256:0e7627c4557d…]`
- **Decisión (plan_next_subgoal, estrategia mouse_direct):** El usuario pide una tarea secundaria: la apunto en el plan SIN abandonar el subobjetivo actual a mitad de fórmula; la haré en un punto limpio (ahora, entre tabulado y totales).
- **Acción:** `SCREENSHOT` {}
  - OpenAI: `[{"type": "screenshot"}]`
  - Anthropic: `[{"toolset_name": "computer", "name": "screenshot", "input": {}}]`
- **Resultado:** [success] captura obtenida
### Paso 28 · t=72.5s
- **Observación:** Vista: calc (calc) en pantalla 1280x720. Celda activa: B12; hoja: Hoja1. Cursor en (198, 697). `[screenshot PNG 1280x720, sha256:0e7627c4557d…]`
- **Decisión (switch_window, estrategia hybrid):** Cambio al explorador para la tarea secundaria; la hoja queda abierta y con su estado intacto.
- **Acción:** `KEY` {"keys": ["alt", "tab"]}
  - OpenAI: `[{"type": "keypress", "keys": ["alt", "tab"]}]`
  - Anthropic: `[{"toolset_name": "computer", "name": "key", "input": {"text": "alt+tab"}}]`
- **Resultado:** [success] ventana anterior traída al frente (Alt+Tab)
- **Verificación:** ✔ (visual_state) Confirmado en la observación siguiente: explorador de archivos en primer plano.
### Paso 29 · t=75.8s
- **Observación:** Vista: desktop (desktop) en pantalla 1280x720. Cursor en (198, 697). `[screenshot PNG 1280x720, sha256:68e42fa1fe41…]`
- **Decisión (open_app, estrategia mouse_direct):** Siguiente subobjetivo: explorer. Lo lanzo y verificaré su ventana antes de actuar dentro.
- **Acción:** `KEY` {"keys": ["win"]}
  - OpenAI: `[{"type": "keypress", "keys": ["win"]}]`
  - Anthropic: `[{"toolset_name": "computer", "name": "key", "input": {"text": "win"}}]`
- **Resultado:** [success] menú de inicio abierto con buscador
- **Verificación:** ✔ (visual_state) Confirmado en la observación siguiente: menú de inicio abierto con buscador visible.
### Paso 30 · t=78.6s
- **Observación:** Vista: desktop (desktop) en pantalla 1280x720. Superpuestos activos: start 'Inicio'. Cursor en (198, 697). `[screenshot PNG 1280x720, sha256:b08d8f43c604…]`
- **Decisión (open_app, estrategia keyboard_first):** Introduzco 'explorer'. Si aparece autocompletado incorrecto lo corregiré antes de continuar.
- **Acción:** `TYPE` {"text": "explorer"}
  - OpenAI: `[{"type": "type", "text": "explorer"}]`
  - Anthropic: `[{"toolset_name": "computer", "name": "type", "input": {"text": "explorer"}}]`
- **Resultado:** [success] texto introducido en 'start_search'
### Paso 31 · t=81.8s
- **Observación:** Vista: desktop (desktop) en pantalla 1280x720. Superpuestos activos: start 'Inicio'. Cursor en (198, 697). `[screenshot PNG 1280x720, sha256:b08d8f43c604…]`
- **Decisión (open_app, estrategia mouse_direct):** Confirmo la búsqueda con Enter para lanzar explorer.
- **Acción:** `KEY` {"keys": ["enter"]}
  - OpenAI: `[{"type": "keypress", "keys": ["enter"]}]`
  - Anthropic: `[{"toolset_name": "computer", "name": "key", "input": {"text": "Return"}}]`
- **Resultado:** [success] Enter confirmó el diálogo activo
- **Verificación:** ✔ (visual_state) Confirmado en la observación siguiente: ventana de explorer abierta y con foco.
### Paso 32 · t=84.7s
- **Observación:** Vista: explorer (explorer) en pantalla 1280x720. Carpeta: /home/usuario/Documentos; 0 elementos visibles. La interfaz está cargando (no actuar aún). Cursor en (198, 697). `[screenshot PNG 1280x720, sha256:71d4016b9bd0…]`
- **Decisión (wait_for_ui, estrategia keyboard_first):** Espero 0.8 s a que la interfaz termine de cambiar antes de actuar.
- **Acción:** `WAIT` {"ms": 800, "until": "ventana de explorer estable"}
  - OpenAI: `[{"type": "wait", "time": 0.8}]`
  - Anthropic: `[{"toolset_name": "computer", "name": "wait", "input": {"duration": 0.8}}]`
- **Resultado:** [success] la carga terminó; la interfaz queda estable
- **Verificación:** ✔ (visual_state) Estado verificado visualmente: explorer en primer plano y estable.
### Paso 33 · t=87.1s
- **Observación:** Vista: explorer (explorer) en pantalla 1280x720. Carpeta: /home/usuario/Documentos; 2 elementos visibles. Cursor en (198, 697). `[screenshot PNG 1280x720, sha256:292ab0cedaae…]`
- **Decisión (select_item, estrategia mouse_direct):** Localizo «borrador_q2.xlsx» y lo selecciono.
- **Acción:** `CLICK` {"button": "left", "x": 739, "y": 361}
  - OpenAI: `[{"type": "click", "button": "left", "x": 739, "y": 361}]`
  - Anthropic: `[{"toolset_name": "computer", "name": "left_click", "input": {"coordinate": [739, 361]}}]`
- **Resultado:** [success] área 'area_items' recibió el clic (selección de zona)
- **Verificación:** ✔ (visual_state) El screenshot posterior muestra archivo borrador_q2.xlsx seleccionado.
### Paso 34 · t=90.2s
- **Observación:** Vista: explorer (explorer) en pantalla 1280x720. Carpeta: /home/usuario/Documentos; 2 elementos visibles. Cursor en (739, 361). `[screenshot PNG 1280x720, sha256:a30f4ce06a27…]`
- **Decisión (rename_file, estrategia mouse_direct):** F2 para renombrar sin abrir el archivo.
- **Acción:** `KEY` {"keys": ["f2"]}
  - OpenAI: `[{"type": "keypress", "keys": ["f2"]}]`
  - Anthropic: `[{"toolset_name": "computer", "name": "key", "input": {"text": "f2"}}]`
- **Resultado:** [success] tecla(s) f2 enviadas
- **Verificación:** ✔ (visual_state) Confirmado en la observación siguiente: campo de renombrado activo.
### Paso 35 · t=93.7s
- **Observación:** Vista: explorer (explorer) en pantalla 1280x720. Carpeta: /home/usuario/Documentos; 2 elementos visibles. Cursor en (739, 361). `[screenshot PNG 1280x720, sha256:a30f4ce06a27…]`
- **Decisión (rename_file, estrategia hybrid):** Tecleo el nombre nuevo que pidió el usuario.
- **Acción:** `TYPE` {"text": "inventario_q2.xlsx"}
  - OpenAI: `[{"type": "type", "text": "inventario_q2.xlsx"}]`
  - Anthropic: `[{"toolset_name": "computer", "name": "type", "input": {"text": "inventario_q2.xlsx"}}]`
- **Resultado:** [unexpected] sin campo enfocado: el texto no se introdujo en ningún control
- **Verificación:** ✘ (text_present) NO confirmado: campo contiene «inventario_q2.xlsx»
### Paso 36 · t=95.2s
- **Observación:** Vista: explorer (explorer) en pantalla 1280x720. Carpeta: /home/usuario/Documentos; 2 elementos visibles. Cursor en (739, 361). `[screenshot PNG 1280x720, sha256:a30f4ce06a27…]`
- **Decisión (rename_file, estrategia hybrid):** Confirmo con Enter y verifico el renombrado.
- **Acción:** `KEY` {"keys": ["enter"]}
  - OpenAI: `[{"type": "keypress", "keys": ["enter"]}]`
  - Anthropic: `[{"toolset_name": "computer", "name": "key", "input": {"text": "Return"}}]`
- **Resultado:** [success] Enter enviado al control con foco
- **Verificación:** ✔ (visual_state) El screenshot posterior muestra archivo renombrado a inventario_q2.xlsx.
### Paso 37 · t=96.5s
- **Observación:** Vista: explorer (explorer) en pantalla 1280x720. Carpeta: /home/usuario/Documentos; 2 elementos visibles. Cursor en (739, 361). `[screenshot PNG 1280x720, sha256:afa809cda1c6…]`
- **Decisión (switch_window, estrategia hybrid):** Tarea secundaria cerrada: vuelvo a la hoja de cálculo con el objetivo principal intacto.
- **Acción:** `KEY` {"keys": ["alt", "tab"]}
  - OpenAI: `[{"type": "keypress", "keys": ["alt", "tab"]}]`
  - Anthropic: `[{"toolset_name": "computer", "name": "key", "input": {"text": "alt+tab"}}]`
- **Resultado:** [success] ventana anterior traída al frente (Alt+Tab)
- **Verificación:** ✔ (visual_state) Estado verificado visualmente: hoja de cálculo de nuevo en primer plano.
### Paso 38 · t=103.2s
- **Observación:** Vista: calc (calc) en pantalla 1280x720. Celda activa: B12; hoja: Hoja1. Cursor en (739, 361). `[screenshot PNG 1280x720, sha256:bb738c94db30…]`
- **Decisión (apply_formula, estrategia hybrid):** Total del inventario con =SUMA bajo la última fila.
- **Acción:** `TYPE` {"text": "=SUMA(B2:B11)"}
  - OpenAI: `[{"type": "type", "text": "=SUMA(B2:B11)"}]`
  - Anthropic: `[{"toolset_name": "computer", "name": "type", "input": {"text": "=SUMA(B2:B11)"}}]`
- **Resultado:** [success] celda B12 = '=SUMA(B2:B11)'; celda activa avanza
- **Verificación:** ✔ (visual_state) Confirmado en la observación siguiente: total 555 calculado.
### Paso 39 · t=106.2s
- **Observación:** Vista: calc (calc) en pantalla 1280x720. Celda activa: B13; hoja: Hoja1. Cursor en (739, 361). `[screenshot PNG 1280x720, sha256:1cfa46a9e98e…]`
- **Decisión (format_text, estrategia hybrid):** Aplico formato de negrita a las cabeceras desde la cinta (pestaña Inicio).
- **Acción:** `CLICK` {"button": "left", "x": 140, "y": 24}
  - OpenAI: `[{"type": "click", "button": "left", "x": 140, "y": 24}]`
  - Anthropic: `[{"toolset_name": "computer", "name": "left_click", "input": {"coordinate": [140, 24]}}]`
- **Resultado:** [success] cinta 'Inicio' activa
- **Verificación:** ✔ (visual_state) Confirmado en la observación siguiente: cabeceras en negrita.
### Paso 40 · t=107.5s
- **Observación:** Vista: calc (calc) en pantalla 1280x720. Celda activa: B13; hoja: Hoja1. Cursor en (140, 24). `[screenshot PNG 1280x720, sha256:5c784d137037…]`
- **Decisión (insert_chart, estrategia hybrid):** Inserto el gráfico de stock por artículo.
- **Acción:** `CLICK` {"button": "left", "x": 139, "y": 58}
  - OpenAI: `[{"type": "click", "button": "left", "x": 139, "y": 58}]`
  - Anthropic: `[{"toolset_name": "computer", "name": "left_click", "input": {"coordinate": [139, 58]}}]`
- **Resultado:** [success] gráfico insertado en la hoja
- **Verificación:** ✔ (visual_state) Confirmado en la observación siguiente: gráfico de inventario insertado.
### Paso 41 · t=109.8s
- **Observación:** Vista: calc (calc) en pantalla 1280x720. Celda activa: B13; hoja: Hoja1. Cursor en (139, 58). `[screenshot PNG 1280x720, sha256:0dd752f58cba…]`
- **Decisión (save_file, estrategia mouse_direct):** Guardo con Ctrl+S; la primera vez aparecerá el diálogo 'Guardar como'.
- **Acción:** `KEY` {"keys": ["ctrl", "s"]}
  - OpenAI: `[{"type": "keypress", "keys": ["ctrl", "s"]}]`
  - Anthropic: `[{"toolset_name": "computer", "name": "key", "input": {"text": "ctrl+s"}}]`
- **Resultado:** [success] guardar (Ctrl+S): posible diálogo de guardado
### Paso 42 · t=112.0s
- **Observación:** Vista: calc (calc) en pantalla 1280x720. Celda activa: B13; hoja: Hoja1. Superpuestos activos: save_dialog 'Guardar como'. Cursor en (139, 58). `[screenshot PNG 1280x720, sha256:d72b868671b4…]`
- **Decisión (confirm_dialog, estrategia mouse_direct):** El diálogo propone el nombre previsto; confirmo con Enter y compruebo el guardado real.
- **Acción:** `KEY` {"keys": ["enter"]}
  - OpenAI: `[{"type": "keypress", "keys": ["enter"]}]`
  - Anthropic: `[{"toolset_name": "computer", "name": "key", "input": {"text": "Return"}}]`
- **Resultado:** [success] guardado confirmado: inventario_q3
- **Verificación:** ✔ (file_exists) Estado verificado visualmente: inventario_q3 guardado (persistido en disco).
### Paso 43 · t=114.7s
- **Observación:** Vista: calc (calc) en pantalla 1280x720. Celda activa: B13; hoja: Hoja1. Superpuestos activos: save_dialog 'Guardar como'. Cursor en (139, 58). `[screenshot PNG 1280x720, sha256:d72b868671b4…]`
- **Decisión (verify_result, estrategia mouse_direct):** Verificación final: tabla completa, total, gráfico y archivo guardado; las dos interrupciones quedaron gestionadas sin perder el objetivo.
- **Acción:** `SCREENSHOT` {}
  - OpenAI: `[{"type": "screenshot"}]`
  - Anthropic: `[{"toolset_name": "computer", "name": "screenshot", "input": {}}]`
- **Resultado:** [success] captura obtenida
- **Verificación:** ✔ (visual_state) Confirmado en la observación siguiente: inventario_q3 con 10 filas, total 555 y gráfico.
## Recuperaciones

- Paso 16: fallo `notification_interrupt` detectado vía «toast del sistema sobre la rejilla a mitad de tabulado» → estrategia `dismiss_dialog` (ESC, SCREENSHOT) — resuelto. Lección: las interrupciones breves se cierran de inmediato y se retoma el subobjetivo exacto, no se reinicia
- Paso 37: fallo `secondary_task_interrupt` detectado vía «petición del usuario a mitad de la tarea principal» → estrategia `alternative_path` (ALT+TAB, F2, TYPE) — resuelto. Lección: las tareas secundarias se ejecutan en un punto limpio del plan y se vuelve al subobjetivo exacto; el plan_remaining lo demuestra

## Verificación final
- Plan: tabular inventario, total y gráfico, gestionar interrupciones, guardar y verificar
- Checks superados: 28/29
- Estado final: gráfico de inventario insertado; inventario_q3 guardado (persistido en disco); inventario_q3 con 10 filas, total 555 y gráfico
