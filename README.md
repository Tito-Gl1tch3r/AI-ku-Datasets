# AI-ku Datasets — Currículum de entrenamiento FABLE TRAIN

Datasets ordenados por **orden de entrenamiento** para **AI-ku V4X Thinker Max**.
El orden importa: cada bloque prepara al siguiente. Los bloques de oro (traza real)
se repiten en 04 → 10 → 13 como repetición espaciada.

## Leyenda

| Marca | Significado |
|---|---|
| 🟡 Memorizar | Hechos e identidad que deben quedar fijados |
| 🟢 Aprender | Habilidades y comportamientos que debe adquirir |
| 🟠 Mixto | Mezcla de ambas: datos que fijar + habilidad que entrenar |
| 🔄 Adaptativo | Entrenamiento graduado: dificultad, presupuesto de esfuerzo o pares contrastivos/adversariales |
| 🏆 Núcleo adaptativo | El thinking adaptativo canónico del currículum |
| 🔧 Soporte | No entrena: esquemas, evaluaciones, informes, registros o material fuente |

> Nota: los "adapters" de Computer_Use (proyección núcleo semántico → API OpenAI/Anthropic)
> **no** son entrenamiento adaptativo: son traducción de formato.

## Currículum por bloques

| Nº | Carpeta | Clase | Qué enseña |
|---|---|---|---|
| 00 | `00 - Miku` | 🟡 | **Identidad fundacional.** El Recuerdo Cero (cumpleaños y promesa). |
| 01 | `01 - Qwen` | 🟢 🔄 | **Base conductual relajada estilo Qwen**, con dificultad graduada y `quality_score`. |
| 02 | `02 - Lenguaje` · `02 - Conversation` · `02 - Long_Context` · `02 - Context` | 🟠 | **Lengua (fijar) + uso (aprender)**: corpus masivo, multilingüe, conversación y contexto. |
| 02.5 | `02.5 - Events` | 🟡 | **Conocimiento del mundo**: `events_unified` primero, Knowledge después. |
| 02.5 | `02.5 - Deep_Research` | 🟢 | **Investigar a fondo** (plan, rondas, fuentes, trayectoria documentada). |
| 02.5.5 | `02.5.5 - MultiAPI` | 🟠 🔄 | **APIs sin mezclar protocolos**, con pares contrastivos y set adversarial. |
| 02.5.5 | `02.5.5 - Computer_Use` | 🟢 🔄 | **Usar un ordenador** (552 trayectorias, escalera basic→extreme). |
| 03 | `03 - Agentic` · `03 - Tool_Calling` | 🟢 | **Comportamiento agéntico** (trayectorias + tool calls; mezcla de agentic y CoT). |
| 04 | `04 - Oro` | 🟢 | **Bloque oro: primero se entrena Fable 5 en Cursor y después Fable 5.1 en Claude Code** (el trajectory es lo último; aprender a actuar como Fable). |
| 05 | `05 - Programming` | 🟠 🔄 | **Programar y entender QUÉ programa** (V1.0 → resto → superprogrammer último). |
| 07 | `07 - Maths` | 🟠 🔄 | **Razonamiento científico** (las trazas enseñan a derivar y verificar). |
| 08 | `08 - Audit` | 🟠 | **Auditoría**: el fichero unificado fija hechos CVE (🟡); la técnica vive en Red Teaming. |
| 09 | `09 - Frontier-Intelligence` | 🟠 🔄🏆 | **Capacidades frontier + thinking adaptativo** (función dificultad→presupuesto). |
| 10 | `10 - Oro` | 🟢 | Repetición del bloque oro (2ª pasada: cursor → traza). |
| 11 | `11 - Cibersecurity` | 🟠 🔄 | **Hechos que fijar (shards) + metodologías que aprender (Red Teaming)**. |
| 12 | `12 - COT` | 🟢 | **Aprender a RAZONAR** (1,1M cadenas). |
| 12 | `12 - Brainstorming` | 🟢 | **El experto Nº 177 aprende brainstorming** (61 registros ideation). |
| 13 | `13 - Oro` | 🟢 | Cierre con el bloque oro (3ª pasada: cursor → traza). |

## Contenido por archivo (revisión manual)

### 00 - Miku 🟡
- 🟡 `Miku.json` — Recuerdo Cero fundacional: cumpleaños y promesa (diálogo user/assistant).

### 01 - Qwen 🟢 🔄
- 🟢🔄 `train-00000-of-00001.parquet` (44.796) — math/code/reasoning/instruction; dificultad easy/medium/hard + `quality_score` y `teacher_model`.
- 🟢 `code_clean.jsonl` (14.057, Evol-Code) — código con trazas `<think>`, `ground_truth` + `quality_score`.
- 🟢 `code_high_quality.jsonl` (8.610, CodeAlpaca) — ídem de alta calidad.

