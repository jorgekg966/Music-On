import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../models/song.dart';

enum PlayerState { stopped, playing, paused, loading }

class PlayerProvider extends ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();
  PlayerState _playerState = PlayerState.stopped;
  Song? _currentSong;
  Duration _currentPosition = Duration.zero;
  Duration _totalDuration = Duration.zero;
  List<Song> _playlist = [];
  int _currentIndex = 0;
  bool _isShuffleEnabled = false;
  bool _isRepeatEnabled = false;

  PlayerState get playerState => _playerState;
  Song? get currentSong => _currentSong;
  Duration get currentPosition => _currentPosition;
  Duration get totalDuration => _totalDuration;
  List<Song> get playlist => _playlist;
  int get currentIndex => _currentIndex;
  bool get isShuffleEnabled => _isShuffleEnabled;
  bool get isRepeatEnabled => _isRepeatEnabled;
  bool get isPlaying => _playerState == PlayerState.playing;
  bool get isPaused => _playerState == PlayerState.paused;
  
  double get progress {
    if (_totalDuration.inMilliseconds > 0) {
      return _currentPosition.inMilliseconds / _totalDuration.inMilliseconds;
    }
    return 0.0;
  }

  PlayerProvider() {
    _audioPlayer.onPlayerStateChanged.listen((state) {
      switch (state) {
        case audioplayers.PlayerState.playing:
          _playerState = PlayerState.playing;
          break;
        case audioplayers.PlayerState.paused:
          _playerState = PlayerState.paused;
          break;
        case audioplayers.PlayerState.stopped:
          _playerState = PlayerState.stopped;
          break;
        case audioplayers.PlayerState.completed:
          _onSongCompleted();
          break;
      }
      notifyListeners();
    });

    _audioPlayer.onPositionChanged.listen((position) {
      _currentPosition = position;
      notifyListeners();
    });

    _audioPlayer.onDurationChanged.listen((duration) {
      _totalDuration = duration;
      notifyListeners();
    });
  }

  Future<void> playSong(Song song, {List<Song>? playlist}) async {
    try {
      _playerState = PlayerState.loading;
      notifyListeners();

      if (playlist != null) {
        _playlist = playlist;
        _currentIndex = playlist.indexWhere((s) => s.id == song.id);
      } else {
        _playlist = [song];
        _currentIndex = 0;
      }

      _currentSong = song;
      
      // En un caso real, aquí usarías song.audioUrl
      // Por ahora usamos URLs de ejemplo
      await _audioPlayer.play(UrlSource(song.audioUrl));
      
    } catch (e) {
      _playerState = PlayerState.stopped;
      notifyListeners();
      print('Error playing song: $e');
    }
  }

  Future<void> pauseResume() async {
    if (_playerState == PlayerState.playing) {
      await _audioPlayer.pause();
    } else if (_playerState == PlayerState.paused) {
      await _audioPlayer.resume();
    }
  }

  Future<void> stop() async {
    await _audioPlayer.stop();
    _currentPosition = Duration.zero;
    _playerState = PlayerState.stopped;
    notifyListeners();
  }

  Future<void> seekTo(Duration position) async {
    await _audioPlayer.seek(position);
  }

  void _onSongCompleted() {
    if (_isRepeatEnabled) {
      playSong(_currentSong!);
    } else {
      nextSong();
    }
  }

  Future<void> nextSong() async {
    if (_playlist.isEmpty) return;

    if (_isShuffleEnabled) {
      _currentIndex = (_currentIndex + 1) % _playlist.length;
    } else {
      _currentIndex = (_currentIndex + 1) % _playlist.length;
    }

    await playSong(_playlist[_currentIndex]);
  }

  Future<void> previousSong() async {
    if (_playlist.isEmpty) return;

    if (_currentPosition.inSeconds > 3) {
      await seekTo(Duration.zero);
      return;
    }

    _currentIndex = (_currentIndex - 1 + _playlist.length) % _playlist.length;
    await playSong(_playlist[_currentIndex]);
  }

  void toggleShuffle() {
    _isShuffleEnabled = !_isShuffleEnabled;
    notifyListeners();
  }

  void toggleRepeat() {
    _isRepeatEnabled = !_isRepeatEnabled;
    notifyListeners();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
} 