<?php
// API simplificada para Music On
// Subir a: public_html/songs.php
// Acceder: https://floristeriaemmanuel.shop/songs.php

header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization, X-Requested-With");

// Configuración de base de datos - DATOS REALES
$host = "localhost";
$db_name = "u730885639_musicon";
$username = "u730885639_musicon1";
$password = "Misifu93";

try {
    $conn = new PDO("mysql:host=$host;dbname=$db_name;charset=utf8", $username, $password);
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    $conn->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
    
    // Consulta para obtener canciones
    $query = "SELECT 
                s.id,
                s.title,
                s.audio_url,
                s.cover_url,
                s.duration_seconds,
                s.genre,
                s.track_number,
                a.name as artist_name,
                al.title as album_title
              FROM songs s
              LEFT JOIN artists a ON s.artist_id = a.id
              LEFT JOIN albums al ON s.album_id = al.id
              ORDER BY s.created_at DESC";
    
    $stmt = $conn->prepare($query);
    $stmt->execute();
    $songs = $stmt->fetchAll();
    
    // Formatear para la app Flutter
    $formatted_songs = [];
    foreach ($songs as $song) {
        $formatted_songs[] = [
            'id' => (string)$song['id'],
            'title' => $song['title'],
            'artist' => $song['artist_name'],
            'album' => $song['album_title'] ?? 'Unknown Album',
            'coverUrl' => $song['cover_url'],
            'audioUrl' => $song['audio_url'],
            'duration' => (int)$song['duration_seconds'],
            'genre' => $song['genre'],
            'isLiked' => false
        ];
    }
    
    echo json_encode([
        'success' => true,
        'data' => $formatted_songs,
        'count' => count($formatted_songs),
        'message' => '🎵 Canciones cargadas correctamente'
    ], JSON_UNESCAPED_UNICODE);
    
} catch (Exception $e) {
    echo json_encode([
        'success' => false,
        'message' => 'Error: ' . $e->getMessage(),
        'data' => []
    ], JSON_UNESCAPED_UNICODE);
}
?> 