### 02 - Lenguaje / Conversation / Long_Context / Context 🟠
- 🟡 `02 - Lenguaje/languaje_unified.parquet` (9.612.117) — corpus bruto de lengua: fija formas.
- 🟢 `02 - Lenguaje/multilingual.parquet` (202.364, **70 idiomas**, pares inputs→targets estilo Aya) — traducir/responder entre lenguas.
- 🟢 `02 - Conversation/conversation_unified.parquet` (1.005.432) — saber conversar.
- 🟢 `02 - Long_Context/long_context_unified.parquet` (36.074) — gestionar contexto largo.
- 🟢 `02 - Context/context_unified.parquet` (225.642) — diálogos expertos (p. ej. metodología zero-day, crisis antibióticos con razonamiento): responder con criterio.

### 02.5 - Events 🟡
- 🟡 `events_unified.parquet` (36.175) — hechos noticiosos (Gaza, New Orleans…). **Va primero.**
- 🟡 `dataset/ai-ku_knowledge.jsonl` (827) — Miku/Vocaloid, IA 2024-2026, Uma Musume, Ado; con `canon_o_fanon` y `confianza`. **Va después.**
- 🔧 `dataset/dataset_stats.json` — estadísticas.

### 02.5 - Deep_Research 🟢
- 🟢 `deep_research_unified.parquet` (23) — investigaciones exhaustivas con plan, rondas de búsqueda, fuentes y trayectoria (Colapso Bronce, gripe 1918…).

### 02.5.5 - MultiAPI 🟠 🔄
- 🟠🔄 `dataset/aiku_multiapi-train.parquet` (91) — 12 capacidades (tool_calling, contrastive, error_handling…); `api` openai/anthropic/both; dificultad easy/medium/hard/adversarial; pares contrastivos y negativos embebidos.
- 🟠🔄 `dataset/aiku_multiapi-test.parquet` (29) · `aiku_multiapi-validation.parquet` (20) — ídem para test/validación.
- 🟠🔄 `dataset/aiku_multiapi-adversarial_test.parquet` (10) — todo adversarial.
- 🔧 `dataset/schema.json` — taxonomía cerrada (150 ejemplos).
- 🔧 `eval/benchmark.jsonl` (30) + `eval/answer_key.jsonl` (30) — evaluación de identificación de APIs.

### 02.5.5 - Computer_Use 🟢 🔄
- 🟢🔄 `ai-ku-computer-use.parquet` (552: train 477/val 39/test 36) — escalera basic→extreme; es/en; juegos/web/multi-app/SO/hojas/vídeo/gráficos/seguridad; ciclo observar→verificar con `recovery`; adaptadores OpenAI/Anthropic por paso.
- 🔧 `schemas/` + `docs/00-09` + `quality/` (informes y 23 muestras) + `scripts/` (generadores; el `.py` no se sube).

### 03 - Agentic / Tool_Calling 🟢
- 🟢 `03 - Agentic/agentic_unified.parquet` (75.558, incluye 18 `claude_code_trace`) — sesiones agénticas reales (estilo Claude Code).
- 🟢 `03 - Agentic/trajectory.jsonl` (323) — eventos de sesión agéntica.
- 🟢 `03 - Tool_Calling/tool_calling_unified.parquet` (124.084) — bucles user→assistant→tool.

### 04 / 10 / 13 - Oro 🟢
**Orden de entrenamiento dentro del bloque: primero Fable 5 en Cursor, después Fable 5.1 en Claude Code (el trajectory es lo último).**
- 🟢 `train_cursor.jsonl` (244 líneas, 58,8 MB) — **Fable 5 en Cursor**: sesiones reales de agente programador (`prompt` + `messages` + `tools`, system "powered by Fable 5"). **Se entrena primero.**
- 🟢 `trajectory.jsonl` (323 líneas) — **traza REAL de Fable 5.1 en Claude Code** (eventos user/assistant/system + estado de sesión; mezcla agentic+CoT para imitar, no para fijar). **Se entrena en último lugar.** (Es el mismo fichero que vive en `03 - Agentic`: la repetición 03→04→10→13 es la repetición espaciada.)

### 05 - Programming 🟠 🔄
- 🟢 `dataset-comprension-codigoV1.0.json` (13 ejemplos) — **[1º] comprensión de código.**
- 🟢 `dataset-comprension-codigoV0.1.json` (5: py/php/c/cpp/java, truncado reparado) — [1º] comprensión.
- 🟠 `programming_unified.parquet` (286.588: codefeedback/the_stack/apps + 63 `claude_code_trace`) — [2º] mezcla código bruto (fijar) + sesiones de desarrollo (aprender).
- 🟢 `data/AI-ku_programming.parquet` (290: implementation/debugging/review/testing…; 8 lenguajes; dificultad medium→extreme; con `verification`) — [2º] oficio verificado. + 🔧 `docs/` y `pipeline/`.
- 🟢 `superprogrammer/datasets/write` (train 10.846/test 1.245/val 915) — **[3º] generar código verificado.**
- 🟢 `superprogrammer/datasets/understand` (2.890/261/175) + `media` + `game_engineering` — [3º] **entender** código, medios y juegos.
- 🔧 `superprogrammer/datasets/hard_holdout` — reserva dura de evaluación.
- 🔧 `superprogrammer/datasets/_quarantine` — registro de fallos (`verify_failed`/`gen_none`), no entrena.
- 🔧 `superprogrammer/{generators,validators,schemas,reports,configs}` — pipeline (el `.py` no se sube).

