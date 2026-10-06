#!/usr/bin/env bash
# Reconstrucción determinista del dataset AI-ku advanced maths.
# Uso: bash build/rebuild.sh
set -euo pipefail
cd "$(dirname "$0")/.."

echo "[1/4] Generando todos los ejemplos (ejecución real de snippets)..."
python3 scripts/pipeline.py gen

echo "[2/4] Ensamblando: validación + dedup + splits + Parquet + stats..."
python3 scripts/pipeline.py assemble

echo "[3/4] Checksums..."
sha256sum ai-ku-advanced-maths.parquet quality/stats.json > quality/SHA256SUMS.txt

echo "[4/4] Verificación de integridad..."
sha256sum -c quality/SHA256SUMS.txt

echo "Reconstrucción completada: ai-ku-advanced-maths.parquet"
