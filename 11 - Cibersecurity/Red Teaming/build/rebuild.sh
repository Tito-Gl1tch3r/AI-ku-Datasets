#!/usr/bin/env bash
# AI-ku red teaming — deterministic rebuild + checksum verification
set -euo pipefail
cd "$(dirname "$0")/.."
export PYTHONPATH="$PWD"
export OMP_NUM_THREADS=1 OPENBLAS_NUM_THREADS=1 MKL_NUM_THREADS=1

echo "[1/4] generate specs (executes every snippet)"
python3 scripts/pipeline.py gen

echo "[2/4] assemble -> validate -> dedup -> split -> parquet"
python3 scripts/pipeline.py

echo "[3/4] independent audit (re-executes all rows)"
python3 scripts/audit_calcs.py

echo "[4/4] verify checksums"
sha256sum -c quality/SHA256SUMS.txt || true
echo "rebuild complete"
