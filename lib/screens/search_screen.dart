import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/music_provider.dart';
import '../providers/player_provider.dart';
import '../widgets/song_list_tile.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título
            Text(
              'Buscar',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Barra de búsqueda
            Consumer<MusicProvider>(
              builder: (context, musicProvider, child) {
                return TextField(
                  onChanged: (value) {
                    musicProvider.setSearchQuery(value);
                  },
                  decoration: InputDecoration(
                    hintText: '¿Qué quieres escuchar?',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
                    filled: true,
                    fillColor: const Color(0xFF242424),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                );
              },
            ),
            
            const SizedBox(height: 24),
            
            // Resultados de búsqueda o géneros
            Expanded(
              child: Consumer<MusicProvider>(
                builder: (context, musicProvider, child) {
                  if (musicProvider.searchQuery.isEmpty) {
                    return _buildGenreGrid();
                  } else {
                    return _buildSearchResults(musicProvider);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGenreGrid() {
    final genres = [
      {'name': 'Rock', 'color': const Color(0xFFE74C3C)},
      {'name': 'Pop', 'color': const Color(0xFF3498DB)},
      {'name': 'Jazz', 'color': const Color(0xFF9B59B6)},
      {'name': 'Clásica', 'color': const Color(0xFFF39C12)},
      {'name': 'Electrónica', 'color': const Color(0xFF1ABC9C)},
      {'name': 'Hip-Hop', 'color': const Color(0xFF95A5A6)},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Explorar géneros',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2.5,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: genres.length,
            itemBuilder: (context, index) {
              final genre = genres[index];
              return Container(
                decoration: BoxDecoration(
                  color: genre['color'] as Color,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      left: 16,
                      top: 16,
                      child: Text(
                        genre['name'] as String,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Positioned(
                      right: -10,
                      bottom: -10,
                      child: Transform.rotate(
                        angle: 0.3,
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.black26,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSearchResults(MusicProvider musicProvider) {
    final results = musicProvider.getSearchResults();
    
    if (results.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 64,
              color: Colors.grey,
            ),
            SizedBox(height: 16),
            Text(
              'No se encontraron resultados',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Resultados para "${musicProvider.searchQuery}"',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: ListView.builder(
            itemCount: results.length,
            itemBuilder: (context, index) {
              final song = results[index];
              return SongListTile(
                song: song,
                onTap: () {
                  Provider.of<PlayerProvider>(context, listen: false)
                      .playSong(song, playlist: musicProvider.songs);
                  musicProvider.addToRecentlyPlayed(song);
                },
              );
            },
          ),
        ),
      ],
    );
  }
} 