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

> Nota: los "adapters" de Computer_Use (proyección núcleo semántico → API OpenAI/Anthropic)
> **no** son entrenamiento adaptativo: son traducción de formato.

## Currículum por bloques

| Nº | Carpeta | Clase | Qué enseña |
|---|---|---|---|
| 00 | `00 - Miku` | 🟡 | **Identidad fundacional.** El Recuerdo Cero (cumpleaños y promesa). |
| 01 | `01 - Qwen` | 🟢 🔄 | **Base conductual relajada estilo Qwen**, con dificultad graduada y `quality_score`. |
| 02 | `02 - Lenguaje` · `02 - Conversation` · `02 - Long_Context` · `02 - Context` | 🟠 | **Lengua y contexto** (9,6M lengua + 1M conversación + contexto corto/largo). |
| 02.5 | `02.5 - Events` | 🟡 | **Conocimiento del mundo**: `events_unified` primero, Knowledge después. |
| 02.5 | `02.5 - Deep_Research` | 🟢 | **Investigar a fondo** (mini-set de 23). |
| 02.5.5 | `02.5.5 - MultiAPI` | 🟠 🔄 | **APIs sin mezclar protocolos**, con pares contrastivos y set adversarial. |
| 02.5.5 | `02.5.5 - Computer_Use` | 🟢 🔄 | **Usar un ordenador** (552 trayectorias, escalera basic→extreme). |
| 03 | `03 - Agentic` · `03 - Tool_Calling` | 🟢 | **Comportamiento agéntico** (75K trayectorias + 124K tool calls). |
| 04 | `04 - Oro` | 🟢 | **Traza agéntica REAL de Fable 5.1 en Claude Code** *(pendiente `trajectory.json`)*. |
| 05 | `05 - Programming` | 🟠 🔄 | **Programar y entender QUÉ programa** (V1.0 → resto → superprogrammer último). |
| 07 | `07 - Maths` | 🟠 🔄 | **Razonamiento científico** (dificultad hasta `frontier`, con verificación). |
| 08 | `08 - Audit` | 🟠 | **Auditar** (906K auditorías). |
| 09 | `09 - Frontier-Intelligence` | 🟠 🔄🏆 | **Capacidades frontier + thinking adaptativo** (función dificultad→presupuesto). |
| 10 | `10 - Oro` | 🟢 | Repetición de la traza real (2ª pasada). |
| 11 | `11 - Cibersecurity` | 🟠 🔄 | **Seguridad ofensiva** (257K base + Red Teaming verificado con `verification`). |
| 12 | `12 - COT` | 🟢 | **Aprender a RAZONAR** (1,1M cadenas). |
| 12 | `12 - Brainstorming` | 🟢 | **El experto Nº 177 aprende brainstorming** (61 registros ideation). |
| 13 | `13 - Oro` | 🟢 | Cierre con la traza real (3ª pasada). |

## Contenido por archivo

### 00 - Miku 🟡
- `Miku.json` — Recuerdo Cero fundacional: cumpleaños y promesa (diálogo user/assistant).

### 01 - Qwen 🟢 🔄
- `train-00000-of-00001.parquet` (44.796) 🔄 — dominios math/code/reasoning/instruction (+tool_use); dificultad easy/medium/hard con `quality_score` y `teacher_model`.
- `code_clean.jsonl` (14.057, fuente Evol-Code) — código limpio con trazas `<think>`, `ground_truth` + `quality_score`.
- `code_high_quality.jsonl` (8.610, fuente CodeAlpaca) — ídem de alta calidad.

### 02 - Lenguaje / Conversation / Long_Context / Context 🟠
- `02 - Lenguaje/languaje_unified.parquet` (9.612.117) — corpus de lengua (origen jsonl/parquet/json).
- `02 - Lenguaje/multilingual.parquet` (202.364, **70 idiomas**, split train) — cobertura multilingüe.
- `02 - Conversation/conversation_unified.parquet` (1.005.432) — conversación general multi-fuente.
- `02 - Long_Context/long_context_unified.parquet` (36.074) — contexto largo (origen arrow/jsonl).
- `02 - Context/context_unified.parquet` (225.642) — manejo de contexto.

