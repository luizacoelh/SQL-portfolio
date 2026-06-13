-- ============================================================
-- Spotify Insights — Consultas avançadas
-- Técnicas: HAVING, SUBQUERY, WITH (CTE)
-- ============================================================


-- ── HAVING ──────────────────────────────────────────────────

-- Consulta 1 — Gêneros com média de popularidade acima de 50
SELECT
    g.genre_name,
    ROUND(AVG(t.popularity), 2) AS popularidade_media,
    COUNT(t.id_track)           AS total_musicas
FROM genres g
INNER JOIN tracks t ON g.id_genre = t.id_genre
GROUP BY g.genre_name
HAVING AVG(t.popularity) > 50
ORDER BY popularidade_media DESC;

-- Consulta 2 — Artistas com mais de 50 músicas no dataset
SELECT
    a.artist_name,
    COUNT(t.id_track)           AS total_musicas,
    ROUND(AVG(t.popularity), 2) AS popularidade_media
FROM artists a
INNER JOIN tracks t ON a.id_artist = t.id_artist
GROUP BY a.artist_name
HAVING COUNT(t.id_track) > 50
ORDER BY total_musicas DESC;

-- Consulta 3 — Gêneros com energia média acima de 0.8 (alto impacto)
SELECT
    g.genre_name,
    ROUND(AVG(t.energy), 3)     AS energia_media,
    ROUND(AVG(t.loudness), 2)   AS loudness_media
FROM genres g
INNER JOIN tracks t ON g.id_genre = t.id_genre
GROUP BY g.genre_name
HAVING AVG(t.energy) > 0.8
ORDER BY energia_media DESC;


-- ── SUBQUERY ────────────────────────────────────────────────

-- Consulta 4 — Músicas acima da média geral de popularidade
SELECT
    t.track_name,
    a.artist_name,
    g.genre_name,
    t.popularity
FROM tracks t
INNER JOIN artists a ON t.id_artist = a.id_artist
INNER JOIN genres  g ON t.id_genre  = g.id_genre
WHERE t.popularity > (
    SELECT AVG(popularity) FROM tracks
)
ORDER BY t.popularity DESC
LIMIT 20;

-- Consulta 5 — Músicas acima da média de danceability do seu próprio gênero
-- (subquery correlacionada — cada música é comparada com a média do SEU gênero)
SELECT
    t.track_name,
    a.artist_name,
    g.genre_name,
    ROUND(t.danceability, 3) AS danceability
FROM tracks t
INNER JOIN artists a ON t.id_artist = a.id_artist
INNER JOIN genres  g ON t.id_genre  = g.id_genre
WHERE t.danceability > (
    SELECT AVG(t2.danceability)
    FROM tracks t2
    WHERE t2.id_genre = t.id_genre
)
ORDER BY g.genre_name, t.danceability DESC
LIMIT 30;

-- Consulta 6 — Gêneros cuja popularidade média supera a média global
SELECT
    g.genre_name,
    ROUND(AVG(t.popularity), 2) AS media_genero,
    ROUND((SELECT AVG(popularity) FROM tracks), 2) AS media_global
FROM genres g
INNER JOIN tracks t ON g.id_genre = t.id_genre
GROUP BY g.genre_name
HAVING AVG(t.popularity) > (SELECT AVG(popularity) FROM tracks)
ORDER BY media_genero DESC;


-- ── WITH / CTE ──────────────────────────────────────────────

-- Consulta 7 — Ranking de gêneros por popularidade média (CTE)
WITH ranking_generos AS (
    SELECT
        g.genre_name,
        ROUND(AVG(t.popularity), 2)     AS popularidade_media,
        COUNT(t.id_track)               AS total_musicas,
        ROUND(AVG(t.danceability), 3)   AS danceability_media,
        ROUND(AVG(t.energy), 3)         AS energia_media
    FROM genres g
    INNER JOIN tracks t ON g.id_genre = t.id_genre
    GROUP BY g.genre_name
)
SELECT
    ROW_NUMBER() OVER (ORDER BY popularidade_media DESC) AS ranking,
    genre_name,
    popularidade_media,
    total_musicas,
    danceability_media,
    energia_media
FROM ranking_generos
ORDER BY popularidade_media DESC
LIMIT 20;

-- Consulta 8 — Top artista por gênero (CTE + subquery)
WITH media_por_artista AS (
    SELECT
        t.id_genre,
        t.id_artist,
        ROUND(AVG(t.popularity), 2) AS popularidade_media,
        COUNT(*)                    AS total_musicas
    FROM tracks t
    GROUP BY t.id_genre, t.id_artist
    HAVING COUNT(*) >= 3
)
SELECT
    g.genre_name,
    a.artist_name,
    m.popularidade_media,
    m.total_musicas
FROM media_por_artista m
INNER JOIN genres  g ON m.id_genre  = g.id_genre
INNER JOIN artists a ON m.id_artist = a.id_artist
WHERE m.popularidade_media = (
    SELECT MAX(m2.popularidade_media)
    FROM media_por_artista m2
    WHERE m2.id_genre = m.id_genre
)
ORDER BY g.genre_name
LIMIT 30;

-- Consulta 9 — Perfil musical por gênero (CTE resumo completo)
WITH perfil_genero AS (
    SELECT
        g.genre_name,
        COUNT(*)                            AS total_musicas,
        ROUND(AVG(t.popularity), 1)         AS popularidade_media,
        ROUND(AVG(t.danceability), 3)       AS danceability_media,
        ROUND(AVG(t.energy), 3)             AS energia_media,
        ROUND(AVG(t.valence), 3)            AS valence_media,
        ROUND(AVG(t.tempo), 1)              AS bpm_medio,
        SUM(CASE WHEN t.explicit = 1 THEN 1 ELSE 0 END) AS total_explicitas
    FROM genres g
    INNER JOIN tracks t ON g.id_genre = t.id_genre
    GROUP BY g.genre_name
)
SELECT *
FROM perfil_genero
ORDER BY popularidade_media DESC
LIMIT 20;
