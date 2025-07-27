<?php
// Archivo de prueba simple
// Subir a: public_html/test.php
// Acceder: https://floristeriaemmanuel.shop/test.php

header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Origin: *");

echo json_encode([
    "success" => true,
    "message" => "🎵 Music On Server funcionando correctamente",
    "timestamp" => date('Y-m-d H:i:s'),
    "php_version" => phpversion(),
    "server_info" => $_SERVER['SERVER_SOFTWARE'] ?? 'Hostinger'
], JSON_UNESCAPED_UNICODE);
?> 