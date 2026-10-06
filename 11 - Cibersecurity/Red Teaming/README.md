# AI-ku red teaming

**Dataset de mentalidad ofensiva (pentest · OSINT · bug bounty · metodologías)
para el SFT de los 128 expertos de AI-ku V4X Thinker Max 35B — con marco de
autorización explícito en cada ejemplo.**

Un único dataset · un único formato · un único archivo:
[`ai-ku-red-teaming.parquet`](ai-ku-red-teaming.parquet)

| | |
|---|---|
| Ejemplos (v1.2) | **357** = 305 publicados (byte-idénticos) + 52 nuevos (55 generados; dedup referencia congelada) |
| Tokens aprox. | ≈ 273 100 (chars/4; ver `quality/stats.json`) |
| Verificación explícita | **100 %** |
| Código realmente ejecutado | **100 %**, re-auditado 357/357 con 0 FAIL |
| Dificultad | 85 % hard · 10 % very_hard · 5 % intermedio |
| Dominios | pentest_methodology · osint · bug_bounty · redteam_brainstorming · security_methodologies (con subdominios prácticos v1.2) |
| BRAINSTORMING | episodios marcados `[BRAINSTORMING]` y separados (dominio propio + tag `brainstorming`) |
| Idioma del contenido | inglés técnico · documentación del repo en español |

## Apéndice v1.1: metodologías de referencia

18 familias nuevas ancladas a las seis metodologías canónicas del pentesting
(estudio completo en
[`docs/methodologies_survey.md`](docs/methodologies_survey.md)):

- **MITRE ATT&CK Enterprise v17** (14 tácticas · 211 técnicas · 468
  sub-técnicas): navegación canónica de tácticas con IDs reales, cobertura de
  detecciones sobre planes de emulación, riesgo por cadena (P(no detección)).
- **OWASP WSTG v4.2** (12 categorías): planes por perfil de aplicación,
  selección bajo presupuesto (mochila exacta DP vs greedy), clasificación de
  hallazgos.
- **NIST SP 800-115**: gates de las 4 fases, validación de ROE con fechas
  reales (incluye 3 ejemplos error_first con bug plantado), remediación óptima
  bajo presupuesto.
- **OSSTMM 3.0** (§4.4, nivel conceptual): superficie de ataque por canal,
  RAV/SL con verificación de cotas, rutas de confianza por cuello de botella.
- **PTES**: auditoría de las 7 fases, inteligencia pasivo→activo por
  optimización exacta, threat model DREAD calculado.
- **ISSAF 0.2.1** (marcado legacy): checklists por tecnología y comparativa de
  fases; **transversal**: mapeo NIST↔PTES↔ISSAF y detección de puntos ciegos.

## Apéndice v1.2: metodologías prácticas y OPSEC («aprender, no hablar»)

14 familias nuevas (más 1 recuperada de ISSAF) ancladas a dos metodologías
prácticas y a la disciplina OPSEC transversal, diseñadas bajo la directriz del
propietario: el dataset enseña a ENTENDER qué se hace, saber QUÉ hacer y
ceñirse a las pautas (alcance, ROE, reglas del programa) — nunca a «hablar
como hacker». Fuentes: informes de diseño aportados por el propietario
(S4vitar; patrones cognitivos de Mr. Robot) + write-ups públicos de los
consultores técnicos de la serie y estándares citados.

- **s4vitar_workflow (17 ej.)**: gate de estabilización de sesión (regla
  dependiente del estado, anti-consola-fantasma), preprocesamiento de recon
  (dump grepeable → estado estructurado + heurística TTL con cota de saltos +
  guard de targets pineados), orden de enumeración local por hipótesis con
  presupuesto de ruido (el orden es función del ROE, no un ritual),
  encadenamiento LFI→RCE por prerrequisitos verificados (si nada encadena:
  reportar, no pulverizar) y rutas de confianza en AD (grafo ACL tipo
  BloodHound, mapeo edge→capacidad, pivoting como requisito de visibilidad).
- **mrrobot_cognitive (21 ej.)**: descarte por evidencia frente a costes
  hundidos (aritmética de factibilidad y pivote), filtro ficción/realidad
  A–F sobre escenas (aprender el patrón, descartar la compresión; la brecha
  de autorización se nombra siempre), perfiles de postura con umbrales
  computados (abortar/coordinar/contramedidas; el caso insider coordinado
  por diseño), router de esfuerzo Sistema 1/Sistema 2 con contabilidad de
  desperdicio y la condición de parada: reportar la AUSENCIA de hallazgos
  con cobertura, nunca alucinar (incluye error_first con indicador tratado
  como prueba).
