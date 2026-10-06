# 08 · Prioridad experimental: qué probar primero y por qué

> Criterios de ordenación: (a) impacto esperado en capacidades generales, (b) dependencias
> del pipeline de AI-ku (SFT → ROUTER → OMNI → baking → MTP → RL), (c) coste de producir
> los datos, (d) riesgo de rework si se hace tarde.

## Ola 1 — Núcleo de decisión (semanas 1-2 del SFT)

1. **Verificación/autocorrección con anomalías sembradas** (V1-V3 + patch-trap)
   - Por qué primero: es el hallazgo más transversal (Fable, GLM-5.3, Opus convergen) y el
     más barato de producir con contraste. Es el corazón del anti-obediencia-mecánica.
   - Artefactos: `v1_seed_verification.jsonl`, `evals/patch_trap.py`, `evals/hidden_oracle.py`.
2. **Think adaptativo estratificado** (incluida la cola trivial)
   - Por qué: define la función esfuerzo-dificultad ANTES de que RL/baking la congelen; es
     barato y su ausencia es el fallo documentado de Fable (sobre-verificación).
   - Artefactos: `v1_seed_adaptive_think.jsonl`, `evals/effort_calibration.py`.
3. **Scope-disciplina con distractores**
   - Por qué: barato, evaluable con métrica dura (creep %), y protege al resto del pipeline
     (un modelo que deriva contamina cualquier fase posterior).

## Ola 2 — Estado y persistencia (semanas 3-4)

4. **Horizonte largo + variantes ACS** (`build_variants.py --mode acs`)
   - Por qué: depende de fijar primero el estilo de estado durable (Ola 1) para que las
     variantes purgadas sean limpias; alimenta directamente el contrato del jinja.
   - Artefactos: `long-0001/0002` + variantes, `evals/purge_survival.py`.
5. **Pivote de estrategia con criterios de abandono** (P3)
   - Por qué: requiere trazas largas de la ola 2 como base; el contraste muerto/vivo es fácil
     de sintetizar sobre ellas.

## Ola 3 — Superficie y mercado (semanas 5-6)

6. **Bilingüismo de serialización** (`build_variants.py --mode dialect`)
   - Por qué: transformación automática y gratis sobre todo lo anterior; sin decisión de
     contenido, solo de formato. Cualquier momento es bueno, pero hacerlo AL FINAL del SFT
     evita regenerarlo en cada ola.
7. **Profesional ES con citas** (C6)
   - Por qué: el diferenciador de mercado de AI-ku; requiere curación de fuentes normativas
     (más coste de verificación), mejor cuando el molde de honestidad epistémica ya está
     entrenado (ola 1).
8. **Research profundo con triaje** (C7)
   - Por qué: familia más cara (necesita entornos web simulados con trampas); beneficio alto
     pero no bloquea nada del pipeline.

## Ola 4 — Post-SFT (fases ROUTER/OMNI/MTP)

9. **Corpus de calibración para el clustering 177→39** (representativo del despliegue).
10. **OMNI-alignment**: projectors por modalidad, dos etapas; extiende evals 1/7 a modalidad
    visual. (MTP después de esto, nunca antes.)
11. **Feedback MTP→dataset**: tasa de aceptación por familia; las familias con baja aceptación
    ganan densidad de predictibilidad local (código idioma-máquina, fórmulas) — sin degradar
    la variedad.

## Criterio de parada por ola

Cada ola sale solo si la anterior pasa sus evals en **tareas inéditas** (no en train):
Ola 1 exige patch_trap + effort_calibration en hold-out; Ola 2 exige purge_survival al 100%
en restricciones (el criterio AISI); Ola 3 exige dialect_parity ≥98% de paridad de decisión.

## Qué NO hacer primero (y por qué)

- **No empezar por escalado a 10.000**: el molde de ~15 canónicos + variantes valida el
  diseño barato; escalar un molde malo es el rework más caro posible.
- **No entrenar contra benchmarks saturados** (FrontierMath, ARC-AGI-3): sin señal, riesgo
  máximo de contaminación.
- **No forzar lanes/expertos nuevos** antes de medir activación en el SFT (clase E con evidence bar).
