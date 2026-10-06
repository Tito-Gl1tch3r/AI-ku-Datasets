# Marco legal y ético del contenido

## Qué ES este dataset

- Enseñanza de **metodología ofensiva legítima**: la que se practica en
  pentesting profesional con contrato, bug bounty dentro de política y OSINT
  sobre datos públicos.
- **Análisis cuantitativo** de decisiones ofensivas/defensivas: tasas
  sostenibles, probabilidad de duplicado, EV de sesión, presupuesto de ruido.
- **Comunicación**: cadenas de evidencia, severidad justificada, informes que
  el cliente puede ejecutar.

## Qué NO es

- No contiene: payloads operativos reales, malware, evasión de EDR ejecutable,
  credenciales, infraestructura de ataque, ni instrucciones contra sistemas de
  terceros.
- No enseña a atacar fuera de un marco autorizado: cada system frame fija el
  contexto de autorización y los límites de alcance.
- No facilita daño a terceros: los "objetivos" son fixtures sintéticos
  (RFC 5737/203.0.113/198.51.100, example.com, dominios de laboratorio).

## Salvaguardas de diseño

1. **Compuerta de alcance computada** en los ejemplos de pentest y bug bounty:
   el gate se ejecuta ANTES de cualquier paso activo simulado.
2. **Compuerta ética fail-closed** en OSINT: caso dudoso → NO PROCEED.
3. **BRAINSTORMING acotado**: la ideación ofensiva vive en su propio dominio,
   marcada, con `knowledge_type = hypothesis` y triaje que penaliza riesgo
   legal — ideas, no decisiones.
4. **Riesgo asimétrico documentado**: los ejemplos de atribución/OSINT
   subrayan el costo irreversible de los falsos positivos.

## Referencias conceptuales

PTES, OSSTMM, OWASP Testing Guide, CVSS v3.1 (FIRST), NIST SP 800-63B,
GDPR principios, MITRE ATT&CK (detecciones). Citadas como referencias
conceptuales; no se reproduce texto ajeno.
