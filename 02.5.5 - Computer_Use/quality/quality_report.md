# Informe de calidad — ai-ku-computer-use v1.0.0

## 1-4. Volumen
| Métrica | Valor |
|---|---|
| Trayectorias | **552** |
| Acciones (pasos) | **11871** |
| Screenshots con píxeles (PNG) | **3780** |
| Duración total estimada | **7.5 h** (26977 s) |

## 5. Longitud media
**21.5 pasos/trayectoria** · mediana ≈ 16 · máxima = 148

## 6. Distribución por plataforma
| Plataforma | Trayectorias | % |
|---|---|---|
| windows_11 | 237 | 42.9 % |
| ubuntu_24_04 | 180 | 32.6 % |
| macos_15 | 81 | 14.7 % |
| windows_10 | 54 | 9.8 % |

## 7. Distribución por aplicación principal
| Aplicación | Trayectorias | % |
|---|---|---|
| browser | 99 | 17.9 % |
| game | 78 | 14.1 % |
| calc | 59 | 10.7 % |
| paint | 47 | 8.5 % |
| explorer | 46 | 8.3 % |
| video_editor | 44 | 8.0 % |
| writer | 40 | 7.2 % |
| slides | 35 | 6.3 % |
| blender | 28 | 5.1 % |
| cad | 23 | 4.2 % |
| crm | 16 | 2.9 % |
| terminal | 11 | 2.0 % |
| settings | 8 | 1.4 % |
| desktop | 8 | 1.4 % |
| notepad | 6 | 1.1 % |
| mail | 4 | 0.7 % |

## 8. Distribución por dificultad
| Dificultad | Trayectorias | % |
|---|---|---|
| intermediate | 216 | 39.1 % |
| advanced | 195 | 35.3 % |
| basic | 65 | 11.8 % |
| very_advanced | 52 | 9.4 % |
| extreme | 24 | 4.3 % |

## 9. Distribución por tipo de tarea
| Tipo | Trayectorias | % |
|---|---|---|
| game_control | 78 | 14.1 % |
| document_production | 48 | 8.7 % |
| workflow_automation | 46 | 8.3 % |
| guided_edit | 46 | 8.3 % |
| video_production | 44 | 8.0 % |
| data_pipeline | 41 | 7.4 % |
| safety_handling | 35 | 6.3 % |
| creative_graphics | 34 | 6.2 % |
| atomic_action | 30 | 5.4 % |
| 3d_production | 28 | 5.1 % |
| error_recovery_drill | 27 | 4.9 % |
| open_objective | 27 | 4.9 % |
| technical_drawing | 23 | 4.2 % |
| research_synthesis | 18 | 3.3 % |
| business_process | 16 | 2.9 % |
| system_administration | 11 | 2.0 % |

## 10-14. Porcentajes clave
| Indicador | Valor |
|---|---|
| Tareas de largo horizonte (≥25 pasos) | 26.1 % |
| Trayectorias con recuperación de fallos | 28.1 % |
| Éxitos con verificación real superada | 100.0 % |
| Tareas multiaplicación | 14.7 % |
| Tareas abiertas (solo objetivo) | 4.9 % |

Horizontes: {'medium': 376, 'long': 140, 'short': 32, 'very_long': 4} · Idiomas: {'en': 117, 'es': 435} · Desenlaces: {'success': 516, 'aborted_safely': 10, 'partial': 23, 'failed': 3}

## 15. Cobertura de representación (por paso)
| Representación | Pasos cubiertos |
|---|---|
| Núcleo semántico común | 11871 (100 %) |
| Adaptador OpenAI Responses `computer` | 11871 (100 % de pasos) |
| Adaptador Anthropic `computer_toolset_20260801` | 11871 (100 % de pasos) |

El núcleo semántico es la fuente de verdad; ambos adaptadores se derivan
automáticamente (ver `scripts/aku/adapters.py`), de modo que la misma intención
aprende a viajar por cualquiera de las dos APIs sin acoplarse a ninguna.

## 16. Duplicados
Tasa de deduplicación semántica: **3.33 %** (19 huellas repetidas eliminadas de 571 generadas).

## 17. Problemas de calidad encontrados y tratamiento
- Variante con generación fallida: 0 (descartadas en el build, nunca silenciadas como filas incompletas).
- Validación exhaustiva: ver `validation_report.json` (esquema, coordenadas, adaptadores, PNG+sha256, políticas de seguridad, coherencia temporal, fuga de splits).
- Resolución fija 1280×720: deliberada para garantizar coherencia coordenada↔píxel; el espacio visual varía por layout de aplicación, no por resolución.
- Screenshots: subconjunto con píxeles reales (3780); el resto conserva descripción + ui_tree completo (regenerable con `--pixels` alto).

## 18. Fuentes y licencias
- **Origen: 100 % sintético propio** (generador determinista incluido en `scripts/`). No se copió ningún ejemplo de AgentNet, OpenCUA/Uni-GUI, GroundCUA ni ScaleCUA-Data; estos datasets se estudiaron como referencia de taxonomía y action space (ver `docs/08-fuentes-y-referencias.md`).
- Licencia del dataset y del repo: **CC-BY-4.0** (código de generación: MIT, ver `LICENSE-CODE`).

## 19. Limitaciones
- UIs sintéticas: la variabilidad visual es menor que la de capturas reales; el valor del dataset está en la semántica del ciclo observar→decidir→actuar→verificar.
- Screenshots en modo paleta (96 colores) para mantener el repositorio ligero.
- Coordenadas fiables solo dentro del espacio del screenshot declarado (1280×720).
- `HOLD_KEY`/`ZOOM`/`TRIPLE_CLICK` se emulan en el adaptador OpenAI (documentado por paso).

## 20. Contaminación y solapamientos
- Al ser datos sintéticos con generador propio, no existe solapamiento con benchmarks públicos ni con datos de preentrenamiento de terceros.
- Riesgo residual: coincidencia incidental de nombres de dominio ficticios (`*.demo.es`) — bajo y documentado.
- Las familias comparten plantillas entre variantes; la fuga train/valid/test se controla separando a nivel de **familia** (sin cortes transversales).
