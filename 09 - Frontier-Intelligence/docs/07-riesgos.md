# 07 · Riesgos: overfitting, contaminación e imitación

## 1. Overfitting a procedimientos (memorizar el "cómo")

**Riesgo**: que AI-ku memorice secuencias (plan→tool→fix) en vez de aprender el principio de
decisión. Evidencia ajena que motiva la cautela: evaluación independiente señala
**memorización** en Opus 5.5 [T-endorlabs] — puede pasarle hasta a un frontier.

**Mitigaciones**:
- Contrafácticos sistemáticos (CF-*): cada solución buena genera variantes donde la condición
  clave cambia y la estrategia deja de servir.
- Variedad de superficie con invariante de fondo: el mismo patrón (p. ej. V1 sanity-check) en
  ≥4 familias de tarea y ≥3 lenguajes de programación.
- Evaluación SOLO en tareas inéditas (docs/06): si patch_trap solo mejora en tareas tipo
  patch-trap del train, es memorización, no transferencia.
- Mezcla con replay general (5%) para no sobre-especializar la política.

## 2. Contaminación de benchmarks

**Riesgo**: que ítems o near-duplicates de benchmarks públicos entrenen al modelo y los
scores dejen de significar nada (contaminación estándar de la era frontier).

**Mitigaciones**:
- Regla dura: ítems de benchmarks **nunca** entran al train. Los benchmarks se usan para
  LEER capacidades (docs/01), no como fuente de datos.
- `scripts/validate_jsonl.py` incluye scanner opcional de n-gramas (8-gramas normalizados)
  contra un directorio de benchmarks públicos que el equipo mantiene fuera del repo.
- Todo ejemplo lleva `injection` documentado: auditable que las trampas son diseño propio.
- Evals propias (docs/06) creadas DESPUÉS del train set, guardadas fuera de él.

## 3. Imitación de Fable (distilación textual disfrazada)

**Riesgo**: que las trazas "inspiradas en" el estilo de Fable terminen siendo una imitación
estilística: AI-ku hablaría como Fable, heredaría su identidad y sus sesgos — exactamente lo
que el proyecto prohíbe ("NO copies respuestas… no quiero distilación textual superficial").

**Mitigaciones**:
- Las muestras son **originales por construcción**: se entrena el PRINCIPIO (re-anclaje,
  verificación, pivote), no el estilo; el estilo lo define la persona AI-ku.
- **Scrub de identidad** obligatorio en el pipeline de datos: ningún "soy Claude/Fable/
  Anthropic/OpenAI" ni vestigios; la persona del system prompt es AI-ku (español, identidad
  propia, tokens V4X).
- Chequeo anti-mimetismo: n-gramas y marcadores estilísticos contra muestras públicas de
  outputs de Fable/Claude (registro fuera del repo por licencia).
- El prompt baking (fase posterior) consolida la identidad AI-ku solo si el SFT ya no
  contiene identidad ajena: por eso el scrub es pre-requisito, no parche.

## 4. Riesgos específicos de AI-ku (arquitectura)

| Riesgo | Mecanismo | Mitigación en datos |
|---|---|---|
| Muerte de lanes (Qwen/Phi) | Router heredado de Nemotron con priors ajenos | Balanceo router-aware (docs/05 §5) + medición de activación por época |
| Router colapsado por sobremuestreo | Muestreo agresivo distorsiona priors | Aux-loss de load-balance; curva de activación como señal de parada |
| Purga ACS con referencias muertas | Modelo referencia pensamientos que ya no existen | Variantes ACS en train + eval purge_survival con umbral <1% |
| Identidad cocinada mal | Baking sobre datos con identidad ajena | Scrub pre-SFT (riesgo 3) |
| MTP con distribución cambiante | Entrenar MTP antes de OMNI desalinea cabezas | Orden del pipeline: MTP al final del bloque de entrenamiento |
| Sobre-verificación aprendida (el fallo de Fable) | Exceso de ejemplos de verificación en lo fácil | Estratificación effort-dificultad explícita (cola trivial `none`) |

## 5. Señales de alarma durante el SFT (monitoreo)

1. Loss de SFT cae rápido pero evals de transferencia planas → memorización (riesgo 1).
2. Activación de lanes con entropía decreciente → colapso de router (riesgo arquitectura).
3. Salidas que "suenen" a Fable/Claude → imitación (riesgo 3): cortar y revisar scrub.
4. over-pensamiento en dificultad 1-2 → la cola trivial no está calibrando (riesgo 4, tabla).
