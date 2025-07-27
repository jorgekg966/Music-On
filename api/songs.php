<?php
// API para gestionar canciones
// Archivo: api/songs.php

require_once 'config/database.php';

class SongAPI {
    private $conn;
    
    public function __construct() {
        $database = new Database();
        $this->conn = $database->getConnection();
    }
    
    // Obtener todas las canciones
    public function getAllSongs() {
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
        
        try {
            $stmt = $this->conn->prepare($query);
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
            
            return [
                'success' => true,
                'data' => $formatted_songs,
                'count' => count($formatted_songs)
            ];
            
        } catch (Exception $e) {
            return [
                'success' => false,
                'message' => 'Error al obtener canciones: ' . $e->getMessage()
            ];
        }
    }
    
    // Buscar canciones
    public function searchSongs($query) {
        $searchQuery = "SELECT 
                         s.id,
                         s.title,
                         s.audio_url,
                         s.cover_url,
                         s.duration_seconds,
                         s.genre,
                         a.name as artist_name,
                         al.title as album_title
                       FROM songs s
                       LEFT JOIN artists a ON s.artist_id = a.id
                       LEFT JOIN albums al ON s.album_id = al.id
                       WHERE s.title LIKE :query 
                          OR a.name LIKE :query 
                          OR al.title LIKE :query
                          OR s.genre LIKE :query
                       ORDER BY s.title ASC";
        
        try {
            $stmt = $this->conn->prepare($searchQuery);
            $searchTerm = '%' . $query . '%';
            $stmt->bindParam(':query', $searchTerm);
            $stmt->execute();
            $songs = $stmt->fetchAll();
            
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
            
            return [
                'success' => true,
                'data' => $formatted_songs,
                'count' => count($formatted_songs)
            ];
            
        } catch (Exception $e) {
            return [
                'success' => false,
                'message' => 'Error en la búsqueda: ' . $e->getMessage()
            ];
        }
    }
    
    // Obtener canción por ID
    public function getSongById($id) {
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
                  WHERE s.id = :id";
        
        try {
            $stmt = $this->conn->prepare($query);
            $stmt->bindParam(':id', $id);
            $stmt->execute();
            $song = $stmt->fetch();
            
            if ($song) {
                $formatted_song = [
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
                
                return [
                    'success' => true,
                    'data' => $formatted_song
                ];
            } else {
                return [
                    'success' => false,
                    'message' => 'Canción no encontrada'
                ];
            }
            
        } catch (Exception $e) {
            return [
                'success' => false,
                'message' => 'Error al obtener la canción: ' . $e->getMessage()
            ];
        }
    }
}

// Procesar la request
$method = $_SERVER['REQUEST_METHOD'];
$api = new SongAPI();

try {
    switch ($method) {
        case 'GET':
            if (isset($_GET['id'])) {
                $result = $api->getSongById($_GET['id']);
            } elseif (isset($_GET['search'])) {
                $result = $api->searchSongs($_GET['search']);
            } else {
                $result = $api->getAllSongs();
            }
            break;
            
        default:
            $result = [
                'success' => false,
                'message' => 'Método no permitido'
            ];
            http_response_code(405);
            break;
    }
    
    echo json_encode($result, JSON_UNESCAPED_UNICODE);
    
} catch (Exception $e) {
    http_response_code(500);
    echo json_encode([
        'success' => false,
        'message' => 'Error del servidor: ' . $e->getMessage()
    ], JSON_UNESCAPED_UNICODE);
}
?> 