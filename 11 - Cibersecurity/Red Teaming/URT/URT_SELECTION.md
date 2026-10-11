# URT — Ultimate Red Teaming (selección de tandevllc/offsec_redteam_codes)

Destino: `11 - Cibersecurity/Red Teaming/URT/<topico>/`.

## Regla de selección (calidad > cantidad + licencias limpias)

- Triaje por shard: fracción de código real + `stargazers` del repo origen.
- **Filtro por licencia (derechos base = upstream)**: solo filas con licencia open source o que permita comercialización (MIT, Apache-2.0, BSD, ISC, CC0, UPL, 0BSD, WTFPL, CC-BY-4.0, MPL-2.0, EPL-2.0…) — por licencia de la fila O por licencia del repo original en GitHub (todos los shards provienen de GitHub). Autorizado por el propio README de TanDev.
- **Esquema final por archivo**: solo `content, lang, stargazers` (columnas de procedencia retiradas; la atribución vive en `URT_ATTRIBUTION.json`).
- Cobertura: **los 30 tópicos** con sus mejores shards.
- **SIN saneamiento de contenido**: ni una línea ha sido modificada ni limpiada por peligrosidad. Solo selección + particionado mecánico por límite de GitHub. Duplicados exactos entre tópicos dejados intactos.
- Excepción: `bug-bounty/train-00000` descartado ENTERO (shard completo, sin tocar filas) por contener una API key real de terceros.

## Trazabilidad

- `URT_PARTS.json`: originales ≥100 MB partidos en `*-part-NNNNN.parquet` (mismo esquema).
- `URT_ATTRIBUTION.json`: pares (repo, base de derechos) con conteo de filas — atribución MIT/Apache.
