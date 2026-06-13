"""
Spotify Insights — Importação dos dados
Lê o arquivo dataset.csv (Kaggle) e popula o banco spotify_insights.db

Como usar:
  1. Coloque o dataset.csv na mesma pasta deste script
  2. Execute: python importar-dados.py
"""

import csv
import sqlite3
import os

CSV_PATH = "dataset.csv"
DB_PATH  = "spotify_insights.db"

# ── Leitura do CSV ───────────────────────────────────────────
print("Lendo CSV...")
with open(CSV_PATH, encoding="utf-8") as f:
    rows = list(csv.DictReader(f))

# Remove linhas com campos críticos vazios
rows = [r for r in rows if r["artists"].strip() and r["track_name"].strip()]
print(f"Registros válidos: {len(rows)}")

# ── Mapas de IDs ────────────────────────────────────────────
genres_set  = sorted(set(r["track_genre"] for r in rows))
artists_set = sorted(set(r["artists"]     for r in rows))

genre_id  = {g: i + 1 for i, g in enumerate(genres_set)}
artist_id = {a: i + 1 for i, a in enumerate(artists_set)}

# ── Banco de dados ───────────────────────────────────────────
if os.path.exists(DB_PATH):
    os.remove(DB_PATH)

con = sqlite3.connect(DB_PATH)
cur = con.cursor()

cur.executescript("""
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
    explicit            INTEGER,
    danceability        REAL,
    energy              REAL,
    loudness            REAL,
    speechiness         REAL,
    acousticness        REAL,
    instrumentalness    REAL,
    liveness            REAL,
    valence             REAL,
    tempo               REAL,
    FOREIGN KEY (id_artist) REFERENCES artists(id_artist),
    FOREIGN KEY (id_genre)  REFERENCES genres(id_genre)
);
""")

# ── Inserção ─────────────────────────────────────────────────
print("Inserindo gêneros...")
cur.executemany(
    "INSERT INTO genres VALUES (?,?)",
    [(v, k) for k, v in genre_id.items()]
)

print("Inserindo artistas...")
cur.executemany(
    "INSERT INTO artists VALUES (?,?)",
    [(v, k) for k, v in artist_id.items()]
)

print("Inserindo faixas...")
def safe_float(v): return float(v) if v.strip() else None
def safe_int(v):   return int(v)   if v.strip() else None

track_rows = []
for i, r in enumerate(rows, 1):
    track_rows.append((
        i,
        r["track_id"],
        r["track_name"],
        r["album_name"],
        artist_id[r["artists"]],
        genre_id[r["track_genre"]],
        safe_int(r["popularity"]),
        safe_int(r["duration_ms"]),
        1 if r["explicit"] == "True" else 0,
        safe_float(r["danceability"]),
        safe_float(r["energy"]),
        safe_float(r["loudness"]),
        safe_float(r["speechiness"]),
        safe_float(r["acousticness"]),
        safe_float(r["instrumentalness"]),
        safe_float(r["liveness"]),
        safe_float(r["valence"]),
        safe_float(r["tempo"]),
    ))

cur.executemany(
    "INSERT INTO tracks VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",
    track_rows
)

con.commit()

# ── Verificação ──────────────────────────────────────────────
print("\nBanco criado com sucesso!")
print(f"  Gêneros : {cur.execute('SELECT COUNT(*) FROM genres').fetchone()[0]}")
print(f"  Artistas: {cur.execute('SELECT COUNT(*) FROM artists').fetchone()[0]}")
print(f"  Faixas  : {cur.execute('SELECT COUNT(*) FROM tracks').fetchone()[0]}")

con.close()
