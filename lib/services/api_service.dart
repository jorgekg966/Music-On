import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/song.dart';
import '../models/playlist.dart';

class ApiService {
  // URL base de tu servidor en Hostinger
  static const String baseUrl = 'https://floristeriaemmanuel.shop';
  
  // Headers por defecto
  static const Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
    'Accept': 'application/json',
  };

  // Obtener todas las canciones
  static Future<List<Song>> getAllSongs() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/songs.php'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        
        if (data['success'] == true && data['data'] != null) {
          List<Song> songs = [];
          
          for (var songData in data['data']) {
            songs.add(Song(
              id: songData['id'].toString(),
              title: songData['title'] ?? 'Título desconocido',
              artist: songData['artist'] ?? 'Artista desconocido',
              album: songData['album'] ?? 'Álbum desconocido',
              coverUrl: songData['coverUrl'] ?? '',
              audioUrl: songData['audioUrl'] ?? '',
              duration: Duration(seconds: songData['duration'] ?? 0),
              isLiked: songData['isLiked'] ?? false,
            ));
          }
          
          return songs;
        } else {
          throw Exception(data['message'] ?? 'Error al obtener canciones');
        }
      } else {
        throw Exception('Error del servidor: ${response.statusCode}');
      }
    } catch (e) {
      print('Error en getAllSongs: $e');
      // Retornar canciones de ejemplo si falla la conexión
      return _getFallbackSongs();
    }
  }

  // Buscar canciones
  static Future<List<Song>> searchSongs(String query) async {
    if (query.isEmpty) return [];
    
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/songs.php?search=${Uri.encodeComponent(query)}'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        
        if (data['success'] == true && data['data'] != null) {
          List<Song> songs = [];
          
          for (var songData in data['data']) {
            songs.add(Song(
              id: songData['id'].toString(),
              title: songData['title'] ?? 'Título desconocido',
              artist: songData['artist'] ?? 'Artista desconocido',
              album: songData['album'] ?? 'Álbum desconocido',
              coverUrl: songData['coverUrl'] ?? '',
              audioUrl: songData['audioUrl'] ?? '',
              duration: Duration(seconds: songData['duration'] ?? 0),
              isLiked: songData['isLiked'] ?? false,
            ));
          }
          
          return songs;
        } else {
          return [];
        }
      } else {
        throw Exception('Error del servidor: ${response.statusCode}');
      }
    } catch (e) {
      print('Error en searchSongs: $e');
      return [];
    }
  }

  // Obtener canción por ID
  static Future<Song?> getSongById(String id) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/songs.php?id=$id'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        
        if (data['success'] == true && data['data'] != null) {
          final songData = data['data'];
          return Song(
            id: songData['id'].toString(),
            title: songData['title'] ?? 'Título desconocido',
            artist: songData['artist'] ?? 'Artista desconocido',
            album: songData['album'] ?? 'Álbum desconocido',
            coverUrl: songData['coverUrl'] ?? '',
            audioUrl: songData['audioUrl'] ?? '',
            duration: Duration(seconds: songData['duration'] ?? 0),
            isLiked: songData['isLiked'] ?? false,
          );
        }
      }
      return null;
    } catch (e) {
      print('Error en getSongById: $e');
      return null;
    }
  }

  // Registrar reproducción (para estadísticas)
  static Future<bool> registerPlay(String songId) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/play_history.php'),
        headers: headers,
        body: json.encode({
          'song_id': songId,
          'timestamp': DateTime.now().toIso8601String(),
        }),
      );

      return response.statusCode == 200;
    } catch (e) {
      print('Error en registerPlay: $e');
      return false;
    }
  }

  // Canciones de respaldo si falla la conexión al servidor
  static List<Song> _getFallbackSongs() {
    return [
      Song(
        id: '1',
        title: 'Bohemian Rhapsody',
        artist: 'Queen',
        album: 'A Night at the Opera',
        coverUrl: 'https://via.placeholder.com/300x300/1DB954/FFFFFF?text=Queen',
        audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
        duration: const Duration(minutes: 5, seconds: 55),
      ),
      Song(
        id: '2',
        title: 'Hotel California',
        artist: 'Eagles',
        album: 'Hotel California',
        coverUrl: 'https://via.placeholder.com/300x300/FF6B6B/FFFFFF?text=Eagles',
        audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3',
        duration: const Duration(minutes: 6, seconds: 30),
      ),
      Song(
        id: '3',
        title: 'Stairway to Heaven',
        artist: 'Led Zeppelin',
        album: 'Led Zeppelin IV',
        coverUrl: 'https://via.placeholder.com/300x300/4ECDC4/FFFFFF?text=Led+Zeppelin',
        audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3',
        duration: const Duration(minutes: 8, seconds: 2),
      ),
      Song(
        id: '4',
        title: 'Imagine',
        artist: 'John Lennon',
        album: 'Imagine',
        coverUrl: 'https://via.placeholder.com/300x300/45B7D1/FFFFFF?text=John+Lennon',
        audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-4.mp3',
        duration: const Duration(minutes: 3, seconds: 3),
      ),
      Song(
        id: '5',
        title: 'Billie Jean',
        artist: 'Michael Jackson',
        album: 'Thriller',
        coverUrl: 'https://via.placeholder.com/300x300/9A8C98/FFFFFF?text=Michael+Jackson',
        audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-5.mp3',
        duration: const Duration(minutes: 4, seconds: 54),
      ),
    ];
  }

  // Test de conectividad
  static Future<bool> testConnection() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/songs.php'),
        headers: headers,
      ).timeout(const Duration(seconds: 10));

      return response.statusCode == 200;
    } catch (e) {
      print('Error de conectividad: $e');
      return false;
    }
  }
} 