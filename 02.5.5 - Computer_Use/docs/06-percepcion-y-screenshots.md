# 06 — Percepción visual, screenshots y espacio de coordenadas

## Dos modalidades de observación, un mismo esquema

Cada observación lleva un bloque `screenshot` con:

1. **Píxeles reales** (`available: true`): PNG en modo paleta (96 colores), 1280×720, con `sha256` verificable y `data_b64`. El build embebió 2.671 screenshots; regenerar con `--pixels` alto produce píxeles para el 100 % de las observaciones.
2. **Estructura completa** (`available: false`): siempre presentes `description` (escena en una frase) y `ui_tree` (elementos con `id`, `role`, `label`, `bbox`, `enabled`, `selected`, `focused`, más overlays). Es la misma información que el renderizador usa para dibujar, garantizando coherencia total entre narración, árbol de UI y píxeles.

Las dos modalidades comparten esquema: el entrenamiento puede mezclarlas y el generador puede regenerar píxeles cuando el presupuesto de tamaño lo permita.

## Coordenadas en el espacio del screenshot

Todas las coordenadas del dataset viven en el espacio del screenshot declarado (1280×720 en v1). No existen coordenadas universales: la misma celda de la hoja de cálculo cambia de posición según la geometría de la ventana, la herramienta activa o el estado de la interfaz. El patrón entrenado es:

```text
screenshot actual → localizar objetivo (elemento/región) → calcular posición →
actuar → screenshot nuevo → comprobar
```

Los elementos del `ui_tree` exponen su `bbox` exacto, de modo que el ground truth de "dónde está el botón" es verificable píxel a píxel contra el PNG embebido.

## Zoom y percepción de detalle

Siguiendo la práctica recomendada por la documentación de Anthropic, el dataset entrena el uso de `ZOOM` cuando el texto o los controles son demasiado pequeños en el screenshot completo: antes de leer una etiqueta de "patrocinado", antes de pulsar un control denso, para verificar un trazo en Paint. Los pasos `ZOOM` incluyen la evidencia ampliada (`result.zoom`) en las trayectorias visuales y el tag `zoom_use` permite filtrarlos.

## Espera activa y no actuación

El renderizador marca estados de carga (`loading`) y los ejemplos enseñan a **no actuar mientras la interfaz cambia**: `WAIT {until: "…"}` seguido de re-observación. Es la antítesis del clic a ciegas y una de las habilidades más rentables del agente.
