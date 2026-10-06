# Procedencia de las fuentes

## Naturaleza del contenido

**Todos los ejemplos son sintetizados y originales.** El dataset NO copia
textos, soluciones, trazas ni contenidos protegidos de ninguna fuente. Las
fuentes listadas a continuación se usan como referencias CONCEPTUALES (la
teoría estándar que los ejemplos ejercitan), y cada ejemplo declara sus
referencias en `provenance.sources`.

Cada familia declara además su `synthesis`: una línea que describe cómo se
construyó el ejemplo (p. ej., "censos originales de regímenes del mapa
logístico con exponentes de Lyapunov calculados").

## Referencias conceptuales por área

**Análisis y medida**: W. Rudin, *Principles of Mathematical Analysis*;
G. Folland, *Real Analysis*; H. Brezis, *Functional Analysis*;
Gelfand & Shilov, *Generalized Functions*.

**EDP**: L. Evans, *Partial Differential Equations*; W. Strauss; G. Whitham,
*Linear and Nonlinear Waves*.

**Análisis complejo**: L. Ahlfors, *Complex Analysis*.

**Álgebra y representaciones**: M. Artin, *Algebra*; D. Cox, *Galois Theory*;
J-P. Serre, *Linear Representations of Finite Groups*; R. Irving.

**Teoría de números**: Hardy & Wright, *An Introduction to the Theory of
Numbers*; N. Koblitz, *A Course in Number Theory and Cryptography*.

**Física**: H. Goldstein, *Classical Mechanics*; S. Strogatz, *Nonlinear
Dynamics and Chaos*; Jackson, *Classical Electrodynamics*; Misner-Thorne-Wheeler,
*Gravitation*; Taylor & Wheeler, *Spacetime Physics*; Plischke & Bergersen,
*Equilibrium Statistical Physics*.

**Cuántica**: J. Sakurai, *Modern Quantum Mechanics*; D. Griffiths;
Nielsen & Chuang, *Quantum Computation and Quantum Information*; Breuer &
Petruccione, *The Theory of Open Quantum Systems*; Peskin & Schroeder (solo
conceptos de microcausalidad); P. Fazekas; S. Sachdev; artículos clásicos
(Berry 1984; Lieb-Schultz-Mattis 1961; Haldane 1983; Pfeuty 1970) como
referencias conceptuales.

**Computación matemática**: Trefethen & Bau; N. Higham; Griewank & Walther;
Cormen et al., *Introduction to Algorithms*; Godsil & Royle, *Algebraic Graph
Theory*; H. Wilf, *generatingfunctionology*; Graham-Rothschild-Spencer,
*Ramsey Theory*.

**Biología y bioinformática**: J. Murray, *Mathematical Biology*; W. Ewens,
*Mathematical Population Genetics*; A. Turing (1952) como referencia
conceptual del mecanismo de Turing.

**Método científico e inferencia**: Efron & Hastie, *Computer Age Statistical
Inference*; D. MacKay, *Information Theory, Inference and Learning
Algorithms*; J. Pearl, *Causality*.

## Contaminación

- El dataset no contiene enunciados de benchmarks públicos ni variantes
  cosméticas de ellos: todos los enunciados proceden de las tablas de
  variantes de los generadores de este repositorio (trazables por
  `generator_family`).
- Los resultados computados (autovalores, constantes, soluciones) son
  recalculados en la construcción; cuando un valor coincide con la literatura
  (p. ej., solución fundamental de Pell para d = 109, δ de Feigenbaum), es
  porque ambos derivan del mismo hecho matemático, verificado de forma
  independiente en el snippet.
- Riesgo residual: los patrones de "derivar → verificar" comparten estilo
  entre ejemplos por diseño (es el método científico lo que se enseña). La
  diversidad proviene de los regímenes y las familias, no de la prosa.
