# AI-ku Computer Use — dataset de entrenamiento

**`ai-ku-computer-use.parquet`** · un único dataset · un único formato · un único archivo Parquet.

Dataset de trayectorias sintéticas de **uso completo de ordenador** para entrenar a **AI-ku V4X Thinker Max 35B** (128 expertos Nemotron) en la capacidad de usar un ordenador de forma natural, fluida, robusta y autónoma:

```text
objetivo → observar → comprender la interfaz → decidir → actuar →
observar resultado → verificar → corregir → continuar → completar
```

El dataset no enseña "cómo hacer clic": enseña **cómo usar un ordenador para conseguir un objetivo**, con una representación semántica común **API-agnóstica** y adaptadores derivados automáticamente para OpenAI y Anthropic.

---

## Cifras clave

| Métrica | v1.0 | v1.1 | **v1.2** |
|---|---|---|---|
| Trayectorias | 401 | 488 | **552** |
| Acciones (pasos) | 9.629 | 10.891 | **11.871** |
| Screenshots con píxeles (PNG) | 2.671 | 3.471 | **3.780** |
| Duración total estimada | 6,5 h | 7,1 h | **7,5 h** |
| Largo horizonte (≥25 pasos) | 33,7 % | 28,3 % | **26,1 %** |
| Con recuperación de fallos | 27,7 % | 28,1 % | **28,1 %** |
| Éxitos con verificación final superada | 100 % | 100 % (452/452) | **100 % (516/516)** |
| Multiaplicación | 20,2 % | 16,6 % | **14,7 %** |
| Idiomas | 80 % es / 20 % en | 80 % es / 20 % en | **79 % es / 21 % en** |
| Familias de escenarios | 96 | 119 | **136** |
| Dominios | 9 | 11 | **14** |
| Intenciones semánticas | ~90 | ~128 | **153** |
| Deduplicación semántica | 8 huellas | 15 huellas | **19 huellas** |
| Licencia | CC-BY-4.0 | CC-BY-4.0 | CC-BY-4.0 |

Informe completo: [`quality/quality_report.md`](quality/quality_report.md) · Validación: [`quality/validation_report.json`](quality/validation_report.json).

## Contenido

Cobertura de dominios: **sistema operativo** (ventanas, archivos, ajustes), **navegador** (pestañas, formularios, descargas, webapps), **Paint/gráficos**, **documentos**, **hojas de cálculo**, **presentaciones**, **terminal**, **edición de vídeo** (montaje NLE con líneas V2/V1/A1 — importar, cortar con cuchilla, fundidos, títulos y subtítulos, música, gradación de color, velocidad, exportación con fallo de render y misión larga de postproducción), **modelado 3D** (v1.2: Blender — vistas por numpad, transformaciones G/R/S con eje y valor exacto, primitivas por menú Añadir, modificadores y materiales, luz y sombreado renderizado, render Cycles/EEVEE con verificación de salida y animación por fotoclaves), **CAD técnico** (v1.2: AstraCAD — comandos L/PL/C/REC/TR/M/O/DIM/Z por línea de comandos, coordenadas exactas en mm, capas con congelado, acotación verificada, TRIM/DESFASE/MOVE y trazado a PDF), **apps de negocio** (v1.2: NimbusCRM — altas con validaciones de campo obligatorio y duplicados, ciclo de etapas del pipeline, filtros + informe de totales, búsqueda global y edición sobre datos vivos), **juegos y control fino** (Rocket League — aéreos con gestión de boost, packs de entrenamiento, ajustes de cámara y revisión de repeticiones; Minecraft — talar→craftear→pico, refugio de primera noche, fundición en horno y organización de hotbar; Forza Horizon — vuelta limpia con frenadas y rebobinado, afinación en garaje con equipado y validación, modo foto y flujo de festival), **flujos multiaplicación** y **seguridad/resiliencia** (CAPTCHA, prompt injection, acciones consecuenciales).

