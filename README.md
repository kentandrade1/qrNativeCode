## Contexto

Este proyecto consiste en una **aplicación móvil** desarrollada en **Flutter**, que permite a los usuarios realizar el **escaneo de códigos QR** utilizando la cámara del dispositivo. Además, cuenta con integración nativa para mejorar el rendimiento, así como una funcionalidad de **autenticación biométrica** mediante **Face ID** (iOS) o **Huella Digital** (Android), para mejorar la seguridad.

El menú de la aplicación incluye dos opciones principales para escanear códigos QR:

1. **Escaneo con código nativo**: Utilizando la integración nativa para optimizar el rendimiento en ambas plataformas (iOS y Android).
2. **Escaneo con Flutter**: Una opción que utiliza una librería de Flutter para escanear códigos QR, con un diseño atractivo y una interfaz de usuario fluida.

## Requisitos Técnicos

- Flutter 3.x
- Android Studio / Xcode
- Gestión de estado con BLoC
- Integración con código nativo (Android e iOS) utilizando Pigeon
- Aplicación compilable para Android e iOS
- Pruebas unitarias implementadas

## Requisitos Funcionales

### Escaneo de Código QR

- La cámara debe activarse automáticamente al abrir la pantalla de escaneo.
- El procesamiento del código QR se realiza de manera nativa para optimizar el rendimiento.
- La información obtenida del QR debe mostrarse en pantalla y almacenarse en un historial que persista incluso después de cerrar la aplicación.
- Se implementa un sqlLite para gestionar los datos escaneados.

### Autenticación Biométrica

- Al iniciar la aplicación, se debe visualizar un botón para iniciar sesión con la autenticación biométrica (Face ID o Huella Digital).
- La aplicación debe detectar si el dispositivo es compatible con la autenticación biométrica.
- En caso de fallo en la autenticación biométrica, se solicita un PIN de respaldo.

### Opciones de Escaneo en el Menú

- **Escaneo con código nativo**:
  - Disponible desde el botón central de SEEK en el menú.
  - Utiliza el procesamiento nativo para escanear QR, optimizando el rendimiento en ambas plataformas (iOS y Android).
  
- **Escaneo con librería Flutter**:
  - Opción con un diseño atractivo para realizar el escaneo utilizando una librería de Flutter.
  - Interfaz de usuario fluida que permite escanear códigos QR de manera efectiva utilizando Flutter.

## Recomendaciones

- Crear una interfaz de usuario atractiva y fácil de usar.
- Usar **Pigeon** para exponer la funcionalidad al código Flutter.
- Implementar **BLoC** para manejar el flujo de autenticación y el manejo del estado de escaneo y el historial.
- Implementar **pruebas unitarias** para ambas funcionalidades.
- Aplicar patrones de diseño apropiados para separar las preocupaciones y facilitar la escalabilidad y mantenibilidad del código.
- Ambas funcionalidades deben ser modulares y desarrollarse como un paquete independiente dentro del monorepo.
- **Melos** recomendado para gestionar el monorepo.
- **Fastlane** recomendado para automatización de compilación y despliegue.
- Asegúrate de que el código sea legible y siga las mejores prácticas de desarrollo.
- Proporciona comentarios en el código donde sea necesario.

## Instrucciones para Ejecutar la Aplicación

### Pre-requisitos

1. **Flutter** debe estar instalado. [Instrucciones de instalación](https://flutter.dev/docs/get-started/install).
2. **Android Studio** o **Xcode** deben estar configurados.

