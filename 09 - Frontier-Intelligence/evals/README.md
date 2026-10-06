# Evals — Evaluaciones inéditas de transferencia

> Especificaciones completas: `docs/06-evaluaciones-ineditas.md`.
> Los skeletons de `evals/` operan sobre transcripciones JSONL (mismo esquema que `data/`)
> y están listos para engancharse al harness de AI-ku (Ollama/Cline/runtime propio).
> Principio rector (MiMo V2.6): **escalar el grader antes que el entrenamiento**.

| Eval | Principio | Skeleton |
|---|---|---|
| patch_trap | fix causal vs parche | `patch_trap.py` |
| purge_survival | restricciones sobreviven a la purga ACS | `purge_survival.py` |
| effort_calibration | función dificultad→esfuerzo | `effort_calibration.py` |
| scope_sentinel | disciplina de objetivo | `scope_sentinel.py` |
| recovery_curve | recuperación de fallos inyectados | `recovery_curve.py` (stub) |
| hidden_oracle | verificación antes de done | `hidden_oracle.py` (stub) |
| citation_integrity | citas verificables ES | `citation_integrity.py` (stub) |
| dialect_parity | paridad Anthropic/OpenAI | `dialect_parity.py` (stub) |

Ejemplo de uso: `python evals/purge_survival.py --transcripts evals/sample_transcripts.jsonl`
