import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/player_provider.dart';
import '../providers/music_provider.dart';

class FullPlayerScreen extends StatelessWidget {
  const FullPlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Consumer<PlayerProvider>(
        builder: (context, playerProvider, child) {
          final currentSong = playerProvider.currentSong;
          if (currentSong == null) {
            return const Center(
              child: Text(
                'No hay canción reproduciéndose',
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xFF1DB954).withOpacity(0.3),
                  Colors.black,
                  Colors.black,
                ],
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  // Header con botón de cerrar
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              'REPRODUCIENDO DE',
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              'Tu Biblioteca',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.more_vert,
                            color: Colors.grey[400],
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Spacer(),

                  // Imagen del álbum
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                      image: DecorationImage(
                        image: NetworkImage(currentSong.coverUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  const Spacer(),

                  // Información de la canción
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    currentSong.title,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    currentSong.artist,
                                    style: TextStyle(
                                      color: Colors.grey[400],
                                      fontSize: 16,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            Consumer<MusicProvider>(
                              builder: (context, musicProvider, child) {
                                final isLiked = currentSong.isLiked;
                                return IconButton(
                                  onPressed: () {
                                    musicProvider.toggleLikeSong(currentSong);
                                  },
                                  icon: Icon(
                                    isLiked ? Icons.favorite : Icons.favorite_border,
                                    color: isLiked ? Theme.of(context).primaryColor : Colors.grey[400],
                                    size: 28,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),

                        const SizedBox(height: 32),

                        // Barra de progreso
                        Column(
                          children: [
                            SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                activeTrackColor: Colors.white,
                                inactiveTrackColor: Colors.grey[600],
                                thumbColor: Colors.white,
                                thumbShape: const RoundSliderThumbShape(
                                  enabledThumbRadius: 6,
                                ),
                                overlayShape: const RoundSliderOverlayShape(
                                  overlayRadius: 16,
                                ),
                              ),
                              child: Slider(
                                value: playerProvider.progress.clamp(0.0, 1.0),
                                onChanged: (value) {
                                  final newPosition = Duration(
                                    milliseconds: (value * playerProvider.totalDuration.inMilliseconds).round(),
                                  );
                                  playerProvider.seekTo(newPosition);
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    _formatDuration(playerProvider.currentPosition),
                                    style: TextStyle(
                                      color: Colors.grey[400],
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    _formatDuration(playerProvider.totalDuration),
                                    style: TextStyle(
                                      color: Colors.grey[400],
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),

                        // Controles de reproducción
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              onPressed: () {
                                playerProvider.toggleShuffle();
                              },
                              icon: Icon(
                                Icons.shuffle,
                                color: playerProvider.isShuffleEnabled 
                                    ? Theme.of(context).primaryColor 
                                    : Colors.grey[400],
                                size: 24,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                playerProvider.previousSong();
                              },
                              icon: Icon(
                                Icons.skip_previous,
                                color: Colors.grey[400],
                                size: 32,
                              ),
                            ),
                            Container(
                              width: 64,
                              height: 64,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(32),
                              ),
                              child: IconButton(
                                onPressed: () {
                                  playerProvider.pauseResume();
                                },
                                icon: Icon(
                                  playerProvider.isPlaying 
                                      ? Icons.pause 
                                      : Icons.play_arrow,
                                  color: Colors.black,
                                  size: 32,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                playerProvider.nextSong();
                              },
                              icon: Icon(
                                Icons.skip_next,
                                color: Colors.grey[400],
                                size: 32,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                playerProvider.toggleRepeat();
                              },
                              icon: Icon(
                                Icons.repeat,
                                color: playerProvider.isRepeatEnabled 
                                    ? Theme.of(context).primaryColor 
                                    : Colors.grey[400],
                                size: 24,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),

                        // Controles adicionales
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.devices,
                                color: Colors.grey[400],
                                size: 20,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.share,
                                color: Colors.grey[400],
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${duration.inHours > 0 ? '${duration.inHours}:' : ''}$twoDigitMinutes:$twoDigitSeconds";
  }
} 