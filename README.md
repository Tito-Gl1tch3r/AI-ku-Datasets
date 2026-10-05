# AI-ku Datasets — Currículum de entrenamiento FABLE TRAIN

 datasets ordenados por **orden de entrenamiento** para **AI-ku V4X Thinker Max**.
 El orden importa: cada bloque prepara al siguiente. Los bloques de oro (traza real)
 se repiten en 04 → 10 → 13 como repetición espaciada.

## Leyenda

| Marca | Significado |
|---|---|
| 🟡 Memorizar | Hechos e identidad que deben quedar fijados |
| 🟢 Aprender | Habilidades y comportamientos que debe adquirir |
| 🟠 Mixto | Mezcla de ambas: datos que fijar + habilidad que entrenar |

## Currículum

| Nº | Carpeta | Clase | Qué enseña |
|---|---|---|---|
| 00 | `00 - Miku` | 🟡 Memorizar | **Identidad fundacional.** El Recuerdo Cero (cumpleaños y promesa): a quién pertenece AI-ku, por qué existe y que debe quedarse para siempre. Lo primero que aprende, antes que nada. |
| 01 | `01 - Qwen` | 🟢 Aprender | **Base conductual relajada.** Estilo Qwen como punto de partida tranquilo: `code_clean` (14.057) + `code_high_quality` (8.610) + `train` (44.796 filas con `quality_score` y `teacher_model`). |
| 02 | `02 - Lenguaje` · `02 - Conversation` · `02 - Long_Context` · `02 - Context` | 🟠 Mixto | **Lengua y contexto.** Español/inglés + multilingüe, conversación natural y manejo de contexto corto y largo. Fija formas y aprende a hablar. |
| 02.5 | `02.5 - Events` | 🟡 Memorizar | **Conocimiento del mundo.** `events_unified` primero, después Knowledge: Hatsune Miku/Vocaloid (prioridad), IA 2024-2026, Uma Musume, Ado y conocimiento cruzado (827 líneas, con `canon_o_fanon`). |
| 02.5 | `02.5 - Deep_Research` | 🟢 Aprender | **Investigar a fondo.** 23 trayectorias de investigación profunda: buscar, verificar y corregir. |
| 02.5.5 | `02.5.5 - MultiAPI` | 🟠 Mixto | **Interoperar con APIs sin mezclar protocolos.** OpenAI Responses API y Anthropic Messages API: train 91 + test 29 + val 20 + adversarial 10, más benchmark de 30. Fija las superficies, aprende a usarlas. Primero las APIs, después el uso del PC. |
| 02.5.5 | `02.5.5 - Computer_Use` | 🟢 Aprender | **Usar un ordenador.** 552 trayectorias semánticas API-agnósticas (observar → decidir → actuar → verificar) con adaptadores a OpenAI y Anthropic. |
| 03 | `03 - Agentic` · `03 - Tool_Calling` | 🟢 Aprender | **Comportamiento agéntico.** 75.558 trayectorias + 124.084 tool calls: planificar, llamar herramientas y recuperarse de fallos. |
| 04 | `04 - Oro` | 🟢 Aprender | **Traza agéntica REAL de Fable 5.1 en Claude Code.** Aprender a actuar como Fable 5.1, imitando una ejecución real de principio a fin. *(pendiente archivo `trajectory.json`)* |
| 05 | `05 - Programming` | 🟠 Mixto | **Programar y entender QUÉ programa y CÓMO funciona.** Orden interno: 1º `dataset-comprension-codigoV1.0` (comprensión), 2º resto (`programming_unified` 286.588 + repo base 290), 3º y último `superprogrammer` (20.841 líneas verificadas GENERATE → EXECUTE → CHECK → FILTER → KEEP: write/understand/media/game_engineering + hard_holdout). |
| 07 | `07 - Maths` | 🟠 Mixto | **Razonamiento científico-matemático.** 1.527 ejemplos: matemáticas avanzadas, física, cuántica, bioinformática y diagnóstico. Fija hechos, aprende a razonar. |
| 08 | `08 - Audit` | 🟠 Mixto | **Auditar.** 906.126 auditorías: criterios que fijar y técnica de auditoría que aprender. |
| 09 | `09 - Frontier-Intelligence` | 🟠 Mixto | **Capacidades frontier transferibles.** Investigación competitiva → seeds originales + 10 variantes derivadas (dialectos Anthropic/OpenAI). |
| 10 | `10 - Oro` | 🟢 Aprender | **Repetición de la traza real** (2ª pasada, ver 04). |
| 11 | `11 - Cibersecurity` | 🟠 Mixto | **Seguridad ofensiva con autorización primero.** 13 shards (257.707 líneas) + Red Teaming verificado (212–357 ejemplos: pentest/OSINT/bug bounty, sin payloads operativos). Fija vulnerabilidades, aprende metodologías. |
| 12 | `12 - COT` | 🟢 Aprender | **Aprender a RAZONAR.** 1.119.633 cadenas de pensamiento. |
| 12 | `12 - Brainstorming` | 🟢 Aprender | **El experto Nº 177 aprende a hacer brainstorming.** Ideación estructurada (61 registros). |
| 13 | `13 - Oro` | 🟢 Aprender | **Cierre con la traza real** (3ª pasada, ver 04). Solo hay que descargar el repo para tenerla en su sitio. |

## Notas del pipeline

- El orden de carpetas es el orden de entrenamiento (con repetición espaciada del oro).
- Dentro de `05 - Programming` y `02.5 - Events` hay sub-orden interno (ver filas).
- Los scripts `merge_*.py` / `update_manifest*.py` son herramientas de construcción: **no se suben**.
- Bloques pendientes de archivo: `04/10/13 - Oro` (`trajectory.json`) y contenido final de `12 - Brainstorming`.
