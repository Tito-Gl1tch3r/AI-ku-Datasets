# 08 — Fuentes estudiadas y decisión de licencias

## Referencias estudiadas (no copiadas)

Durante el diseño se estudiaron los datasets públicos de trayectorias GUI citados en los requisitos, como **referencia de taxonomía, action spaces y buenas prácticas de anotación**:

- **AgentNet** — ~22,6K tareas anotadas de uso de escritorio en Windows, macOS y Ubuntu. Referencia para la distribución multiplataforma y la noción de horizonte de tarea.
- **OpenCUA / Uni-GUI-OpenCUA** — trayectorias con acción espacial explícita (click, drag, scroll, key, wait). Referencia para la estructura observación→acción.
- **GroundCUA** — grounding de elementos de interfaz. Referencia para el `ui_tree` con bboxes verificables.
- **ScaleCUA-Data** — escalado de datos de computer use. Referencia para la mezcla de dominios y la discusión de calidad frente a cantidad.

## Inspiración v1.1 (edición de vídeo y gaming)

La expansión v1.1 (dominio `video_editing` y familias de Rocket League / Minecraft / Forza Horizon) se diseñó tras revisar dos tipos de fuentes, **sin copiar ningún registro**:

- **Datasets públicos de computer-use y gaming** (p. ej. las colecciones grandes de markov-ai sobre uso de ordenador y ~500 h de gameplay): consultados **únicamente como idea de cobertura** — qué categorías de tarea existen en editores de vídeo (montaje, audio, color, exportación) y en juegos (control, menús, ajustes, modos foto). Los pesos, nombres, estados, pantallas y trayectorias de este repositorio son 100 % originales y sintéticos; nada de ese material entra en el Parquet ni se deriva de él. La prioridad explícita del proyecto es **calidad sobre cantidad** (552 trayectorias con ciclo completo y verificación, no decenas de miles de pasos crudos).
- **Demos públicas de agentes 2025-2026** (entre ellas la demo de edición de vídeo de Claude Opus 5.5 en YouTube): motivaron la inclusión del editor NLE sintético con línea de tiempo multipista, cortes, audio desincronizado y exportación con fallo de render — las operaciones que un agente real debe dominar en un editor de vídeo.

## Inspiración v1.2 (modelado 3D, CAD y apps de negocio)

La expansión v1.2 (`3d_modeling`, `cad`, `business_apps`) partió de una pregunta concreta: **¿qué aplicaciones dominan el uso real de ordenador que merece la pena aprender?** Para responderla se revisaron las tarjetas públicas de los datasets markov-ai (solo metadatos y README; sin descargar ni copiar ningún registro):

- **`markov-ai/computer-use-large`** (~48.478 grabaciones de software profesional): sus 6 categorías son AutoCAD (2.149 h), Blender (3.624 h), Excel (2.002 h), Photoshop (2.060 h), Salesforce (2.336 h) y VS Code (127 h). Conclusión: **3D, CAD, hojas de cálculo, retoque y CRM empresarial son las aplicaciones profesionales con más horas reales** de usoGUI.
- **`markov-ai/computer-use`** (160 trayectorias OSWorld): dominios chrome, gimp, LibreOffice (calc/impress/writer), multi_apps, os, thunderbird, vlc y vs_code — ya cubiertos en v1.0 por nuestras familias web/graphics/sheets/docs/slides/os.
- **`markov-ai/gaming-500-hours`** (776 sesiones, 494,7 h): Minecraft (41,3 h), Forza Horizon (~18,9 h) y Rocket League (7,7 h) entre los juegos top — la mezcla v1.1 del dataset ya los cubre.

De ahí salieron las tres aplicaciones nuevas de v1.2: **Blender** y **CAD** (las dos categorías con más horas de computer-use-large y ausentes en v1.1) y un **CRM tipo Salesforce** para automatización profesional. Todo lo demás (Chrome, Excel, Photoshop) ya tenía familias propias desde v1.0.

**Nota sobre el vídeo de referencia (pdoom-video, demo de Claude Opus 5.5):** la verificación del repositorio público confirma que ese videoclip **NO fue generado con computer use**: es un renderizado 100 % por código (TypeScript + three.js en Claude Code, exportado con Chrome headless + ffmpeg). No hay capturas de pantalla, ni ratón/teclado sobre una GUI. Por eso el dominio `video_editing` de este dataset se centra en lo que SÍ es computer use de vídeo: operar un **editor NLE gráfico** (línea de tiempo, cuchilla, fundidos, subtítulos, exportación), no en reproducir renders programáticos.

## Decisión: 100 % sintético propio

**No se copió ningún ejemplo, fragmento ni derivado de estos datasets.** Razones:

1. **Licencias**: la compatibilidad de cada fuente con la redistribución comercial y la redistribución como dataset de entrenamiento no es uniforme; mezclarlas contamina la trazabilidad.
2. **Contaminación**: datos públicos pueden solapar con benchmarks y con preentrenamiento de terceros; el generador propio garantiza que el dataset no existe en ningún corpus externo.
3. **Coherencia**: el valor del dataset está en el ciclo completo observación→decisión→acción→resultado→verificación con estado coherente; solo un generador con modelo de estado puede garantizarlo a escala.
4. **Reproducibilidad**: semillas fijas y código incluido: cualquiera regenera el dataset byte a byte y audita cada decisión.

## Documentación de APIs

La representación de las superficies de OpenAI (Responses API, herramienta `computer`, `computer_call.actions`) y Anthropic (`computer_toolset_20260801`, 17 miembros, batch actions, coordenadas en píxeles del screenshot) se basó en la **documentación oficial de ambas plataformas consultada en septiembre de 2026** (ver `docs/03` y `docs/04`). Las notas de emulación (triple clic, hold, zoom en OpenAI) documentan las diferencias de superficie sin acoplar el núcleo semántico a ninguna de las dos.

## Licencias del repositorio

- **Dataset y documentación**: CC-BY-4.0 (atribución requerida).
- **Código del generador** (`scripts/`): MIT.
- Sin PII, sin secretos, sin dominios reales (los dominios ficticios usan el patrón `*.demo.es`).
