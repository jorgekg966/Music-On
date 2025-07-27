# Music On - Aplicación de Música Flutter

Una aplicación de música móvil desarrollada en Flutter con interfaz tipo Spotify que permite reproducir música desde tu servidor.

## ✨ Características

- 🎵 **Interfaz tipo Spotify**: Diseño moderno y familiar
- 🎮 **Reproductor completo**: Con controles de play/pause, siguiente, anterior
- 📱 **Mini reproductor**: Control desde cualquier pantalla
- 🔍 **Búsqueda**: Encuentra canciones por título, artista o álbum
- ❤️ **Favoritos**: Marca y guarda tus canciones favoritas
- 📚 **Biblioteca**: Organiza tu música en playlists
- 🔀 **Aleatorio y repetir**: Controles de reproducción avanzados
- 🌙 **Tema oscuro**: Diseño elegante y fácil para los ojos

## 🚀 Cómo Compilar la APK

### Prerequisitos

1. **Flutter SDK** instalado ([Guía de instalación](https://flutter.dev/docs/get-started/install))
2. **Android Studio** con Android SDK
3. **Dispositivo Android** o emulador para pruebas

### Pasos para compilar

1. **Clonar o descargar el proyecto**
   ```bash
   # Si tienes git
   git clone <url-del-repositorio>
   cd music_on_app
   ```

2. **Instalar dependencias**
   ```bash
   flutter pub get
   ```

3. **Verificar configuración de Flutter**
   ```bash
   flutter doctor
   ```

4. **Compilar la APK**
   ```bash
   # APK para pruebas (debug)
   flutter build apk --debug
   
   # APK optimizada para distribución (release)
   flutter build apk --release
   
   # APK dividida por arquitectura (recomendado para Play Store)
   flutter build apk --split-per-abi
   ```

5. **Encontrar la APK**
   
   Las APK compiladas se encuentran en:
   ```
   build/app/outputs/flutter-apk/
   ```
   
   - `app-debug.apk` - Para pruebas
   - `app-release.apk` - Para distribución
   - `app-armeabi-v7a-release.apk` - Para dispositivos ARM 32-bit
   - `app-arm64-v8a-release.apk` - Para dispositivos ARM 64-bit
   - `app-x86_64-release.apk` - Para dispositivos x86

### Instalación en el dispositivo

1. **Habilitar fuentes desconocidas** en tu dispositivo Android
2. **Transferir la APK** al dispositivo
3. **Instalar** tocando el archivo APK

## 🎵 Configuración del Servidor

Para usar tu propio servidor de música:

1. Edita el archivo `lib/providers/music_provider.dart`
2. Cambia las URLs de ejemplo por las de tu servidor:
   ```dart
   audioUrl: 'https://tu-servidor.com/musica/cancion.mp3',
   coverUrl: 'https://tu-servidor.com/imagenes/album.jpg',
   ```

## 📱 Funcionalidades Implementadas

### ✅ Completadas
- [x] Interfaz principal con navegación tipo Spotify
- [x] Reproductor de música con controles básicos
- [x] Mini reproductor persistente
- [x] Pantalla de búsqueda con filtros
- [x] Biblioteca de música organizada
- [x] Sistema de favoritos
- [x] Reproducción desde URLs de audio
- [x] Tema oscuro completo
- [x] Gestión de estado con Provider

### 🚧 En desarrollo
- [ ] Conexión real con servidor de música
- [ ] Autenticación de usuarios
- [ ] Creación y edición de playlists
- [ ] Descarga de música offline
- [ ] Ecualizador
- [ ] Compartir canciones
- [ ] Historial de reproducción

## 🛠️ Tecnologías Utilizadas

- **Flutter** - Framework de desarrollo
- **Provider** - Gestión de estado
- **AudioPlayers** - Reproducción de audio
- **HTTP/Dio** - Peticiones de red
- **Google Fonts** - Tipografías personalizadas

## 📋 Estructura del Proyecto

```
lib/
├── main.dart                 # Punto de entrada
├── models/                   # Modelos de datos
│   ├── song.dart
│   └── playlist.dart
├── providers/                # Gestión de estado
│   ├── music_provider.dart
│   └── player_provider.dart
├── screens/                  # Pantallas principales
│   ├── home_screen.dart
│   ├── music_home_screen.dart
│   ├── search_screen.dart
│   └── library_screen.dart
└── widgets/                  # Widgets reutilizables
    ├── mini_player.dart
    ├── song_list_tile.dart
    ├── playlist_card.dart
    └── full_player_screen.dart
```

## 🎨 Personalización

### Cambiar colores del tema
Edita `lib/main.dart` en la sección `ThemeData`:
```dart
colorScheme: ColorScheme.dark(
  primary: const Color(0xFF1DB954), // Verde Spotify
  // Cambia por tus colores preferidos
),
```

### Agregar más géneros musicales
Edita `lib/screens/search_screen.dart` en el array `genres`.

## 📞 Soporte

Si tienes problemas compilando:

1. Verifica que Flutter esté actualizado: `flutter upgrade`
2. Limpia el proyecto: `flutter clean && flutter pub get`
3. Revisa la documentación oficial de [Flutter](https://flutter.dev)

## 📄 Licencia

Este proyecto es solo para fines educativos y demostración.

---

**¡Disfruta tu nueva aplicación de música! 🎵** 