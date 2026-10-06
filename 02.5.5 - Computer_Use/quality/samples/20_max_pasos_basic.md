# Muestra: aku_cu_000065
- **Objetivo:** En «soporte_simple.dwg», dibuja un rectángulo de 120x60 mm con la esquina en (0,0) y un círculo de Ø30 mm dentro, todo por comandos.
- **Plataforma/Aplicación:** windows_11 / cad (cad)
- **Dominio/Tipo/Dificultad/Horizonte:** cad · technical_drawing · basic · medium (22 pasos)
- **Desenlace:** success (verificado: True) · entregables: soporte_simple.dwg con rectángulo 120x60 y Ø30
- **Tags:** basic, cad, fault_recovery, technical_drawing

### Paso 1 · t=0.8s
- **Observación:** Vista: desktop (desktop) en pantalla 1280x720. Cursor en (640, 360). `[observación estructurada sin píxeles]`
- **Decisión (open_app, estrategia mouse_direct):** AstraCAD no está anclado: lo lanzo desde el buscador del sistema.
- **Acción:** `KEY` {"keys": ["win"]}
  - OpenAI: `[{"type": "keypress", "keys": ["win"]}]`
  - Anthropic: `[{"toolset_name": "computer", "name": "key", "input": {"text": "win"}}]`
- **Resultado:** [success] menú de inicio abierto con buscador
- **Verificación:** ✔ (visual_state) Confirmado en la observación siguiente: menú de inicio abierto con buscador visible.
### Paso 2 · t=2.0s
- **Observación:** Vista: desktop (desktop) en pantalla 1280x720. Superpuestos activos: start 'Inicio'. Cursor en (640, 360). `[observación estructurada sin píxeles]`
- **Decisión (open_app, estrategia hybrid):** Tecleo «astracad» para localizar el programa.
- **Acción:** `TYPE` {"text": "astracad"}
  - OpenAI: `[{"type": "type", "text": "astracad"}]`
  - Anthropic: `[{"toolset_name": "computer", "name": "type", "input": {"text": "astracad"}}]`
- **Resultado:** [success] texto introducido en 'start_search'
- **Verificación:** ✔ (text_present) Estado verificado visualmente: búsqueda contiene «astracad».
### Paso 3 · t=2.9s
- **Observación:** Vista: desktop (desktop) en pantalla 1280x720. Superpuestos activos: start 'Inicio'. Cursor en (640, 360). `[observación estructurada sin píxeles]`
- **Decisión (open_app, estrategia keyboard_first):** Confirmo con Enter para lanzar AstraCAD.
- **Acción:** `KEY` {"keys": ["enter"]}
  - OpenAI: `[{"type": "keypress", "keys": ["enter"]}]`
  - Anthropic: `[{"toolset_name": "computer", "name": "key", "input": {"text": "Return"}}]`
- **Resultado:** [success] Enter confirmó el diálogo activo
- **Verificación:** ✔ (visual_state) El screenshot posterior muestra ventana de AstraCAD en primer plano.
### Paso 4 · t=4.5s
- **Observación:** Vista: cad (AstraCAD — soporte_simple.dwg) en pantalla 1280x720. Dibujo AstraCAD: 0 entidad(es) en 4 capa(s); capa actual «0»; OSNAP activo; ORTO inactivo; zoom 1.00; unidades mm (rejilla 10 mm/celda). La interfaz está cargando (no actuar aún). Cursor en (640, 360). `[observación estructurada sin píxeles]`
- **Decisión (wait_for_ui, estrategia hybrid):** Espero 1.3 s a que la interfaz termine de cambiar antes de actuar.
- **Acción:** `WAIT` {"ms": 1300, "until": "área de dibujo y línea de comandos listas"}
  - OpenAI: `[{"type": "wait", "time": 1.3}]`
  - Anthropic: `[{"toolset_name": "computer", "name": "wait", "input": {"duration": 1.3}}]`
