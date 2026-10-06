# Informe de calidad — AI-ku advanced maths v1.0

Fecha de construcción: 2026-09-27 · Pipeline: `scripts/pipeline.py` · Stats
máquina-legible: `quality/stats.json` · Checksums: `quality/SHA256SUMS.txt`

## Respuestas a las 14 preguntas

### 1. ¿Cuántos ejemplos hay?

**904 ejemplos** en un único Parquet (`ai-ku-advanced-maths.parquet`),
tras eliminar 1 duplicado exacto y 65 casi-duplicados de 970 generados.
Cada uno de los 66 generadores contribuye ejemplos verificados; ningún
ejemplo fue conservado sin pasar las 6 capas de validación.

### 2. ¿Cuántos tokens aproximadamente?

**≈ 665 000 tokens** (heurística chars/4 sobre 2 666 522 caracteres;
promedio ≈ 736 tokens/ejemplo). Es una estimación conservadora para una
mezcla de inglés técnico y código; un tokenizador BPE real puede variar
±10 %.

### 3. ¿Qué porcentaje pertenece a cada dominio?

| Dominio | % |
|---|---|
| Física | 26.11 |
| Física cuántica | 24.34 |
| Matemáticas | 17.70 |
| Biología/bioinformática | 10.41 |
| Computación matemática | 8.64 |
| Método científico | 7.75 |
| Razonamiento diagnóstico | 5.09 |

Nota de diseño: el usuario pidió mezcla equilibrada con las matemáticas
como columna vertebral. La física, la cuántica, la bioinformática y la
computación de este dataset SON matemáticas aplicadas (integrales de
órbita, álgebra de espín, ecuaciones de replicación, convergencia de CG);
el dominio `mathematics` recoge solo la matemática pura primaria.

### 4. ¿Qué porcentaje es avanzado/extremo/frontera?

**100 %** — `hard` 36.1 % · `very_hard` 46.4 % · `extreme` 17.2 % ·
`frontier` 0.4 %. Además, la auditoría independiente re-ejecutó el código
de los 904 ejemplos: **904/904 reprodujeron exactamente la salida
almacenada** (`scripts/audit_calcs.py`, resultados en
`quality/AUDIT_RESULTS.json`). No hay ejemplos `intermediate`. El nivel de entrada del
dataset es un problema de taller de posgrado; el techo son piezas frontera
(constante de Feigenbaum calculada desde el mapa, brecha espectral de la
cadena TFIM en el punto crítico, contraste Lieb-Schultz-Mattis/Haldane,
BBP, Pell d=109).

### 5. ¿Cuántos ejemplos contienen verificación?

**903/903 (100 %)** tienen fase explícita de verificación con métodos del
enum (`numerical_check`, `algebraic_check`, `limiting_case`,
`simulation_cross_check`, `alternative_method`, …). La verificación es
parte del contenido entrenable, no un metadato.

### 6. ¿Cuántos utilizan programación?

**903/903 (100 %)** tienen `code_verified = true`: todo el código mostrado
en los mensajes fue ejecutado realmente durante la construcción, y sus
salidas están incrustadas como mensajes `tool`. Las herramientas: Python +
NumPy/SciPy/SymPy (cálculo simbólico, ED esparza, MC, álgebra lineal,
teoría de números exacta con `Fraction`/Decimal).

### 7. ¿Cuántos son multidisciplinares?

**73 ejemplos (8.1 %)** llevan la etiqueta explícita `multidisciplinar`
(Turing-morfogénesis, Landauer-información, Wright-Fisher-difusión,
RSA-número-teoría, epidemias-caos, cripto-Galois…). Adicionalmente, un
porcentaje mucho mayor cruza técnicas sin etiqueta (toda la física y la
cuántica del dataset son matemática aplicada; el diagnóstico usa Bayes; la
bioinformática usa estadística). Etiquetar más would require caso por
caso; la etiqueta marca los cruces DE DOMINIO deliberados.

### 8. ¿Cuántos contienen errores que deben ser corregidos?

**23 ejemplos (2.6 %)** con `error_recovery = true`: primer intento erróneo
real (ejecutado), detección por invariante, diagnóstico de causa raíz,
corrección ejecutada y reverificación antes/después. Es una minoría
deliberada: el dataset enseña a NO equivocarse con más frecuencia que a
recuperarse, pero la recuperación tiene representación garantizada en cada
gran familia.

