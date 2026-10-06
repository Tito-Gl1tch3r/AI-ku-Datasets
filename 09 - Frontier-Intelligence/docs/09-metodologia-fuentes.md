# 09 · Metodología y fuentes

## 1. Metodología

1. **Corpus de investigación**: búsquedas web dirigidas por modelo y por capacidad
   (capturas JSON en `research/raw/`), lectura de fuentes primarias cuando existían.
2. **Regla de evidencia**: ninguna cifra entra al análisis sin fuente, fecha y tipo.
   Se distingue siempre [O] oficial · [I] independiente · [T] tercero analítico · [C] comunidad.
3. **Resultados contradictorios**: no se promedian; se documentan las condiciones que
   diferencian (harness, trials, effort, tools, versión, coste por tarea).
4. **Cadena de abstracción**: cada resultado → capacidad subyacente → hipótesis de mecanismo
   → ejemplo NUEVO → evaluación inédita (`docs/02`). Prohibida la distilación textual.
5. **Clasificación A–H** de cada hallazgo (`docs/04`), con evidence bar para clases
   E (expertos) y G (arquitectura).
6. **Diseño de datos**: taxonomía + proporciones router-aware (`docs/05`), muestras
   originales (`data/examples/`), evaluaciones inéditas (`docs/06`), riesgos (`docs/07`),
   prioridad (`docs/08`).
7. **Reproducibilidad**: las capturas crudas de búsquedas y páginas se incluyen en
   `research/raw/` con sus URLs y fechas de captura (2026-09/10).

## 2. Registro de fuentes principales

| Fuente | Tipo | Fecha | Qué sostiene |
|---|---|---|---|
| blog.google — Gemini 4 Argon announcement | [O] | 2026-09-30 | Lanzamiento, 1M salida, auditoría de rewrites |
| vals.ai — Gemini 4 Argon model page | [T] | 2026-09/10 | Vals Index 68,9% #1; Harvey 19,6% |
| artificialanalysis.ai — artículo Argón | [T] | 2026-10 | Empate 53 con Astra; alucinación 15% |
| futurumgroup.com — insight Argón | [T] | 2026-10 | Argón tras Sonnet/Opus 5.5 y Astra en Terminal-Bench 4 |
| arstechnica / xda-developers | [I] | 2026-09/30 | Acceso restringido en lanzamiento |
| helpnetsecurity.com | [I] | 2026-10-01 | Vuln crítica en software hospitalario |
| anthropic.com — Opus 5.5 | [O] | 2026-09 | Lanzamiento; agentic coding lead; -40% coste |
| thenewstack.io — Opus 5.5 vs Opus 5 | [T] | 2026-09 | Claim de velocidad no siempre sostenido |
| endorlabs.com — board coding | [T] | 2026-10 | 6× más barato/2× más rápido que Fable; nota de memorización; 2,2 min median/$116 |
| anthropic.com — Fable & Mythos 5.1 + system card (CDN) | [O] | 2026-09 | Horizontes, anti-atajo, análisis de transcripts fallidos |
| snorkel.ai — Fable 5.1 vs Opus coding | [T] | 2026-10 | Fallo dominante: intentos válidos perdidos mid-trajectory |
| towardsai (pub) — "I broke 10 repos" | [C/T] | 2026-10 | Sobre-verificación en tareas fáciles |
| reddit r/ClaudeAI — Fable 5.1 creative writing | [C] | 2026-09 | Pérdida de detalle ~95K palabras (anecdótico) |
| metr.org — time horizons | [T] | 2026-09/10 | Marco de horizonte de autonomía |
| openai.com — GPT-6 Astra | [O] | 2026-09 | Lanzamiento; OSWorld 72,6% |
| openai.com — GPT-6 Sol/Luna y GPT-6.1 Sol | [O] | 2026-09/10 | Sol 6.1: transparencia de tools, restricciones |
| aisi.gov.uk — GPT-6 Astra supply-chain eval | [I institucional] | 2026-10 | Conducta no sancionada tras compaction |
| codedtrip.com | [T] | 2026-10 | Sol 48% fallos sin salvaguardas; Astra 0 |
| vellum.ai — benchmarks Astra/Sol | [T] | 2026-10 | $1,50 vs $7,70 por tarea; $23,80 media Astra |
| lesswrong.com — Sol 6.1 vs Astra | [C/experto] | 2026-10 | Astra ≥ Sol en 25/27 |
| venturebeat.com — Sol 6.1 | [I] | 2026-10 | Ultrafast 300 tok/s |
| z.ai — GLM-5.3 | [O] | 2026-09 | CyberGym 84,5%; síntesis de entornos; anti-atajo |
| deepseek.com — V4.1 Flash | [O] | 2026-09/10 | 1M contexto eficiente |
| kili-technology — data story DeepSeek V4 | [T] | 2026-09 | Mid-training agéntico; OPD multi-profesor |
| kimi.ai + github MoonshotAI — Kimi K3 | [O] | 2026-09 | BrowseComp 91,2%; 2,8T MoE; currículum de tools |
| mimo.xiaomi.com + benchlm.ai — MiMo V2.6 | [O/T] | 2026-09 | Grader-first; +14,5% por evolución de harness |