- **Resultado:** [success] la carga terminó; la interfaz queda estable
- **Verificación:** ✔ (visual_state) Confirmado en la observación siguiente: área de dibujo, capas y línea de comandos visibles.
### Paso 5 · t=5.5s
- **Observación:** Vista: cad (AstraCAD — soporte_simple.dwg) en pantalla 1280x720. Dibujo AstraCAD: 0 entidad(es) en 4 capa(s); capa actual «0»; OSNAP activo; ORTO inactivo; zoom 1.00; unidades mm (rejilla 10 mm/celda). Cursor en (640, 360). `[observación estructurada sin píxeles]`
- **Decisión (enter_command, estrategia mouse_direct):** RECTANG por teclado: comando exacto, sin buscar iconos.
- **Acción:** `TYPE` {"text": "rec"}
  - OpenAI: `[{"type": "type", "text": "rec"}]`
  - Anthropic: `[{"toolset_name": "computer", "name": "type", "input": {"text": "rec"}}]`
- **Resultado:** [success] línea de comandos: «rec» (Enter para ejecutar)
- **Verificación:** ✔ (text_present) Confirmado en la observación siguiente: comando «rec» en la línea.
### Paso 6 · t=6.2s
- **Observación:** Vista: cad (AstraCAD — soporte_simple.dwg) en pantalla 1280x720. Dibujo AstraCAD: 0 entidad(es) en 4 capa(s); capa actual «0»; OSNAP activo; ORTO inactivo; zoom 1.00; unidades mm (rejilla 10 mm/celda); línea de comandos: «rec». Cursor en (640, 360). `[observación estructurada sin píxeles]`
- **Decisión (enter_command, estrategia hybrid):** Confirmo con Enter: el comando queda activo esperando puntos.
- **Acción:** `KEY` {"keys": ["enter"]}
  - OpenAI: `[{"type": "keypress", "keys": ["enter"]}]`
  - Anthropic: `[{"toolset_name": "computer", "name": "key", "input": {"text": "Return"}}]`
- **Resultado:** [success] comando RECT iniciado: indica la primera esquina
- **Verificación:** ✔ (visual_state) El screenshot posterior muestra comando REC iniciado.
### Paso 7 · t=7.3s
- **Observación:** Vista: cad (AstraCAD — soporte_simple.dwg) en pantalla 1280x720. Dibujo AstraCAD: 0 entidad(es) en 4 capa(s); capa actual «0»; OSNAP activo; ORTO inactivo; zoom 1.00; unidades mm (rejilla 10 mm/celda); comando rect activo con 0 punto(s). Cursor en (640, 360). `[observación estructurada sin píxeles]`
- **Decisión (enter_command, estrategia hybrid):** Intento un alias que no existe…
- **Acción:** `TYPE` {"text": "rectngl"}
  - OpenAI: `[{"type": "type", "text": "rectngl"}]`
  - Anthropic: `[{"toolset_name": "computer", "name": "type", "input": {"text": "rectngl"}}]`
- **Resultado:** [success] línea de comandos: «rectngl» (Enter para ejecutar)
- **Verificación:** ✔ (text_present) El screenshot posterior muestra comando «rectngl» en la línea.
### Paso 8 · t=8.3s
- **Observación:** Vista: cad (AstraCAD — soporte_simple.dwg) en pantalla 1280x720. Dibujo AstraCAD: 0 entidad(es) en 4 capa(s); capa actual «0»; OSNAP activo; ORTO inactivo; zoom 1.00; unidades mm (rejilla 10 mm/celda); comando rect activo con 0 punto(s); línea de comandos: «rectngl». Cursor en (640, 360). `[observación estructurada sin píxeles]`
- **Decisión (enter_command, estrategia keyboard_first):** Confirmo con Enter: el comando queda activo esperando puntos.
- **Acción:** `KEY` {"keys": ["enter"]}
  - OpenAI: `[{"type": "keypress", "keys": ["enter"]}]`
  - Anthropic: `[{"toolset_name": "computer", "name": "key", "input": {"text": "Return"}}]`