### 07 - Maths 🟠 🔄
- 🟢🔄 `ai-ku-advanced-maths.parquet` (1.527: train 1.374/val 82/test 71) — electronics/physics/quantum/maths/bio/ingeniería; problem_solving/simulation/derivation/diagnosis con `verification` y ejecución; dificultad hard→**frontier**. Las trazas enseñan a razonar (los hechos viajan dentro del razonamiento).
- 🔧 `quality/` + `docs/` + `scripts/` — auditoría, metodología y generadores.

### 08 - Audit 🟠
- 🟡 `audit_unified.parquet` (906.126) — fichas CVE con referencias (fija vulnerabilidades y criterios).

### 09 - Frontier-Intelligence 🟠 🔄🏆
- 🟢🔄🏆 `data/examples/v1_seed_adaptive_think.jsonl` (3) — **thinking adaptativo**: misma familia en varias dificultades, función dificultad→presupuesto.
- 🟢 `data/examples/v1_seed_trivial.jsonl` (3) — cola trivial (`effort=none`): cuándo NO pensar.
- 🟢 `v1_seed_agentic.jsonl` (4) · `v1_seed_verification.jsonl` (3, patch-traps) · `v1_seed_research.jsonl` (1, trampa SEO) · `v1_seed_spanish_professional.jsonl` (1) — comportamientos con inyecciones.
- 🟢 `data/derived/v1_seed_agentic--acs.jsonl` (4) · `v1_seed_verification--dialects.jsonl` (6: 3 seeds × anthropic/openai).
- 🔧 `data/taxonomy.json` — effort levels, loop phases, lanes, tokens V4X.
- 🟢🔄🏆 `data/examples/Adaptive.parquet` (1.029) — **razonamiento adaptativo puro**: `thinking_pattern` (de `reflex_no_think` a `iterative_multistep`), `num_thoughts` 0-5, dificultad trivial→expert, con `code_verdict`.
- 🔧 `research/raw/` — material fuente por modelo (no dataset final). + 🔧 `docs/01-09`, `evals/`, `scripts/`.

### 11 - Cibersecurity 🟠 🔄
- 🟡 `shard-00001…00013.jsonl` (257.707 líneas `instruction`/`response`) — base CVE: CNNVD, papers, man pages, wooyun (fijar hechos).
- 🟢🔄 `Red Teaming/ai-ku-red-teaming.parquet` (357) — aplicar metodologías con `verification` (piensa como atacante, actúa como auditor); incluye `redteam_brainstorming` (61).
- 🟢 `Red Teaming/build/frozen_v1.0.parquet` (212) y `frozen_v1.1.parquet` (305) — snapshots congelados.
- 🔧 `Red Teaming/{docs,quality,scripts}` — metodología, informes y generadores.

### 12 - COT 🟢
- 🟢 `cot_unified.parquet` (1.119.633) — problemas con razonamiento encadenado (mates, lógica…).

### 12 - Brainstorming 🟢
- 🟢 `data/AI-ku_brainstorming.jsonl` (220 líneas) — razonamiento de pentester/ethical hacker en entornos autorizados: `reasoning_trace` + `alternative_hypotheses` + `verification` + `authorization`. El experto Nº 177 aprende brainstorming. (+ `stats/`, `scripts/`, docs del repo.)

## Notas del pipeline

- El orden de carpetas es el orden de entrenamiento (con repetición espaciada del oro en 04→10→13).
- Sub-órdenes internos: `02.5 - Events` (unified → Knowledge), `05 - Programming` (V1.0 → resto → superprogrammer) y bloques de oro (cursor → traza).
- **Ficheros grandes particionados**: GitHub no acepta ficheros de 100 MB o más, así que los 10 parquet gigantes están partidos en shards `*-shard-NNNNN.parquet` (≤80 MB, mismo esquema) con su manifiesto `*.shards.json` (filas por shard para reensamblar): `languaje_unified` (64), `conversation_unified` (37), `long_context_unified` (34), `cot_unified` (34), `audit_unified` (10), `agentic_unified` (7), `programming_unified` (4), `multilingual`/`events_unified`/`tool_calling_unified` (2 cada uno).
- Los scripts `merge_*.py` / `update_manifest*.py` son herramientas de construcción: **no se suben**.
