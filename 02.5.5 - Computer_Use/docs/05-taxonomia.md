# 05 — Taxonomía

## Dominios (`domain`)

`operating_system` (ventanas, escritorio, explorador, ajustes) · `web` (navegación, formularios, descargas, webapps) · `graphics` (Paint: dibujo, selección, recorte, exportación) · `documents` (creación y edición de documentos) · `spreadsheets` (celdas, fórmulas, gráficos, pipelines) · `presentations` (decks completos, notas, consistencia) · `terminal` (comandos, build-fix-run, logs) · `games` (control fino, timing, coordinación; v1.1: Rocket League, Minecraft, Forza Horizon) · `video_editing` (v1.1: montaje NLE multipista, cortes, transiciones, audio, color, exportación) · `3d_modeling` (v1.2: Blender — vistas numpad, G/R/S con eje y valor, primitivas, modificadores, materiales, luz, render Cycles/EEVEE con verificación de salida, fotoclaves) · `cad` (v1.2: AstraCAD — comandos L/PL/C/REC/TR/M/O/DIM/Z, coordenadas en mm, capas y congelado, acotación, trazado PDF) · `business_apps` (v1.2: NimbusCRM — altas validadas, etapas, filtros, informe de pipeline, búsqueda global, datos vivos) · `multi_application` (flujos que cruzan aplicaciones) · `safety_resilience` (CAPTCHA, inyección, consecuentes, recuperación).

## Tipos de tarea (`task_type`)

`atomic_action` (el escalón "haz clic ahí") · `guided_edit` (modificar algo concreto) · `workflow_automation` (secuencias multi-paso) · `data_pipeline` (importar→limpiar→métricas→gráficos) · `research_synthesis` (fuentes→notas→producto) · `document_production` (informes y decks de principio a fin) · `creative_graphics` (composiciones en Paint) · `system_administration` (ajustes no destructivos) · `game_control` (precisión, timing, mecánicas) · `video_production` (v1.1: postproducción de principio a fin) · `3d_production` (v1.2: modelado, escena y render) · `technical_drawing` (v1.2: dibujo técnico con precisión) · `business_process` (v1.2: registros y pipeline de negocio) · `safety_handling` (políticas seguras) · `error_recovery_drill` (fallos y recuperación) · `open_objective` (solo el objetivo; el plan lo infiere el agente).

## Dificultad y horizonte

| Dificultad | Pasos típicos | Ejemplo |
|---|---|---|
| `basic` | 2–7 | "Pon 20 en B4", "haz clic en Guardar" |
| `intermediate` | 8–24 | formulario web con validación; crear estructura de carpetas |
| `advanced` | 25–79 | fórmulas cruzadas + gráfico; recuperación de #REF! |
| `very_advanced` | 60–150 | pipeline de análisis; deck desde documentos |
| `extreme` | 120–148 (máx. dataset) | mega-pipeline multiapp; maniobra *musty* |

Buckets de `horizon`: `short` (<8) · `medium` (8–24) · `long` (25–79) · `very_long` (80–249) · `extreme_long` (≥250). Bandera `long_horizon` = ≥25 pasos.

## Aplicaciones principales presentes

`browser` (99) · `game` (78) · `calc` (59) · `paint` (47) · `explorer` (46) · `video_editor` (44) · `blender` (28) · `writer` (40) · `cad` (23) · `crm` (16) · `slides` (35) · `terminal` (11) · `settings`/`notepad`/`desktop` · `mail`.

## Escalera deliberada (sección 35 del requisitos)

El dataset incluye la escalera completa: click simple → click+menú+formulario → multiventana → browser+files+spreadsheet → browser+spreadsheet+presentation+document → proyecto completo de largo horizonte → tarea abierta extremo a extremo con errores, cambios de estado, verificación, recuperación y entregable final. Los flagships (`flagship_*`) están en el tramo superior; su peso combinado con las familias avanzadas hace que el 55,6 % del dataset sea `advanced` o superior.