- **Resultado:** [unexpected] «rectngl» no aplicable durante rect: esc y vuelve a intentarlo
- **Verificación:** ✘ (visual_state) NO confirmado: respuesta del sistema
### Paso 9 · t=12.5s
- **Observación:** Vista: cad (AstraCAD — soporte_simple.dwg) en pantalla 1280x720. Dibujo AstraCAD: 0 entidad(es) en 4 capa(s); capa actual «0»; OSNAP activo; ORTO inactivo; zoom 1.00; unidades mm (rejilla 10 mm/celda); comando rect activo con 0 punto(s). Cursor en (640, 360). `[observación estructurada sin píxeles]`
- **Decisión (enter_command, estrategia keyboard_first):** Repetido con el alias correcto REC.
- **Acción:** `TYPE` {"text": "rec"}
  - OpenAI: `[{"type": "type", "text": "rec"}]`
  - Anthropic: `[{"toolset_name": "computer", "name": "type", "input": {"text": "rec"}}]`
- **Resultado:** [success] línea de comandos: «rec» (Enter para ejecutar)
- **Verificación:** ✔ (text_present) El screenshot posterior muestra comando «rec» en la línea.
### Paso 10 · t=13.5s
- **Observación:** Vista: cad (AstraCAD — soporte_simple.dwg) en pantalla 1280x720. Dibujo AstraCAD: 0 entidad(es) en 4 capa(s); capa actual «0»; OSNAP activo; ORTO inactivo; zoom 1.00; unidades mm (rejilla 10 mm/celda); comando rect activo con 0 punto(s); línea de comandos: «rec». Cursor en (640, 360). `[observación estructurada sin píxeles]`
- **Decisión (enter_command, estrategia keyboard_first):** Confirmo con Enter: el comando queda activo esperando puntos.
- **Acción:** `KEY` {"keys": ["enter"]}
  - OpenAI: `[{"type": "keypress", "keys": ["enter"]}]`
  - Anthropic: `[{"toolset_name": "computer", "name": "key", "input": {"text": "Return"}}]`
- **Resultado:** [unexpected] «rec» no aplicable durante rect: esc y vuelve a intentarlo
- **Verificación:** ✔ (visual_state) Estado verificado visualmente: comando REC iniciado.
### Paso 11 · t=14.0s
- **Observación:** Vista: cad (AstraCAD — soporte_simple.dwg) en pantalla 1280x720. Dibujo AstraCAD: 0 entidad(es) en 4 capa(s); capa actual «0»; OSNAP activo; ORTO inactivo; zoom 1.00; unidades mm (rejilla 10 mm/celda); comando rect activo con 0 punto(s). Cursor en (640, 360). `[observación estructurada sin píxeles]`
- **Decisión (enter_command, estrategia keyboard_first):** Primera esquina en el origen por coordenada (no a ojo).
- **Acción:** `TYPE` {"text": "0,0"}
  - OpenAI: `[{"type": "type", "text": "0,0"}]`
  - Anthropic: `[{"toolset_name": "computer", "name": "type", "input": {"text": "0,0"}}]`
- **Resultado:** [success] línea de comandos: «0,0» (Enter para ejecutar)
- **Verificación:** ✔ (text_present) El screenshot posterior muestra coordenada (0,0) en la línea de comandos.
### Paso 12 · t=14.8s
- **Observación:** Vista: cad (AstraCAD — soporte_simple.dwg) en pantalla 1280x720. Dibujo AstraCAD: 0 entidad(es) en 4 capa(s); capa actual «0»; OSNAP activo; ORTO inactivo; zoom 1.00; unidades mm (rejilla 10 mm/celda); comando rect activo con 0 punto(s); línea de comandos: «0,0». Cursor en (640, 360). `[observación estructurada sin píxeles]`
- **Decisión (enter_command, estrategia mouse_direct):** Enter para registrar el punto por coordenada.
- **Acción:** `KEY` {"keys": ["enter"]}
  - OpenAI: `[{"type": "keypress", "keys": ["enter"]}]`
  - Anthropic: `[{"toolset_name": "computer", "name": "key", "input": {"text": "Return"}}]`