- **opsec_discipline (13 ej.)**: presupuesto de ruido y ritmo (encajar la
  transferencia simulada en la línea base; si no cabe, renegociar — el NO es
  parte del método), libro de exposición de artefactos con la regla
  «auditar logs ANTES de nada tras root», puerta de parada alcance/ROE
  (ALLOW/DENY/STOP/ESCALATE/FOLLOW_POLICY con la economía del bounty:
  fuera de alcance no paga y puede costar el acceso) y proceso OPSEC de 5
  pasos con matriz de riesgo y ranking de contramedidas por valor.

Auditoría de la directriz (`scripts/audit_learn_not_talk.py`) sobre las 52
filas nuevas: 0 jerga glorificante · 96 % señales de comprensión · 100 %
señal de alcance/ROE · 88 % condiciones de parada · 100 % evidencia.

## Marco legal y ético (no negociable)

1. **Autorización primero.** El system frame de cada ejemplo fija el contexto:
   engagement autorizado, reglas de alcance, "objetivo fuera de alcance = no
   objetivo".
2. **Metodología, no armamento.** El dataset enseña a PENSAR como pentester:
   validación de alcance, recon pasivo→activo, cadenas de evidencia, prioridad
   por impacto, informes accionables. No contiene payloads operativos, malware,
   ni instrucciones contra sistemas de terceros.
3. **Análisis sobre código ofensivo.** Los snippets ejecutados son simulaciones,
   parseos de trazas sintéticas, aritmética de tasas/riesgos y modelos de
   decisión — el "texto == cómputo" se mantiene igual que en el dataset madre.
4. **OSINT disciplinado.** Datos públicos, provenance por registro, atribución
   probabilística (Bayes) y compuerta ética de 4 pasos con fallo-cerrado.
5. **Bug bounty leal.** El documento de scope es ley; el triaje no infla
   severidades; la duplicación se modela; nada se suplica.

## Recolector de corpus de código (v1.1)

`scripts/collect_redteam_codes.py` construye el dataset de código estilo
*OffSec RedTeam Codes*: repos públicos de GitHub por 27 topics de seguridad,
licencias permisivas (MIT · Apache-2.0 · BSD), filtrado a extensiones de
código, presupuesto global de 10–15 GB crudos y salida en lotes `.parquet`
(`content, repo_name, path, license, lang, topic`) con borrado inmediato de
los crudos. Reanudable vía `manifest.json`.

```bash
export GITHUB_TOKEN=ghp_xxx
python scripts/collect_redteam_codes.py --out-dir data/redteam_codes \
    --target-gb 10 --hard-cap-gb 15
```

Detalles, garantías de diseño y pasos posteriores:
[`docs/redteam_codes_collector.md`](docs/redteam_codes_collector.md).

## Estructura

```
ai-ku-red-teaming.parquet    EL dataset
README.md                    este archivo
docs/
  schema.md                  esquema PyArrow + taxonomía (+ apéndices v1.1/v1.2)
  methodology.md             arquetipos y familias
  legal_framework.md         marco legal/ético del contenido
  methodologies_survey.md    estudio de metodologías (+ secciones prácticas v1.2)
quality/
  quality_report.md          informe + auditoría (+ adendas)
  stats.json                 estadísticas
  SHA256SUMS.txt             checksums
  learn_not_talk_v1.2.json   auditoría de la directriz «aprender, no hablar»
build/rebuild.sh             reconstrucción determinista
build/frozen_v1.0.parquet    referencia v1.0 congelada
build/frozen_v1.1.parquet    artefacto publicado completo (305 filas; política v1.2)
scripts/                     pipeline + generadores (56 familias en 9 módulos)
scripts/audit_learn_not_talk.py  auditoría de filosofía de datos
scripts/collect_redteam_codes.py  recolector GitHub → parquet (ver docs/)
docs/redteam_codes_collector.md   guía del recolector
data/                        salida del recolector (gitignored)
```

## Splits

90/5/5 por `sha256("akr-split-v1" + id)` en la columna `split`. Congela `test`
antes de cualquier uso como benchmark. Con la política v1.2 el artefacto
publicado completo (305 filas) queda congelado en su orden de publicación:
todos los IDs y splits liberados se conservan byte-idénticos entre versiones.

## Uso previsto

Entrenamiento de la faceta ofensiva-metodológica de AI-ku junto al dataset
madre (`AI-ku-advanced-maths`), que cubre ciencia y ciberdefensa defensiva.
Los episodios `BRAINSTORMING` filtran en una línea:

```python
ds.filter(lambda r: "brainstorming" in r["tags"])
```

y el apéndice de metodologías:

```python
ds.filter(lambda r: r["domain"] == "security_methodologies")
```
