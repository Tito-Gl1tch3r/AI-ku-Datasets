# Esquema (congelado)

Un único esquema PyArrow para las 212 filas: `id, split, domain, subdomain,
difficulty, task_type, messages(role/content), verification, provenance, tags`.

## Dominios y subdominios

| Dominio | Subdominios |
|---|---|
| `pentest_methodology` | scoping_authorization, recon_passive, enumeration_active, vuln_analysis, exploitation_methodology, post_exploit_concepts, reporting_evidence, opsec_tradeoffs, tooling_verification |
| `osint` | domain_footprinting, identity_correlation, data_verification, collection_opsec, osint_legal_ethics, attribution_discipline |
| `bug_bounty` | program_scope_parsing, asset_recon, vuln_class_triage, impact_assessment, duplicate_avoidance, report_writing, bounty_math, retest_verification |
| `redteam_brainstorming` | ideation (episodios `[BRAINSTORMING]` separados del resto) |

## Convenciones

- `messages`: `system` (marco de autorización/método) → `user` (tarea) →
  `assistant` (razonamiento + código) → `tool` (salida REAL ejecutada) →
  `assistant` (verificación + conclusión con estado epistémico).
- `verification.methods` proviene del enum congelado; `code_verified` es True
  en el 100 % de las filas.
- `provenance.knowledge_type`: el marco de autorización bloquea la ideación en
  `hypothesis` (nada de conclusiones operativas en episodios de ideas).
- Ids `akr-NNNNN` por ordenación determinista
  (dominio, familia, subdominio, tipo de tarea); split por hash de id.

## Apéndice v1.1 — dominio `security_methodologies`

La v1.1 añade el dominio `security_methodologies` (apéndice: las posiciones
v1.0 del esquema quedan intactas y los IDs `akr-00000..00211` se preservan
byte-idénticos como prefijo del Parquet, incluido su `split`).

| Subdominio | Framework base | Familias |
|---|---|---|
| `mitre_attack` | MITRE ATT&CK Enterprise v17 (14 tácticas · 211 técnicas · 468 sub-técnicas) | tactic_navigation, detection_coverage, chain_risk |
| `wstg_web` | OWASP WSTG v4.2 (12 categorías estables) | category_plan, budget_knapsack, finding_classify |
| `nist_800_115` | NIST SP 800-115 (4 fases) | phase_gate, roe_consistency, remediation_dp |
| `osstmm_metrics` | OSSTMM 3.0 §4.4 (nivel conceptual) | surface_channels, rav_sl, trust_map |
| `ptes_phases` | PTES (7 fases) | phase_map, intel_yield, dread_ranking |
| `issaf_framework` | ISSAF 0.2.1 (legacy, sin mantenimiento) | phase_checklist, tech_checklist |
| `cross_framework` | transversal | mapping_blindspots |

Política de dedup v1.1: referencia congelada. El vectorizador TF-IDF se ajusta
SOLO a las filas v1.0 publicadas; éstas se fuerzan a sobrevivir; las filas
nuevas se deduplican contra el conjunto congelado y entre sí. Así el crecer del
corpus no recoloca las decisiones fronterizas de la versión publicada.

## Apéndice v1.2 — metodologías prácticas y OPSEC

Tres subdominios nuevos en `security_methodologies` (las posiciones v1.0/v1.1
quedan intactas; con la política v1.2 el artefacto publicado completo, 305
filas, se congela en su orden de publicación y las nuevas filas van detrás:
`akr-00305..akr-00356`). Fuente de diseño: informes aportados por el
propietario + write-ups públicos de los consultores técnicos de Mr. Robot y
estándares citados. Directriz rectora: «aprender, no hablar» — entender qué
se hace, saber qué hacer y ceñirse a pautas; cero jerga glorificante.

| Subdominio | Base | Familias |
|---|---|---|
| `s4vitar_workflow` | metodología empírica de S4vitar (informe del propietario; material público: gist OSCP, write-ups bspwm/extractPorts) + PTES/WSTG | tty_gate, recon_preprocessing, enum_order, chain_prereq, ad_trust_path |
| `mrrobot_cognitive` | patrones cognitivos de Mr. Robot (informe del propietario; write-ups de R. Kazanciyan) con filtro ficción/realidad A–F | hypothesis_pivot, fiction_filter, profile_risk, s1s2_router, stop_report |
| `opsec_discipline` | proceso OPSEC de 5 pasos (linaje NSDD-298) + patrones de políticas de bug bounty | pacing_budget, exposure_ledger, scope_stop_gate, risk_matrix |

Política de dedup v1.2 (evolución de la v1.1): `build/frozen_v1.1.parquet`
contiene el artefacto publicado completo en su orden publicado; esas filas se
fuerzan a sobrevivir EN ESE ORDEN (IDs y splits preservados byte-idénticos) y
las filas nuevas se añaden después, deduplicadas contra el conjunto congelado
y entre sí. El pipeline verifica el prefijo congelado tras cada build y aborta
si hay deriva.
