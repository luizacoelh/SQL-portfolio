-- ============================================================
-- Spotify Insights — Criação das tabelas
-- Fonte dos dados: Kaggle - Spotify Tracks Dataset
-- ============================================================

CREATE TABLE genres (
    id_genre    INTEGER PRIMARY KEY,
    genre_name  TEXT NOT NULL UNIQUE
);

CREATE TABLE artists (
    id_artist   INTEGER PRIMARY KEY,
    artist_name TEXT NOT NULL UNIQUE
);

CREATE TABLE tracks (
    id_track            INTEGER PRIMARY KEY,
    track_id            TEXT NOT NULL,
    track_name          TEXT NOT NULL,
    album_name          TEXT,
    id_artist           INTEGER NOT NULL,
    id_genre            INTEGER NOT NULL,
    popularity          INTEGER,
    duration_ms         INTEGER,
    explicit            INTEGER,   -- 0 = não explícita, 1 = explícita
    danceability        REAL,      -- 0.0 a 1.0
    energy              REAL,      -- 0.0 a 1.0
    loudness            REAL,      -- em dB
    speechiness         REAL,
    acousticness        REAL,
    instrumentalness    REAL,
    liveness            REAL,
    valence             REAL,      -- 0.0 (triste) a 1.0 (feliz)
    tempo               REAL,      -- BPM
    FOREIGN KEY (id_artist) REFERENCES artists(id_artist),
    FOREIGN KEY (id_genre)  REFERENCES genres(id_genre)
);
