# Esquemas del dataset AI-ku Computer Use

| Archivo | Define |
|---|---|
| `record.schema.json` | Una fila del Parquet: columnas planas + bloques JSON (`messages`, `trajectory`, `verification`, `recovery`, `outcome`, `provenance`, `tags`) |
| `trajectory.schema.json` | La estructura del paso: observación (screenshot + ui_tree), decisión, acción (con adaptadores OpenAI/Anthropic), resultado y verificación |
| `action-vocabulary.json` | Las 12 primitivas semánticas, sus parámetros, las ~90 intenciones y los fallos catalogados |
| `adapter-mappings.json` | Correspondencia núcleo semántico ↔ OpenAI Responses `computer` ↔ Anthropic `computer_toolset_20260801` (incluye emulaciones documentadas) |

Los bloques JSON dentro del Parquet se validan contra estos esquemas en cada ejecución de `scripts/validate_dataset.py`. El ciclo de publicación exige validación con cero errores.
