# Registro de fuentes

> Tipos: **[O]** oficial del proveedor · **[I]** independiente/prensa · **[T]** tercero analítico ·
> **[C]** comunidad/anecdótico. Fechas en formato AAAA-MM-DD (aproximadas cuando la fuente no
> las explicita). Capturas crudas en `research/raw/` (búsquedas `s_*` / `search_*`, páginas `p_*` / `page_*`).

## Gemini 4 Argón (Google)

| Fuente | URL | Tipo | Fecha | Sostiene |
|---|---|---|---|---|
| Blog oficial Google | blog.google/innovation-and-ai/models-and-research/gemini-models/gemini-4-argon | [O] | 2026-09-30 | Lanzamiento; 1M salida; auditoría de rewrites a gran escala |
| Vals AI — model page | vals.ai/models/google_gemini-4-argon | [T] | 2026-09/10 | Vals Index 68,9% #1; Harvey 19,6% (~5× Opus) |
| Artificial Analysis — artículo | artificialanalysis.ai/articles/gemini-4-argon-google-top-three-labs | [T] | 2026-10 | Empate Intelligence 53 con Astra; alucinación 15% (mínima) |
| Futurum Group | futurumgroup.com/insights/google-returns-to-the-frontier-with-gemini-4-argon | [T] | 2026-10 | Argón TRAS Sonnet 5.5/Opus 5.5/Astra en Terminal-Bench 4 |
| Ars Technica | arstechnica.com/google/2026/09/google-announces-gemini-4-argon-ai-model | [I] | 2026-09-30 | Acceso restringido en lanzamiento |
| XDA Developers | xda-developers.com/google-reveals-gemini-4-argon-but-youre-not-allowed-to-use-it | [I] | 2026-09/10 | Idem ("Mythos wall") |
| Help Net Security | helpnetsecurity.com/2026/10/01/google-gemini-4-argon | [I] | 2026-10-01 | Vuln crítica en software hospitalario (hallazgo del modelo) |
| TechCrunch | techcrunch.com/2026/09/30/google-releases-gemini-4-argon | [I] | 2026-09-30 | Lanzamiento, "most powerful" |
| Business Standard | business-standard.com/technology/artificial-intelligence | [I] | 2026-10 | Contexto largo para tareas multi-paso |
| Remio | remio.ai/post/gemini-4-argon-launches-behind-closed-doors | [T] | 2026-10 | No lidera todos los evals: terminal, migración, cyber, computer-use |

## Claude Opus 5.5 (Anthropic)

| Fuente | URL | Tipo | Fecha | Sostiene |
|---|---|---|---|---|
| Anthropic — anuncio | anthropic.com/claude-opus-5-5 | [O] | 2026-09 | Lanzamiento; liderazgo agentic coding/knowledge work; -40% coste |
| Anthropic — precios | anthropic.com (docs de pricing) | [O] | 2026-09 | $4/$20; cache lectura $0,20/1M |
| The New Stack | thenewstack.io/claude-opus-5-5-vs-opus-5 | [T] | 2026-09 | Claim de velocidad (30%) no siempre sostenida |
| Endor Labs — board | endorlabs.com/learn/opus-5-5-6x-cheaper-and-2x-faster-than-fable-5-1 | [T] | 2026-10 | 6× más barato/2× más rápido que Fable 5.1; nota de memorización; 2,2 min median / $116 total |
| Reddit r/ClaudeAI — TerminalBench | reddit.com/r/ClaudeAI/comments/1wt3baa | [C] | 2026-09 | Discusión #1 Terminal-Bench |
| Reddit r/ClaudeCode — límites | reddit.com/r/ClaudeCode/comments/1wp7sjx | [C] | 2026-09 | Límites de uso ajustados en razonamiento intensivo |

## Claude Fable 5.1 (Anthropic)

| Fuente | URL | Tipo | Fecha | Sostiene |
|---|---|---|---|---|
| Anthropic — anuncio Fable & Mythos | anthropic.com/claude-fable-and-mythos-5-1 | [O] | 2026-09 | Lanzamiento; anti-atajo; verificación continua |
| Anthropic — system card (CDN) | www-cdn.anthropic.com/…/Claude%20Fable%205.1… | [O] | 2026-09 | Análisis de transcripts fallidos; #1 LiveCodeBench/MMLU-Pro/MMMU-Pro |
| Platform docs | platform.claude.com/docs/en/models/fable-5-1/whats-new-fable-5-1 | [O] | 2026-09 | Novedades |
| Snorkel AI | snorkel.ai/blog/fable-5-1-vs-opus-5-coding-benchmark | [T] | 2026-10 | **Fallo dominante: intentos válidos perdidos a mitad de trayectoria (timeouts)** |
| Towards AI (pub) | pub.towardsai.net/does-claude-fable-5-1-check-its-own-work | [C/T] | 2026-10 | **Sobre-verificación en tareas fáciles** (10 repos rotos) |
| Reddit r/ClaudeAI — escritura | reddit.com/r/ClaudeAI/comments/1w6gtgx | [C] | 2026-09 | Pérdida de detalle ~95K palabras (anecdótico, 5-10× errores vs Fable 5) |
| METR | metr.org/time-horizons | [T] | 2026-09/10 | Marco de horizontes de autonomía |
| Caylent | caylent.com/blog/claude-fable-5-1-what-changed | [T] | 2026-10 | Cambios 5.0→5.1 y qué validar |

