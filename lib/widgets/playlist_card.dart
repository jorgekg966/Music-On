import 'package:flutter/material.dart';
import '../models/playlist.dart';

class PlaylistCard extends StatelessWidget {
  final Playlist playlist;
  final VoidCallback? onTap;
  final double width;

  const PlaylistCard({
    super.key,
    required this.playlist,
    this.onTap,
    this.width = 160,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen de la playlist
            Container(
              width: width,
              height: width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
                image: DecorationImage(
                  image: NetworkImage(playlist.coverUrl),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.1),
                    ],
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 8),
            
            // Nombre de la playlist
            Text(
              playlist.name,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            
            const SizedBox(height: 2),
            
            // Descripción o información adicional
            Text(
              playlist.description.isNotEmpty 
                  ? playlist.description 
                  : '${playlist.songCount} canciones',
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 12,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class PlaylistCardLarge extends StatelessWidget {
  final Playlist playlist;
  final VoidCallback? onTap;

  const PlaylistCardLarge({
    super.key,
    required this.playlist,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0xFF181818),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            // Imagen de la playlist
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
                image: DecorationImage(
                  image: NetworkImage(playlist.coverUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            
            // Información de la playlist
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      playlist.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${playlist.songCount} canciones',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // Botón de opciones
            IconButton(
              onPressed: () {
                _showPlaylistOptions(context, playlist);
              },
              icon: Icon(
                Icons.more_vert,
                color: Colors.grey[400],
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showPlaylistOptions(BuildContext context, Playlist playlist) {
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
            // Header
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
                        image: NetworkImage(playlist.coverUrl),
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
                          playlist.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          '${playlist.songCount} canciones',
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 14,
                          ),
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
              leading: Icon(Icons.play_arrow, color: Colors.grey[400]),
              title: const Text(
                'Reproducir',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pop(context);
                // TODO: Reproducir playlist
              },
            ),
            
            ListTile(
              leading: Icon(Icons.shuffle, color: Colors.grey[400]),
              title: const Text(
                'Reproducir aleatoriamente',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pop(context);
                // TODO: Reproducir aleatoriamente
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
                // TODO: Compartir playlist
              },
            ),
          ],
        ),
      ),
    );
  }
} 