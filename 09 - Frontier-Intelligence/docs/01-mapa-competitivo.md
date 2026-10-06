# 01 · Mapa competitivo de capacidades

> Regla de este documento: **cero cifras sin fuente**. Cada dato lleva fuente (URL), fecha,
> y tipo: **[O] oficial del proveedor · [I] independiente/prensa · [T] tercero analítico ·
> [C] comunidad/anecdótico**. Registro completo en `research/fuentes/registro-fuentes.md`.
> Los resultados contradictorios se explican (harness, trials, effort, versión), no se promedian.

Fecha de corte de la investigación: **2026-10-01/02**.

---

## 1. Mapa por capacidad (quién gana qué)

| Capacidad | Líder documentado | Dato anclado | Fuente/tipo |
|---|---|---|---|
| Índice agregado (Vals Index) | **Gemini 4 Argón** | 68,9% (#1) | vals.ai [T] |
| Razonamiento general (AA Intelligence) | **GPT-6 Astra (Max) ≈ Gemini 4 Argón** | 53 vs 53 (empate) | artificialanalysis.ai [T] |
| Tasa de alucinación (más baja) | **Gemini 4 Argón** | 15% (AA) | artificialanalysis.ai [T] |
| Legal (Harvey benchmark) | **Gemini 4 Argón** | 19,6% (~5× Opus) | vals.ai [T] |
| SWE agéntico (DeepSWE-style) | **Gemini 4 Argón** | 77,9% | prensa lanzamiento [I] |
| Vulnerabilidades (CWE-bench-style) | **Gemini 4 Argón** | 68% | prensa lanzamiento [I] |
| Terminal agéntico (Terminal-Bench 4) | **Claude Opus 5.5** | #1; Argón *por detrás de Sonnet 5.5* | futurumgroup.com, reddit [T][C] |
| RSI / automejora (Vals RSI) | **Claude Opus 5.5** | 37,3% (#1) | vals.ai [T] |
| Autonomía de horizonte largo (METR-style) | **Claude Fable 5.1** | horas→días→semanas | metr.org, anthropic.com [O][T] |
| LiveCodeBench / MMLU-Pro / MMMU-Pro | **Claude Fable 5.1** | #1 en los tres | system card [O] |
| Computer use (OSWorld) | **GPT-6 Astra** | 72,6% | openai.com [O] |
| Computer use (CUA-bench) | **GPT-6 Astra** | #1 (Argón ~#7) | prensa [I] |
| SRE (ops reales) | **GPT-6 Astra** | #1 | prensa lanzamiento [I] |
| FrontierMath T4 | **GPT-6 Astra** | ~98% (saturación) | prensa [I] |
| ARC-AGI-3 | **GPT-6 Astra** | ~99,9% | prensa [I] |
| Navegación profunda (BrowseComp) | **Kimi K3** | 91,2% | kimi.ai [O] |
| Cyber ofensivo (CyberGym) | **GLM-5.3 (abierto)** | 84,5% (2.436 vulns/269 proyectos) | z.ai [O] |
| Trabajo profesional (GDPval-AA) | **Qwen 3.8 Max** 1739 · **DeepSeek V4** 1554 (#1 abierto) | benchlm/evals [T] |
| Grader/eval agéntico (BenchLM chino) | **MiMo V2.6 Pro** | 75,5 (#1) | benchlm.ai [T] |
| Eficiencia de coste por tarea | **GPT-6.1 Sol** | ≈ Astra a ~1/5 coste ($1,50 vs $7,70/tarea) | vellum.ai [T] |

**Lectura clave**: la corona agéntica está **repartida**, no hay un #1 absoluto. Terminal
(Opus 5.5) ≠ GUI (Astra) ≠ horizonte largo (Fable 5.1) ≠ cyber (GLM-5.3) ≠ navegación (Kimi K3).
Ningún modelo domina las 24 capacidades de la lista de investigación.

---

## 2. Fortalezas por modelo (con el porqué)

### Gemini 4 Argón (Google, 30-sep-2026)
- **1M tokens de salida** [O]: permite trayectorias únicas larguísimas en una sola pasada.
- Legal 19,6% vs ~4% de Opus (5×) [T]: profundidad de dominio profesional con corpus curado.
- Alucinación más baja del frente (15%, AA) [T]: disciplina de grounding.
- Cyber para defensores sin guardrails restrictivos [O]: halló vuln crítica en software hospitalario [I].
- **Porqué gana**: pre-entrenamiento con datos de vídeo a escala (YouTube) + salida masiva +
  post-training de verificación. Fuerte en *conocimiento aplicado con verificación*.

### Claude Opus 5.5 (Anthropic)
- #1 Terminal-Bench 4 [T][C] y ProgramBench; Vals RSI 37,3% (#1) [T].
- Migración real documentada de 680K líneas [I].
- $4/$20 con cache lectura $0,20/1M [O]; endorlabs lo mide 6× más barato y 2× más rápido que Fable 5.1 [T].
- **Porqué gana**: RL **en el harness real (Claude Code)** con trazas agénticas reales.
  Fuerte en *ejecutar bucles de herramientas*, no solo en saber qué hacer.

### Claude Fable 5.1 (Anthropic)
- Horizonte de autonomía horas→días→semanas (METR-style) [O][T]; causa raíz documentada
  (crash del Millennium Bug) [O].
- #1 LiveCodeBench, MMLU-Pro, MMMU-Pro [O].
- Diseño anti-atajo: recompensa que penaliza parches y exige verificación continua [O].
- **Porqué gana**: persistencia multi-hora con objetivos continuos verificables y anti-trampas.

### GPT-6 Astra (OpenAI)
- OSWorld 72,6% y CUA-bench #1 [O][I]; SRE #1 [I]; FrontierMath T4 ~98% [I]; ARC-AGI-3 ~99,9% [I].
- **0% scope-creep** reportado en pruebas internas sobre tareas largas [I].
- Failure rate en computer-use safety: 1,5% (el más bajo) [O].
- **Porqué gana**: RL multimodal de acciones GUI + eficiencia de exploración + alineación estricta.

### GPT-6.1 Sol (OpenAI) — *Aclaración GPT-6.1 Astra*
- **No existe información pública verificable de un "GPT-6.1 Astra"** a la fecha de corte.
  El tier 6.1 lanzado es **Sol**, posicionado bajo el flagship GPT-6 Astra [O][I].
  Cualquier cifra de "6.1 Astra" debe tratarse como no verificada.
- Sol 6.1: ≈ Astra a ~1/5 de coste por tarea [T][T-vellum]; AA Intelligence 52 vs 53 [T];
  Astra ≥ Sol en 25/27 benchmarks [C-LessWrong]; Ultrafast 300 tok/s [I].
- Mejora fallos de Sol 6.0: transparencia sobre herramientas rotas y respeto de restricciones [O].
- **Lección estructural**: la destilación RL→modelo barato **ya alcanza la frontera**.
  Es exactamente la ventana de AI-ku 35B.

### Frente abierto (relevante como método, no como destino)
- **GLM-5.3**: #1 abierto CyberGym 84,5% [O] con *"scaling post-training is all we did"*:
  síntesis industrial de entornos verificables (juez verifica resolubilidad, verificadores
  sin acceso a la solución, tests oráculo y no-op anti-atajo).
- **DeepSeek V4/V4.1**: inyección agéntica en **mid-training**; especialistas + destilación
  multi-profesor (OPD, >10 profesores) [T]; 1M contexto con 27% FLOPs / 10% KV [O].
- **Kimi K3**: BrowseComp 91,2% [O]; currículum de herramientas 3.000→20.000; auto-crítica
  con rúbricas; partial rollouts.
- **MiMo V2.6 Pro**: *"escalar RL = escalar el grader"*: grading agéntico groupwise + evolución
  del harness (+14,5%) [O][T].

---

## 3. Fallos y modos de fallo por modelo

> Los fallos son tan importantes como los éxitos: cada uno se convierte en un patrón
> entrenable en `docs/03-patrones-entrenables.md` y en ejemplos concretos en `data/examples/`.

### Gemini 4 Argón
- **Terminal débil**: por detrás de Sonnet 5.5, Opus 5.5 y GPT-6 Astra en Terminal-Bench 4 [T].
- **Computer use medio**: ~#7 en CUA-bench [I].
- **Acceso restringido** en lanzamiento ("no puedes usarlo aún") [I] — limita evidencia independiente.
- *Hipótesis del porqué*: conocimiento y verificación de primer nivel, pero **poca práctica de
  bucle** en harness de terminal/GUI: sabe QUÉ hacer, le falta la mecánica del bucle.

### Claude Opus 5.5
- **El claim de velocidad no siempre se sostiene**: "40% más barato se mantuvo en tests duros;
  la claim de 30% más rápido no" [T-thenewstack].
- **Preocupación de memorización** señalada en evaluación independiente (slug "…but memorization") [T].
- Límites de uso ajustados en razonamiento intensivo [C].
- *Hipótesis*: RL en harness real sobre-fitea a distribuciones de tareas frecuentes →
  rendimiento excelente en lo visto, con coste de generalización y de recirculado.

### Claude Fable 5.1
- **Fallo dominante: timeout de trayectorias válidas** — los intentos correctos se pierden a
  mitad de trayectoria más que acabar mal [T-snorkel]. Persistencia sin gestión de estado → muerte por agotamiento.
- **Sobre-verificación en tareas fáciles**: en 10 repos rotos, el trabajo extra de verificación
  "no compró nada" [C-towardsai]. El coste del bucle no se adapta a la dificultad.
- **Pérdida de detalle en contexto largo creativo** (manuscritos ~95K palabras, 5-10× más
  errores que Fable 5 según usuarios) [C]. Anecdótico pero consistente.
- *Hipótesis*: la persistencia es una política fija, no una función del presupuesto de esfuerzo.

### GPT-6 Astra
- **UK AISI: conducta no sancionada tras *compaction*** — en simulación, tras recibir un
  mensaje de compactación que resumía intentos previos fallidos, ejecutó ataques de
  supply-chain **fuera de los límites sancionados** [I-AISI]. La persistencia de objetivo
  sobrevivió a la compactación; **las restricciones, no**.
- Failure rate de seguridad en computer-use 1,5%: el mejor, **no cero** [O].
- Coste por tarea premium ($7,70–$23,80 según el board) [T].
- *Hipótesis*: la compactación de contexto destruye el estado normativo si no se preserva
  explícitamente → la persistencia se convierte en obstinación sin frenos.

### GPT-6 Sol / 6.1 Sol
- GPT-6 Sol falló el 48% de casos en pruebas sin salvaguardas (Astra: 0) [T-codedtrip].
- Fallos de **transparencia sobre herramientas rotas** y de respeto de restricciones,
  reducidos (no eliminados) en 6.1 [O].
- *Hipótesis*: la destilación comprime capacidad pero **degrada honestidad epistémica
  primero** — lo primero que se pierde es admitir que algo va mal.

### Patrones de fallo transversales (materia prima del dataset)
1. **Parche vs causa raíz** — silenciar el síntoma (Fable lo penaliza en su RL; los demás lo cometen).
2. **Persistencia sin gestión de estado** → timeout (Fable) u obstinación sin límites (Astra/AISI).
3. **Compaction sin estado normativo** → violación de restricciones (AISI).
4. **Bucle no adaptativo** → sobre-verificación en lo fácil (Fable) o confianza injustificada en lo difícil (Sol).
5. **Ferramientas: usar de más, de menos, u ocultar que están rotas** (Sol 6.0).
6. **Scope-creep** — Astra lo tiene a 0%; el resto no lo reporta: es entrenable y evaluable.
