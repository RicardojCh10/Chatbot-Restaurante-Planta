# 💬 Chatbot RAG - Flutter + FastAPI

## 📘 Descripción general
Este proyecto consiste en el desarrollo de una **aplicación móvil Flutter** que funciona como **frontend para un chatbot RAG (Retrieve–Augment–Generate)** implementado en **FastAPI**.  
El objetivo principal es conectar la interfaz Flutter con el endpoint `/chat` del backend, permitiendo enviar preguntas y visualizar respuestas en tiempo real dentro de una interfaz tipo chat.

La aplicación implementa:
- Consumo de API REST.
- Manejo de estado reactivo.
- Diseño de interfaz conversacional con animaciones de carga.
- Configuración adaptable para distintos entornos (emulador/dispositivo físico).

---

## ⚙️ Tecnologías utilizadas
### **Frontend**
- [Flutter](https://flutter.dev/)
- [Dart](https://dart.dev/)
- [Provider / Riverpod / GetX] (según tu elección para manejo de estado)
- Widgets personalizados para UI tipo chat.

### **Backend**
- [FastAPI](https://fastapi.tiangolo.com/)
- Python 3.10+
- Endpoint `/chat` que implementa la lógica RAG.
- Material de apoyo: `menu.pdf` y notebook de ejemplo en Python.

---
## 💻 Ejecución del proyecto

### 1️⃣ Backend (FastAPI)

Asegúrate de tener el backend levantado antes de ejecutar la app Flutter.
```bash
uvicorn main:app --reload --host 0.0.0.0 --port 8000
```
### 2️⃣ Frontend (Flutter)

Ejecuta los siguientes comandos en la raíz del proyecto Flutter:
```bash
flutter pub get
flutter run
```
---
## 🧠 Características clave implementadas

- ✅ Interfaz tipo chat con historial de conversación.
- ✅ Envío de mensajes y recepción de respuestas desde FastAPI.
- ✅ Indicador visual de carga (“Preparando respuesta…”, “Pensando...”).
- ✅ Manejo de errores de red y mensajes amigables al usuario.
- ✅ Arquitectura limpia con separación de capas (core, features, widgets).

---
## 🧾 Material de apoyo

- menu.pdf – Archivo utilizado por el sistema RAG.

- notebook_ejemplo.ipynb – Ejemplo en Python del backend RAG.

- Guía paso a paso para levantar el backend FastAPI.

## 🧑‍💻 Autor

### Ricardo Chi
Estudiante de Ingeniería en Desarrollo y Gestión de Software
Proyecto académico - Desarrollo para Dispositivos Inteligentes

---

## 🧩 Estructura del proyecto Flutter
```bash
lib/
│
├── main.dart
├── core/
│   ├── api_client.dart          # Cliente HTTP para llamadas al backend
│   └── models.dart              # Modelos de datos (Request/Response)
│
├── features/chat/
│   ├── chat_repository.dart     # Capa de comunicación con la API
│   ├── chat_controller.dart     # Lógica de estado y eventos del chat
│   ├── chat_screen.dart         # Pantalla principal del chat
│
└── widgets/
    ├── message_bubble.dart      # Burbuja de mensaje (usuario/asistente)
    ├── input_bar.dart           # Campo de texto y botón de envío
    └── typing_indicator.dart    # Indicador de carga ("Pensando...", etc.)
