class Song {
  final String id;
  final String title;
  final String artist;
  final String album;
  final String coverUrl;
  final String audioUrl;
  final Duration duration;
  final bool isLiked;

  Song({
    required this.id,
    required this.title,
    required this.artist,
    required this.album,
    required this.coverUrl,
    required this.audioUrl,
    required this.duration,
    this.isLiked = false,
  });

  Song copyWith({
    String? id,
    String? title,
    String? artist,
    String? album,
    String? coverUrl,
    String? audioUrl,
    Duration? duration,
    bool? isLiked,
  }) {
    return Song(
      id: id ?? this.id,
      title: title ?? this.title,
      artist: artist ?? this.artist,
      album: album ?? this.album,
      coverUrl: coverUrl ?? this.coverUrl,
      audioUrl: audioUrl ?? this.audioUrl,
      duration: duration ?? this.duration,
      isLiked: isLiked ?? this.isLiked,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'artist': artist,
      'album': album,
      'coverUrl': coverUrl,
      'audioUrl': audioUrl,
      'duration': duration.inSeconds,
      'isLiked': isLiked,
    };
  }

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      id: json['id'],
      title: json['title'],
      artist: json['artist'],
      album: json['album'],
      coverUrl: json['coverUrl'],
      audioUrl: json['audioUrl'],
      duration: Duration(seconds: json['duration']),
      isLiked: json['isLiked'] ?? false,
    );
  }
} 