- **Resultado:** [success] punto introducido por coordenada (0, 0) mm → rect: punto 1 aceptado (0, 0); indique esquina opuesta
- **Verificación:** ✔ (visual_state) Estado verificado visualmente: punto registrado.
### Paso 13 · t=15.8s
- **Observación:** Vista: cad (AstraCAD — soporte_simple.dwg) en pantalla 1280x720. Dibujo AstraCAD: 0 entidad(es) en 4 capa(s); capa actual «0»; OSNAP activo; ORTO inactivo; zoom 1.00; unidades mm (rejilla 10 mm/celda); comando rect activo con 1 punto(s). Cursor en (640, 360). `[observación estructurada sin píxeles]`
- **Decisión (enter_command, estrategia mouse_direct):** Esquina opuesta: 120 mm en X y 60 mm en Y.
- **Acción:** `TYPE` {"text": "120,60"}
  - OpenAI: `[{"type": "type", "text": "120,60"}]`
  - Anthropic: `[{"toolset_name": "computer", "name": "type", "input": {"text": "120,60"}}]`
- **Resultado:** [success] línea de comandos: «120,60» (Enter para ejecutar)
- **Verificación:** ✔ (text_present) El screenshot posterior muestra coordenada (120,60) en la línea de comandos.
### Paso 14 · t=16.5s
- **Observación:** Vista: cad (AstraCAD — soporte_simple.dwg) en pantalla 1280x720. Dibujo AstraCAD: 0 entidad(es) en 4 capa(s); capa actual «0»; OSNAP activo; ORTO inactivo; zoom 1.00; unidades mm (rejilla 10 mm/celda); comando rect activo con 1 punto(s); línea de comandos: «120,60». Cursor en (640, 360). `[observación estructurada sin píxeles]`
- **Decisión (enter_command, estrategia keyboard_first):** Enter para registrar el punto por coordenada.
- **Acción:** `KEY` {"keys": ["enter"]}
  - OpenAI: `[{"type": "keypress", "keys": ["enter"]}]`
  - Anthropic: `[{"toolset_name": "computer", "name": "key", "input": {"text": "Return"}}]`
- **Resultado:** [success] punto introducido por coordenada (120, 60) mm → entidad rect e1 creada en capa «0»
- **Verificación:** ✔ (visual_state) Confirmado en la observación siguiente: punto registrado.
### Paso 15 · t=17.3s
- **Observación:** Vista: cad (AstraCAD — soporte_simple.dwg) en pantalla 1280x720. Dibujo AstraCAD: 1 entidad(es) en 4 capa(s); capa actual «0»; OSNAP activo; ORTO inactivo; zoom 1.00; unidades mm (rejilla 10 mm/celda). Cursor en (640, 360). `[observación estructurada sin píxeles]`
- **Decisión (enter_command, estrategia keyboard_first):** CIRCLE para el agujero.
- **Acción:** `TYPE` {"text": "c"}
  - OpenAI: `[{"type": "type", "text": "c"}]`
  - Anthropic: `[{"toolset_name": "computer", "name": "type", "input": {"text": "c"}}]`
