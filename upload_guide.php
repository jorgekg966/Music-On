<?php
// Guía interactiva para subir archivos
// Acceder desde: https://floristeriaemmanuel.shop/upload_guide.php
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>🎵 Music On - Guía de Subida</title>
    <style>
        body { font-family: Arial, sans-serif; max-width: 1000px; margin: 0 auto; padding: 20px; background: #000; color: #fff; }
        .header { background: linear-gradient(135deg, #1DB954, #1ed760); padding: 30px; border-radius: 15px; text-align: center; margin-bottom: 30px; }
        .section { background: #111; padding: 25px; border-radius: 10px; margin-bottom: 20px; border-left: 4px solid #1DB954; }
        .step { background: #222; padding: 15px; margin: 10px 0; border-radius: 8px; }
        .success { background: #d4edda; color: #155724; padding: 15px; border-radius: 5px; margin: 10px 0; }
        .warning { background: #fff3cd; color: #856404; padding: 15px; border-radius: 5px; margin: 10px 0; }
        .error { background: #f8d7da; color: #721c24; padding: 15px; border-radius: 5px; margin: 10px 0; }
        code { background: #333; padding: 3px 8px; border-radius: 4px; font-family: monospace; }
        .file-list { background: #1a1a1a; padding: 15px; border-radius: 5px; margin: 10px 0; }
        .progress { background: #333; border-radius: 10px; overflow: hidden; margin: 10px 0; }
        .progress-bar { background: #1DB954; height: 20px; width: 0%; transition: width 0.3s; }
        table { width: 100%; border-collapse: collapse; margin: 15px 0; }
        th, td { padding: 12px; text-align: left; border-bottom: 1px solid #333; }
        th { background: #1DB954; color: white; }
        .btn { background: #1DB954; color: white; padding: 10px 20px; border: none; border-radius: 5px; cursor: pointer; text-decoration: none; display: inline-block; margin: 5px; }
        .btn:hover { background: #1ed760; }
    </style>
</head>
<body>

<div class="header">
    <h1>🎵 Music On - Guía de Configuración</h1>
    <p>Configuración paso a paso para tu servidor en Hostinger</p>
</div>

<div class="section">
    <h2>📋 Estado de tu configuración</h2>
    
    <?php
    // Verificar estado de carpetas y archivos
    $folders_check = [
        'api' => is_dir('api'),
        'api/config' => is_dir('api/config'),
        'music' => is_dir('music'),
        'music/audio' => is_dir('music/audio'),
        'music/albums' => is_dir('music/albums'),
        'music/artists' => is_dir('music/artists')
    ];
    
    $files_check = [
        'api/config/database.php' => file_exists('api/config/database.php'),
        'api/songs.php' => file_exists('api/songs.php')
    ];
    ?>
    
    <h3>📁 Estado de Carpetas:</h3>
    <table>
        <tr><th>Carpeta</th><th>Estado</th></tr>
        <?php foreach ($folders_check as $folder => $exists): ?>
        <tr>
            <td><code><?php echo $folder; ?></code></td>
            <td><?php echo $exists ? '✅ Existe' : '❌ No existe'; ?></td>
        </tr>
        <?php endforeach; ?>
    </table>
    
    <h3>📄 Estado de Archivos PHP:</h3>
    <table>
        <tr><th>Archivo</th><th>Estado</th></tr>
        <?php foreach ($files_check as $file => $exists): ?>
        <tr>
            <td><code><?php echo $file; ?></code></td>
            <td><?php echo $exists ? '✅ Existe' : '❌ No existe'; ?></td>
        </tr>
        <?php endforeach; ?>
    </table>
</div>

<div class="section">
    <h2>🚀 Paso 1: Crear Carpetas Automáticamente</h2>
    
    <?php if (!is_dir('api')): ?>
    <div class="warning">
        <strong>⚠️ Las carpetas no están creadas aún.</strong><br>
        Ejecuta el script de configuración automática.
    </div>
    <a href="setup_folders.php" class="btn">🔧 Crear Carpetas Automáticamente</a>
    <?php else: ?>
    <div class="success">
        <strong>✅ Las carpetas ya están creadas.</strong><br>
        Puedes continuar al siguiente paso.
    </div>
    <?php endif; ?>
</div>

<div class="section">
    <h2>📁 Paso 2: Estructura Final de Archivos</h2>
    <p>Esta es la estructura que necesitas en tu servidor:</p>
    
    <div class="file-list">
        <pre>
public_html/
├── 📁 api/
│   ├── 📁 config/
│   │   └── 📄 database.php
│   ├── 📄 songs.php
│   └── 📄 playlists.php
├── 📁 music/
│   ├── 📁 audio/
│   │   ├── 🎵 bohemian_rhapsody.mp3
│   │   ├── 🎵 hotel_california.mp3
│   │   └── 🎵 ... (tus archivos MP3)
│   ├── 📁 albums/
│   │   ├── 🖼️ queen_opera.jpg
│   │   ├── 🖼️ eagles_hotel.jpg
│   │   └── 🖼️ ... (imágenes de álbumes)
│   └── 📁 artists/
│       ├── 🖼️ queen.jpg
│       ├── 🖼️ eagles.jpg
│       └── 🖼️ ... (fotos de artistas)
├── 📄 setup_folders.php (borrar después de usar)
└── 📄 upload_guide.php (este archivo)
        </pre>
    </div>
</div>

<div class="section">
    <h2>🗄️ Paso 3: Configurar Base de Datos</h2>
    
    <div class="step">
        <h3>3.1 - Acceder a phpMyAdmin</h3>
        <p>1. Ve a tu panel de Hostinger</p>
        <p>2. Busca "Bases de Datos" → "phpMyAdmin"</p>
        <p>3. Selecciona tu base de datos: <code>u730885639_musicon</code></p>
    </div>
    
    <div class="step">
        <h3>3.2 - Importar Esquema SQL</h3>
        <p>1. Clic en "Importar" en phpMyAdmin</p>
        <p>2. Seleccionar archivo: <code>database_schema.sql</code></p>
        <p>3. Clic en "Continuar"</p>
        
        <div class="success">
            <strong>✅ Tu base de datos está configurada:</strong><br>
            • Nombre: u730885639_musicon<br>
            • Usuario: u730885639_musicon1<br>
            • Contraseña: Misifu93
        </div>
    </div>
</div>

<div class="section">
    <h2>📤 Paso 4: Subir Archivos PHP</h2>
    
    <div class="step">
        <h3>4.1 - Archivos PHP Necesarios</h3>
        <table>
            <tr><th>Archivo</th><th>Destino en Servidor</th><th>Estado</th></tr>
            <tr>
                <td><code>database.php</code></td>
                <td><code>public_html/api/config/</code></td>
                <td><?php echo file_exists('api/config/database.php') ? '✅' : '❌'; ?></td>
            </tr>
            <tr>
                <td><code>songs.php</code></td>
                <td><code>public_html/api/</code></td>
                <td><?php echo file_exists('api/songs.php') ? '✅' : '❌'; ?></td>
            </tr>
        </table>
    </div>
    
    <div class="step">
        <h3>4.2 - Cómo Subir</h3>
        <p><strong>Opción A - File Manager de Hostinger:</strong></p>
        <ol>
            <li>Panel Hostinger → "Administrador de Archivos"</li>
            <li>Navegar a <code>public_html/</code></li>
            <li>Subir archivos arrastrando y soltando</li>
        </ol>
        
        <p><strong>Opción B - FTP:</strong></p>
        <ol>
            <li>Usar FileZilla o similar</li>
            <li>Conectar con credenciales FTP de Hostinger</li>
            <li>Subir a <code>/public_html/</code></li>
        </ol>
    </div>
</div>

<div class="section">
    <h2>🎵 Paso 5: Subir Archivos de Música</h2>
    
    <div class="step">
        <h3>5.1 - Formatos Recomendados</h3>
        <table>
            <tr><th>Tipo</th><th>Formatos</th><th>Tamaño Máximo</th><th>Destino</th></tr>
            <tr><td>Audio</td><td>MP3, AAC, M4A</td><td>50 MB</td><td><code>music/audio/</code></td></tr>
            <tr><td>Álbumes</td><td>JPG, PNG</td><td>5 MB</td><td><code>music/albums/</code></td></tr>
            <tr><td>Artistas</td><td>JPG, PNG</td><td>5 MB</td><td><code>music/artists/</code></td></tr>
        </table>
    </div>
    
    <div class="step">
        <h3>5.2 - Nomenclatura de Archivos</h3>
        <div class="warning">
            <strong>⚠️ Importante:</strong> Usa nombres sin espacios ni caracteres especiales
        </div>
        
        <p><strong>✅ Correcto:</strong></p>
        <ul>
            <li><code>bohemian_rhapsody.mp3</code></li>
            <li><code>queen_opera.jpg</code></li>
            <li><code>led_zeppelin.jpg</code></li>
        </ul>
        
        <p><strong>❌ Incorrecto:</strong></p>
        <ul>
            <li><code>Bohemian Rhapsody.mp3</code> (espacios)</li>
            <li><code>queen's_album.jpg</code> (apostrofe)</li>
            <li><code>música_rápida.mp3</code> (acentos)</li>
        </ul>
    </div>
</div>

<div class="section">
    <h2>🧪 Paso 6: Probar la API</h2>
    
    <div class="step">
        <h3>6.1 - Verificar Endpoints</h3>
        <p>Prueba estos enlaces en tu navegador:</p>
        
        <table>
            <tr><th>Endpoint</th><th>Descripción</th><th>Probar</th></tr>
            <tr>
                <td><code>/api/songs.php</code></td>
                <td>Todas las canciones</td>
                <td><a href="api/songs.php" target="_blank" class="btn">🔗 Probar</a></td>
            </tr>
            <tr>
                <td><code>/api/songs.php?search=queen</code></td>
                <td>Buscar canciones</td>
                <td><a href="api/songs.php?search=queen" target="_blank" class="btn">🔗 Probar</a></td>
            </tr>
        </table>
    </div>
    
    <div class="step">
        <h3>6.2 - Respuesta Esperada</h3>
        <p>Debes ver algo como esto:</p>
        <div class="file-list">
            <pre>{
  "success": true,
  "data": [
    {
      "id": "1",
      "title": "Bohemian Rhapsody",
      "artist": "Queen",
      "coverUrl": "https://floristeriaemmanuel.shop/music/albums/queen_opera.jpg",
      "audioUrl": "https://floristeriaemmanuel.shop/music/audio/bohemian_rhapsody.mp3"
    }
  ]
}</pre>
        </div>
    </div>
</div>

<div class="section">
    <h2>📱 Paso 7: Compilar APK</h2>
    
    <div class="step">
        <h3>🥇 Opción Recomendada: FlutterFlow</h3>
        <ol>
            <li>Ve a <a href="https://flutterflow.io" target="_blank" class="btn">FlutterFlow.io</a></li>
            <li>Crea cuenta gratuita</li>
            <li>Nuevo proyecto → "Import from code"</li>
            <li>Sube carpeta <code>lib/</code> en ZIP</li>
            <li>Build → Download APK</li>
        </ol>
    </div>
    
    <div class="step">
        <h3>🥈 Alternativa: GitHub Codespaces</h3>
        <ol>
            <li>Sube proyecto a GitHub</li>
            <li>Abre en Codespaces</li>
            <li>Ejecuta: <code>flutter pub get && flutter build apk --release</code></li>
        </ol>
    </div>
</div>

<div class="section">
    <h2>🎉 ¡Felicitaciones!</h2>
    <p>Si has completado todos los pasos, tu aplicación Music On está lista:</p>
    
    <div class="success">
        <strong>✅ Tu app ya puede:</strong><br>
        • Conectarse a tu servidor Hostinger<br>
        • Reproducir música desde tu base de datos<br>
        • Buscar canciones en tiempo real<br>
        • Funcionar offline con datos de ejemplo<br>
        • Mostrar interfaz tipo Spotify
    </div>
    
    <a href="api/songs.php" class="btn">🔗 Probar API</a>
    <a href="https://flutterflow.io" target="_blank" class="btn">📱 Compilar APK</a>
</div>

<div class="section">
    <h2>🆘 Ayuda</h2>
    <p>Si tienes problemas:</p>
    <ol>
        <li>Verifica que todas las carpetas existan</li>
        <li>Confirma que los archivos PHP estén subidos</li>
        <li>Prueba los endpoints de la API</li>
        <li>Revisa los logs de error en Hostinger</li>
    </ol>
</div>

<script>
// Verificar estado cada 5 segundos
setInterval(function() {
    location.reload();
}, 30000);
</script>

</body>
</html> 