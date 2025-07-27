import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/song.dart';
import '../providers/music_provider.dart';
import '../providers/player_provider.dart';

class SongListTile extends StatelessWidget {
  final Song song;
  final VoidCallback? onTap;
  final bool showAlbumCover;
  final Widget? trailing;

  const SongListTile({
    super.key,
    required this.song,
    this.onTap,
    this.showAlbumCover = true,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer2<PlayerProvider, MusicProvider>(
      builder: (context, playerProvider, musicProvider, child) {
        final isCurrentSong = playerProvider.currentSong?.id == song.id;
        final isPlaying = isCurrentSong && playerProvider.isPlaying;
        
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 2),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
            leading: showAlbumCover
                ? Stack(
                    children: [
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          image: DecorationImage(
                            image: NetworkImage(song.coverUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      if (isCurrentSong)
                        Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.black54,
                          ),
                          child: Icon(
                            isPlaying ? Icons.volume_up : Icons.pause,
                            color: Theme.of(context).primaryColor,
                            size: 20,
                          ),
                        ),
                    ],
                  )
                : null,
            title: Text(
              song.title,
              style: TextStyle(
                color: isCurrentSong ? Theme.of(context).primaryColor : Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              song.artist,
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 14,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: trailing ?? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Duración
                Text(
                  _formatDuration(song.duration),
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 12,
                  ),
                ),
                const SizedBox(width: 8),
                
                // Botón de favorito
                IconButton(
                  onPressed: () {
                    musicProvider.toggleLikeSong(song);
                  },
                  icon: Icon(
                    song.isLiked ? Icons.favorite : Icons.favorite_border,
                    color: song.isLiked ? Theme.of(context).primaryColor : Colors.grey[400],
                    size: 20,
                  ),
                ),
                
                // Menú de opciones
                IconButton(
                  onPressed: () {
                    _showSongOptions(context, song);
                  },
                  icon: Icon(
                    Icons.more_vert,
                    color: Colors.grey[400],
                    size: 20,
                  ),
                ),
              ],
            ),
            onTap: onTap,
          ),
        );
      },
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${duration.inHours > 0 ? '${duration.inHours}:' : ''}$twoDigitMinutes:$twoDigitSeconds";
  }

  void _showSongOptions(BuildContext context, Song song) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF282828),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header con información de la canción
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      image: DecorationImage(
                        image: NetworkImage(song.coverUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          song.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          song.artist,
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 14,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 20),
            const Divider(color: Color(0xFF404040), height: 1),
            
            // Opciones
            ListTile(
              leading: Icon(
                song.isLiked ? Icons.favorite : Icons.favorite_border,
                color: song.isLiked ? Theme.of(context).primaryColor : Colors.grey[400],
              ),
              title: Text(
                song.isLiked ? 'Quitar de favoritas' : 'Agregar a favoritas',
                style: const TextStyle(color: Colors.white),
              ),
              onTap: () {
                Provider.of<MusicProvider>(context, listen: false).toggleLikeSong(song);
                Navigator.pop(context);
              },
            ),
            
            ListTile(
              leading: Icon(Icons.playlist_add, color: Colors.grey[400]),
              title: const Text(
                'Agregar a playlist',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pop(context);
                // TODO: Implementar agregar a playlist
              },
            ),
            
            ListTile(
              leading: Icon(Icons.share, color: Colors.grey[400]),
              title: const Text(
                'Compartir',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pop(context);
                // TODO: Implementar compartir
              },
            ),
          ],
        ),
      ),
    );
  }
} 