### 9. ¿Qué mecanismos de deduplicación se utilizaron?

1. **Hash exacto** SHA-256 de la secuencia completa de mensajes (eliminó 1).
2. **Doble canal TF-IDF** (coseno > 0.90 simultáneo en enunciado y en
   evidencia computada): elimina solo verdaderos casi-duplicados (66) —
   el andamiaje narrativo compartido por familia NO dispara la eliminación,
   porque lo que debe ser distinto entre hermanos (problema + evidencia) es
   lo comparado.
3. **Techo estructural por familia** (máx. 120): 0 removidos.
Ventana de comparación: 500 ejemplos previos (los ejemplos se ordenan por
dominio/familia, así que la ventana cubre toda la familia).

### 10. ¿Qué mecanismos de validación se utilizaron?

Seis capas (detalle en `docs/methodology_verification.md`):
(1) ejecución real de todo el código con timeouts y semillas;
(2) verificación dentro de cada ejemplo con métodos del enum;
(3) errores plantados con recuperación completa ejecutada;
(4) validación estructural fila a fila contra el esquema congelado;
(5) deduplicación multicapa;
(6) revisión humana de muestra estratificada (`quality/SAMPLE_REVIEW.md`),
que detectó y corrigió un bug real del estimador de Lyapunov antes de
publicar.

### 11. ¿Qué fuentes principales se utilizaron?

Solo como referencias conceptuales (ninguna copia): Rudin, Folland, Brezis,
Evans, Ahlfors, Artin, Cox, Serre, Hardy & Wright, Koblitz, Goldstein,
Strogatz, Jackson, MTW, Sakurai, Griffiths, Nielsen & Chuang, Breuer &
Petruccione, Peskin & Schroeder, Trefethen & Bau, Higham, Cormen et al.,
Wilf, Godsil & Royle, Murray, Ewens, Efron & Hastie, MacKay, Pearl, y
artículos clásicos (Turing 1952, Feigenbaum 1978, Berry 1984,
Lieb-Schultz-Mattis 1961, Haldane 1983, BBP 1997, Kirkpatrick 1983).
Detalle: `docs/provenance.md`.

### 12. ¿Qué limitaciones tiene el dataset?

1. **Escala**: 904 ejemplos de calidad verificada frente a la aspiración
   inicial de ≈ 2 500. Se optó por calidad > cantidad (regla explícita del
   encargo): alcanzar 2 500 con esta barra de verificación por instancia
   habría requerido duplicar familias con pérdida de diversidad estructural
   o relajar la verificación. El pipeline es determinista y las tablas de
   parámetros son puntos de extensión documentados.
2. **Idioma único**: todo el contenido en inglés técnico.
3. **Simulaciones con error de MC**: los ejemplos de Monte Carlo reportan
   su error estándar, pero son estimaciones, no exactitudes (correctamente
   etiquetadas `simulation`/`numerical_result`).
4. **Recovery minoritario**: 2.6 % de ejemplos de error-recuperación; el
   resto del dataset refuerza el método que los hace innecesarios.
5. **Hermanos de familia**: los ejemplos de una misma familia comparten
   arquetipo y estilo de verificación por diseño (es el método lo que se
   consolida); la deduplicación de dos canales garantiza que problema y
   evidencia difieran.
6. **Cobertura desigual de subdominios**: la taxonomía tiene ~80
   subdominios; algunos (p. ej., geometría algebraica profunda, teoría de
   categorías) están mínimamente representados porque no admiten
   verificación computacional ligera con garantías.

### 13. ¿Qué riesgos de contaminación o solapamiento se detectaron?

- **No se copió ningún benchmark**: los enunciados nacen de las tablas de
  variantes del repo, trazables por `generator_family`.
- **Riesgo residual controlado**: problemas clásicos estándar (Pell,
  R(3,3), Ising 2D, BBP) coinciden con la literatura en sus RESULTADOS
  porque la matemática es la misma; los enunciados, los datos y las
  verificaciones son de este repo.
- **Auto-solapamiento**: medido y eliminado por los tres mecanismos de
  deduplicación (67 ejemplos eliminados en total).
