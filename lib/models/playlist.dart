import 'song.dart';

class Playlist {
  final String id;
  final String name;
  final String description;
  final String coverUrl;
  final List<Song> songs;
  final DateTime createdAt;

  Playlist({
    required this.id,
    required this.name,
    required this.description,
    required this.coverUrl,
    required this.songs,
    required this.createdAt,
  });

  Playlist copyWith({
    String? id,
    String? name,
    String? description,
    String? coverUrl,
    List<Song>? songs,
    DateTime? createdAt,
  }) {
    return Playlist(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      coverUrl: coverUrl ?? this.coverUrl,
      songs: songs ?? this.songs,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  int get songCount => songs.length;
  
  Duration get totalDuration {
    return songs.fold(Duration.zero, (total, song) => total + song.duration);
  }
} 