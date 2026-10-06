# 04 · Clasificación A–H e ideas: Skills, expertos, router, arquitectura

## 1. Esquema de clasificación (aplicado a cada hallazgo)

| Clase | Significado | Ejemplos de hallazgos clasificados |
|---|---|---|
| **A** | Conocimiento general que debe aprender el modelo | Grounding de fuentes (C6), calibración de incertidumbre (V4), dominio profesional ES |
| **B** | Comportamiento agéntico | Re-anclaje (P1), estado durable (P2), pivote con evidencia (P3), verificación proporcional (P4), scope-disciplina (C5) |
| **C** | Skill (paquete de procedimiento invocable) | /audit → V5 Auditoría de completitud; /plan → descomposición con criterios de abandono; /deeper → triaje de fuentes; /goal → re-anclaje; State Scribe |
| **D** | Herramienta/runtime | Bilingüismo de serialización (H5), ACS en jinja, MTP packing, effort como parámetro runtime |
| **E** | Posible especialización de experto | Lane código/ops (alimentar lanes Qwen 129-176), lane razonamiento profundo (Phi-177), lane legal/finanzas ES (nueva), lane música (fase OMNI/MERT) |
| **F** | Posible mejora de router | Balanceo router-aware, routing condicionado por esfuerzo, routing por modalidad (post-OMNI) |
| **G** | Posible cambio arquitectónico | Conversión 177→39 por clustering OT, MTP x4 al final del bloque de entrenamiento, conversión 177→39 por clustering OT, hook de restricciones en la purga ACS |
| **H** | Mecanismo de evaluación | patch_trap, purge_survival, scope_sentinel, effort_calibration, citation_integrity, hidden_oracle, dialect_parity, recovery_curve |

**Regla**: NO forzar hallazgos a expertos. Un hallazgo solo es clase E si existe evidencia de
que exige competencias distintas y sostenidas (p. ej. cyber ofensivo/defensivo), y solo es
clase G si toca la arquitectura, no los datos.

## 2. Ideas para Skills (clase C)

1. **`/audit` → "Auditoría de completitud"**: checklist de criterios de done generada AL
   PLANEAR (no al final), ejecutada contra evidencia real. Datos: trazas donde el audit
   detecta un criterio incumplido y reabre el trabajo.
2. **`/plan` → "Plan con criterios de abandono"**: todo plan define qué evidencia abortaría
   cada fase (alimenta P3). Datos: planes cuya fase 2 muere y se pivota limpio.
3. **`/deeper` → "Triaje de fuentes"**: protocolo fuente-primaria-primero + resolución de
   contradicciones (alimenta C7). Datos: research con trampas SEO sembradas.
4. **`/goal` → "Contrato de objetivo"**: objetivo + restricciones + criterio de done + fuera-de-alcance,
   re-anclado en bifurcaciones (alimenta P1/C5).
5. **State Scribe**: resúmenes de estado durable al cierre de cada hito (alimenta P2/ACS).
6. **Citation Guardian** (dominio ES): protocolo de cita verificable legal/financiera (alimenta C6).
7. **Effort Meter**: auto-etiquetado del esfuerzo previsto; si el presupuesto real diverge del
   etiquetado, es señal de entrenamiento (alimenta C4 y la eval effort_calibration).

## 3. Ideas para expertos (clase E) — con evidence bar

1. **Lane código/ops real**: ya existen (Qwen 48); alimentarlas con las familias
   terminal/patch-trap/SRE del dataset. No crear lanes nuevas para esto.
2. **Lane razonamiento profundo**: la mega-lane Phi-177; alimentar con matemática
   verificable + planificación larga (Ado-mode traces).
3. **Lane profesional ES (candidata nueva)**: solo si el volumen de dominio legal/finanzas ES
   justifica una lane; alternativa barata: datasets de dominio que activen lanes existentes.
   Decidir tras medir activación de lanes en el SFT (mecanismo H).
4. **Lane música/OMNI (post-fase)**: MERT + música teórica textual en v1 (el corpus de
   calibración debe incluirlo para el clustering 39).

## 4. Ideas para router (clase F)

1. **Reentrenamiento con balanceo consciente de lanes**: el router heredado de Nemotron
   prioriza 128 lanes; sin corrección, Qwen/Phi mueren de hambre. Aux-loss de load-balance +
   priors de lane durante SFT.
2. **Routing condicionado por esfuerzo**: en modo Ado, sesgar hacia lane profunda (Phi-177);
   en modo trivial, minimizar activación (coherente con think adaptativo y latencia).
3. **Router-aware sampling en SFT**: sobremuestrear familias que activan lanes infrautilizadas,
   midiendo activación por lane en cada época (no a ciegas).
4. **Post-OMNI**: routing por modalidad (tokens de imagen/audio activan lanes de modalidad;
   evita interferencia cross-modal en el MoE denso-soft).

## 5. Ideas de arquitectura/runtime (clase G)

1. **Hook de restricciones en la purga ACS** (lección AISI): el jinja purga razonamiento,
   NUNCA el bloque de restricciones/objetivo del contrato. El dataset refleja el contrato:
   restricciones re-expuestas tras purga.
2. **MTP x4 al final del bloque de entrenamiento** (después de OMNI-alignment): las cabezas
   aprenden sobre la distribución completa de tokens. Además: datos con alta predictibilidad
   local (código, fórmulas legales) mejoran la tasa de aceptación → el dataset afecta la
   velocidad efectiva en hardware streameado.
3. **Conversión 177→39 por clustering OT con restricción semántica**: calibración con corpus
   representativo del despliegue (español + agéntico + código + música), fusión ponderada por
   masa de router, Phi intacto como lane #39 (mi-ku). Recovery SFT tras fusión.
4. **Encoders como shards opcionales**: DeepSeek-ViT / Qwen3-Omni-tower / Whisper / MERT
   cargados on-demand — el dataset v1 es solo-texto; el OMNI-alignment es fase separada
   (dos etapas: projectors con backbone congelado → unfreeze parcial).
5. **Salida de voz (roadmap, no v1)**: si AI-ku hablará/cantará, condiciona decisiones de
   tokenización de audio; deja el easter egg de marca (voz estilo Miku) en el roadmap.

## 6. Matriz hallazgo → clase → artefacto

| Hallazgo (fuente en docs/01) | Clase | Dónde se materializa |
|---|---|---|
| Terminal-Bench: bucle > conocimiento (Opus vs Argón) | B, H | `term-0001`, `recovery_curve.py` |
| Anti-parche Fable/GLM | B, H | `ver-0001/0002`, `patch_trap.py` |
| Timeout de trayectorias Fable | B, D | `long-0001`, variante ACS |
| AISI: restricciones mueren en compaction | G, H, B | jinja ACS, `purge_survival.py`, `scope-0001` |
| Sobre-verificación Fable en lo fácil | A, B | `adaptive_think` (cola trivial) |
| Scope-creep 0% Astra | B, H | `scope-0001/0002`, `scope_sentinel.py` |
| Harvey 5× Argón | A, E | `prof-0001`, `citation_integrity.py` |
| BrowseComp Kimi | B, C | `res-0001`, skill /deeper |
| Sol oculta tools rotas | B, H | `tools-0001`, `hidden_oracle.py` |
| Currículum de herramientas Kimi | E, H | H4, escalado por olas |
| Grader-first MiMo | H | todos los `evals/` |
| OPD multi-profesor DeepSeek | A | el propio SFT multi-fuente |