### 02.5 - Events 🟡
- `events_unified.parquet` (36.175) — eventos/conocimiento general. **Va primero.**
- `dataset/ai-ku_knowledge.jsonl` (827) — Miku/Vocaloid (prioridad), IA 2024-2026, Uma Musume, Ado y cruzado; con `canon_o_fanon`, `confianza`, `tipo` y `corte`. **Va después.**
- `dataset/dataset_stats.json` — estadísticas del dataset.

### 02.5 - Deep_Research 🟢
- `deep_research_unified.parquet` (23) — mini-set de investigación profunda (buscar → verificar → corregir).

### 02.5.5 - MultiAPI 🟠 🔄
- `dataset/aiku_multiapi-train.parquet` (91) 🔄 — 12 capacidades (tool_calling, contrastive_discrimination, error_handling, structural_mapping, api_recognition, streaming…); `api` openai/anthropic/both; dificultad easy/medium/hard/adversarial; pares contrastivos (`contrast_pair_id`) y negativos embebidos (`negative`: intento erróneo + porqué + corrección).
- `dataset/aiku_multiapi-test.parquet` (29) · `aiku_multiapi-validation.parquet` (20) — ídem para test/validación.
- `dataset/aiku_multiapi-adversarial_test.parquet` (10) 🔄 — todo `difficulty=adversarial`.
- `dataset/schema.json` — taxonomía cerrada del dataset (150 ejemplos).
- `eval/benchmark.jsonl` (30) + `eval/answer_key.jsonl` (30) — benchmark de identificación de APIs con grading automático.

### 02.5.5 - Computer_Use 🟢 🔄
- `ai-ku-computer-use.parquet` (552: train 477/val 39/test 36) 🔄 — escalera basic→extreme; es/en; dominios juegos/web/multi-app/SO/hojas/vídeo/gráficos/seguridad; ciclo observar→decidir→actuar→verificar con `recovery`; núcleo semántico + adaptadores OpenAI/Anthropic por paso.
- `schemas/` — record, trajectory, vocabulario de acciones y `adapter-mappings.json` (núcleo ↔ OpenAI ↔ Anthropic).
- `docs/00-09` — visión, esquema, capa semántica, compatibilidad OpenAI/Anthropic, taxonomía, percepción, seguridad, fuentes, reproducción.
- `quality/` — informes + 23 muestras legibles por dificultad.

### 03 - Agentic / Tool_Calling 🟢
- `03 - Agentic/agentic_unified.parquet` (75.558, incluye 18 `claude_code_trace`) — trayectorias agénticas.
- `03 - Agentic/trajectory.jsonl` (323) — log de sesión.
- `03 - Tool_Calling/tool_calling_unified.parquet` (124.084) — llamadas a herramientas.

### 05 - Programming 🟠 🔄
- `dataset-comprension-codigoV1.0.json` (13 ejemplos) — **[1º] comprensión de código.**
- `dataset-comprension-codigoV0.1.json` (5: py/php/c/cpp/java, truncado reparado) — [1º] comprensión.
- `programming_unified.parquet` (286.588: codefeedback/the_stack/apps + 63 `claude_code_trace`) — [2º] programación general.
- `data/AI-ku_programming.parquet` (290: backend/systems/databases/scripting/web/security/data/architecture; implementation/debugging/review/testing…; 8 lenguajes; dificultad medium→extreme) — [2º] verificado. + `docs/` (REPORT/SCHEMA/qc/stats) + `pipeline/` (generadores; el `.py` no se sube).
- `superprogrammer/` — **[3º y ÚLTIMO]**: `datasets/write` (train 10.846/test 1.245/val 915), `datasets/understand` (2.890/261/175), `datasets/media` + `datasets/game_engineering` (medios y juegos: escribir y entender), `datasets/hard_holdout` (reserva dura), `datasets/_quarantine` (5 vacíos intencionales + registro de fallos `verify_failed`/`gen_none`); pipeline GENERATE → EXECUTE → CHECK → FILTER → KEEP (`generators/`, `validators/`, `schemas/`, `reports/`, `configs/`).

