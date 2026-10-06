# Metodología de verificación

La promesa central del dataset: **ningún número aparece en un ejemplo sin haber
sido calculado realmente durante la construcción**. Esto convierte la calidad
de contenido en una propiedad verificable del pipeline, no en una promesa.

## Capa 1 — ejecución real de todo el código

- Cada ejemplo contiene un snippet Python que el pipeline ejecuta de verdad
  (`scripts/narrative.py:run_snippet`), con:
  - timeout por snippet (25-90 s según familia),
  - namespace controlado (numpy, scipy, sympy pre-importados),
  - supresión de warnings (la salida `tool` es solo stdout),
  - determinismo: toda aleatoriedad usa `np.random.default_rng(semilla)`
    derivada del índice de instancia.
- La salida capturada se inserta textualmente como mensaje `tool`. El texto de
  la narrativa cita los mismos números (parseados de líneas `METRICS: k=v`).
- Si un snippet falla, la familia entera falla en la construcción: el pipeline
  no publica ejemplos con código no ejecutado.

## Capa 2 — verificación dentro de cada ejemplo

Cada ejemplo incluye al menos un método del enum `verification.methods`
aplicado explícitamente en el texto:

| Método | Ejemplo de uso |
|---|---|
| `algebraic_check` | Cayley-Hamilton residual ≈ 0; ortogonalidad de caracteres. |
| `numerical_check` | Cuadratura adaptativa vs forma cerrada; autovalores vs fórmula. |
| `limiting_case` | Límite no relativista; caso neutro s=0 → u = p exacto. |
| `dimensional_analysis` / `unit_check` | Auditoría de unidades en colas y proyectiles. |
| `alternative_method` | Perturbación vs diagonalización exacta; WKB vs matriz de transferencia. |
| `counterexample` | Búsqueda exhaustiva de 2-coloreados; contraejemplo de UFD. |
| `small_case_test` | Casos n pequeños por fuerza bruta contra la fórmula general. |
| `simulation_cross_check` | MC vs teoría (difusión, Onsager, potencia estadística). |
| `boundary_condition_check` | Condiciones de contorno de EDP verificadas numéricamente. |
| `symmetry_check` | Bipartición espectral; conservación de H en Lotka-Volterra. |
| `code_execution` | El snippet mismo es la verificación. |
| `consistency_check` | Batalla secuencial vs por lotes en Bayes; flujo = corte. |

## Capa 3 — errores plantados con recuperación (~x % del dataset)

Los ejemplos con `error_recovery = true` contienen:
1. un **primer intento erróneo** cuyo código se ejecuta de verdad y produce una
   salida plausible-pero-equivocada;
2. la **detección** por una sonda/invariante explícita;
3. el **diagnóstico** de la causa raíz;
4. el **código corregido** — también ejecutado;
5. la **reverificación** (antes/después en la misma salida).

Clases de error plantadas: signo invertido, orden de actualización,
incompatibilidad de unidades, desplazamiento de índice (look-ahead),
cancelación catastrófica, desbordamiento de softmax, rango de histograma que
descarta datos silenciosamente, condición de entrechocado (bracket) inválida.

## Capa 4 — validación estructural del dataset completo

`scripts/pipeline.py` sobre CADA ejemplo antes de publicar:
- conformidad con el esquema PyArrow congelado;
- enums válidos (dominio/subdominio/dificultad/tarea/roles/métodos);
- último mensaje `assistant`; `tool` solo tras `assistant`;
- coherencia `error_recovery` ↔ `planted_error`;
- longitudes mínimas/máximas (400-48 000 caracteres);
- identificadores únicos; splits válidos.

## Capa 5 — deduplicación multicapa

1. **Hash exacto** (SHA-256 de la secuencia de mensajes).
2. **Doble canal TF-IDF**: se elimina un ejemplo solo si su ENUNCIADO y su
   EVIDENCIA COMPUTADA (salidas `tool`) superan ambos coseno > 0.90 frente a
   un ejemplo previo. El andamiaje narrativo compartido dentro de una familia
   NO provoca eliminación — lo que debe ser distinto entre hermanos es el
   problema y la evidencia, y eso es exactamente lo que se compara.
3. **Techo por familia** (120 instancias máximo).

## Capa 6 — revisión humana

Revisión manual de una muestra estratificada registrada en
`quality/SAMPLE_REVIEW.md`, incluida la detección y corrección de un bug real
del estimador de Lyapunov (renormalización de Benettin incorrecta) antes de la
publicación.
