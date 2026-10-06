# Revisión manual de muestra

Revisión humana estratificada sobre el Parquet final (muestreo aleatorio
sembrado + objetivos seleccionados en `extreme`/`frontier`). Metodología:
lectura completa de enunciado, razonamiento, código, salida `tool` y
conclusión; contraste de los números citados con la salida real del snippet;
contraste de resultados clásicos con la literatura.

## Muestra aleatoria (semilla 42)

| id | Dominio/subdominio | Veredicto | Notas |
|---|---|---|---|
| akm-00654 | comp/automatic_differentiation | OK | Gradiente AD == diferencias finitas (10.601925 vs 10.601925). Conclusión con estado epistémico correcto. |
| akm-00114 | math/algebraic_number_theory (extreme) | OK | Pell d=109: x = 158070671986249, y = 15140424455100 — coincide con el valor de la literatura; verificación x²-109y²=1 exacta en el output. |
| akm-00025 | math/frontier_explorations | OK | RSA round-trip True; ed mod phi = 1; ECDLP consistente. |
| akm-00759 | bio/systems_biology | OK | Escaneo de monostabildad/bistabilidad con puntos fijos impresos; conclusión honesta ("no bistable region found") cuando el régimen no lo es. |
| akm-00281 | physics/chaos_and_dynamics | OK | Lorenz rho=24.5: λ = 0.8172 coherente con caos débil cercano a rho_H ≈ 24.74. |
| akm-00250 | physics/statistical_mechanics | OK | Ising L=32, T=2.45: <|m|> = 0.268 ± 0.180, clasificación desorden correcta (T > Tc). |
| akm-00228 | physics/chaos_and_dynamics (extreme) | **BUG detectado y corregido** | λ = -667.8 en r=3.97 (caos profundo): renormalización de Benettin incorrecta (`x2 = x + d*eps` en vez de `x2 = x + diff/d*eps`) + pasos degenerados sin guarda. Corregido y verificado: r=3.97 → λ=0.5998; r=3.2 → λ=-0.9163 = ln(0.16)/2 (valor analítico del ciclo-2: multiplicador 4+2r-r² = 0.16). Dataset regenerado tras el fix. |
| akm-00142 | math/graph_theory | OK | K7: espectro [6,-1×6] exacto; λ2 del laplaciano = 7 (correcto para K_n). |

## Comprobaciones dirigidas adicionales

- Constante de Feigenbaum (flagship): estimaciones convergen hacia
  4.6692 con radii calculados a 1e-12 — ratio final ≈ 4.66 con correcciones
  O(delta^-n) esperadas. OK.
- BBP (flagship): 60 dígitos decimales; hex inicial 3.243F6A8885A3
  consistente. OK.
- Cadenas de Heisenberg N=14: eigsh converge; tendencia del hueco
  decreciente. OK.
- Microcausalidad: conmutador ~0 fuera del cono con modo-sum truncado a
  k=60 (el truncamiento está documentado en el propio ejemplo). OK.
- Vigilancia de certeza falsa: ningún ejemplo con `knowledge_type`
  conjetura/simulación usa lenguaje de certeza ("proven", "guaranteed")
  en la conclusión — chequeado por lectura en la muestra y por la frase
  epistémica incluida en cada conclusión.

## Acciones derivadas

1. FIX del estimador de Lyapunov logístico (código en
   `scripts/generators/physics_gen.py::_logistic_snippet`) — regeneración
   completa del dataset tras el fix.
2. Sin otros hallazgos que requieran acción.


## Auditoría independiente completa (gate final de publicación)

`scripts/audit_calcs.py` re-ejecuta el código de CADA ejemplo del Parquet y
compara la salida con la almacenada (match exacto de string; tolerancia
numérica 2e-6 solo si el esqueleto textual coincide).

**Resultado final: 904/904 PASS, 0 FAIL.**

La auditoría (y la revisión) atraparon y corrigieron CUATRO bugs reales antes
de publicar:

1. **Estimador de Lyapunov (mapa logístico)** — renormalización de Benettin
   incorrecta (`x2 = x + d*eps` en lugar de `x2 = x + diff/d*eps`) y pasos
   degenerados sin guarda: daba λ = -667 en caos profundo. Corregido y
   validado contra el valor analítico del ciclo-2 en r = 3.2
   (λ = ln(0.16)/2 = -0.9163).
2. **Cadena de Heisenberg (flagship LSM/Haldane)** — desalineación de
   coordenadas/valores en la construcción COO de la matriz (el valor
   diagonal `e` caía sobre la coordenada del último flip): la matriz no era
   simétrica y `eigsh` devolvía autovalores sin sentido (huecos no
   monótonos). Corregido el orden de append; certificación densa N=8
   integrada en el snippet (eigsh == eigvalsh a 1e-8); E0/N ahora converge
   a 1/4 - ln2 = -0.443147 con la corrección de tamaño finito esperada y el
   hueco decrece monótonamente (gapless, LSM).
3. **Determinismo de ARPACK** — `eigsh` sin `v0` fijo es no determinista
   entre ejecuciones (auditoría atrapó la discrepancia). Fijado `v0`
   determinista + `tol=0` en TFIM y Heisenberg.
4. **SIR estacional** — el modelo cerrado sin dinámica vital se extingue
   (picos ~1e-7, censo dominado por ruido de redondeo). Reescrito con
   renovación demográfica μ = 0.02 (formulación estándar Olsen-Schaffer),
   con R0 parametrizado; ahora los regímenes regular/marginal/caótico son
   estables y físicamente significativos.

Lección metodológica registrada: la verificación por RE-EJECUCIÓN
independiente + certificación densa dentro del snippet es la única barrera
que atrapa bugs de construcción silenciosos (los 4 pasaron la validación
estructural).
