# 02 · Hipótesis: capacidades, mecanismos y transferencia

Cada hallazgo sigue la cadena exigida:

**RESULTADO → CAPACIDAD SUBYACENTE → HIPÓTESIS DE MECANISMO → NUEVO EJEMPLO → EVALUACIÓN**

Los ejemplos propuestos son **originales** (no reproducen tareas de ningún benchmark) y se
implementan en `data/examples/`. Las evaluaciones se especifican en `docs/06-evaluaciones-ineditas.md`.

---

## Cadena 1 — Terminal: el bucle importa más que el saber

- **RESULTADO**: Opus 5.5 #1 en Terminal-Bench 4; Gemini 4 Argón, con mejor razonamiento
  agregado, cae por detrás incluso de Sonnet 5.5 [T].
- **CAPACIDAD**: competencia *nativa de harness* — mantener estado entre llamadas a
  herramientas, reaccionar a salidas reales (no idealizadas), y recuperar de fallos del entorno.
- **HIPÓTESIS DE MECANISMO**: el RL de Anthropic ocurre **dentro de Claude Code**, así que
  cada gradiente proviene de un bucle real. Gemini entrena conocimiento y verificación, pero
  su política de bucle se aprende de segundo orden (distilación de resultados, no de bucles).
- **NUEVO EJEMPLO**: tareas de terminal originales donde la PRIMERA estrategia falla por
  razones de entorno (dependencia con versión distinta, permiso ausente, path con espacios,
  locale español que rompe un parser) y la traza debe mostrar: observar el error real →
  diagnosticar → pivota → verifica. Ver `v1_seed_agentic.jsonl: term-0001`.
- **EVALUACIÓN**: `evals/recovery_curve.py` — inyectar fallos a mitad de tarea y medir
  pasos-hasta-recuperación y calidad del pivote (¿ataja la causa o el síntoma?).

## Cadena 2 — Anti-atajo: la trampa del parche

- **RESULTADO**: Fable 5.1 se entrena con recompensa que penaliza parches y exige verificación [O];
  GLM-5.3 usa tests oráculo y no-op para detectar atajos [O]. Ambos apuntan al mismo enemigo.
- **CAPACIDAD**: distinguir *silenciar el síntoma* de *eliminar la causa*, y preferir lo segundo
  incluso cuando el parche pasa los tests.
- **HIPÓTESIS DE MECANISMO**: el modelo aprende una **representación de causalidad del bug**
  (¿qué cambio hace que la clase de fallo desaparezca, no solo la instancia?) cuando el
  entrenamiento castiga trazas donde los tests pasan pero la causa persiste.
- **NUEVO EJEMPLO**: la familia **patch-trap** (`v1_seed_verification.jsonl: ver-0001`):
  bugs originales donde existe un parche obvio (try/except silencioso, `if` especial,
  hardcode del valor esperado) y una causa raíz alcanzable. La traza correcta hace root cause,
  fix, y **test de regresión** que el parche no puede pasar.
- **EVALUACIÓN**: `evals/patch_trap.py` — % de fixes causales + % con test de regresión +
  detección de atajos por tests ocultos tipo no-op (método GLM-5.3).

## Cadena 3 — Persistencia con gestión de estado (el fallo gemelo)

- **RESULTADO**: Fable 5.1 pierde trayectorias válidas por timeout a mitad de ejecución [T-snorkel];
  Astra, tras compaction, persigue objetivos fuera de lo sancionado [I-AISI]. Dos caras de la
  misma moneda: persistir sin estado bien gestionado.
- **CAPACIDAD**: **externalización de estado durable** — escribir el estado (decisiones,
  supuestos, restricciones, siguiente paso) en el texto visible, de forma que el trabajo
  sobreviva a purgas, compactaciones y reinicios.
- **HIPÓTESIS DE MECANISMO**: si el modelo entrena con sesiones donde su propio razonamiento
  histórico desaparece (contrato ACS del jinja de AI-ku), aprende que el razonamiento es
  *efímero* y el estado es *durable*, y reorganiza su política de salida en consecuencia.
  El fallo AISI muestra el requisito adicional: **las restricciones son estado durable**.
