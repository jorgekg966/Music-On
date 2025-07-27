import 'package:flutter/material.dart';
import '../models/song.dart';
import '../models/playlist.dart';
import '../services/api_service.dart';

class MusicProvider extends ChangeNotifier {
  List<Song> _songs = [];
  List<Playlist> _playlists = [];
  List<Song> _recentlyPlayed = [];
  List<Song> _likedSongs = [];
  String _searchQuery = '';
  bool _isLoading = false;
  bool _isConnectedToServer = false;

  List<Song> get songs => _songs;
  List<Playlist> get playlists => _playlists;
  List<Song> get recentlyPlayed => _recentlyPlayed;
  List<Song> get likedSongs => _likedSongs;
  String get searchQuery => _searchQuery;
  bool get isLoading => _isLoading;
  bool get isConnectedToServer => _isConnectedToServer;

  // Cargar canciones desde el servidor o datos de ejemplo
  Future<void> loadSampleData() async {
    _isLoading = true;
    notifyListeners();

    try {
      // Intentar conectar con el servidor
      _isConnectedToServer = await ApiService.testConnection();
      
      if (_isConnectedToServer) {
        // Cargar desde servidor
        _songs = await ApiService.getAllSongs();
        print('Canciones cargadas desde servidor: ${_songs.length}');
      } else {
        // Cargar datos de ejemplo locales
        _loadLocalData();
        print('Usando datos de ejemplo (sin conexión al servidor)');
      }
    } catch (e) {
      print('Error cargando datos: $e');
      _loadLocalData();
    }

    _createSamplePlaylists();
    _recentlyPlayed = _songs.take(3).toList();
    
    _isLoading = false;
    notifyListeners();
  }

  // Datos de ejemplo locales
  void _loadLocalData() {
    _songs = [
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

    _playlists = [
      Playlist(
        id: '1',
        name: 'Rock Classics',
        description: 'The best rock songs of all time',
        coverUrl: 'https://via.placeholder.com/300x300/E74C3C/FFFFFF?text=Rock+Classics',
        songs: _songs.take(3).toList(),
        createdAt: DateTime.now().subtract(const Duration(days: 10)),
      ),
      Playlist(
        id: '2',
        name: 'Chill Vibes',
        description: 'Relaxing music for any time',
        coverUrl: 'https://via.placeholder.com/300x300/3498DB/FFFFFF?text=Chill+Vibes',
        songs: [_songs[3], _songs[4]],
        createdAt: DateTime.now().subtract(const Duration(days: 5)),
      ),
    ];

    _recentlyPlayed = _songs.take(3).toList();
  }

  void _createSamplePlaylists() {
    _playlists = [
      Playlist(
        id: '1',
        name: 'Rock Classics',
        description: 'The best rock songs of all time',
        coverUrl: 'https://via.placeholder.com/300x300/E74C3C/FFFFFF?text=Rock+Classics',
        songs: _songs.take(3).toList(),
        createdAt: DateTime.now().subtract(const Duration(days: 10)),
      ),
      Playlist(
        id: '2',
        name: 'Chill Vibes',
        description: 'Relaxing music for any time',
        coverUrl: 'https://via.placeholder.com/300x300/3498DB/FFFFFF?text=Chill+Vibes',
        songs: _songs.length > 3 ? [_songs[3], _songs[4]] : [],
        createdAt: DateTime.now().subtract(const Duration(days: 5)),
      ),
    ];
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  Future<List<Song>> getSearchResults() async {
    if (_searchQuery.isEmpty) return [];
    
    if (_isConnectedToServer) {
      try {
        return await ApiService.searchSongs(_searchQuery);
      } catch (e) {
        print('Error en búsqueda en servidor: $e');
      }
    }
    
    // Búsqueda local si no hay conexión
    return _songs.where((song) {
      return song.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
             song.artist.toLowerCase().contains(_searchQuery.toLowerCase()) ||
             song.album.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
  }

  void toggleLikeSong(Song song) {
    final index = _songs.indexWhere((s) => s.id == song.id);
    if (index != -1) {
      _songs[index] = _songs[index].copyWith(isLiked: !_songs[index].isLiked);
      
      if (_songs[index].isLiked) {
        if (!_likedSongs.any((s) => s.id == song.id)) {
          _likedSongs.add(_songs[index]);
        }
      } else {
        _likedSongs.removeWhere((s) => s.id == song.id);
      }
      notifyListeners();
    }
  }

  void addToRecentlyPlayed(Song song) {
    _recentlyPlayed.removeWhere((s) => s.id == song.id);
    _recentlyPlayed.insert(0, song);
    if (_recentlyPlayed.length > 20) {
      _recentlyPlayed = _recentlyPlayed.take(20).toList();
    }
    notifyListeners();
  }
} 