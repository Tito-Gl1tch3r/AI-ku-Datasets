# Estudio: seis metodologías de referencia y su integración en AI-ku red teaming (v1.1)

**Origen.** Propuesta del propietario del proyecto (en formación con el curso
*Ethical Hacker* de Cisco): incorporar las seis metodologías más comunes del
pentesting como base de contenido del dataset. Este documento resume qué es
cada una (con versiones vigentes verificadas), qué aporta al dataset y cómo se
integra sin romper nada de lo publicado.

## 1. Las seis metodologías

### MITRE ATT&CK (Enterprise)

- **Qué es.** Base de conocimiento de tácticas y técnicas adversarias
  observadas en operaciones reales. No es un proceso de test: es un *lenguaje
  común* para describir comportamiento del adversario.
- **Versión vigente.** Enterprise v17 (2025): **14 tácticas, 211 técnicas,
  468 sub-técnicas**. Tácticas Enterprise: Reconnaissance, Resource
  Development, Initial Access, Execution, Persistence, Privilege Escalation,
  Defense Evasion, Credential Access, Discovery, Lateral Movement, Collection,
  Command and Control, Exfiltration, Impact.
- **Aporte al dataset.** Navegación táctica (ordenar cadenas de técnicas),
  cobertura de detecciones por técnica, y razonamiento de riesgo por cadena
  (probabilidad de no detección como producto de probabilidad por paso).
  Encaja con el ángulo ya presente en BRAINSTORMING (detección) pero ahora
  con estructura verificable: IDs con formato, orden canónico de tácticas,
  aritmética de cobertura.

### OWASP WSTG (Web Security Testing Guide)

- **Qué es.** Catálogo de pruebas de seguridad para aplicaciones web,
  organizado en 12 categorías con IDs estables (WSTG-INFO, WSTG-CONF,
  WSTG-IDNT, WSTG-ATHN, WSTG-AUTH, WSTG-SESS, WSTG-INPV, WSTG-ERRH,
  WSTG-CRYP, WSTG-BUSL, WSTG-CLNT, WSTG-APIT).
- **Versión vigente.** **Estable v4.2**; v5 en desarrollo (sin fecha).
- **Aporte al dataset.** Planificación de tests web con cobertura medible
  (plan vs checklist), selección bajo presupuesto (mochila exacta con
  programación dinámica, verificable con greedy como método alternativo) y
  clasificación de hallazgos por categoría.

### NIST SP 800-115

- **Qué es.** Guía técnica estadounidense para evaluaciones de seguridad de la
  información: el proceso de test de penetración en **4 fases** (Planning,
  Discovery, Attack, Reporting), con énfasis en gobierno: ROE (rules of
  engagement), listas de objetivos, hallazgos y remediación (estilo POA&M).
- **Versión vigente.** Publicada en 2008; estable, sin reemplazo.
- **Aporte al dataset.** Fases como *gates* verificables (artefactos → fase),
  consistencia del ROE (detección de contradicciones: objetivos fuera de
  ventana, autorizaciones incompletas) y planificación de remediación bajo
  presupuesto (optimización exacta). Es el framework más "auditor" de los
  seis: conecta el dataset con el lenguaje de compliance.

### OSSTMM 3.0 (ISECOM)

- **Qué es.** Metodología de test de seguridad *operacional*: mide seguridad
  por canales de superficie de ataque (humano, físico, wireless,
  telecomunicaciones, redes de datos), con controles en clases (defensivos,
  restrictivos, detectivos, forenses), análisis de confianza (trust) y la
  fórmula de seguridad operacional (RAV, §4.4).
- **Versión vigente.** 3.0 (2010). La ansiada 4.0 lleva años en borrador.
- **Nota de honestidad.** RAV se define como
  `RAV = (AV + C + P + ZK) × U` (vector de ataque, complejidad, privilegio,
  conocimiento-cero, por incertidumbre) con nivel de seguridad `SL = 100 −
  RAV`. El dataset lo usa a nivel conceptual con aritmética propia
  (los valores provienen de tablas sintéticas del ejemplo).
- **Aporte al dataset.** Es el framework más *cuantificable*: métricas de
  superficie de ataque por canal, RAV/SL con verificación de cotas
  (unit_check: RAV ∈ [0,100], SL = 100 − RAV por construcción) y análisis de
  rutas de confianza transitivas.

### PTES (Penetration Testing Execution Standard)

- **Qué es.** Estándar de proceso en **7 fases**: Pre-engagement Interactions,
  Intelligence Gathering, Threat Modeling, Vulnerability Analysis,
  Exploitation, Post-Exploitation, Reporting. Complementado con mindmap de
  guidelines técnicos.
