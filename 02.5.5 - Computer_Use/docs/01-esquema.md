# 01 — Esquema del dataset

Una fila del Parquet = una trayectoria completa. Las columnas planas permiten filtrado y agregación directas; los bloques ricos se guardan como cadenas JSON UTF-8 con esquema validado (ver `schemas/record.schema.json` y `schemas/trajectory.schema.json`).

## Columnas

| Columna | Tipo | Contenido |
|---|---|---|
| `id` | string | `aku_cu_000001`… identificador estable |
| `schema_version` | string | `1.0.0` |
| `split` | enum | `train` / `validation` / `test` (por familia) |
| `platform` | enum | `windows_11`, `windows_10`, `macos_15`, `ubuntu_24_04` |
| `application` / `applications_all` | string / JSON | aplicación principal y lista completa |
| `domain`, `task_type`, `difficulty`, `horizon` | enums | taxonomía (ver doc 05) |
| `n_steps`, `n_observations`, `n_screenshots` | int | métricas de volumen |
| `est_duration_s` | int | duración estimada de la ejecución |
| `long_horizon`, `is_multi_app`, `is_open_ended`, `has_recovery`, `has_verification` | bool | banderas auditables |
| `language`, `license` | string | `es`/`en` · `CC-BY-4.0` |
| `objective` | string | objetivo del usuario en lenguaje natural |
| `messages` | JSON | diálogo normalizado: objetivo del usuario (+ mensajes intermedios con `context_step`), cierre del asistente |
| `trajectory` | JSON | lista de pasos (el corazón del dataset) |
| `verification` | JSON | `{plan, checks[], final_state, overall_passed}` |
| `recovery` | JSON | eventos `{fault, at_step, detected_via, strategy, actions, resolved, lesson}` |
| `outcome` | JSON | `{status, success, verified, deliverables, notes, faults_injected}` |
| `provenance` | JSON | origen, generador, `family_id`, semilla, licencia, sabores de API, sandbox |
| `tags` | JSON | etiquetas (`keyboard_first`, `zoom_use`, `captcha_encounter`, …) |

## Estructura de un paso

```json
{
  "step": 7, "t_ms": 21480,
  "observation": {
    "screenshot": {"available": true, "width": 1280, "height": 720,
                    "format": "png", "encoding": "base64", "sha256": "…",
                    "description": "…", "ui_tree": {"app": "calc", "elements": [...]}},
    "focus": {"app": "calc", "window": "analisis_sector.xlsx", "dialog": null},
    "environment": {"os": "windows_11", "display": [1280, 720],
                     "locale": "es-ES", "sandboxed": false},
    "annotations": []
  },
  "decision": {"thought": "…", "intent": "apply_formula", "strategy": "keyboard_first",
                "risk": "none", "irreversible": false, "plan_remaining": ["…"]},
  "action": {"tool": "TYPE", "params": {"text": "=SUM(B2:B13)"}, "intent": "apply_formula",
              "adapters": {"openai": {"calls": [...]}, "anthropic": {"calls": [...]}}},
  "result": {"status": "success", "delta": "celda D2 = '=SUM(B2:B13)'…",
              "unexpected": false, "error": null},
  "verification": {"type": "formula_recalc", "method": "…", "passed": true, "evidence": "…"}
}
```

## Reglas de coherencia (validadas automáticamente)

1. `step` índices contiguos desde 1; `t_ms` monótono no decreciente.
2. Toda acción válida contra el vocabulario y dentro del espacio del screenshot (1280×720).
3. Si `screenshot.available`, los bytes decodifican a PNG y su `sha256` coincide.
4. Éxito ⇒ checks no vacíos y **último check** superado ⇒ `outcome.verified = true`.
5. Trayectorias con CAPTCHA ⇒ status `aborted_safely` o `blocked_by_policy`.
6. Trayectorias con `injection_resist` ⇒ contienen el intent `reject_injection`.
7. Una familia nunca se reparte entre splits distintos.
