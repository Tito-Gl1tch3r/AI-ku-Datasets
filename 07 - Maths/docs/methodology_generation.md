# Metodología de generación

## Principio rector

**Cada ejemplo justifica su existencia.** No se rellena hasta una cifra: se
construyen familias de problemas de investigación, cada una anclada a una
estructura matemática/física real, y cada instancia dentro de una familia varía
el RÉGIMEN (no los adornos): distinto punto de bifurcación, distinto grupo de
Galois, distinto campo de la cadena, distinto U/t, distinto número de Pell.

## Arquitectura

El pipeline vive en `scripts/` y se reconstruye con `build/rebuild.sh`:

```
scripts/schema.py            esquema PyArrow congelado + enums + validación
scripts/narrative.py         motor narrativo + ejecutor verificado de snippets
scripts/generators/
    common.py                arquetipos de proceso (assemble_examples)
    analysis_gen.py          análisis real, medida, operadores, dualidad
    analysis_gen2.py         EDP, complejo, variacional
    algebra_gen.py           grupos, Galois, anillos, representaciones, Jordan
    bio_gen.py               bioinformática y modelado biológico
    physics_gen.py           caos, Lorenz, relatividad, guías de onda, precesión,
                             modos normales, Ising Monte Carlo
    quantum_gen.py           espín, perturbaciones, Rabi, WKB, Hubbard, entrelaza-
                             miento, Grover, Lindblad, fase de Berry, microcausalidad
    comp_gen.py              CG, Monte Carlo, AD inverso
    scidiag_gen.py           potencia estadística, estándares de evidencia, causalidad,
                             crítica de modelos, diagnóstico diferencial, debugging,
                             actualización bayesiana secuencial
    multi_gen.py             Turing, RSA/ECC, Wright-Fisher, Landauer, recocido,
                             epidemias estacionales
    math_ext_gen.py          Pell, funciones generatrices, grafos espectrales,
                             Ramsey, flujos, punto flotante
    flagships.py             piezas frontera artesanales (Feigenbaum, BBP, TFIM,
                             fracción continua de e, LSM/Haldane, TSP-BHH)
scripts/pipeline.py          ensamblado, validación, dedup, splits, Parquet, stats
```

## Arquetipos de proceso (lo que los 128 expertos aprenden)

Cada ejemplo sigue uno de ocho arquetipos explícitos:

1. **derive_first** — encuadre → derivación → cómputo → verificación → conclusión.
2. **hypothesis** — hipótesis H1/H2/H3 → experimento discriminante → actualización → conclusión.
3. **experiment** — conjetura → simulación → contraste con teoría → refinamiento.
4. **error_first** — primer intento (con error REAL plantado) → la verificación lo detecta → diagnóstico → corrección → reverificación.
5. **exploration** — casos pequeños → patrón → conjetura → test computacional → prueba parcial.
6. **critique** — auditoría paso a paso de una afirmación/solución → fallo localizado → reparación.
7. **comparative** — dos métodos en condiciones idénticas → coste/precisión → recomendación razonada.
8. **design** — objetivo → restricciones → diseño (potencia/coste) → regla de decisión.

La distribución real de arquetipos queda registrada en `quality/stats.json`
(vía `task_type` y `verification.error_recovery`).

## Reglas de contenido

- Contenido en inglés técnico; documentación en español.
- El mensaje `user` es autocontenido; el asistente razona como un investigador,
  no recita un manual.
- El código existe porque ayuda a pensar: siempre imprime la evidencia clave
  (`METRICS: k=v`) que después la narrativa cita.
- La narrativa se redacta DESPUÉS de ejecutar el snippet y cita sus números:
  texto == cómputo por construcción.
- Estado epistémico explícito en la conclusión de cada ejemplo
  (`provenance.knowledge_type` + frase correspondiente en el texto).
- Los casos de diagnóstico son ficticios y están etiquetados con
  `fictional_case`; enseñan el método, no medicina.

## Diversidad y anti-monocultivo

- 66 familias generadoras; ninguna aporta > 12 % del dataset.
- Variación por RÉGIMEN: los parámetros de cada tabla cambian la estructura
  cualitativa (periodo, fase, simetría, existencia de solución), no solo el
  número.
- Bancos de frases sembrados (`scripts/narrative.py`) para que la superficie
  textual no sea idéntica entre hermanos de familia.
- Deduplicación agresiva (ver `methodology_verification.md`).
