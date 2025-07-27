# 🎵 MUSIC ON - PASOS COMPLETOS (ULTRA SIMPLE)

## 📋 TUS DATOS REALES
- **Servidor**: https://floristeriaemmanuel.shop/
- **Base de Datos**: u730885639_musicon
- **Usuario DB**: u730885639_musicon1
- **Contraseña**: Misifu93

---

## 🚀 PASO 1: CREAR CARPETAS AUTOMÁTICAMENTE

### 1.1 Subir script automático
1. Ve al **File Manager** de Hostinger
2. Entra a la carpeta `public_html`
3. Sube el archivo `setup_folders.php`
4. Ve a: `https://floristeriaemmanuel.shop/setup_folders.php`
5. ¡Se crearán todas las carpetas automáticamente!

### 1.2 Resultado esperado:
```
✅ Carpeta creada: api
✅ Carpeta creada: api/config
✅ Carpeta creada: music
✅ Carpeta creada: music/audio
✅ Carpeta creada: music/albums
✅ Carpeta creada: music/artists
```

---

## 🗄️ PASO 2: CONFIGURAR BASE DE DATOS

### 2.1 Ir a phpMyAdmin
1. Panel Hostinger → "Bases de Datos" → "phpMyAdmin"
2. Seleccionar: `u730885639_musicon`

### 2.2 Importar SQL
1. Clic en **"Importar"**
2. **"Seleccionar archivo"** → `database_schema.sql`
3. Clic en **"Continuar"**
4. ✅ ¡Verás las tablas creadas!

---

## 📁 PASO 3: SUBIR ARCHIVOS PHP

### 3.1 Subir archivos de configuración
**File Manager de Hostinger** → `public_html/`:

| Archivo | Destino |
|---------|---------|
| `database.php` | `api/config/` |
| `songs.php` | `api/` |

### 3.2 ¡Ya está configurado!
La configuración ya incluye tus datos reales:
- ✅ Base de datos: u730885639_musicon
- ✅ Usuario: u730885639_musicon1  
- ✅ Contraseña: Misifu93

---

## 🎵 PASO 4: SUBIR MÚSICA (OPCIONAL)

### 4.1 Formatos permitidos
- **Audio**: MP3, AAC, M4A (máx 50MB)
- **Imágenes**: JPG, PNG (máx 5MB)

### 4.2 Dónde subir
| Tipo | Carpeta | Ejemplo |
|------|---------|---------|
| Canciones | `music/audio/` | `bohemian_rhapsody.mp3` |
| Álbumes | `music/albums/` | `queen_opera.jpg` |
| Artistas | `music/artists/` | `queen.jpg` |

### 4.3 Nombres de archivos
- ✅ `bohemian_rhapsody.mp3`
- ✅ `queen_opera.jpg`
- ❌ `Bohemian Rhapsody.mp3` (no espacios)

---

## 🧪 PASO 5: PROBAR QUE FUNCIONA

### 5.1 Probar API
Abre en navegador:
```
https://floristeriaemmanuel.shop/api/songs.php
```

### 5.2 Respuesta esperada:
```json
{
  "success": true,
  "data": [
    {
      "id": "1",
      "title": "Bohemian Rhapsody",
      "artist": "Queen"
    }
  ]
}
```

---

## 📱 PASO 6: COMPILAR APK

### 🥇 Opción FÁCIL - FlutterFlow

1. **Ir a**: https://flutterflow.io
2. **Crear cuenta** gratis
3. **Nuevo proyecto** → "Import from code"
4. **Comprimir en ZIP** la carpeta `lib/` completa
5. **Subir ZIP** a FlutterFlow
6. **Build** → "Download APK"
7. ✅ ¡APK lista!

### 🥈 Opción AVANZADA - GitHub Codespaces

1. **Subir todo** a GitHub (repositorio público)
2. **Abrir** en Codespaces
3. **Terminal**: `flutter pub get`
4. **Terminal**: `flutter build apk --release`
5. **Descargar** APK de `build/app/outputs/flutter-apk/`

---

## 🎯 VERIFICACIÓN FINAL

### ✅ Checklist completo:
- [ ] Carpetas creadas con `setup_folders.php`
- [ ] Base de datos importada en phpMyAdmin
- [ ] Archivos PHP subidos a `api/`
- [ ] API funcionando: `/api/songs.php`
- [ ] APK compilada con FlutterFlow/Codespaces

---

## 🆘 SI ALGO NO FUNCIONA

### ❌ Error: "API not found"
- Verifica que `songs.php` esté en `public_html/api/`

### ❌ Error: "Database connection failed"  
- Confirma que importaste `database_schema.sql`
- Verifica que la base de datos se llame `u730885639_musicon`

### ❌ Error: "CORS blocked"
- Los headers ya están configurados en `database.php`

---

## 🏁 RESULTADO FINAL

Tu app **Music On** tendrá:
- 🎵 **Reproductor completo** (play, pause, siguiente, anterior)
- 🔍 **Búsqueda en tiempo real** desde tu servidor
- 📱 **Interfaz tipo Spotify** profesional
- 🌐 **Conexión automática** a floristeriaemmanuel.shop
- 💾 **Datos de respaldo** si no hay internet

---

## 🎉 ¡LISTO!

**Total de tiempo**: 30-60 minutos
**Dificultad**: Principiante
**Resultado**: App profesional de música

### 🚀 Compilar ahora:
1. **FlutterFlow**: https://flutterflow.io (más fácil)
2. **Codespaces**: https://github.com (más control)

**¡Tu aplicación estará lista para usar! 🎵** 