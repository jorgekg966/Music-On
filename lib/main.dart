import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'providers/music_provider.dart';
import 'providers/player_provider.dart';

void main() {
  runApp(const MusicOnApp());
}

class MusicOnApp extends StatelessWidget {
  const MusicOnApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MusicProvider()),
        ChangeNotifierProvider(create: (_) => PlayerProvider()),
      ],
      child: MaterialApp(
        title: 'Music On',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.dark(
            primary: const Color(0xFF1DB954), // Spotify Green
            secondary: const Color(0xFF1DB954),
            surface: const Color(0xFF121212),
            background: const Color(0xFF000000),
            onPrimary: Colors.white,
            onSecondary: Colors.white,
            onSurface: Colors.white,
            onBackground: Colors.white,
          ),
          scaffoldBackgroundColor: const Color(0xFF000000),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.white),
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          textTheme: GoogleFonts.interTextTheme().apply(
            bodyColor: Colors.white,
            displayColor: Colors.white,
          ),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Color(0xFF181818),
            selectedItemColor: Color(0xFF1DB954),
            unselectedItemColor: Color(0xFF535353),
            type: BottomNavigationBarType.fixed,
          ),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
} 