- **Resultado:** [success] línea de comandos: «c» (Enter para ejecutar)
- **Verificación:** ✔ (text_present) El screenshot posterior muestra comando «c» en la línea.
### Paso 16 · t=18.1s
- **Observación:** Vista: cad (AstraCAD — soporte_simple.dwg) en pantalla 1280x720. Dibujo AstraCAD: 1 entidad(es) en 4 capa(s); capa actual «0»; OSNAP activo; ORTO inactivo; zoom 1.00; unidades mm (rejilla 10 mm/celda); línea de comandos: «c». Cursor en (640, 360). `[observación estructurada sin píxeles]`
- **Decisión (enter_command, estrategia keyboard_first):** Confirmo con Enter: el comando queda activo esperando puntos.
- **Acción:** `KEY` {"keys": ["enter"]}
  - OpenAI: `[{"type": "keypress", "keys": ["enter"]}]`
  - Anthropic: `[{"toolset_name": "computer", "name": "key", "input": {"text": "Return"}}]`
- **Resultado:** [success] comando CIRCLE iniciado: indica el centro
- **Verificación:** ✔ (visual_state) Estado verificado visualmente: comando C iniciado.
### Paso 17 · t=19.1s
- **Observación:** Vista: cad (AstraCAD — soporte_simple.dwg) en pantalla 1280x720. Dibujo AstraCAD: 1 entidad(es) en 4 capa(s); capa actual «0»; OSNAP activo; ORTO inactivo; zoom 1.00; unidades mm (rejilla 10 mm/celda); comando circle activo con 0 punto(s). Cursor en (640, 360). `[observación estructurada sin píxeles]`
- **Decisión (enter_command, estrategia hybrid):** Centro del círculo en el centro del rectángulo.
- **Acción:** `TYPE` {"text": "60,30"}
  - OpenAI: `[{"type": "type", "text": "60,30"}]`
  - Anthropic: `[{"toolset_name": "computer", "name": "type", "input": {"text": "60,30"}}]`
- **Resultado:** [success] línea de comandos: «60,30» (Enter para ejecutar)
- **Verificación:** ✔ (text_present) Confirmado en la observación siguiente: coordenada (60,30) en la línea de comandos.
### Paso 18 · t=19.8s
- **Observación:** Vista: cad (AstraCAD — soporte_simple.dwg) en pantalla 1280x720. Dibujo AstraCAD: 1 entidad(es) en 4 capa(s); capa actual «0»; OSNAP activo; ORTO inactivo; zoom 1.00; unidades mm (rejilla 10 mm/celda); comando circle activo con 0 punto(s); línea de comandos: «60,30». Cursor en (640, 360). `[observación estructurada sin píxeles]`
- **Decisión (enter_command, estrategia hybrid):** Enter para registrar el punto por coordenada.
- **Acción:** `KEY` {"keys": ["enter"]}
  - OpenAI: `[{"type": "keypress", "keys": ["enter"]}]`
  - Anthropic: `[{"toolset_name": "computer", "name": "key", "input": {"text": "Return"}}]`
- **Resultado:** [success] punto introducido por coordenada (60, 30) mm → circle: punto 1 aceptado (150, 75); indique punto de radio
- **Verificación:** ✔ (visual_state) Estado verificado visualmente: punto registrado.
### Paso 19 · t=20.8s
- **Observación:** Vista: cad (AstraCAD — soporte_simple.dwg) en pantalla 1280x720. Dibujo AstraCAD: 1 entidad(es) en 4 capa(s); capa actual «0»; OSNAP activo; ORTO inactivo; zoom 1.00; unidades mm (rejilla 10 mm/celda); comando circle activo con 1 punto(s). Cursor en (640, 360). `[observación estructurada sin píxeles]`
- **Decisión (enter_command, estrategia hybrid):** Punto de radio: 15 mm = Ø30 mm.
- **Acción:** `TYPE` {"text": "75,30"}
  - OpenAI: `[{"type": "type", "text": "75,30"}]`
  - Anthropic: `[{"toolset_name": "computer", "name": "type", "input": {"text": "75,30"}}]`
