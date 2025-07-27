import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/music_provider.dart';
import '../providers/player_provider.dart';
import '../widgets/mini_player.dart';
import 'music_home_screen.dart';
import 'search_screen.dart';
import 'library_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  
  final List<Widget> _screens = [
    const MusicHomeScreen(),
    const SearchScreen(),
    const LibraryScreen(),
  ];

  @override
  void initState() {
    super.initState();
    // Cargar datos de ejemplo
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MusicProvider>(context, listen: false).loadSampleData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _screens[_currentIndex],
          // Mini reproductor en la parte inferior
          Consumer<PlayerProvider>(
            builder: (context, playerProvider, child) {
              if (playerProvider.currentSong != null) {
                return Positioned(
                  bottom: 60, // Altura del BottomNavigationBar
                  left: 0,
                  right: 0,
                  child: const MiniPlayer(),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: Color(0xFF282828), width: 0.5),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Inicio',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Buscar',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.library_music),
              label: 'Biblioteca',
            ),
          ],
        ),
      ),
    );
  }
} 