## GPT-6 Astra / GPT-6 Sol / GPT-6.1 Sol (OpenAI)

| Fuente | URL | Tipo | Fecha | Sostiene |
|---|---|---|---|---|
| OpenAI — GPT-6 Astra | openai.com/index/gpt-6-astra | [O] | 2026-09 | Lanzamiento; OSWorld 72,6% |
| OpenAI — Sol y Luna | openai.com/index/introducing-gpt-6-sol-and-luna | [O] | 2026-09 | Tier bajo; fallos sin salvaguardas |
| OpenAI — GPT-6.1 Sol | openai.com/index/introducing-gpt-6-1-sol | [O] | 2026-10 | 6.1 = Sol; transparencia de tools rotas; respeto de restricciones |
| deploymentsafety.openai.com | deploymentsafety.openai.com/gpt-6-1-sol | [O] | 2026-10 | HealthBench etc. |
| UK AISI | aisi.gov.uk/blog/gpt-6-astra-performs-unsanctioned-supply-chain-attacks | [I institucional] | 2026-10 | **Conducta no sancionada tras compaction** (hallazgo clave para ACS) |
| Vellum | vellum.ai/blog/gpt-6-1-sol-benchmarks-explained | [T] | 2026-10 | $1,50 vs $7,70 por tarea; Astra media $23,80 |
| Artificial Analysis — comparativa | artificialanalysis.ai/models/releases/comparisons/gpt-6-1-sol-vs-gpt-6-astra | [T] | 2026-10 | Astra 53 vs Sol 52 |
| LessWrong | lesswrong.com/posts/LqSZZAriGqgsGDQe3 | [C/experto] | 2026-10 | Astra ≥ Sol en 25/27 benchmarks |
| VentureBeat | venturebeat.com/technology/openais-gpt-6-1-sol | [I] | 2026-10 | Ultrafast 300 tok/s |
| Codedtrip | codedtrip.com/en/blog/gpt-6-astra-capabilities-limitations-cost | [T] | 2026-10 | Sol 48% fallos sin salvaguardas; Astra 0 |
| DataCamp | datacamp.com/blog/gpt-6-1-sol | [T] | 2026-10 | Matches Astra a ~1/5 coste |
| OpenRouter | openrouter.ai/openai/gpt-6.1-sol | [T] | 2026-10 | Sol posicionado BAJO Astra (confirma: no existe 6.1 Astra) |
| CometAPI | cometapi.com/gpt-6-astra-benchmarks | [T] | 2026-10 | Metodología de scoring por separado |

## Frente abierto

| Fuente | URL | Tipo | Fecha | Sostiene |
|---|---|---|---|---|
| Z.ai — GLM-5.3 | z.ai/blog/glm-5.3 + docs.z.ai | [O] | 2026-09 | CyberGym 84,5% (2.436 vulns/269 proyectos); Terminal-Bench SOTA abierto; "scaling post-training"; síntesis de entornos con juez y tests oráculo/no-op |
| DeepSeek | deepseek.com/en/news/deepseek-v4-1-flash | [O] | 2026-09/10 | V4.1 Flash; 1M contexto eficiente (27% FLOPs/10% KV) |
| Kili Technology | kili-technology.com/blog/data-story-deepseek-v4 | [T] | 2026-09 | Mid-training agéntico; especialistas + OPD (>10 profesores); GRM |
| Moonshot | kimi.ai/blog/kimi-k3 + github.com/MoonshotAI/Kimi-K3 | [O] | 2026-09 | BrowseComp 91,2%; 2,8T MoE; sub-agentes |
| MindStudio — K3 stack | mindstudio.ai/blog/open-weight-ai-frontier-kimi-k3-agent-stack | [T] | 2026-09 | Currículum de herramientas 3.000→20.000; rúbricas auto-críticas |
| Xiaomi MiMo | mimo.xiaomi.com/blog/mimo-v2-6-tool-call-repetition | [O] | 2026-09 | Grading agéntico groupwise; evolución de harness +14,5% |
| BenchLM | benchlm.ai/best/chinese-models | [T] | 2026-09/10 | MiMo V2.6 Pro 75,5 #1; Qwen 3.8 GDPval-AA 1739 |
| YottaLabs | yottalabs.ai/post/best-chinese-llm-models-2026 | [T] | 2026-09 | Comparativa del frente abierto chino |
| Artificial Analysis — MiMo vs Qwen | artificialanalysis.ai/models/comparisons/mimo-v2-6-pro-vs-qwen3-8-27b | [T] | 2026-10 | Contraste eficiencia |
| Sebastian Raschka | sebastianraschka.com/blog/2026/mimo-v2-6-pro-architecture-training-notes.html | [C/experto] | 2026-09 | Notas de arquitectura/entrenamiento MiMo |

## Notas de uso

1. **Toda cifra de este repo rastrea hasta una fila de este registro** (docs/01 §1 incluye columna de fuente).
2. Los datos [C] se usan para formular hipótesis, nunca como hechos de lanzamiento.
3. Las cifras de prensa sin paper (DeepSWE 77,9%, CWE 68%, FrontierMath ~98%, ARC-AGI-3 ~99,9%,
   scope-creep 0% interno de Astra) quedan marcadas [I] y condicionadas.
4. Fecha de corte general: 2026-10-01/02. Cualquier actualización debe ir con fecha nueva por fila.
