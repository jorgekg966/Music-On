import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/player_provider.dart';
import '../providers/music_provider.dart';
import 'full_player_screen.dart';

class MiniPlayer extends StatelessWidget {
  const MiniPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PlayerProvider>(
      builder: (context, playerProvider, child) {
        final currentSong = playerProvider.currentSong;
        if (currentSong == null) return const SizedBox.shrink();

        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const FullPlayerScreen(),
              ),
            );
          },
          child: Container(
            height: 64,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF282828),
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                // Imagen del álbum
                Container(
                  width: 48,
                  height: 48,
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    image: DecorationImage(
                      image: NetworkImage(currentSong.coverUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                
                // Información de la canción
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          currentSong.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          currentSong.artist,
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 12,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
                
                // Botón de favorito
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
                        size: 20,
                      ),
                    );
                  },
                ),
                
                // Controles de reproducción
                IconButton(
                  onPressed: () {
                    playerProvider.pauseResume();
                  },
                  icon: Icon(
                    playerProvider.isPlaying ? Icons.pause : Icons.play_arrow,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                
                const SizedBox(width: 8),
              ],
            ),
          ),
        );
      },
    );
  }
} 