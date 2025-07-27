import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/music_provider.dart';
import '../providers/player_provider.dart';
import '../widgets/playlist_card.dart';
import '../widgets/song_list_tile.dart';

class MusicHomeScreen extends StatelessWidget {
  const MusicHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Saludo y configuración
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Buenas tardes',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Descubre nueva música',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.settings),
                  color: Colors.grey[400],
                ),
              ],
            ),
            
            const SizedBox(height: 24),
            
            // Accesos rápidos
            Consumer<MusicProvider>(
              builder: (context, musicProvider, child) {
                final recentSongs = musicProvider.recentlyPlayed.take(4).toList();
                
                return Column(
                  children: [
                    for (int i = 0; i < recentSongs.length; i += 2)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: _QuickAccessTile(song: recentSongs[i]),
                            ),
                            const SizedBox(width: 8),
                            if (i + 1 < recentSongs.length)
                              Expanded(
                                child: _QuickAccessTile(song: recentSongs[i + 1]),
                              )
                            else
                              const Expanded(child: SizedBox()),
                          ],
                        ),
                      ),
                  ],
                );
              },
            ),
            
            const SizedBox(height: 32),
            
            // Sección de playlists recomendadas
            Text(
              'Hecho para ti',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            
            const SizedBox(height: 16),
            
            Consumer<MusicProvider>(
              builder: (context, musicProvider, child) {
                return SizedBox(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: musicProvider.playlists.length,
                    itemBuilder: (context, index) {
                      final playlist = musicProvider.playlists[index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: PlaylistCard(playlist: playlist),
                      );
                    },
                  ),
                );
              },
            ),
            
            const SizedBox(height: 32),
            
            // Reproducido recientemente
            Text(
              'Reproducido recientemente',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            
            const SizedBox(height: 16),
            
            Consumer<MusicProvider>(
              builder: (context, musicProvider, child) {
                return Column(
                  children: musicProvider.recentlyPlayed.map((song) {
                    return SongListTile(
                      song: song,
                      onTap: () {
                        Provider.of<PlayerProvider>(context, listen: false)
                            .playSong(song, playlist: musicProvider.songs);
                        musicProvider.addToRecentlyPlayed(song);
                      },
                    );
                  }).toList(),
                );
              },
            ),
            
            const SizedBox(height: 100), // Espacio para el mini player
          ],
        ),
      ),
    );
  }
}

class _QuickAccessTile extends StatelessWidget {
  final dynamic song; // Puede ser Song o Playlist

  const _QuickAccessTile({required this.song});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Reproducir canción
        Provider.of<PlayerProvider>(context, listen: false)
            .playSong(song, playlist: Provider.of<MusicProvider>(context, listen: false).songs);
        Provider.of<MusicProvider>(context, listen: false).addToRecentlyPlayed(song);
      },
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: const Color(0xFF282828),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          children: [
            // Imagen del álbum
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(4),
                  bottomLeft: Radius.circular(4),
                ),
                image: DecorationImage(
                  image: NetworkImage(song.coverUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            
            // Información de la canción
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(
                  song.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            
            // Botón de reproducir
            Consumer<PlayerProvider>(
              builder: (context, playerProvider, child) {
                final isCurrentSong = playerProvider.currentSong?.id == song.id;
                final isPlaying = isCurrentSong && playerProvider.isPlaying;
                
                return IconButton(
                  onPressed: () {
                    if (isCurrentSong) {
                      playerProvider.pauseResume();
                    } else {
                      playerProvider.playSong(song, 
                          playlist: Provider.of<MusicProvider>(context, listen: false).songs);
                      Provider.of<MusicProvider>(context, listen: false).addToRecentlyPlayed(song);
                    }
                  },
                  icon: Icon(
                    isPlaying ? Icons.pause : Icons.play_arrow,
                    color: Colors.white,
                    size: 20,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
} 