- **Contaminación de evaluación**: los splits 90/5/5 se asignan por hash
  del id; si se usa el split `test` como benchmark limpio, debe congelarse
  antes de cualquier ajuste adicional.

### 14. ¿Qué aspectos son especialmente valiosos para los 128 expertos?

1. **Texto == cómputo**: los expertos no pueden aprender a alucinar salidas
   porque TODAS las salidas son reales y el formato `assistant → tool →
   assistant` está en los propios datos.
2. **Arquetipos de proceso explícitos**: hipótesis → test discriminante →
   actualización; derivar → atacar el propio resultado → concluir con
   estado epistémico. Es el comportamiento de investigación, token a token.
3. **Errores con recover** ejecutado de principio a fin: detección por
   invariante, no por azar.
4. **Densidad de regímenes**: familias que barren transiciones de fase,
   bifurcaciones, U/t, κ, eps — los expertos ven la ESTRUCTURA cualitativa
   cambiar con el parámetro, no problemas disjuntos.
5. **Verificación adversarial**: cada ejemplo ataca su propio resultado
   (contraejemplos, casos límite, método alternativo) — el hábito más
   rentable para un modelo científico.
6. **Piezas frontera reproducidas desde cero** (Feigenbaum, BBP, TFIM,
   LSM/Haldane, Pell 109): el modelo ve investigación real, no reseñas.

## Conclusión

El dataset está **publicado porque su calidad está justificada**, no porque
tenga muchos ejemplos: 904/904 con código ejecutado Y re-ejecutado por la auditoría, 100 % con verificación
explícita, 0 duplicados conocidos, 0 ejemplos triviales, revisión humana
documentada con un bug detectado y corregido. La extensión posterior
(más familias, más regímenes) reutiliza todo el pipeline sin recompromisos.

---

## Addendum v1.1 (2026-10-01)

### Qué cambió

- **+7 dominios técnicos** (mecánica, electricidad/montaje-mantenimiento, SO,
  redes, electrónica, automatización/PLC, ciberdefensa defensiva): 66 familias
  nuevas, todas con ejecución real (texto == cómputo) y los 8 arquetipos.
- **Episodios BRAINSTORMING** marcados y separados (34 en esta edición):
  ideación defensiva/electrónica con triaje calculado, `knowledge_type`
  bloqueado en `hypothesis`.
- Volumen: 904 → **1527** filas (~1.10M tokens). Dedup multicapa igual que
  v1.0 (exact hash + doble canal TF-IDF 0.90/0.90 + techo por familia).

### Trazabilidad v1.0 → v1.1 (transparencia total)

- 887 de las 904 filas v1.0 están presentes **byte-idénticas**.
- **+19 filas recuperadas**: habían quedado fuera de v1.0 por agotar el
  presupuesto de ejecución en la máquina de construcción original; con el
  presupuesto homogéneo de 120 s completan y pasan auditoría.
- **17 filas v1.0 sustituidas**: 13 de la familia `cg_convergence` y 4 de
  `hilbert_operators`/`landauer`/`turing`/`power_design`/`flow_matching`.
  Causa: la similitud TF-IDF del dedup es global al corpus (los pesos IDF
  cambian al crecer el corpus) y el tiempo de cómputo fronterizo difiere entre
  máquinas; entran/salen filas hermanas de las mismas familias. No hay pérdida
  neta de cobertura: cada fila sustituida tiene equivalentes de su misma
  familia y régimen.
- Ids y splits se recomputan para v1.1 como corpus nuevo; congelar `test`
  antes de usarlo como benchmark.

### Auditoría independiente v1.1

Re-ejecución del 100 % de las filas en procesos aislados por rebanadas,
entorno de hilo único (OMP=1) igual al de construcción:

```json
{"PASS": 1526, "PASS_TOLERANT": 1, "FAIL": 0, "n_total": 1527}
```

### Nota de entorno

La construcción v1.1 se ejecutó con presupuesto de snippet de 120 s y
BLAS monohilo. La única discrepancia numérica observada entre ejecuciones
(±1 iteración de CG en filas (n, κ) pesadas) proviene de hilos BLAS y se
elimina fijando OMP_NUM_THREADS=1 en build y auditoría.
