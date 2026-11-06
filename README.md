# 👁️ PMG VISION — Industrial Computer Vision Hub
> Sistema de visión artificial en tiempo real optimizado para entornos de producción industrial 24/7.

[![Flutter](https://img.shields.io/badge/Flutter-3.x-blue?logo=flutter)](https://flutter.dev)
[![TFLite](https://img.shields.io/badge/TFLite-YOLO-orange?logo=tensorflow)](https://tensorflow.org)
[![Platform](https://img.shields.io/badge/Platform-Android%20%2F%2F%20Industrial%20Edge-green)](https://github.com)

---

## 🚀 Acerca del Proyecto
**PMG VISION** es una aplicación de HMI (Interfaz Humana-Máquina) desarrollada en Flutter para la automatización y conteo de piezas metálicas en líneas de producción exigentes. Utiliza inferencia local mediante modelos YOLO ejecutados directamente sobre el hardware del dispositivo (Aceleración por GPU/NNAPI) para garantizar **cero latencia** y funcionamiento autónomo sin dependencia de la nube.

<p align="center">
  <!-- Aquí puedes subir una captura real de tu app a GitHub y poner el enlace -->
  <img src="assets/piston_bg.jpg" width="300" alt="PMG Vision Interface Preview">
</p>

---

## 🛠️ Stack Tecnológico & Arquitectura
* **Frontend UI:** Flutter (Material Design 3, optimizado a 60 FPS con `ValueNotifier` y aislamiento de renderizado).
* **Inteligencia Artificial:** `tflite_flutter` con delegados de aceleración por **GPU** y buffers pre-asignados (*Zero-Allocation*).
* **Persistencia y Resiliencia:** Almacenamiento local optimizado (`SharedPreferences`) con cola de sincronización offline para ERPs.
* **Estabilidad Operativa:** Control de inactividad de pantalla 24/7 (`WakelockPlus`) y recuperación automática ante fallos de sensor.

---

## ✨ Características Principales
1. **Inferencia Ultrarrápida:** Procesamiento de frames YUV directos de cámara sin copias de memoria intermedias.
2. **Modo Operativo Industrial:** Interfaz diseñada para operarios con guantes, alertas visuales por capas/cajas completadas y control de zoom/exposición.
3. **Resistencia a Caídas:** Guardado automático de estado del turno en disco local ante reinicios imprevistos de hardware.
4. **Telemetría en Vivo:** Monitorización de latencia en milisegundos (`ms`) y cuadros por segundo (`FPS`) directamente en pantalla.