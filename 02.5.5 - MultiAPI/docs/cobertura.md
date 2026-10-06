# Cobertura del dataset (150 ejemplos)

Generado por `scripts/build_dataset.py` y `validation/validate_all.py` (fecha del snapshot: 2026-10-04).

## task_type × split

| task_type | train | validation | test | adversarial_test | total |
|---|---|---|---|---|---|
| agentic_planning | 4 | 1 | 1 | 1 | 7 |
| api_recognition | 9 | 1 | 1 | 1 | 12 |
| contrastive_discrimination | 12 | 4 | 4 | 0 | 20 |
| error_handling | 10 | 3 | 2 | 1 | 16 |
| multimodal | 6 | 1 | 2 | 1 | 10 |
| protocol_repair | 6 | 1 | 2 | 1 | 10 |
| semantic_conversion | 6 | 3 | 4 | 1 | 14 |
| state_management | 3 | 1 | 3 | 1 | 8 |
| streaming | 8 | 2 | 2 | 1 | 13 |
| structural_mapping | 10 | 1 | 1 | 0 | 12 |
| tool_calling | 13 | 1 | 5 | 1 | 20 |
| versioning | 4 | 1 | 2 | 1 | 8 |
| **total** | **91** | **20** | **29** | **10** | **150** |

## api × dificultad

| api | easy | medium | hard | adversarial | total |
|---|---|---|---|---|---|
| both | 5 | 33 | 22 | 2 | 62 |
| anthropic | 4 | 18 | 20 | 2 | 44 |
| openai | 5 | 22 | 13 | 2 | 42 |
| unknown | 0 | 2 | 0 | 0 | 2 |
| **total** | **14** | **76** | **48** | **12** | **150** |

## Grupos contrastivos (viajan intactos en su split)

| Grupo | Tema | Split | Miembros |
|---|---|---|---|
| g1-tools | definición de herramienta (parameters vs input_schema) | validation | 4 |
| g2-toolround | ronda de herramienta (call_id vs tool_use_id) | test | 4 |
| g3-system | instrucciones de sistema (instructions vs system) | test | 4 |
| g4-image | entrada de imagen (input_image vs image+source) | validation | 4 |
| g5-stream | consumidor de streaming (deltas tipados vs eventos response.*) | train | 4 |

## Negativos

- `negative` struct embebido: 9 (rec-006, rec-007, map-002, map-005, cnv-001, cnv-014,
  tool-003, tool-014, mm-002).
- Miembros "mix" de grupos contrastivos: 5 (ctr-gX-mix), cada uno con corrección en su
  miembro `-fixed`.
- difficulty=adversarial: 12 (rec-007, ctr-g3-mix, ctr-g5-mix, cnv-014, tool-019, str-011,
  err-013, mm-008, rep-010, st-008, plan-005, + ver-008).
- Casos de incertidumbre honesta: 2 (rec-006, rec-007) — enseñan a decir "no determinable".

## Habilidades (`skills`)

365 etiquetas finas únicas para auditoría y filtrado (p. ej. `call_id_pairing`,
`tool_result_in_user_message`, `cache_control_in_tool_loops`, `adversarial_msg_prefix`,
`pause_turn_handling`, `ids_not_portable`). Son descriptivas: la cobertura nominal se mide
sobre `task_type` (100% de los 12 tipos presentes en train y test).

## Mapa de competencias del brief → módulos

| Capacidad requerida | Módulos |
|---|---|
| 1. Reconocimiento de API (+incertidumbre) | d01 |
| 2. Comprensión estructural (equivalencias y no-equivalencias) | d02 |
| 3. Conversión semántica (ambos sentidos) | d03 |
| 4. Diferenciación activa / pares contrastivos | d04 (+adversariales repartidos) |
| 5. Tool calling / ciclo agentic | d05 |
| 6. Streaming (inicio → eventos → fin) | d06 |
| 7. Errores y recuperación (obligatorio) | d07 (+err en otros módulos) |
| 8. Compatibilidad y versiones | d09 |
| 9. Multimodalidad (capacidades reales) | d10 |
| 10. Estado/conversaciones | d11 |
| 11. Planificación agentic e identidad | d12 |
| Transversal: reparación de protocolos | d08 |
