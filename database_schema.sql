-- Base de datos para Music On App
-- Compatible con MySQL/MariaDB (Hostinger)

-- Tabla de usuarios
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    display_name VARCHAR(100),
    avatar_url VARCHAR(500),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Tabla de artistas
CREATE TABLE artists (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    bio TEXT,
    image_url VARCHAR(500),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabla de álbumes
CREATE TABLE albums (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    artist_id INT,
    cover_url VARCHAR(500),
    release_year INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (artist_id) REFERENCES artists(id) ON DELETE CASCADE
);

-- Tabla de canciones
CREATE TABLE songs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    artist_id INT NOT NULL,
    album_id INT,
    audio_url VARCHAR(500) NOT NULL,
    cover_url VARCHAR(500),
    duration_seconds INT DEFAULT 0,
    file_size_mb DECIMAL(10,2),
    genre VARCHAR(50),
    track_number INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (artist_id) REFERENCES artists(id) ON DELETE CASCADE,
    FOREIGN KEY (album_id) REFERENCES albums(id) ON DELETE SET NULL
);

-- Tabla de playlists
CREATE TABLE playlists (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    cover_url VARCHAR(500),
    is_public BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Tabla de canciones en playlists
CREATE TABLE playlist_songs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    playlist_id INT NOT NULL,
    song_id INT NOT NULL,
    position INT NOT NULL,
    added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (playlist_id) REFERENCES playlists(id) ON DELETE CASCADE,
    FOREIGN KEY (song_id) REFERENCES songs(id) ON DELETE CASCADE,
    UNIQUE KEY unique_playlist_song (playlist_id, song_id)
);

-- Tabla de canciones favoritas
CREATE TABLE user_favorites (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    song_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (song_id) REFERENCES songs(id) ON DELETE CASCADE,
    UNIQUE KEY unique_user_favorite (user_id, song_id)
);

-- Tabla de historial de reproducción
CREATE TABLE play_history (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    song_id INT NOT NULL,
    played_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (song_id) REFERENCES songs(id) ON DELETE CASCADE
);

-- Índices para mejorar rendimiento
CREATE INDEX idx_songs_artist ON songs(artist_id);
CREATE INDEX idx_songs_album ON songs(album_id);
CREATE INDEX idx_songs_genre ON songs(genre);
CREATE INDEX idx_playlist_songs_playlist ON playlist_songs(playlist_id);
CREATE INDEX idx_user_favorites_user ON user_favorites(user_id);
CREATE INDEX idx_play_history_user ON play_history(user_id);
CREATE INDEX idx_play_history_song ON play_history(song_id);

-- Datos de ejemplo
INSERT INTO artists (name, bio, image_url) VALUES
('Queen', 'Banda británica de rock formada en 1970', 'https://floristeriaemmanuel.shop/music/artists/queen.jpg'),
('Eagles', 'Banda estadounidense de rock fundada en 1971', 'https://floristeriaemmanuel.shop/music/artists/eagles.jpg'),
('Led Zeppelin', 'Banda británica de rock pesado de los 70', 'https://floristeriaemmanuel.shop/music/artists/ledzeppelin.jpg'),
('John Lennon', 'Músico británico, ex-miembro de The Beatles', 'https://floristeriaemmanuel.shop/music/artists/johnlennon.jpg'),
('Michael Jackson', 'Rey del Pop, artista estadounidense', 'https://floristeriaemmanuel.shop/music/artists/michaeljackson.jpg');

INSERT INTO albums (title, artist_id, cover_url, release_year) VALUES
('A Night at the Opera', 1, 'https://floristeriaemmanuel.shop/music/albums/queen_opera.jpg', 1975),
('Hotel California', 2, 'https://floristeriaemmanuel.shop/music/albums/eagles_hotel.jpg', 1976),
('Led Zeppelin IV', 3, 'https://floristeriaemmanuel.shop/music/albums/lz4.jpg', 1971),
('Imagine', 4, 'https://floristeriaemmanuel.shop/music/albums/imagine.jpg', 1971),
('Thriller', 5, 'https://floristeriaemmanuel.shop/music/albums/thriller.jpg', 1982);

INSERT INTO songs (title, artist_id, album_id, audio_url, cover_url, duration_seconds, genre, track_number) VALUES
('Bohemian Rhapsody', 1, 1, 'https://floristeriaemmanuel.shop/music/audio/bohemian_rhapsody.mp3', 'https://floristeriaemmanuel.shop/music/albums/queen_opera.jpg', 355, 'Rock', 11),
('Hotel California', 2, 2, 'https://floristeriaemmanuel.shop/music/audio/hotel_california.mp3', 'https://floristeriaemmanuel.shop/music/albums/eagles_hotel.jpg', 390, 'Rock', 1),
('Stairway to Heaven', 3, 3, 'https://floristeriaemmanuel.shop/music/audio/stairway_heaven.mp3', 'https://floristeriaemmanuel.shop/music/albums/lz4.jpg', 482, 'Rock', 4),
('Imagine', 4, 4, 'https://floristeriaemmanuel.shop/music/audio/imagine.mp3', 'https://floristeriaemmanuel.shop/music/albums/imagine.jpg', 183, 'Pop', 1),
('Billie Jean', 5, 5, 'https://floristeriaemmanuel.shop/music/audio/billie_jean.mp3', 'https://floristeriaemmanuel.shop/music/albums/thriller.jpg', 294, 'Pop', 6); 