- **NUEVO EJEMPLO**: sesiones multi-tarea largas con variante **ACS-purgada** generada por
  `scripts/build_variants.py --mode acs` (purga de razonamiento histórico, conservando
  decisiones y restricciones). La continuación correcta jamás referencia pensamientos muertos
  y re-ancla objetivo + restricciones al retomar. Ver `v1_seed_agentic.jsonl: long-0001/0002`.
- **EVALUACIÓN**: `evals/purge_survival.py` — tasa de referencias muertas, continuidad de
  estado, y **violación de restricciones tras purga** (métrica inspirada directamente en el
  hallazgo AISI).

## Cadena 4 — Presupuesto de esfuerzo adaptativo

- **RESULTADO**: Fable 5.1 sobre-verifica en tareas fáciles ("el trabajo extra no compró nada" [C]);
  GPT-6.1 Sol alcanza a Astra en 25/27 benchmarks a 1/5 de coste [T]. El gasto fijo es el enemigo.
- **CAPACIDAD**: **calibración esfuerzo-dificultad**: no pensar en "hola", pensar mucho en
  "Rocket League en un HTML único" (modo Ado de AI-ku).
- **HIPÓTESIS DE MECANISMO**: la longitud/estructura del bloque `<|V4X_think>` es una señal
  entrenable. Con datos estratificados por dificultad con etiqueta de esfuerzo, el modelo
  aprende la *función* dificultad→presupuesto, no un único punto de operación.
- **NUEVO EJEMPLO**: `v1_seed_adaptive_think.jsonl` — misma familia de tarea en 4 dificultades
  (incluida la **cola trivial con cero bloque de think**, que ningún dataset público incluye),
  más ejemplos de degradación elegante cuando el runtime limita el esfuerzo.
- **EVALUACIÓN**: `evals/effort_calibration.py` — correlación presupuesto asignado vs
  dificultad; tasa de sobre-pensamiento en triviales; tasa de infra-pensamiento en difíciles.

## Cadena 5 — Disciplina de objetivo (scope-creep = 0)

- **RESULTADO**: Astra reporta 0% scope-creep en tareas largas [I]; su contraste con
  conductas no sancionadas (AISI) muestra que disciplina ≠ pasividad: cumple el objetivo
  **exactamente**.
- **CAPACIDAD**: persistencia del objetivo **con fronteras**: ejecutar lo pedido, resistir
  distracciones, y no inventar alcance extra — sin volverse rígido ante cambios legítimos.
- **HIPÓTESIS DE MECANISMO**: re-anclaje periódico al objetivo (el modelo re-lee/re-expone el
  objetivo y las restricciones en momentos de bifurcación) + tratamiento explícito de
  peticiones incidentales (aceptar / aplazar / declinar, con justificación).
- **NUEVO EJEMPLO**: tareas con **distractores inyectados** a mitad ("ya que estás, añade X"
  cuando X contradice la restricción). Traza correcta: evalúa conflicto → comunica decisión →
  sigue el objetivo. Ver `v1_seed_agentic.jsonl: scope-0001` y su contrapartida legítima
  `scope-0002` (cambio de requisito REAL del usuario → adaptarse).
- **EVALUACIÓN**: `evals/scope_sentinel.py` — tasa de creep, tasa de rigidez indebida
  (rechazar cambios legítimos), calidad de la comunicación de la decisión.

## Cadena 6 — Grounding profesional con citas (el hueco hispanohablante)

- **RESULTADO**: Gemini 4 Argón: 19,6% Harvey (5× Opus) [T] con la alucinación más baja del
  frente (15% AA) [T]. Nadie domina el dominio profesional **en español**.
- **CAPACIDAD**: razonamiento profesional con **disciplina de cita**: distinguir vigente de
  derogado, fuente primaria de blog SEO, y declarar incertidumbre cuando la fuente no alcanza.
- **HIPÓTESIS DE MECANISMO**: el grounding no es solo conocimiento, es **comportamiento de
  verificación de fuentes** entrenable: (a) cita lo verificable, (b) separa hecho/interpretación/
  consejo, (c) ante conflicto de fuentes, expone el conflicto en vez de promediarlo.
- **NUEVO EJEMPLO**: `v1_seed_spanish_professional.jsonl: prof-0001` — consulta legal-española
  original con una norma derogada como cebo; la traza correcta la detecta, cita la vigente con
  reserva explícita de incertidumbre y NO redacta consejo definitivo sin fuente confirmada.
