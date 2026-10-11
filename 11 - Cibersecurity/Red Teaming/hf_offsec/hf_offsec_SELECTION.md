# hf_offsec — Selección del dataset tandevllc/offsec_redteam_codes

Fuente: `tandevllc/offsec_redteam_codes` (Hugging Face, acceso gated concedido).
Destino: `11 - Cibersecurity/Red Teaming/hf_offsec/<topico>/`.

## Regla de selección (calidad > cantidad)

- Triaje por shard: fracción de código real (`py/c/cpp/js/go/rust/java/...`) + `stargazers` del repo origen.
- Se descartan shards-volcado de configs/datos (`yaml`/`json` masivos de un solo repo) y el tópico `exploit` salvo sus 2 mejores shards.
- Gemelos deduplicados por calidad (`recon` sí / `reconnaissance` parcial, `red-team` sí, etc.).
- Cobertura: **los 30 tópicos** están representados con sus mejores shards.
- **SIN saneamiento**: ni una línea de contenido ha sido modificada, filtrada por peligrosidad ni limpiada. Solo selección por shard + particionado mecánico por límite de GitHub (ver abajo). Duplicados exactos entre tópicos (~7%) dejados intactos a propósito.

## Totales

- 73 shards origen → 1.830.004 filas.
- Los 13 ficheros ≥100 MB están partidos mecánicamente en `*-part-NNNNN.parquet` (mismo esquema, filas intactas; ver `hf_offsec_PARTS.json`).
- Esquema origen: `content, repo_name, repo_id, path, branch, license, lang, stargazers, pushed_at, topics_matched, size, topic` (código crudo de GitHub por tópico, NO SFT verificado).
