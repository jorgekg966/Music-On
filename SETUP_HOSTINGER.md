# 🚀 Guía Completa: Configurar Music On en Hostinger

## 📋 Resumen
Esta guía te ayudará a configurar tu aplicación de música **Music On** en tu servidor Hostinger ([https://floristeriaemmanuel.shop/](https://floristeriaemmanuel.shop/)).

## 🗄️ **Paso 1: Configurar Base de Datos**

### 1.1 Crear Base de Datos en Hostinger
1. Ve al **Panel de Control de Hostinger**
2. Busca "**Bases de Datos MySQL**"
3. Crea una nueva base de datos:
   - **Nombre**: `u123456789_music_on` (reemplaza con tu usuario)
   - **Usuario**: `u123456789_musicuser`
   - **Contraseña**: Elige una segura

### 1.2 Ejecutar Script SQL
Copia y pega el contenido del archivo `database_schema.sql` en **phpMyAdmin**:

```sql
-- El script completo está en database_schema.sql
-- Incluye todas las tablas necesarias y datos de ejemplo
```

## 📁 **Paso 2: Subir Archivos PHP al Servidor**

### 2.1 Estructura de Carpetas en Hostinger
Crea esta estructura en tu **public_html**:

```
public_html/
├── api/
│   ├── config/
│   │   └── database.php
│   ├── songs.php
│   ├── playlists.php
│   └── users.php
├── music/
│   ├── audio/
│   │   ├── bohemian_rhapsody.mp3
│   │   ├── hotel_california.mp3
│   │   └── ... (tus archivos MP3)
│   ├── albums/
│   │   ├── queen_opera.jpg
│   │   ├── eagles_hotel.jpg
│   │   └── ... (imágenes de álbumes)
│   └── artists/
│       ├── queen.jpg
│       ├── eagles.jpg
│       └── ... (fotos de artistas)
```

### 2.2 Configurar database.php
Edita `api/config/database.php` con tus datos reales:

```php
private $host = "localhost";
private $db_name = "u123456789_music_on"; // TU nombre de DB
private $username = "u123456789_musicuser"; // TU usuario
private $password = "TU_PASSWORD_REAL"; // TU contraseña
```

## 🎵 **Paso 3: Subir Archivos de Música**

### 3.1 Formatos Recomendados
- **Audio**: MP3, AAC, M4A (hasta 50MB por archivo)
- **Imágenes**: JPG, PNG (hasta 5MB por imagen)
- **Resolución de carátulas**: 300x300px mínimo

### 3.2 Nomenclatura de Archivos
```
audio/
├── bohemian_rhapsody.mp3
├── hotel_california.mp3
└── stairway_heaven.mp3

albums/
├── queen_opera.jpg
├── eagles_hotel.jpg
└── lz4.jpg

artists/
├── queen.jpg
├── eagles.jpg
└── ledzeppelin.jpg
```

## 🔧 **Paso 4: Configurar URLs en la App**

### 4.1 Actualizar API Service
En `lib/services/api_service.dart`, la URL ya está configurada:
```dart
static const String baseUrl = 'https://floristeriaemmanuel.shop/api';
```

### 4.2 Verificar Conexión
Las URLs de ejemplo en la base de datos apuntan a:
```
https://floristeriaemmanuel.shop/music/audio/cancion.mp3
https://floristeriaemmanuel.shop/music/albums/album.jpg
```

## 🌐 **Paso 5: Probar la API**

### 5.1 Endpoints Disponibles
```
GET https://floristeriaemmanuel.shop/api/songs.php
GET https://floristeriaemmanuel.shop/api/songs.php?search=queen
GET https://floristeriaemmanuel.shop/api/songs.php?id=1
```

### 5.2 Respuesta Esperada
```json
{
  "success": true,
  "data": [
    {
      "id": "1",
      "title": "Bohemian Rhapsody",
      "artist": "Queen",
      "album": "A Night at the Opera",
      "coverUrl": "https://floristeriaemmanuel.shop/music/albums/queen_opera.jpg",
      "audioUrl": "https://floristeriaemmanuel.shop/music/audio/bohemian_rhapsody.mp3",
      "duration": 355,
      "genre": "Rock"
    }
  ]
}
```

## 📱 **Paso 6: Compilar APK**

### 6.1 Opciones de Compilación

#### **Opción A: FlutterFlow (Recomendado)**
1. Ve a [https://flutterflow.io](https://flutterflow.io)
2. Crea una cuenta gratuita
3. Importa el código Flutter
4. Configura y compila APK directamente

#### **Opción B: GitHub Codespaces**
1. Sube el código a GitHub
2. Abre en Codespaces
3. Ejecuta:
   ```bash
   flutter pub get
   flutter build apk --release
   ```

#### **Opción C: Replit**
1. Ve a [https://replit.com](https://replit.com)
2. Crea un nuevo proyecto Flutter
3. Pega el código y compila

### 6.2 Comandos de Compilación
```bash
# Instalar dependencias
flutter pub get

# Compilar APK de prueba
flutter build apk --debug

# Compilar APK final
flutter build apk --release

# APK optimizada por arquitectura
flutter build apk --split-per-abi
```

## 🔒 **Paso 7: Seguridad y Optimización**

### 7.1 Configurar HTTPS
Hostinger incluye SSL gratuito:
1. Ve a **SSL** en tu panel
2. Activa **Force HTTPS**
3. Verifica que todas las URLs usen `https://`

### 7.2 Optimizar Base de Datos
```sql
-- Agregar índices para mejor rendimiento
CREATE INDEX idx_songs_title ON songs(title);
CREATE INDEX idx_songs_artist_title ON songs(artist_id, title);
```

### 7.3 Configurar Cache
Agrega a `.htaccess`:
```apache
# Cache para archivos de audio
<FilesMatch "\.(mp3|m4a|aac)$">
    ExpiresActive On
    ExpiresDefault "access plus 1 month"
</FilesMatch>

# Cache para imágenes
<FilesMatch "\.(jpg|jpeg|png|gif)$">
    ExpiresActive On
    ExpiresDefault "access plus 1 week"
</FilesMatch>
```

## 🧪 **Paso 8: Pruebas**

### 8.1 Verificar API
```bash
# Probar endpoint principal
curl https://floristeriaemmanuel.shop/api/songs.php

# Probar búsqueda
curl "https://floristeriaemmanuel.shop/api/songs.php?search=queen"
```

### 8.2 Verificar Archivos de Audio
Abre en navegador:
```
https://floristeriaemmanuel.shop/music/audio/bohemian_rhapsody.mp3
```

## 📊 **Paso 9: Monitoreo**

### 9.1 Logs de Error
Revisa regularmente:
- **Error Logs** en Hostinger
- **Access Logs** para ver uso

### 9.2 Métricas Importantes
- Tiempo de respuesta de API
- Consumo de ancho de banda
- Espacio de almacenamiento usado

## 🆘 **Solución de Problemas**

### Error: "API not found"
- Verifica que los archivos PHP estén en `public_html/api/`
- Confirma permisos de archivos (644 para archivos, 755 para carpetas)

### Error: "Database connection failed"
- Revisa credenciales en `database.php`
- Confirma que la base de datos existe

### Error: "CORS blocked"
- Verifica headers en `database.php`
- Confirma configuración SSL

### Audio no reproduce
- Verifica que archivos MP3 estén accesibles vía HTTPS
- Confirma formato de audio compatible

## 📞 **Soporte**

Si necesitas ayuda:
1. Revisa logs de error en Hostinger
2. Verifica conectividad con herramientas online
3. Prueba endpoints individualmente

---

**¡Tu aplicación de música estará lista para usar! 🎵** 