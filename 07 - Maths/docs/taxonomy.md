# Taxonomía

## Dominios (primario único + etiquetas cruzadas)

| Dominio | Subdominios (~80 en total) | Peso |
|---|---|---|
| `mathematics` | análisis real/complejo/funcional, medida, EDP, armónico, variacional, grupos, Galois, anillos, representaciones, Jordan, NT analítica/algebraica, combinatoria, grafos, Ramsey-extremal, numérica, exploraciones frontera | 17.6 % |
| `physics` | lagrangiana/hamiltoniana, caos, relatividad especial/general, EM, guías de onda, mecánica estadística, modelado físico | 26.1 % |
| `quantum_physics` | fundamentos, espectro, espín, perturbaciones, scattering-WKB, muchos cuerpos, información cuántica, sistemas abiertos, QFT básica, interfaz matemática | 24.4 % |
| `mathematical_computation` | álgebra lineal numérica, optimización, Monte Carlo, diferenciación automática | 8.6 % |
| `biology_bioinformatics` | dinámica poblacional, epidemiología, secuencias, estadística genómica, modelado molecular, sistemas, neuro, evolución | 10.4 % |
| `scientific_method` | diseño experimental, estándares de evidencia, causalidad, crítica de modelos, reproducibilidad | 7.8 % |
| `diagnostic_reasoning` | diagnóstico diferencial (House), debugging, Bayes secuencial, casos ficticios | 5.1 % |

Lista completa y congelada de subdominios: `scripts/schema.py::SUBDOMAINS`.

## Dificultad (sesgo deliberado a difícil+)

`intermediate` (0 %) · `hard` (36 %) · `very_hard` (46 %) · `extreme`
(17 %) · `frontier` (0.4 %). Criterios de asignación por familia en los
generadores (p. ej., `extreme` para transiciones de fase, números de Pell
enormes, agotamiento de Ramsey, caos con Lyapunov positivo).

## Tipos de tarea (proceso, no tema)

`derivation` 13.8 · `simulation` 25.6 · `problem_solving` 23.9 ·
`method_comparison` 16.9 · `diagnosis` 5.1 · `data_analysis` 2.0 ·
`result_analysis` 3.8 · `experiment_design` 2.2 · `proof` 0.8 ·
`counterexample_search` 1.6 · `optimization` 1.7 · `error_correction` 0.9 ·
`solution_critique` 1.6 · `exploration` 0.2. Los arquetipos de proceso se
documentan en `methodology_generation.md`.

## Tipos de conocimiento (estado epistémico)

`derivation` 270 · `numerical_result` 304 · `simulation` 144 ·
`proven_theorem` 184 · `approximation` 1. Cada conclusión lleva además su
frase epistémica explícita en el texto.

## Dominios técnicos (v1.1, añadidos al final del enum)

Los siete dominios originales conservan su posición en `DOMAINS`; los técnicos se
añaden a continuación. Cada familia nueva ejecuta su snippet en la construcción
(texto == cómputo) y usa los mismos 8 arquetipos de proceso.

| Dominio | Subdominios | Cobertura |
|---|---|---|
| `mechanical_engineering` | statics_and_structures, machine_elements, power_transmission, shaft_and_bearing_design, bolted_joints, tolerancing_and_fits, fatigue_and_reliability, vibration_analysis, mechanism_kinematics, robot_kinematics, mechatronic_integration | 50 % técnica-industrial (engranajes/Lewis, ejes ASME, rodamientos L10, tornillos, ISO 286, vibraciones ISO 10816) + 50 % mecatrónica (brazos 2R FK/IK/Jacobiano, cuatro barras/Grashof) |
| `electrical_systems` | dc_circuit_analysis, ac_power_analysis, three_phase_systems, conductor_sizing, protection_coordination, grounding_and_earthing, electric_motors_starting, measurement_and_instrumentation, electrical_safety, assembly_and_maintenance | Instalaciones reales: mallas DC con balance de potencias, corrección de cos φ, estrella desequilibrada, sección de conductores y caída de tensión, selectividad I²t, TT/TN + diferenciales, arranque de motores, mantenimiento preventivo Weibull (edad-óptimo) |
| `operating_systems` | processes_and_scheduling, memory_management, filesystems_and_storage, permissions_and_users, services_and_boot, shell_and_pipelines, signals_and_priorities, os_theory | Mezcla 70/30: planificación FCFS/SJF/RR simulada, reemplazo de páginas (FIFO/LRU/OPT + Belady), permisos/umask bit a bit, orden de unidades systemd (Kahn), pipelines de logs, RAID/inodos, cgroups/nice, ley de Little |
| `computer_networks` | ip_addressing_subnetting, routing, switching_and_lan, transport_tcp_udp, dns_dhcp_services, network_diagnostics, wireless, network_performance_theory | VLSM con aserción de bloque, LPM + Dijkstra, arranque lento TCP + cota de Mathis, caché DNS con TTL, ciclo de vida DHCP (T1/T2), bufferbloat/BDP, airtime Wi-Fi |
| `electronics` | analog_circuits, operational_amplifiers, filters_and_frequency, diodes_and_power, transistor_circuits, combinational_logic, sequential_logic, adc_dac, buses_and_interfaces | Ganancia de lazo con Aol finito, Bode exacto vs asintótico, ripple de rectificadores, ventana del zener por esquinas, polarización BJT con sensibilidad β, Fmax/hold, SNR/aliasing ADC |
| `industrial_automation` | plc_ladder_logic, sequential_control_grafcet, industrial_pid, sensor_scaling_calibration, actuators_and_drives, motor_control_circuits, scan_cycle_and_timing, safety_instrumented_systems | Enclavamiento ladder con tabla de verdad, GRAFCET lineal sin deadlock, ZN vs conservador en FOPDT, 4-20 mA con NAMUR NE 43, enclavamientos de contactores, presupuesto de scan/watchdog, PFDavg/SIL (IEC 61511) |
| `cyberdefense` | log_analysis_and_detection, system_hardening, applied_cryptography, vulnerability_management, incident_response, network_defense, backup_and_recovery, digital_forensics_basics, **brainstorming** | SOLO defensiva: detección en logs de autenticación con auditoría de falsos positivos, entropía de contraseñas, validación de certificados (regla de comodín de una etiqueta), CVSS v3.1 fiel a la especificación, revisión sshd fail-closed, 3-2-1/RPO/RTO, línea forense con ventana pre-borrado. El subdominio `brainstorming` contiene los episodios marcados `[BRAINSTORMING]` (ver abajo) |

### Episodios BRAINSTORMING (marcados y separados)

Los ejemplos de ideación llevan la etiqueta `[BRAINSTORMING]` en el enunciado, el
tag `brainstorming`, familias propias (`BRAINSTORMING_*`) y — en ciberdefensa —
un subdominio dedicado. Filtran en una línea:

```python
ds.filter(lambda r: "brainstorming" in r["tags"])
```

Su estructura: fase divergente sin filtro (cantidad) → triaje explícito y
calculado (valor/costo/riesgo) → primera sonda elegida; el estado epistémico
permanece en `hypothesis` de principio a fin.
