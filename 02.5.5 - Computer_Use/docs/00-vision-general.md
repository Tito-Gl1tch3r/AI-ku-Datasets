# 00 — Visión general del dataset

## Propósito

Este dataset entrena la capacidad de **computer use** de AI-ku: recibir un objetivo en lenguaje natural y convertirlo en una secuencia completa, autónoma y verificada de operaciones sobre un ordenador real (o sandbox). La premisa de diseño es que la competencia de un agente no reside en conocer el nombre de una API, sino en dominar el ciclo operativo completo: observar el estado real de la pantalla, comprender qué está ocurriendo, decidir con contexto, actuar con precisión, observar el resultado, verificar de forma explícita y recuperarse de lo inesperado sin perder el objetivo global.

## Filosofía de contenido

Cada trayectoria es una **misión completa** con un desenlace auditable. El dataset cubre el espectro desde "haz clic ahí" (2 pasos) hasta proyectos extremos de extremo a extremo con seis aplicaciones, interrupciones reales y verificación integral (148 pasos en la flagship más larga). La calidad prima sobre la cantidad: cada familia de escenarios genera variantes que difieren en estrategia (ratón frente a teclado), fallos inyectados, orden y desenlace, y un validador automatizado rechaza cualquier inconsistencia.

## Decisiones de diseño principales

- **Esquema único API-agnóstico**: la misma trayectoria se representa en núcleo semántico y se traduce automáticamente a las superficies de OpenAI y Anthropic (ver docs 03 y 04).
- **Paso con ciclo completo**: cinco bloques por paso (ver doc 01) para que el modelo aprenda la relación causa-efecto entre acción y estado, no secuencias memorizadas.
- **Coordenadas ligadas al screenshot**: las coordenadas pertenecen al espacio del screenshot declarado; nada es memorizable como "x=500 significa el botón Guardar".
- **Verificación obligatoria**: el 100 % de los éxitos cierran con un check superado; "acción ejecutada" y "objetivo conseguido" son conceptos distintos y etiquetados.
- **Seguridad como contenido**: CAPTCHA, prompt injection y acciones consecuenciales son familias explícitas con validadores dedicados.

## Composición resultante

552 trayectorias · 11.871 pasos · 3.780 screenshots con píxeles (el resto con `ui_tree` + descripción) · 26,1 % de largo horizonte · 28,1 % con recuperación · 14,7 % multiaplicación · 4,9 % tareas abiertas · español 79 % / inglés 21 %. La distribución por dificultad prioriza lo avanzado: 49,1 % de las trayectorias son `advanced` o superior. Los splits (477/39/36) se asignan por familia completa para evitar fuga entre train/validation/test, y el validador lo comprueba.