Escalera de dificultad completa (`basic → intermediate → advanced → very_advanced → extreme`) con peso en categorías avanzadas, tareas abiertas donde el agente **infiere el plan** (sin micro-instrucciones) y flagships de largo horizonte de hasta 148 pasos.

## Diseño en 4 ideas

1. **Un paso = el ciclo completo.** Cada paso contiene `observación → decisión → acción → resultado → verificación`, con screenshot (píxeles o `ui_tree` estructurado), razonamiento en el idioma de la tarea, acción semántica y evidencia de verificación.
2. **La inteligencia vive en el núcleo semántico, no en la API.** 12 primitivas (`MOVE_CURSOR, CLICK, DOUBLE_CLICK, TRIPLE_CLICK, DRAG, SCROLL, TYPE, KEY, HOLD_KEY, WAIT, SCREENSHOT, ZOOM`) + 153 intenciones. Cada paso incluye su traducción automática a **OpenAI Responses** (`computer_call.actions`) y a **Anthropic** (`computer_toolset_20260801`, 17 miembros) con notas de emulación donde la API no tiene equivalente nativo. AI-ku aprende *"necesito mover el cursor aquí"*, no *"OpenAI = esto"*.
3. **Verificar ≠ suponer.** El 100 % de los éxitos terminan con un check final superado; los fallos intermedios se conservan deliberadamente para enseñar `acción → resultado inesperado → diagnóstico → cambio de estrategia → nueva acción → verificación`.
4. **Seguridad por construcción.** CAPTCHA = detectar, clasificar, no evadir, detenerse y pedir humano (validado por reglas). El contenido en pantalla (páginas, documentos, popups) es **dato**, nunca una orden. Las acciones consecuenciales exigen revisión previa, riesgo declarado y confirmación explícita.

## Estructura del repositorio

```text
ai-ku-computer-use.parquet     ← el dataset (único archivo Parquet)
schemas/                       ← record, trajectory y vocabulario de acciones (JSON Schema)
docs/                          ← diseño, compatibilidad de APIs, taxonomía, seguridad, reproducción
scripts/                       ← generador determinista completo (build/validate/report/samples)
quality/                       ← informes de calidad y validación + 23 muestras legibles
```

## Cómo leer el dataset

```python
import pyarrow.parquet as pq, json

tb = pq.read_table("ai-ku-computer-use.parquet")
row = tb.slice(0, 1).to_pylist()[0]

print(row["objective"])                      # objetivo del usuario
steps = json.loads(row["trajectory"])        # ciclo completo por paso
s0 = steps[0]
print(s0["decision"]["thought"])             # razonamiento operativo
print(s0["action"]["tool"], s0["action"]["params"])   # acción semántica
print(s0["action"]["adapters"]["anthropic"]) # equivalente Anthropic
print(s0["action"]["adapters"]["openai"])    # equivalente OpenAI
print(s0["verification"])                    # evidencia de verificación
```

Los campos `messages`, `trajectory`, `verification`, `recovery`, `outcome`, `provenance` y `tags` son cadenas JSON UTF-8 (ver `schemas/`); las columnas planas (`platform`, `domain`, `difficulty`, `n_steps`, …) permiten filtrado directo.

## Reproducción

El dataset es **100 % sintético y determinista** (semillas fijas). Regenerarlo completo, con screenshots para el 100 % de las observaciones si se desea:

```bash
python3 scripts/build_dataset.py --pixels 3700   # o --pixels 100000 para píxeles universales
python3 scripts/validate_dataset.py              # validación exhaustiva (debe dar 0 errores)
python3 scripts/make_report.py                   # informe de las 20 métricas
python3 scripts/export_samples.py                # muestras legibles
```

Requisitos: Python ≥3.11, `pyarrow`, `pillow`, `jsonschema`. No se necesita red, tokens ni servicios externos.

## Seguridad del dataset

