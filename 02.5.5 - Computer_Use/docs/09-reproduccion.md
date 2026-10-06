# 09 — Reproducción completa

## Requisitos

Python ≥ 3.11 con `pyarrow`, `pillow`, `jsonschema` (y `numpy` para utilidades). No se necesita red, tokens ni servicios externos: el dataset es 100 % sintético y determinista.

```bash
pip install pyarrow pillow jsonschema
```

## Pipeline completo

```bash
# 1) construir el dataset (un único Parquet)
#    --pixels N = presupuesto de screenshots con píxeles embebidos
python3 scripts/build_dataset.py --pixels 2600

# 2) validación exhaustiva (debe terminar con "errores: 0")
python3 scripts/validate_dataset.py

# 3) informe de calidad (las 20 métricas)
python3 scripts/make_report.py

# 4) muestras legibles para revisión manual
python3 scripts/export_samples.py
```

Con `--pixels 100000` el generador produce screenshots con píxeles para **todas** las observaciones (el Parquet crece proporcionalmente); con presupuestos menores, las observaciones restantes conservan descripción + `ui_tree` completos. La semilla de cada variante deriva de `(family_id, índice)`: el mismo comando produce exactamente el mismo dataset.

## Arquitectura del generador

```text
scripts/aku/
  vocab.py        primitivas, intenciones, fallos, validador de acciones
  adapters.py     núcleo semántico → OpenAI Responses / Anthropic toolset
  state.py        modelo de estado de UI (layouts, overlays, efectos reales)
  mockshot.py     renderizador de screenshots desde el estado (coherencia garantizada)
  engine.py       Traj: ciclo observación→decisión→acción→resultado→verificación,
                  timing, fallos, recuperación, fingerprint y record
  phrasing.py     bancos de razonamiento es/en
  families_*.py   familias de escenarios por dominio (contrato en families_os.py)
  flagships.py    trayectorias extremas artesanales
  registry.py     registro central
scripts/
  build_dataset.py / validate_dataset.py / make_report.py / export_samples.py
```

## Añadir escenarios nuevos

1. Leer el contrato en `scripts/aku/families_os.py` (cabecera y estilo).
2. Crear `families_<tema>.py` con funciones `fn(rng, i) -> dict` que devuelven `t.finish(...)`.
3. Registrarlas en `FAMILIES` y en `registry.py`.
4. Ejecutar `build_dataset.py` + `validate_dataset.py`: el validador acepta o rechaza el contenido nuevo con las mismas reglas que el resto.

## Notas de reproducibilidad

- El validador es la barrera de publicación: si falla, no se publica.
- Los splits son deterministas por familia (`sha1(domain|family_id)`), sin fuga train/validation/test.
- `quality/build_stats.json` conserva las estadísticas exactas de la construcción publicada.
