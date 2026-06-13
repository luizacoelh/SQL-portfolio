-- ============================================================
-- Spotify Insights — Consultas básicas
-- ============================================================

-- Consulta 1 — Top 10 músicas mais populares
SELECT
    t.track_name,
    a.artist_name,
    g.genre_name,
    t.popularity
FROM tracks t
INNER JOIN artists a ON t.id_artist = a.id_artist
INNER JOIN genres  g ON t.id_genre  = g.id_genre
ORDER BY t.popularity DESC
LIMIT 10;

-- Consulta 2 — Quantidade de músicas por gênero (top 15)
SELECT
    g.genre_name,
    COUNT(t.id_track) AS total_musicas
FROM genres g
INNER JOIN tracks t ON g.id_genre = t.id_genre
GROUP BY g.genre_name
ORDER BY total_musicas DESC
LIMIT 15;

-- Consulta 3 — Músicas explícitas vs não explícitas
SELECT
    CASE WHEN explicit = 1 THEN 'Explícita' ELSE 'Não explícita' END AS tipo,
    COUNT(*) AS total,
    ROUND(AVG(popularity), 2) AS popularidade_media
FROM tracks
GROUP BY explicit;

-- Consulta 4 — Artistas com mais músicas no dataset (top 10)
SELECT
    a.artist_name,
    COUNT(t.id_track) AS total_musicas
FROM artists a
INNER JOIN tracks t ON a.id_artist = t.id_artist
GROUP BY a.artist_name
ORDER BY total_musicas DESC
LIMIT 10;

-- Consulta 5 — Músicas mais dançantes (danceability alta, top 10)
SELECT
    t.track_name,
    a.artist_name,
    ROUND(t.danceability, 3) AS danceability,
    t.popularity
FROM tracks t
INNER JOIN artists a ON t.id_artist = a.id_artist
ORDER BY t.danceability DESC
LIMIT 10;

-- Consulta 6 — Duração média das músicas por gênero (em minutos, top 10 mais longas)
SELECT
    g.genre_name,
    ROUND(AVG(t.duration_ms) / 60000.0, 2) AS duracao_media_min
FROM genres g
INNER JOIN tracks t ON g.id_genre = t.id_genre
GROUP BY g.genre_name
ORDER BY duracao_media_min DESC
LIMIT 10;
