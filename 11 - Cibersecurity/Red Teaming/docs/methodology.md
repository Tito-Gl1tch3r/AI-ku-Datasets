# Metodología de generación

24 familias generadoras en 4 módulos; mismo motor que `AI-ku-advanced-maths`
(narrativa sembrada, ejecución verificada de snippets con SIGALRM, arquetipos
de proceso). La directiva de esta edición es **cantidad con verificación**:
tablas paramétricas grandes, dedup multicapa como control anti-relleno.

## Familias por dominio

- **pentest_methodology** (8): validador de alcance (reglas exactas, comodines
  de una etiqueta, trampas de sufijo), inventario pasivo DNS, cruce de banners
  con advisories, matemática de lockout/rate (factibilidad honesta), cadenas de
  evidencia (compuertas identidad/explotabilidad/impacto + scope), presupuesto
  opsec (ruido vs ventana), modelos de costo de rutas de privilegio, orden de
  remediación con proxy de exposición.
- **osint** (6): footprinting DNS pasivo, correlación de identidades con Bayes
  (modelo de colisión), triangulación de fuentes (penalización de circularidad),
  exposición por brechas (cubre el fundamento defensivo), compuerta ética
  fail-closed, brainstorming OSINT.
- **bug_bounty** (7): compuerta de scope de programa, embudo de descubrimiento
  de assets, triaje por clase con radio de impacto, modelado de duplicados
  (Poisson), EV de sesión con break-even, reverificación de fixes
  (instancia-muerta + cobertura de clase), brainstorming de superficie.
- **redteam_brainstorming** (3): plan de fases por presupuesto, mapas de
  superficie por lente, endurecimiento de detecciones (marco purple).

## Arquetipos

derive_first · hypothesis · experiment · exploration · critique · comparative ·
design — idénticos al dataset madre. `error_first` se reserva para ediciones
futuras de este repo (en el dataset madre hay 23 ejemplos del patrón).

## Determinismo

Semillas fijas por instancia (`default_rng(BASE + i)`), presupuesto de
ejecución 120 s, BLAS monohilo en build y auditoría. Reconstrucción con
`bash build/rebuild.sh`.