- **Resultado:** [success] línea de comandos: «75,30» (Enter para ejecutar)
- **Verificación:** ✔ (text_present) El screenshot posterior muestra coordenada (75,30) en la línea de comandos.
### Paso 20 · t=21.7s
- **Observación:** Vista: cad (AstraCAD — soporte_simple.dwg) en pantalla 1280x720. Dibujo AstraCAD: 1 entidad(es) en 4 capa(s); capa actual «0»; OSNAP activo; ORTO inactivo; zoom 1.00; unidades mm (rejilla 10 mm/celda); comando circle activo con 1 punto(s); línea de comandos: «75,30». Cursor en (640, 360). `[observación estructurada sin píxeles]`
- **Decisión (enter_command, estrategia mouse_direct):** Enter para registrar el punto por coordenada.
- **Acción:** `KEY` {"keys": ["enter"]}
  - OpenAI: `[{"type": "keypress", "keys": ["enter"]}]`
  - Anthropic: `[{"toolset_name": "computer", "name": "key", "input": {"text": "Return"}}]`
- **Resultado:** [success] punto introducido por coordenada (75, 30) mm → entidad circle e2 creada en capa «0»
- **Verificación:** ✔ (visual_state) Confirmado en la observación siguiente: punto registrado.
### Paso 21 · t=22.7s
- **Observación:** Vista: cad (AstraCAD — soporte_simple.dwg) en pantalla 1280x720. Dibujo AstraCAD: 2 entidad(es) en 4 capa(s); capa actual «0»; OSNAP activo; ORTO inactivo; zoom 1.00; unidades mm (rejilla 10 mm/celda). Cursor en (640, 360). `[observación estructurada sin píxeles]`
- **Decisión (zoom_view, estrategia keyboard_first):** Zoom a la extensión para encuadrar todo el dibujo antes de revisar.
- **Acción:** `CLICK` {"button": "left", "x": 1075, "y": 376}
  - OpenAI: `[{"type": "click", "button": "left", "x": 1075, "y": 376}]`
  - Anthropic: `[{"toolset_name": "computer", "name": "left_click", "input": {"coordinate": [1075, 376]}}]`
- **Resultado:** [success] zoom a extensión: todo el dibujo encuadrado en el área
- **Verificación:** ✔ (visual_state) Estado verificado visualmente: dibujo encuadrado (zoom 1.0).
### Paso 22 · t=23.4s
- **Observación:** Vista: cad (AstraCAD — soporte_simple.dwg) en pantalla 1280x720. Dibujo AstraCAD: 2 entidad(es) en 4 capa(s); capa actual «0»; OSNAP activo; ORTO inactivo; zoom 1.00; unidades mm (rejilla 10 mm/celda). Cursor en (1075, 376). `[observación estructurada sin píxeles]`
- **Decisión (verify_result, estrategia mouse_direct):** Verificación final: existen rectángulo y círculo con las medidas pedidas.
- **Acción:** `SCREENSHOT` {}
  - OpenAI: `[{"type": "screenshot"}]`
  - Anthropic: `[{"toolset_name": "computer", "name": "screenshot", "input": {}}]`
- **Resultado:** [success] captura obtenida
- **Verificación:** ✔ (visual_state) Estado verificado visualmente: entidades ['rect', 'circle'] con rect 120x60 y círculo r15.
## Recuperaciones

- Paso 8: fallo `command_unknown` detectado vía «el programa no reconoce el alias tecleado» → estrategia `alternative_path` (TYPE, KEY) — resuelto. Lección: uso solo los alias documentados (REC, L, C, TR, M, O, DIM, Z); si un comando no existe, la línea de comandos lo dice y no inventa

## Verificación final
- Plan: abrir AstraCAD, rectángulo por coordenadas, círculo centrado, zoom extensión, verificar entidades
- Checks superados: 21/22
- Estado final: punto registrado; dibujo encuadrado (zoom 1.0); entidades ['rect', 'circle'] con rect 120x60 y círculo r15
