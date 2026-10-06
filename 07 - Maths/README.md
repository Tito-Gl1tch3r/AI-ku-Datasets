# AI-ku advanced maths

**Dataset de especialización científico-matemática y técnica para el SFT de los 128
expertos de AI-ku V4X Thinker Max 35B.**

Un único dataset · un único formato · un único archivo:
[`ai-ku-advanced-maths.parquet`](ai-ku-advanced-maths.parquet)

| | |
|---|---|
| Ejemplos | **1527** (1717 generados; dedup multicapa) — v1.1 |
| Tokens aprox. | ≈ 1 100 000 (chars/4; ver `quality/stats.json`) |
| Verificación explícita | **100 %** |
| Código realmente ejecutado | **100 %** (`assistant → tool → assistant`), re-auditado 1527/1527 |
| Dificultad | 0 % intermedio · 54 % hard · 35 % very_hard · 10 % extreme · 0.3 % frontier |
| Errores plantados con recuperación | 23 ejemplos ejecutados de principio a fin |
| Dominios | v1.0: matemáticas · física · cuántica · computación matemática · bio/bioinformática · método científico · diagnóstico (House) — **v1.1 añade**: mecánica · electricidad/montaje y mantenimiento · sistemas operativos · redes · electrónica · automatización/PLC · ciberdefensa (+ episódios `BRAINSTORMING` marcados y separados) |
| Idioma del contenido | inglés técnico · documentación del repo en español |
| Cambios v1.0 → v1.1 | +7 dominios técnicos (66 familias nuevas, 120 en total); +19 filas recuperadas que v1.0 perdió por timeout; 17 filas v1.0 sustituidas por equivalentes de sus mismas familias (dedup global del corpus); ids/splits recomputados para v1.1 |

## Qué hace distinto a este dataset

1. **Texto == cómputo.** Ningún número aparece sin haber sido calculado:
   el pipeline ejecuta cada snippet e incrusta su salida real como mensaje
   `tool`. La alucinación numérica no tiene de qué aprender.
2. **Arquetipos de investigación**, no ejercicios: hipótesis → test
   discriminante → actualización; derivar → atacar el propio resultado →
   concluir con estado epistémico etiquetado
   (`provenance.knowledge_type`).
3. **Errores con recuperación completa**: intento erróneo ejecutado,
   detección por invariante, diagnóstico, fix, reverificación.
4. **Densidad de regímenes**: las familias barren transiciones de fase,
   bifurcaciones y parámetros críticos — la estructura cualitativa cambia
   entre hermanos, no el adorno.
5. **Piezas frontera reproducidas desde cero**: constante de Feigenbaum,
   fórmula BBP, brecha crítica de la cadena TFIM, contraste
   Lieb-Schultz-Mattis/Haldane, Pell d = 109, R(3,3) por agotamiento de
   2^15 coloreados.

## Estructura del repositorio

```
ai-ku-advanced-maths.parquet     EL dataset (único archivo de datos)
README.md                        este archivo
docs/
  schema.md                      esquema PyArrow congelado + convenciones
  taxonomy.md                    dominios, subdominios, dificultades, tareas
  methodology_generation.md      cómo se genera (arquetipos, familias, reglas)
  methodology_verification.md    las 6 capas de verificación y dedup
  provenance.md                  fuentes conceptuales y análisis de contaminación
quality/
  quality_report.md              informe final (14 preguntas del encargo)
  stats.json                     estadísticas máquina-legibles
  SAMPLE_REVIEW.md               revisión manual documentada (bug detectado y fix)
  SHA256SUMS.txt                 checksums de todos los artefactos
build/
  rebuild.sh                     reconstrucción determinista de extremo a extremo
scripts/
  schema.py                      esquema + enums + validador (fuente de verdad)
  narrative.py                   motor narrativo + ejecutor verificado de snippets
  pipeline.py                    ensamblado → validación → dedup → splits → Parquet
  generators/                    los 120 generadores de familias + flagships
```

## Reproducibilidad

```bash
bash build/rebuild.sh
```

El pipeline es determinista (semillas fijas por instancia, ordenación
estable, splits por hash de id). Presupuesto de ejecución de cada snippet:
**120 s** (los módulos v1.0 conservan sus presupuestos originales donde eran
explícitos). La reconstrucción sobre la misma máquina produce un Parquet
byte-idéntico; entre máquinas pueden variar un puñado de filas frontera cuyo
tiempo de cómputo ronde el presupuesto o cuya similitud TF-IDF (global al
corpus) caiga en la franja de dedup — la auditoría `quality/AUDIT_RESULTS.json`
re-ejecuta el 100 % de las filas publicadas y debe mantenerse en 0 FAIL.

## Splits

90 % train · 5 % validation · 5 % test, asignados por
`sha256("akm-split-v1" + id)` dentro de la columna `split` del único
Parquet. Congela el split `test` antes de cualquier uso como benchmark.

## Licencia y uso

Dataset interno de entrenamiento para AI-ku. Los enunciados y el código son
originales de este repositorio; las referencias citadas son solo eso —
referencias — y no se reproduce su texto. Revisar `docs/provenance.md`.
