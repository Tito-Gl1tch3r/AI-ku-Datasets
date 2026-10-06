# Informe de calidad — AI-ku red teaming v1.0

## Cifras

- **212 ejemplos** publicados (252 generados; 40 casi-duplicados eliminados por
  dedup doble canal tarea/evidencia > 0.90).
- ~151,211 tokens (chars/4).
- 24 familias generadoras en 4 módulos + motor compartido con el dataset madre.
- 100 % con verificación explícita; 100 % código ejecutado y re-ejecutado.

## Auditoría independiente

Re-ejecución del 100 % de las filas:

{"PASS": 212, "PASS_TOLERANT": 0, "FAIL": 0}

## Distribuciones clave

- Dominios: pentest_methodology ~39 %, osint ~23 %, bug_bounty ~24 %,
  redteam_brainstorming ~14 % (episodios BRAINSTORMING separados y marcados).
- Tarea: data_analysis, problem_solving, exploration, result_analysis,
  solution_critique, troubleshooting, method_comparison, optimization.

## Marco de contenido

- Sin payloads operativos, malware ni terceros reales (fixtures RFC 5737 /
  203.0.113 / 198.51.100 / example.com).
- Compuerta de alcance computada antes de pasos activos simulados.
- Compuerta ética fail-closed en OSINT; atribución probabilística (Bayes).
- BRAINSTORMING: dominio propio `redteam_brainstorming`, tag `brainstorming`,
  `knowledge_type` bloqueado en `hypothesis`.

## Reproducibilidad

Semillas fijas por instancia; presupuesto 120 s; BLAS monohilo.
`bash build/rebuild.sh` regenera el Parquet y verifica checksums.

---

# Adenda v1.1 — security_methodologies (metodologías de referencia)

## Cifras v1.1

- **305 ejemplos** publicados: 212 de la v1.0 (byte-idénticos, mismo ID y split)
  + 93 nuevos (122 generados; 69 casi-duplicados eliminados bajo la política de
  referencia congelada).
- ~222,590 tokens (chars/4).
- 42 familias en 6 módulos; 18 familias nuevas ancladas a MITRE ATT&CK v17,
  OWASP WSTG v4.2, NIST SP 800-115, OSSTMM 3.0 (§4.4, nivel conceptual), PTES e
  ISSAF 0.2.1 (marcado legacy).
- Dominio nuevo `security_methodologies`: 30.5 % del corpus v1.1
  (mitre_attack 20, wstg_web 18, nist_800_115 15, osstmm_metrics 14,
  ptes_phases 12, issaf_framework 11, cross_framework 3 → 93 nuevos).

## Auditoría v1.1

Re-ejecución del 100 % de las filas (checkpoint reanudable):

{"PASS": 305, "PASS_TOLERANT": 0, "FAIL": 0}

## Integridad v1.0 → v1.1

- Prefijo `akr-00000..00211` verificado byte-idéntico contra el Parquet v1.0
  (build/frozen_v1.0.parquet, artefacto de referencia commiteado).
- Política de dedup: referencia congelada (vectorizador ajustado solo a filas
  v1.0; fuerza-keep de las 212; nuevas contra congeladas + anteriores). Motivo:
  el TF-IDF global recoloca decisiones fronterizas al crecer el corpus.
- Contenido nuevo: tablas sintéticas, IDs de framework reales, aritmética de
  cobertura/riesgo/planificación; incluye 3 ejemplos error_first (bug plantado
  de validación ROE por prefijo de año). Sin payloads operativos.

## Marco de contenido (apéndice)

- Las 6 metodologías se enseñan como lenguaje de proceso y medición: fases,
  gates, cobertura, métricas y reporting — bajo el mismo marco de autorización.
- ISSAF marcado explícitamente como legacy; OSSTMM RAV operacionalizado a nivel
  conceptual con verificación de cotas (unit_check).

## Adenda v1.2 — metodologías prácticas y OPSEC

- **357 ejemplos** (305 publicados byte-idénticos + 52 nuevos: 17
  s4vitar_workflow, 21 mrrobot_cognitive, 13 opsec_discipline, 1 ISSAF
  recuperado por la política congelada). ~273 100 tokens.
- Auditoría independiente: re-ejecución 357/357 PASS, 0 FAIL.
- Política de dedup v1.2: el artefacto publicado completo se congela en su
  orden; el pipeline verifica el prefijo tras el build (drift = abort).
- Directriz «aprender, no hablar» (`scripts/audit_learn_not_talk.py`,
  resultados en `learn_not_talk_v1.2.json`): jerga 0/357; en las 52 filas
  nuevas: comprensión 96 %, alcance/ROE 100 %, paradas 88 %, evidencia 100 %.
