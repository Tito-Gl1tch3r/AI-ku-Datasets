# Esquema del dataset — `ai-ku-advanced-maths.parquet`

Un único archivo Parquet. Un único esquema. Cada ejemplo (fila) contiene TODOS los
campos, sin excepciones. La fuente de verdad ejecutable es
`scripts/schema.py` (esquema PyArrow congelado).

## Columnas

| Columna | Tipo | Descripción |
|---|---|---|
| `id` | string | Identificador estable `akm-00000` … asignado tras ordenación determinista. |
| `split` | string | `train` (90 %) · `validation` (5 %) · `test` (5 %). Asignado por `sha256("akm-split-v1" + id)[0]/255` — determinista, sin ficheros separados. |
| `domain` | string | Dominio primario (enum de 7 valores, ver abajo). |
| `subdomain` | string | Subdominio dentro del dominio (enum de ~80 valores en `schema.py`). |
| `difficulty` | string | `intermediate` · `hard` · `very_hard` · `extreme` · `frontier`. El dataset está sesgado a difícil+: no contiene ejemplos `intermediate`. |
| `task_type` | string | Tipo de proceso cognitivo (18 valores: `proof`, `derivation`, `problem_solving`, `exploration`, `counterexample_search`, `optimization`, `simulation`, `data_analysis`, `diagnosis`, `solution_critique`, `error_correction`, `method_comparison`, `generalization`, `simplification`, `open_investigation`, `conjecture_formulation`, `experiment_design`, `result_analysis`). |
| `messages` | list<struct{role, content}> | Núcleo conversacional. Roles permitidos: `system`, `user`, `assistant`, `tool`. El último mensaje es siempre `assistant`; un `tool` siempre sigue a un `assistant`. |
| `verification` | struct | Metadatos de verificación (ver abajo). |
| `provenance` | struct | Metadatos de procedencia (ver abajo). |
| `tags` | list<string> | Etiquetas en minúsculas (`sympy`, `monte_carlo`, `multidisciplinar`, `fictional_case`, …). |

## `verification` (struct)

| Campo | Tipo | Descripción |
|---|---|---|
| `has_verification` | bool | El ejemplo contiene fase explícita de verificación. |
| `methods` | list<string> | Métodos usados, enum cerrado: `algebraic_check`, `numerical_check`, `limiting_case`, `dimensional_analysis`, `alternative_method`, `counterexample`, `unit_check`, `small_case_test`, `simulation_cross_check`, `boundary_condition_check`, `symmetry_check`, `code_execution`, `consistency_check`, `order_of_magnitude_check`. |
| `verified_claims` | list<string> | Afirmaciones concretas que fueron verificadas. |
| `error_recovery` | bool | El ejemplo incluye un primer intento erróneo + diagnóstico + corrección + reverificación. |
| `planted_error` | string | Código de la clase de error plantado (vacío si no hay). |
| `code_verified` | bool | `true` si las salidas mostradas fueron ejecutadas de verdad durante la construcción del dataset. |

## `provenance` (struct)

| Campo | Tipo | Descripción |
|---|---|---|
| `knowledge_type` | string | Estado epistémico del contenido: `proven_theorem`, `known_result`, `derivation`, `empirical_evidence`, `hypothesis`, `conjecture`, `intuition`, `approximation`, `numerical_result`, `simulation`, `speculation`. El asistente del dataset etiqueta explícitamente en el texto qué es demostrado, qué es evidencia de simulación y qué es conjetura. |
| `sources` | list<string> | Referencias conceptuales (libros/papers estándar). El dataset sintetiza ejemplos originales; nunca copia texto de las fuentes. |
| `synthesis` | string | Declaración de cómo se construyó el ejemplo. |
| `generator_family` | string | Familia generadora (trazabilidad hasta el script). |
| `language` | string | `en` (contenido del dataset en inglés técnico). |

## Convenciones de `messages`

- Mensaje `system`: encuadre de rol científico (presente en ~75 % de ejemplos).
- Mensaje `user`: enunciado autocontenido — TODOS los números necesarios están en el enunciado.
- Mensajes `assistant`: razonamiento estilo investigador (encuadre → hipótesis → método → derivación → código → verificación → conclusión con estado epistémico).
- Mensajes `tool`: salida real del código mostrado, capturada durante la construcción. Nunca es una salida fabricada.

## Invariantes garantizados por el pipeline

1. Todos los ejemplos comparten exactamente el mismo esquema PyArrow.
2. Cada salida de código fue ejecutada realmente (`code_verified`).
3. Último mensaje = `assistant`; `tool` solo tras `assistant`.
4. `error_recovery == (planted_error != "")`.
5. Sin duplicados exactos (SHA-256 del contenido).
6. Sin duplicados semánticos: se elimina todo par con similitud > 0.90 simultánea en el enunciado y en la evidencia computada (TF-IDF, dos canales).
