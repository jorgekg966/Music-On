import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/music_provider.dart';
import '../providers/player_provider.dart';
import '../widgets/playlist_card.dart';
import '../widgets/song_list_tile.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tu Biblioteca',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.search),
                      color: Colors.grey[400],
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.more_vert),
                      color: Colors.grey[400],
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Tabs
          TabBar(
            controller: _tabController,
            indicatorColor: Theme.of(context).primaryColor,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey[400],
            tabs: const [
              Tab(text: 'Playlists'),
              Tab(text: 'Favoritas'),
              Tab(text: 'Todas'),
            ],
          ),
          
          // Tab content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildPlaylistsTab(),
                _buildFavoritesTab(),
                _buildAllSongsTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaylistsTab() {
    return Consumer<MusicProvider>(
      builder: (context, musicProvider, child) {
        if (musicProvider.playlists.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.library_music_outlined,
                  size: 64,
                  color: Colors.grey,
                ),
                SizedBox(height: 16),
                Text(
                  'No tienes playlists aún',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: musicProvider.playlists.length + 1, // +1 para "Canciones que me gustan"
          itemBuilder: (context, index) {
            if (index == 0) {
              // "Canciones que me gustan" siempre va primero
              return ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    gradient: LinearGradient(
                      colors: [
                        Colors.purple.shade700,
                        Colors.blue.shade500,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: const Icon(
                    Icons.favorite,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                title: const Text(
                  'Canciones que me gustan',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                subtitle: Consumer<MusicProvider>(
                  builder: (context, provider, child) {
                    return Text(
                      '${provider.likedSongs.length} canciones',
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 12,
                      ),
                    );
                  },
                ),
                onTap: () {
                  // Navegar a canciones favoritas
                },
              );
            }

            final playlist = musicProvider.playlists[index - 1];
            return ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  image: DecorationImage(
                    image: NetworkImage(playlist.coverUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              title: Text(
                playlist.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              subtitle: Text(
                '${playlist.songCount} canciones',
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 12,
                ),
              ),
              onTap: () {
                // Navegar a la playlist
              },
            );
          },
        );
      },
    );
  }

  Widget _buildFavoritesTab() {
    return Consumer<MusicProvider>(
      builder: (context, musicProvider, child) {
        if (musicProvider.likedSongs.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.favorite_border,
                  size: 64,
                  color: Colors.grey,
                ),
                SizedBox(height: 16),
                Text(
                  'No tienes canciones favoritas',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Toca el corazón en las canciones que te gusten',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          itemCount: musicProvider.likedSongs.length,
          itemBuilder: (context, index) {
            final song = musicProvider.likedSongs[index];
            return SongListTile(
              song: song,
              onTap: () {
                Provider.of<PlayerProvider>(context, listen: false)
                    .playSong(song, playlist: musicProvider.likedSongs);
                musicProvider.addToRecentlyPlayed(song);
              },
            );
          },
        );
      },
    );
  }

  Widget _buildAllSongsTab() {
    return Consumer<MusicProvider>(
      builder: (context, musicProvider, child) {
        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          itemCount: musicProvider.songs.length,
          itemBuilder: (context, index) {
            final song = musicProvider.songs[index];
            return SongListTile(
              song: song,
              onTap: () {
                Provider.of<PlayerProvider>(context, listen: false)
                    .playSong(song, playlist: musicProvider.songs);
                musicProvider.addToRecentlyPlayed(song);
              },
            );
          },
        );
      },
    );
  }
} 