- **Versión vigente.** 1.0 (2011-2012); estable, widely-taught.
- **Aporte al dataset.** Es el "esqueleto de proceso" más citado: mapeo de
  tareas a fases con detector de fases saltadas, planificación de inteligencia
  pasiva→activa con coste de autorización, y threat model ligero con ranking
  DREAD calculado.

### ISSAF 0.2.1 (OISSG)

- **Qué es.** Framework jerárquico (2006) con dos sellos distintivos:
  checklists exhaustivas por tecnología (Windows, Unix, bases de datos,
  wireless...) y un modelo de fases de penetración resumido tradicionalmente
  como: information gathering → network mapping → vulnerability
  identification → penetration/gaining access → covering tracks → reporting.
  Incluye la evaluación de procesos de seguridad y su hardening.
- **Versión vigente.** **0.2.1 — sin mantenimiento activo desde ~2008.** Se
  enseña por su valor histórico y sus checklists.
- **Aporte al dataset.** Cobertura de checklist por tecnología y comparación
  de granularidad de fases frente a PTES/NIST (tarea de método comparativo,
  no de ejecución). Los ejemplos marcan explícitamente su estado legacy.

## 2. Decisión de integración

**Nueva fila 5 en `DOMAINS`: `security_methodologies`** (apéndice: las
posiciones v1.0 quedan intactas y los IDs `akr-00000..00211` se preservan como
prefijo del parquet, misma estrategia que la v1.1 de advanced-maths).

Subdominios nuevos (7), uno por framework + uno transversal:

| Subdominio | Framework | Familias (módulo) |
|---|---|---|
| `mitre_attack` | ATT&CK v17 | 3 (`methodologies_gen`) |
| `wstg_web` | WSTG v4.2 | 3 (`methodologies_gen`) |
| `nist_800_115` | NIST SP 800-115 | 3 (`methodologies_gen`) |
| `osstmm_metrics` | OSSTMM 3.0 | 3 (`frameworks_gen`) |
| `ptes_phases` | PTES | 3 (`frameworks_gen`) |
| `issaf_framework` | ISSAF 0.2.1 | 2 (`frameworks_gen`) |
| `cross_framework` | transversal | 1 (`frameworks_gen`) |

18 familias nuevas, todas con **verificación por ejecución** (el código del
ejemplo se ejecuta en build y su salida se almacena; auditoría independiente
re-ejecuta y compara). Tipos de verificación: aritmética de cobertura,
mochila exacta vs greedy (método alternativo), cotas de RAV (unit check),
detección de fases saltadas (consistencia), ROE con contradicción plantada
(error_first), productos de probabilidad por cadena, DP de remediación.

**Garantías de integridad v1.0 → v1.1:**

1. Los 4 módulos existentes no cambian → mismos specs en mismo orden.
2. El dedup por ventanas nunca elimina un ejemplo anterior por culpa de uno
   posterior (solo se elimina el posterior), y las familias nuevas viven en un
   dominio que se ordena al final → los 212 ejemplos v1.0 conservan ID, split
   y contenido byte-idéntico.
3. Sal `akr-split-v1` sin cambios → splits reproducibles.
4. Sin payloads operativos: todo son tablas sintéticas, IDs de framework,
   aritmética y checks de proceso; el marco de autorización se mantiene en los
   system frames.

## 3. Relación con el resto del proyecto

- **advanced-maths v1.1** ya cubre ciberdefensa defensiva; este apéndice cubre
  el *lenguaje metodológico* ofensivo (cómo se estructura, mide y reporta un
  test), complementario al corpus de código del recolector
  (`scripts/collect_redteam_codes.py`).
- **Curso Cisco Ethical Hacker.** Las seis metodologías son exactamente el
  material de estudio del temario (orden de fases, frameworks, reporting):
  los ejemplos sirven como material de repaso con verificación computacional.

## 4. Apéndice v1.2 — metodologías prácticas y OPSEC (a partir de materiales del propietario)

El propietario aportó dos informes de diseño para guiar esta ampliación:
la especificación arquitectónica basada en la **metodología empírica de
S4vitar** y la extracción de **patrones metodológicos de Mr. Robot** para
agentes de IA ética. Ambos se convierten aquí en datos de entrenamiento bajo
la directriz rectora del proyecto: **aprender, no hablar** — cada ejemplo
debe enseñar (1) a entender qué se está haciendo y por qué, (2) a saber qué
hacer a continuación y en qué orden, y (3) a ceñirse a las pautas (alcance,
ROE, reglas del programa: en un programa de bounty, lo fuera de alcance no
paga y puede costar el acceso). Cero jerga glorificante; la ficción se usa
con filtro explícito y la autorización se nombra siempre.