### 07 - Maths 🟠 🔄
- `ai-ku-advanced-maths.parquet` (1.527: train 1.374/val 82/test 71) 🔄 — electronics/physics/quantum/maths/bioinformática/ingeniería/ciberdefensa; problem_solving/simulation/derivation/diagnosis; dificultad hard→very_hard→extreme→**frontier**; con `verification` y ejecución de código.

### 08 - Audit 🟠
- `audit_unified.parquet` (906.126) — auditorías multi-fuente (criterios que fijar + técnica que aprender).

### 09 - Frontier-Intelligence 🟠 🔄🏆
- `data/examples/v1_seed_adaptive_think.jsonl` (3) 🔄🏆 — **thinking adaptativo**: misma familia de tarea en varias dificultades; enseña la función dificultad→presupuesto (think corto de 1-3 líneas en fácil, cero razonamiento en trivial). El ejemplo canónico de adaptatividad.
- `data/examples/v1_seed_trivial.jsonl` (3) — cola trivial (`effort=none`): el extremo inferior de la función esfuerzo→dificultad.
- `data/examples/v1_seed_agentic.jsonl` (4) — ciclo agéntico completo coding-terminal con fallo de entorno inyectado.
- `data/examples/v1_seed_verification.jsonl` (3) — verificación con patch-traps (parches obvios que silencian el síntoma).
- `data/examples/v1_seed_research.jsonl` (1) — research web con trampa SEO; `v1_seed_spanish_professional.jsonl` (1) — español profesional con claim normativo falso.
- `data/derived/v1_seed_agentic--acs.jsonl` (4) — variantes con fallos inyectados; `v1_seed_verification--dialects.jsonl` (6) — 3 seeds × dialectos anthropic/openai.
- `data/taxonomy.json` — taxonomía: effort levels, loop phases, lanes (`qwen-coder`, `phi-reasoning`, `nemotron-chat`), tokens V4X.
- `research/raw/` (`p_*`, `page_*`, `s_*`, `search_*` por modelo: astra, opus, kimi, glm, sol, fable…) — material fuente de la investigación, no dataset final.
- `docs/01-09` + `evals/` (`effort_calibration`, `dialect_parity`…) — metodología y evaluaciones inéditas.

### 11 - Cibersecurity 🟠 🔄
- `shard-00001…00013.jsonl` (257.707 líneas `instruction`/`response`) — base de conocimiento: CVEs/CNNVD, papers, man pages, reportes wooyun (fijar hechos).
- `Red Teaming/ai-ku-red-teaming.parquet` (357: train 325) 🔄 — metodologías + `redteam_brainstorming` (61) + pentest/bug_bounty/osint; dificultad hard→intermediate; con `verification`; subdominios ideation/mitre_attack/wstg/nist/osstmm…
- `Red Teaming/build/frozen_v1.0.parquet` (212) y `frozen_v1.1.parquet` (305) — snapshots congelados.

### 12 - COT 🟢
- `cot_unified.parquet` (1.119.633) — cadenas de pensamiento para aprender a razonar.

### 12 - Brainstorming 🟢
- *(vacía; 61 registros `ideation` localizados en Red Teaming, pendientes de colocar)* — el experto Nº 177 aprende brainstorming.

## Notas del pipeline

- El orden de carpetas es el orden de entrenamiento (con repetición espaciada del oro en 04→10→13).
- Sub-órdenes internos: `02.5 - Events` (unified → Knowledge) y `05 - Programming` (V1.0 → resto → superprogrammer).
- Los scripts `merge_*.py` / `update_manifest*.py` son herramientas de construcción: **no se suben**.
- Pendientes: `04/10/13 - Oro` (`trajectory.json`) y contenido final de `12 - Brainstorming`.
