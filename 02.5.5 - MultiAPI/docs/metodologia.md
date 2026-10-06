# Metodología del AI-ku MultiAPI Dataset

## 1. Principio de diseño

El dataset enseña una **capacidad de protocolo**, no plantillas: dado un objetivo, AI-ku debe
ser capaz de (1) identificar qué interfaz tiene delante por evidencia estructural, (2) interpretar
sus reglas, (3) construir la comunicación correcta, (4) usar herramientas si corresponde,
(5) interpretar la respuesta, (6) detectar errores, (7) corregir y (8) continuar. La identidad,
el objetivo y el comportamiento agentic permanecen independientes de la interfaz.

Se rechazó deliberadamente el enfoque de reglas superficiales ("si aparece X → OpenAI"): los
casos adversariales del dataset (prefijo `msg_` compartido, `delta`/`stop` como falsos amigos,
campos con nombres parecidos y significados distintos) castigan exactamente esa estrategia.

## 2. Anatomía de un ejemplo

Cada ejemplo combina: `contexto` (quién llama y con qué evidencia) + `objetivo` (intent) +
`input` (los datos crudos que el modelo debe procesar) + `expected_behavior` (criterios de una
buena respuesta) + `target` (respuesta ideal con payload correcto) +, cuando aporta valor,
`negative` (intento plausible pero incorrecto + por qué está mal + corrección). No se fuerza la
misma estructura conversacional en todos: los ejemplos de reconocimiento son cortos; los de
ciclo agentic, largos y multi-turno.

Convención crítica: los bloques JSON de `input`/`context` **pueden contener mezclas y errores
a propósito** (es el material que se enseña a auditar); los bloques JSON de `target` y de
`negative.correction` son **protocolo limpio** y se validan automáticamente contra la
especificación del ecosistema reclamado.

## 3. Los cuatro planos de fallo

Cualquier error se clasifica antes de actuar — es la competencia central del módulo de errores:

1. **Mi solicitud está mal formada** (400 con param/code): corregir el payload; reintentar sin
   cambiar nada es un bug.
2. **El servicio rechaza / está saturado** (429, 529, 5xx): backoff exponencial con jitter,
   retry-after, tope de intentos, circuit breaker; el payload no se toca.
3. **La capacidad no existe** (audio en Anthropic/Responses, generación de imágenes en
   Anthropic): rediseño o degradación honesta; ningún reintento es aplicable.
4. **Información insuficiente** (timeout propio sin respuesta): observabilidad e
   instrumentación antes de actuar; no clasificar por intuición.

## 4. Política de negativos

- **Contrastivos**: 5 grupos (`g1-tools`, `g2-toolround`, `g3-system`, `g4-image`, `g5-stream`)
  con 4 miembros cada uno — correcto-OpenAI, correcto-Anthropic, mezcla plausible (a auditar) y
  corrección limpia. El grupo viaja siempre al mismo split (ver §5).
- **Embebidos** (`negative` struct): 9 casos donde la respuesta incorrecta es la que un
  integrador real escribiría, con explicación verificable del porqué y corrección.
- **Adversariales** (12): trampas de discriminación (`msg_`, ejes versión/proveedor,
  round-trips de payloads, desemparejamiento semántico de tool results, parsers "universales").

Se excluyen deliberadamente: errores absurdos que ningún modelo razonable produciría, y
cualquier negativo sin explicación verificable.

## 5. Asignación de splits (determinista)

1. Los miembros de un `contrast_pair_id` van **siempre al mismo split** (hash del grupo).
2. `difficulty == "adversarial"` (sin grupo) → `adversarial_test`.
3. El resto: hash del `id` → train 70% / validation 15% / test 15%.
4. Rebalanceo determinista: si un `task_type` queda ausente en validation/test, se mueve un
   ejemplo desde train.

Resultado: 91 / 20 / 29 / 10. El script de validación comprueba que ningún grupo esté partido,
que no haya inputs repetidos entre splits y que la columna `split` coincida con el shard.

## 6. Higiene de datos

- Deduplicación por normalización de `input` (excluyendo intencionalmente a los miembros de
  grupos contrastivos, que comparten input por diseño).
- Re-escapado sistemático del JSON anidado como string (`"output": "{\"k\": 1}"`): los
  payloads modelan el wire format real, donde outputs/arguments/content son **strings JSON**.
- Validación estructural de los `target` con detectores de mezcla y checks por ecosistema
  (ver `validation/checks.py`): envolventes de error, vocabulario de eventos de streaming,
  formas de tool defs, posiciones de tool_result, invariantes de historial.

## 7. Proceso de verificación de especificaciones

1. Búsqueda y lectura de la documentación oficial (octubre 2026) — registro completo en
   `sources.md`.
2. Extracción de firmas verificadas a `docs/api_notes_openai.md` y `docs/api_notes_anthropic.md`.
3. Construcción de ejemplos **originales** sobre esos hechos (nada de la documentación se copia).
4. Validación automatizada + inspección manual de muestra.
5. Registro de limitaciones descubiertas en el propio proceso (README §Limitaciones).

## 8. Evaluación

El benchmark (`eval/`) es **independiente del entrenamiento**: 30 ítems nuevos con superficies
distintas, 27 auto-calificables mediante el harness (que reutiliza los validadores estructurales
para calificar los payloads que el modelo genere) y 3 de rúbrica. El `--self-check` del harness
garantiza que las referencias puntuarían 1.0 — un test del propio sistema de evaluación.