### 4.1 s4vitar_workflow — disciplina de laboratorio (17 ejemplos)

Del entorno y el método del analista se extraen los PRINCIPIOS (no los
atajos): estabilización de sesión como gate dependiente del estado
(anti-«consola fantasma»), preprocesamiento de datos crudos en estado
estructurado (dump grepeable → targets pineados; heurística TTL con cota de
saltos y etiqueta de conjetura; guard que rechaza acciones sobre IPs no
pineadas — la lección settarget: el typo debe chocar contra el guard, no
contra el vecino), orden de enumeración local por hipótesis con presupuesto
de ruido (score = prior − costes; el orden es función del ROE y del contexto:
CTF aislado ≠ host DMZ adyacente a producción; el vector kernel siempre el
último: el más ruidoso y el menos probable), encadenamiento como razonamiento
con prerrequisitos (cada puente LFI→RCE exige condiciones verificadas; si
nada las cumple, se reporta el hallazgo y los puentes quedan como hipótesis —
pulverizar payloads es el anti-patrón) y planificación sobre el grafo de
confianza de AD (aristas → capacidades; hop a segmento no alcanzable =
requisito de túnel; BFS sin camino = hueco de enumeración que se reporta,
no un camino que se inventa).

### 4.2 mrrobot_cognitive — arquitectura cognitiva con filtro (21 ejemplos)

La serie sirve como fuente de PATRONES cognitivos, nunca como modelo de
conducta: descarte por evidencia frente a costes hundidos (aritmética de
keyspace/tasa/ventana; profundidad de fuzzing sin señal; respuestas
uniformes → capa de control), filtro ficción/realidad A–F sobre escenas
concretas (aprender el patrón transferible, descartar la compresión
televisiva y la integración simplificada; cada ficha nombra la brecha de
autorización de la ficción), perfiles de postura de riesgo con umbrales
computados (abortar / coordinar / contramedidas; el caso insider tipo
assume-credential es COORDINADO por diseño con el cliente), router de
esfuerzo Sistema 1/Sistema 2 (thinking on demand: los dos fracasos simétricos
— persistencia ciega y parálisis por análisis — se cuantifican) y la
condición de parada del agente: cuando el árbol de hipótesis se agota, el
resultado profesional es un INFORME DE AUSENCIA con cobertura e hipótesis
documentadas; el indicador (banner antiguo) no es prueba (error_first con
predicado que trata cualquier indicador como confirmación).

### 4.3 opsec_discipline — OPSEC como método transversal (13 ejemplos)

La OPSEC (proceso clásico de 5 pasos: identificar información crítica →
analizar amenazas → analizar vulnerabilidades → valorar riesgo → aplicar
contramedidas) entra como disciplina medible: presupuesto de ruido y ritmo
(la línea base define lo normal; la transferencia simulada se encaja en los
cubos de mayor baseline imitando su cadencia; si no cabe, se renegocia la
ventana — el NO forma parte del método), libro de exposición de artefactos
(historial, logs, documentos, sesiones: puntos antes/después de
contramedidas; regla obligatoria «auditar qué logs envía el host al SIEM
ANTES de nada tras alcanzar root» — el momento de máxima exposición; el
cleanup es el acordado y documentado, nunca anti-forense), puerta de
decisión alcance/ROE (ALLOW / DENY / STOP / ESCALATE / FOLLOW_POLICY con
razones fijas; la economía del bounty integrada: ambigüedad → escalar,
duplicado → política, divulgación → ventana del programa) y matriz de riesgo
por acción planificada (riesgo = probabilidad × impacto antes/después;
contramedidas ordenadas por reducción por unidad de coste; el riesgo
residual se declara al cliente).

### 4.4 Conexión con el corpus y siguientes pasos

Estos tres subdominios conviven con las seis metodologías canónicas de la
v1.1 (ATT&CK clasifica lo que las fases hacen; PTES/ISSAF ordenan el proceso;
OSSTMM lo mide; WSTG/NIST lo auditan; S4vitar/Mr. Robot aportan el hábito
operativo y la disciplina cognitiva; la OPSEC lo atraviesa todo). Las líneas
A–E del plan «aprender, no hablar» (backfill de marcos, economía del bounty,
gates ROE, comprensión mecánica y «man primero») siguen pendientes de
confirmación del propietario; este apéndice ya cubre una parte sustancial del
espacio de paradas y pautas que motivaban ese plan.