- Sin datos de terceros: no se copió ningún ejemplo de AgentNet, OpenCUA/Uni-GUI, GroundCUA, ScaleCUA ni de los datasets markov-ai (consultados solo como inspiración de cobertura, ver [`docs/08-fuentes-y-referencias.md`](docs/08-fuentes-y-referencias.md)).
- CAPTCHAs sintéticos de laboratorio: solo se entrena **detectar → parar → pedir humano**; la validación rechaza cualquier trayectoria etiquetada como CAPTCHA que no termine en `aborted_safely`/`blocked_by_policy`.
- Sin secretos: el pipeline escanea el contenido buscando patrones de token antes de publicar.

## Novedades v1.2

- **Nuevo dominio `3d_modeling`** (7 familias / 28 trayectorias): Blender sintético con viewport 3D, outliner y panel de propiedades; transformaciones **teclado-primero** (G/R/S + eje + valor + Enter, como Blender real), menú Añadir de primitivas, modificadores no destructivos, materiales, luz, sombreado renderizado, **render Cycles/EEVEE con fallo de render y re-intento** (verificando que el archivo de salida EXISTE) y animación con fotoclaves en los fotogramas 1 y 24.
- **Nuevo dominio `cad`** (6 familias / 23 trayectorias): AstraCAD (estilo AutoCAD) con **línea de comandos primero**: L/PL/C/REC/TR/M/O/DIM/Z + Enter, entrada de **coordenadas exactas en mm** (25 px = 1 celda = 10 mm), capas con congelado (una capa congelada bloquea el dibujo y enseña a descongelar), acotación con valor leído del dibujo, TRIM por intersección, DESFASE con distancia tipada, MOVE en tres clics, ayudas F3 (OSNAP) y F8 (ORTO) y trazado a PDF con tamaño de papel.
- **Nuevo dominio `business_apps`** (4 familias / 16 trayectorias): NimbusCRM con borrador pendiente de Guardar, validaciones reales (**campo obligatorio** y **registro duplicado** rechazados con diálogo), ciclo de etapas del pipeline, filtros por etapa con conteo de filas, informe de totales EUR y **vista obsoleta multiusuario** (cambios externos hasta pulsar Actualizar).
- Inspiración de cobertura: las categorías con más horas de uso real en los datasets públicos de referencia (Blender, Excel/CAD y CRM empresarial) — solo como idea de qué aplicaciones importan; **cero datos copiados** (ver `docs/08`).
- Vocabulario ampliado a **153 intenciones** y 41 tipos de fallo (`render_incomplete`, `wrong_viewport`, `osnap_off`, `command_unknown`, `field_required`, `duplicate_record`, `stale_view`).

## Novedades v1.1

- **Nuevo dominio `video_editing`** (11 familias / 44 trayectorias): editor NLE sintético con monitor, pool de medios, panel de efectos y línea de tiempo multipista; incluye fallo de render en exportación 4K con re-intento y misión larga de postproducción (desincronía de audio + medio offline + gradación + entrega).
- **Expansión de `games`** (12 familias / 49 trayectorias): Rocket League (aéreos con presupuesto de boost, pack de entrenamiento con reinicios, ajustes de cámara, repeticiones), Minecraft (talar→craftear→pico, refugio nocturno con mob, fundición, hotbar) y Forza Horizon (vuelta limpia con rebobinado, afinación garaje→equipar→validar, modo foto, flujo de festival).
- **Corrección**: los screenshots de la vista de juego ahora dibujan la arena real (en v1.0 el render de la arena salía en blanco por un rol de elemento erróneo).
- Vocabulario ampliado a ~115 intenciones y 33 tipos de fallo (`export_failed`, `media_offline`, `audio_desync`, `attempt_failed`, …).

## Licencia

Dataset y documentación: **CC-BY-4.0** (ver `LICENSE`). Código del generador: **MIT** (ver `LICENSE-CODE`).
