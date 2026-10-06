# Recolector de código red-team: `scripts/collect_redteam_codes.py`

Herramienta de ingeniería de datos que construye un dataset de código fuente
estilo *OffSec RedTeam Codes*: repositorios públicos de GitHub con topics de
seguridad, filtrados a extensiones de código y licencias permisivas, y
consolidados en lotes `.parquet` comprimidos.

Este script NO forma parte del dataset `ai-ku-red-teaming.parquet` ni altera
sus 212 ejemplos verificados: es el siguiente paso del proyecto, la recolección
de corpus crudo de código ofensivo/defensivo para fases posteriores de
curación.

## Requisitos

```bash
pip install requests pandas pyarrow
export GITHUB_TOKEN=ghp_xxxxxxxxxxxxxxxxxxxx   # PAT con scope público (read)
```

Sin `GITHUB_TOKEN` funciona, pero la API de búsqueda cae a 10 req/min (con
token: 30 req/min) y el run completo se ralentiza mucho. El token se lee de la
variable de entorno; nunca se escribe en logs, manifiestos ni commits.

## Uso

Run completo (10 GB objetivo, tope duro 15 GB):

```bash
python scripts/collect_redteam_codes.py \
    --out-dir data/redteam_codes \
    --target-gb 10 --hard-cap-gb 15 \
    --min-stars 5 --batch-repos 8 --batch-mb 64
```

Smoke test (3 repos, ~60 MB, ~1 minuto):

```bash
python scripts/collect_redteam_codes.py --out-dir data/smoke_test \
    --topics red-team --licenses mit --max-repos 3 \
    --target-gb 0.05 --hard-cap-gb 0.06 --max-repo-mb 30
```

Reanudación: `manifest.json` registra cada repo procesado y el contador global
de bytes crudos; re-ejecutar el mismo comando continúa donde se quedó
(idempotente). Un repo ya visto (ok o saltado) jamás se descarga dos veces.

## Garantías de diseño

1. **Presupuesto global con doble umbral.** Un contador único suma TODO byte
   crudo descargado (tarballs completos y descargas parciales abortadas). Al
   llegar a `--target-gb` (10 GB) el proceso para con gracia al terminar el
   repo en curso; si un repo individual cruzara `--hard-cap-gb` (15 GB), la
   descarga se aborta a mitad y el proceso se detiene inmediatamente.
2. **Lotes y borrado inmediato.** Cada repo se descarga como tarball
   (`codeload.github.com`, no consume cuota de API) a un directorio temporal,
   se procesa leyendo el tar EN MEMORIA (sin extraer a disco, sin riesgo de
   path traversal) y el tarball se borra al instante, pase lo que pase. Los
   lotes se vuelven a `batch_NNNN.parquet` (compresión zstd) cada
   `--batch-repos` repos o cuando el buffer supera `--batch-mb`.
3. **Estado final limpio.** Al terminar, el directorio de salida solo contiene
   `batch_*.parquet` + `manifest.json`; se verifica programáticamente y el
   directorio temporal se elimina. El script sale con código 1 si quedara
   cualquier resto crudo.
4. **Schema parquet exacto:** `content, repo_name, path, license, lang, topic`.

## Qué se descarta

- Extensiones no incluidas en la whitelist (`py js ts c cc cpp h hpp cs go rs
  java rb php sh bash ps1 bat pl lua kt swift scala asm sql r jl nim zig hs …`).
- Binarios (byte NUL detectado), archivos no-UTF-8, minificados (`*.min.js`),
  lockfiles, archivos > `--max-file-kb` (512 KB) y tarballs > `--max-repo-mb`
  (400 MB; los bytes parciales descargados sí se contabilizan).
- Directorios de build/vendor/IDE: `node_modules`, `vendor`, `build`, `dist`,
  `target`, `__pycache__`, `venv`, `third_party`, `.git`, `docs`, etc.
- Forks (activable con `--include-forks`), repos deshabilitados, repos ya
  procesados en runs previos.

## Licencias

La búsqueda filtra en el servidor con `license:mit`, `license:apache-2.0`,
`license:bsd-3-clause` y `license:bsd-2-clause`, en ese orden de prioridad por
topic (uso comercial seguro). El SPDX detectado por GitHub queda en la columna
`license` de cada fila para el cumplimiento downstream. `repo_name` y `path`
preservan la atribución original de cada archivo.

## Estimación de volumen

Con zstd, el texto de código comprime típicamente ~4:1: 10–15 GB crudos
producen ~2.5–4 GB de parquet. El número de repos varía con el presupuesto:
con los defaults, entre ~200 (todos 400 MB) y ~4.000 (todos <10 MB).

## Pasos posteriores sugeridos

1. Concatenar lotes: `pd.concat([pd.read_parquet(p) for p in glob(...)])`.
2. Dedup exacto por hash de `content` y casi-duplicados (MinHash/TF-IDF).
3. Auditoría de calidad por `lang` y `topic`; tope por repo para evitar
   dominancia de un solo proyecto.
4. Clasificador de sensibilidad antes de publicar (el crudo puede contener
   secretos filtrados en el repo original — escanear con detect-secrets/trufflehog).