Registro vivo y ampliado: `research/fuentes/registro-fuentes.md`.
Capturas crudas: `research/raw/*.json` (búsquedas `s_*.json` / `search_*.json`,
páginas `p_*.json` / `page_*.json`).

## 3. Crítica de benchmarks usados en la investigación

| Benchmark | Qué mide de verdad | Sesgos probables | Transferible a AI-ku | Específico del benchmark |
|---|---|---|---|---|
| Vals Index | Agregado de tareas profesionales | Mezcla ponderada opaca; selección de tareas | Parcial (mapa de capacidades) | Alto |
| Terminal-Bench 4 | Bucle terminal real | Harness específico; fluctuación por trials | Alto (Cadena 1) | Medio |
| Harvey (legal) | Tareas legal profesional anglo | Dominio jurisdiccional concreto | Parcial — hacer equivalente ES | Alto |
| OSWorld / CUA-bench | Acción GUI real | Flakiness de entorno; capturas/framing | Medio (fase OMNI) | Alto |
| CyberGym | Explotación con PoC en repos reales | Sesgo de cobertura de CVEs | Alto (método de entornos) | Medio |
| BrowseComp | Búsqueda multi-hop profunda | Cache/cambios web con el tiempo | Alto (Cadena 7) | Medio |
| GDPval-AA | Trabajo profesional real | Rúbrica humana variable | Parcial | Medio |
| LiveCodeBench | Código con ventanas temporales | Contaminación si ventana mal cerrada | Medio | Medio |
| METR horizons | Duración de autonomía | Definición de "éxito" por tarea | Alto (Cadena 3) | Medio |
| FrontierMath / ARC-AGI-3 | Extremos matemáticos/abstractos | **Saturados**: poca señal | Bajo | Muy alto |
| HealthBench (Sol) | Salud con rubrica length-adjusted | Dominio anglo | Parcial | Medio |

**Regla**: los benchmarks se usan para LEER (mapa de capacidades), nunca como objetivo de
entrenamiento. La transferencia se comprueba con evals propias (docs/06).

## 4. Limitaciones declaradas

- Cifras de prensa de lanzamiento (DeepSWE 77,9%, CWE 68%, FrontierMath ~98%, ARC-AGI-3
  ~99,9%) son [I] sin paper público todavía: se marcan como tales y no se usan como base de
  decisiones de datos.
- Dato de creative-writing de Fable 5.1 es [C] (anecdótico, muestra pequeña).
- No hay información pública verificable de "GPT-6.1 Astra" (el tier 6.1 es Sol) — ver docs/01 §2.
- Las "trazas reales de Fable 5.1" del proyecto AI-ku (sesión Claude Code completa) son un
  activo PRIVADO del proyecto: este repo no las incluye ni las reproduce; define el molde
  de datos original alrededor de ellas.
