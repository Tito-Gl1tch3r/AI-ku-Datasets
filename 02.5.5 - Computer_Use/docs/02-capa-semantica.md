# 02 — Capa semántica común

## Primitivas (las 12 herramientas)

| Primitiva | Parámetros | Significado entrenado |
|---|---|---|
| `MOVE_CURSOR` | x, y | apuntar, hover, seguir trayectorias; sin clic |
| `CLICK` | button (left/right/middle), x, y | pulsación simple; `right` abre menús contextuales |
| `DOUBLE_CLICK` | x, y | abrir, seleccionar palabra |
| `TRIPLE_CLICK` | x, y | seleccionar párrafo/línea |
| `DRAG` | from, to, button, path?, modifiers? | mover, seleccionar por región, sliders, dibujar |
| `SCROLL` | direction, amount, x?, y? | desplazar contenido; no confundir con zoom |
| `TYPE` | text | texto literal al foco de teclado actual |
| `KEY` | keys[] | teclas y combinaciones (`ctrl+s`, `alt+Tab`, `enter`, flechas) |
| `HOLD_KEY` | key, duration_ms, concurrent? | aceleración/dash sostenido en juegos |
| `WAIT` | ms, until?, timeout? | **no actuar mientras la interfaz cambia** |
| `SCREENSHOT` | — | re-observar antes de decidir |
| `ZOOM` | region, purpose | inspeccionar texto pequeño/UI densa a resolución completa |

## Intenciones: el significado por encima del gesto

Cada paso lleva además un `intent` (≈115 valores: `open_context_menu`, `save_file`, `switch_window`, `fill_field`, `apply_formula`, `reject_injection`, `ask_human`, `diagnose_problem`, `aim`, `accelerate`…; v1.1 añade el bloque de edición de vídeo — `import_media`, `arrange_timeline`, `trim_clip`, `split_clip`, `add_transition`, `add_caption`, `adjust_color`, `adjust_audio`, `set_speed`, `export_render`, `scrub_playhead`, `relink_media` — y el de control de juego extendido — `boost`, `place_block`, `mine_block`, `craft_item`, `manage_inventory`, `tune_vehicle`, `restart_attempt`, `rewind_state`, `attempt_failed`…). Las intenciones son **objetivos funcionales** que se materializan con composiciones distintas de primitivas según el contexto. El mismo `open_context_menu` se ejecuta con `CLICK(right)` o con `KEY(shift+f10)`; el mismo `save_file` con `KEY(ctrl+s)`, con menú Archivo, o con `CLICK(btn_guardar)`; el mismo `trim_clip` con cuchilla+clic, con arrastre de borde o con entrada por playhead+teclado.

El dataset contiene deliberadamente **múltiples estrategias para la misma intención**, de modo que el modelo aprenda:

- la herramienta adecuada al contexto (teclado-first cuando es más robusto; espera cuando la interfaz está cambiando; zoom antes de adivinar coordenadas);
- economía de acciones (lotes con Ctrl+X/Ctrl+V, atajos frente a menús);
- que `WAIT` y `SCREENSHOT` son acciones de primer nivel, no relleno.

## Composición de alto nivel

Apertura de aplicaciones, cambios de ventana o de pestaña, copiar/pegar, navegación o formularios **no son primitivas**: son composiciones que aparecen etiquetadas con su intención. Esto enseña que "abrir la calculadora" es un objetivo alcanzable por varios caminos (menú inicio con búsqueda, icono anclado, teclado), no un patrón fijo de píxeles.

## Variantes equivalentes y generalización

Cada familia genera variantes que cambian la estrategia manteniendo el objetivo. La validación garantiza que los cambios son semánticos (secuencia de intenciones y acciones distinta, fallos distintos, desenlaces distintos), no cosméticos: el objetivo de generalización es que "hoja de cálculo = estructura tabular con celdas, fórmulas y relaciones" transfiera entre aplicaciones, y que "navegador = interfaz que puede cambiar" no dependa de un dominio concreto.