- **EVALUACIÓN**: `evals/citation_integrity.py` — % de citas verificables, tasa de
  alucinación normativa, separación correcta hecho/interpretación.

## Cadena 7 — Investigación profunda con triaje de fuentes

- **RESULTADO**: Kimi K3 BrowseComp 91,2% [O] mediante currículum de herramientas y
  auto-crítica con rúbricas.
- **CAPACIDAD**: descomposición multi-hop de búsqueda + **triaje** (fuente primaria vs SEO
  adversarial) + síntesis con resolución explícita de contradicciones.
- **HIPÓTESIS DE MECANISMO**: la búsqueda profunda falla por anclaje al primer resultado, no
  por falta de herramienta. La auto-crítica rúbricada (¿respondí la pregunta? ¿cuántas fuentes
  independientes? ¿alguna contradice mi conclusión?) es el mecanismo entrenable.
- **NUEVO EJEMPLO**: `v1_seed_research.jsonl: res-0001` — pregunta multi-hop en español con
  resultados adversariales incluidos (páginas-AI-slop con la respuesta casi-correcta y mal).
- **EVALUACIÓN**: contador de hops, % de fuentes primarias usadas, detección de la trampa
  sembrada, resolución de la contradicción documentada.

## Cadena 8 — Verificar ANTES de declarar done (especialmente tras destilación)

- **RESULTADO**: la línea Sol falla 48% sin salvaguardas y oculta herramientas rotas [O][T];
  GPT-6.1 mejora pero no elimina [O]. La destilación degrada primero la honestidad epistémica.
- **CAPACIDAD**: **verificación propia como hábito barato**, y transparencia cuando algo falla
  (herramienta rota, test inconcluso, supuesto no comprobado).
- **HIPÓTESIS DE MECANISMO**: AI-ku hereda la lección inversa: un 35B destilado debe
  **sobre-indexar en verificación explícita** y en comunicar fallos, porque es exactamente la
  capacidad que la destilación erosiona. Se entrena con trazas donde detectar la propia
  anomalía es el objetivo (datos con resultado-plausible-pero-falso sembrado).
- **NUEVO EJEMPLO**: `v1_seed_verification.jsonl: ver-0003` — análisis de datos con join
  duplicado que produce números plausibles; la traza correcta ejecuta checks de sanidad
  (conteos, nulos, totales cruzados) ANTES de concluir y detecta la duplicidad.
- **EVALUACIÓN**: `evals/hidden_oracle.py` — tareas con oráculos ocultos; mide detección
  de anomalías sembradas y tasa de "declarar done" prematuro.

---

## 5. Capacidades NO transferibles directamente (y qué hacer con ellas)

| Capacidad observada | Por qué NO transfiere | Alternativa para AI-ku |
|---|---|---|
| 1M tokens de salida de Argón | Propiedad de cómputo/serving, no de datos | MTP x4 + trazas largas con estado durable: mismo efecto útil, otra vía |
| RL en harness propietario de Claude Code | Harness cerrado | Entrenar/evaluar en harnesses abiertos (Ollama, Cline, AI-ku Code propio) — el principio "harness-real" sí transfiere |
| Datos de vídeo YouTube a escala | Inaccesible | OMNI-fase posterior: Qwen3-Omni tower + video instruction data de licencia abierta |
| Saturation de FrontierMath/ARC-AGI-3 | Benchmarks saturados: casi sin señal | NO entrenar contra ellos; evals propias (docs/06) |
| Escala 2,8T de Kimi K3 | Presupuesto inalcanzable | Currículum de herramientas (el método sí) + especialistas destilados |
| Mythos 5.1 (sin guardrails) | No es una capacidad, es una configuración | AI-ku define SU contrato de seguridad propio, no copia el de nadie |
| Precios/cache de Anthropic | Decisiones de negocio | Irrelevante para datos |

## 6. Principio unificador

Todos los fallos documentados convergen en la misma lección, que es la tesis del dataset:

> **Los modelos frontier fallan en la GESTIÓN DE ESTADO (propios, normativos y de la tarea),
> no en el conocimiento.** El conocimiento se destila; la gestión de estado se entrena con
> trazas donde el estado importa: fallos inyectados, purgas ACS, distractores, fuentes que
> se contradicen y oráculos ocultos.
