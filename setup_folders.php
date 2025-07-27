<?php
// Script para crear automáticamente todas las carpetas necesarias
// Ejecutar UNA SOLA VEZ desde: https://floristeriaemmanuel.shop/setup_folders.php

echo "<h1>🎵 Music On - Configuración Automática de Carpetas</h1>";
echo "<p>Creando estructura de carpetas...</p>";

// Lista de carpetas a crear
$folders = [
    'api',
    'api/config',
    'music',
    'music/audio',
    'music/albums', 
    'music/artists',
    'music/playlists'
];

$created = 0;
$errors = 0;

foreach ($folders as $folder) {
    if (!is_dir($folder)) {
        if (mkdir($folder, 0755, true)) {
            echo "✅ Carpeta creada: <strong>$folder</strong><br>";
            $created++;
        } else {
            echo "❌ Error creando: <strong>$folder</strong><br>";
            $errors++;
        }
    } else {
        echo "ℹ️ Ya existe: <strong>$folder</strong><br>";
    }
}

// Crear archivos .htaccess para proteger carpetas
$htaccess_content = "# Proteger archivos de configuración\n<Files \"*.php\">\nOrder allow,deny\nDeny from all\n</Files>";

file_put_contents('api/.htaccess', $htaccess_content);
echo "🔒 Protección agregada a carpeta api/<br>";

// Crear index.html para evitar listado de directorios
$index_content = '<!DOCTYPE html><html><head><title>Music On</title></head><body><h1>🎵 Music On Server</h1><p>Servidor funcionando correctamente.</p></body></html>';

$index_folders = ['music', 'music/audio', 'music/albums', 'music/artists'];
foreach ($index_folders as $folder) {
    if (is_dir($folder)) {
        file_put_contents("$folder/index.html", $index_content);
        echo "📄 Index creado en: <strong>$folder</strong><br>";
    }
}

echo "<hr>";
echo "<h2>📊 Resumen:</h2>";
echo "✅ Carpetas creadas: <strong>$created</strong><br>";
echo "❌ Errores: <strong>$errors</strong><br>";
echo "<br>";

if ($errors == 0) {
    echo "<div style='background:#d4edda;padding:15px;border-radius:5px;color:#155724;'>";
    echo "<strong>🎉 ¡Configuración completada exitosamente!</strong><br>";
    echo "Ahora puedes subir los archivos PHP y de música.";
    echo "</div>";
} else {
    echo "<div style='background:#f8d7da;padding:15px;border-radius:5px;color:#721c24;'>";
    echo "<strong>⚠️ Hubo algunos errores.</strong><br>";
    echo "Verifica permisos de tu servidor Hostinger.";
    echo "</div>";
}

echo "<br><h2>🔄 Próximos pasos:</h2>";
echo "<ol>";
echo "<li>✅ Sube los archivos PHP a la carpeta <code>api/</code></li>";
echo "<li>🗄️ Importa <code>database_schema.sql</code> en phpMyAdmin</li>";
echo "<li>🎵 Sube tus archivos MP3 a <code>music/audio/</code></li>";
echo "<li>🖼️ Sube las imágenes de álbumes a <code>music/albums/</code></li>";
echo "<li>📱 Compila tu APK usando FlutterFlow o Codespaces</li>";
echo "</ol>";

echo "<br><p><strong>⚠️ IMPORTANTE:</strong> Borra este archivo (setup_folders.php) después de usarlo por seguridad.</p>";
?>

<style>
body { font-family: Arial, sans-serif; max-width: 800px; margin: 0 auto; padding: 20px; }
h1 { color: #1DB954; }
h2 { color: #333; }
code { background: #f4f4f4; padding: 2px 5px; border-radius: 3px; }
</style> 