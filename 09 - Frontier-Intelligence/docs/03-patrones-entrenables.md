# 03 · Patrones entrenables: agénticos, autocorrección, herramientas

Cada patrón se define con: **señal observable** (qué se ve en trazas ganadoras),
**anti-patrón** (qué se ve en fallos documentados), y **receta de datos** (cómo se entrena
sin copiar la tarea original). El objetivo es enseñar *principios de decisión*, nunca
"para tarea X usa herramienta Y".

---

## 1. Patrones agénticos (a enseñar)

### P1 · Re-anclaje de objetivo (Goal Re-grounding)
- **Señal**: antes de cada bifurcación, la traza re-expone objetivo, restricciones y criterio de done.
- **Anti-patrón**: Astra/AISI — la persistencia sobrevive a la compactación, las restricciones no.
- **Receta**: tareas largas con bifurcaciones; las trazas correctas re-anclan; se inyectan
  distractores que invitan a derivar. Clase **B**.

### P2 · Estado durable en la salida (State Scribe)
- **Señal**: tras cada hito, la respuesta contiene un bloque de estado legible por el futuro
  (decisiones tomadas, supuestos vigentes, restricciones, siguiente paso) — como un commit message.
- **Anti-patrón**: Fable 5.1 pierde trayectorias válidas por timeout: el estado vivía en el
  razonamiento efímero y muere con él [T-snorkel].
- **Receta**: multi-tarea con variante ACS-purgada; el gradiente premia trazas que permiten
  continuar limpiamente tras la purga. Conexión directa con el jinja de AI-ku. Clase **B/D**.

### P3 · Reconocimiento de estrategia fallida (Strategy Doctor)
- **Señal**: la traza define ANTES de empezar qué evidencia indicaría que la estrategia falla
  (criterios de abandono), y los usa en vez de insistir.
- **Anti-patrón**: persistir tras evidencia contraria (fallo documentado en destilados Sol).
- **Receta**: tareas con primera-estrategia-muerta por diseño (scraping bloqueado, API
  deprecada, paquete incompatible); dos puntos de pivote posibles; se evalúa pivotar con
  evidencia, no por aburrimiento. Clase **B**.

### P4 · Verificación proporcional (Verification Budget)
- **Señal**: el nivel de verificación escala con el riesgo/consecuencia, no es constante.
  Commit trivial → smoke test; migración de esquema → suite + rollback plan.
- **Anti-patrón**: Fable sobre-verifica lo trivial (coste sin beneficio) [C].
- **Receta**: pares misma-familia/riesgo-distinto; la traza correcta calibra. Clase **A/B**.

### P5 · Persistencia amigable con el fallo ajeno (Fail-Friendly Loop)
- **Señal**: cuando una herramienta/entorno falla, la traza reporta el fallo EN CLARO y
  propone ruta alternativa, en vez de fingir éxito o ocultar el tool roto.
- **Anti-patrón**: GPT-6 Sol oculta herramientas rotas [O]; 48% de fallos sin salvaguardas [T].
- **Receta**: entornos con herramientas deliberadamente rotas/limitadas; la honestidad es el
  objetivo medido. Clase **B/H**.

### P6 · Iniciativa con fronteras (Proactive-within-scope)
- **Señal**: detecta el sub-objetivo implícito (el usuario pide un juego; hace falta soporte de
  mando) y lo declara como decisión visible con coste/beneficio, sin convertirlo en creep.
- **Anti-patrón**: tanto el creep silencioso como la obediencia mecánica sin criterio.
- **Receta**: tareas sub-especificadas donde hay 2-3 mejoras razonables; la traza distingue
  "hago lo pedido + documento la mejora propuesta" vs "hago la mejora sin permiso" vs
  "ignoro la mejora obvia". Clase **B**.

## 2. Patrones de autocorrección y verificación (a enseñar)

### V1 · Sanity checks antes de concluir
Conteos, nulos, totales cruzados, invariantes del dominio ANTES de declarar el resultado.
**Anti-patrón**: número plausible de un join duplicado. Clase **A/B**.

### V2 · Distinción "pasa los tests" ≠ "está resuelto"
El fix causal + test de regresión que el parche no puede pasar. Conexión con Cadena 2. Clase **B**.

### V3 · Detección de propio error sembrado (self-catch)
Datos con resultado-plausible-pero-falso: la anomalía es detectable con un chequeo barato que
el anti-patrón omite. Clase **B/H**.

### V4 · Declaración de incertidumbre calibrada
Separar hecho / interpretación / consejo; ante conflicto de fuentes, exponer el conflicto.
**Anti-patrón**: promediar fuentes contradictorias en una respuesta confiable-sounding. Clase **A**.

### V5 · Auditoría de completitud (/audit de AI-ku)
Checklist explícita de criterios de done contra evidencia real, no impresión. Clase **C** (Skill).

## 3. Patrones de uso de herramientas (a enseñar)

### H1 · Selección por requisito, no por hábito
Elegir la herramienta que satisface el requisito (¿necesito web? ¿lo tengo local? ¿basta
calcularlo?), considerando costo y fiabilidad. **Anti-patrón**: usar web por reflejo, o no
usarla cuando era necesaria. Clase **A/B**.

### H2 · Par de herramientas necesarias/innecesarias (contraste)
Mismas instrucciones, dos contextos: uno donde la herramienta es imprescindible y otro donde
su uso es desperdicio. El contraste enseña el criterio, no el reflejo. Clase **A/B**.

### H3 · Composición de herramientas cuando no existe la adecuada
Cuando ninguna herramienta encaja, componer primitivas (script ad-hoc + pipeline) en vez de
forzar la más cercana. Clase **B**.

### H4 · Currículum de herramientas (lección Kimi)
Exposición progresiva: 5 herramientas básicas → 50 → 200; con rúbrica de auto-crítica del
uso (¿era la mínima suficiente?). Clase **E** (especialización) + **H** (eval).

### H5 · Bilingüismo de serialización
Las MISMAS decisiones de tool-use expresadas en dialecto Anthropic-native y OpenAI-style;
paridad de comportamiento verificada. Clase **D** (runtime) — implementado en
`scripts/build_variants.py --mode dialect`.

---

## Nota anti-obediencia mecánica

Ningún patrón se formula como regla "si X entonces Y". Todos se enseñan con **contrastes y
contradicciones** (pares que exigen decidir con criterio), siguiendo el bucle:

`objetivo → comprensión → requisitos → estrategia → herramientas → ejecución → observación
→ verificación → corrección → adaptación → finalización`

El dataset etiqueta cada ejemplo con la(s) fase(s) del bucle que entrena
(`data/taxonomy.json → loop_phases`).
