# 🎵 Spotify Insights — SQL Analytics

>  **Dica para Avaliadores/Recrutadores:** Para que você não precise baixar o arquivo CSV de 114k linhas e rodar o script de importação Python, eu já deixei o banco de dados SQLite pronto para uso. Você pode baixá-lo diretamente aqui: [Baixar spotify_insights.db (21MB)](https://github.com/luizacoelh/SQL-portfolio/releases/download/v1.0.0/spotify_insights.db)
Análise de **113.999 faixas** do Spotify com SQL puro, utilizando dados reais do Kaggle.

O projeto demonstra modelagem de banco de dados relacional, normalização em múltiplas tabelas e consultas analíticas avançadas sobre um dataset real de larga escala.

---

## Estrutura do banco

O dataset original foi normalizado em 3 tabelas relacionadas:

| Tabela    | Descrição                              | Registros  |
|-----------|----------------------------------------|------------|
| `genres`  | 114 gêneros musicais únicos            | 114        |
| `artists` | Artistas únicos extraídos do dataset   | 31.437     |
| `tracks`  | Faixas com atributos de áudio          | 113.999    |

```
genres ──── tracks ──── artists
  1:N          N:1
```

---

## Arquivos

| Arquivo                    | Conteúdo                                              |
|---------------------------|-------------------------------------------------------|
| `01-criacao-tabelas.sql`  | DDL: criação das 3 tabelas com chaves estrangeiras    |
| `02-consultas-basicas.sql`| SELECT, JOIN, GROUP BY, ORDER BY, LIMIT, CASE         |
| `03-consultas-avancadas.sql` | HAVING, SUBQUERY correlacionada, WITH (CTE), ROW_NUMBER |
| `importar-dados.py`       | Script Python para popular o banco a partir do CSV    |
| `diagrama.png`            | Diagrama do modelo relacional                         |

---

## Consultas desenvolvidas

### Básicas
- Top 10 músicas mais populares do dataset
- Quantidade de músicas por gênero
- Músicas explícitas vs não explícitas (com popularidade média)
- Artistas com mais faixas no dataset
- Músicas mais dançantes (`danceability`)
- Duração média por gênero

### Avançadas

**HAVING**
- Gêneros com popularidade média acima de 50
- Artistas com mais de 50 músicas no dataset
- Gêneros com energia média acima de 0.8

**SUBQUERY**
- Músicas acima da média geral de popularidade
- Músicas acima da média de `danceability` do seu próprio gênero *(subquery correlacionada)*
- Gêneros cuja popularidade supera a média global

**WITH (CTE)**
- Ranking completo de gêneros por popularidade
- Top artista por gênero (CTE + subquery aninhada)
- Perfil musical completo por gênero (popularidade, danceability, energia, valence, BPM)

---

## Como executar

**1. Baixe o dataset**

[Spotify Tracks Dataset — Kaggle](https://www.kaggle.com/datasets/maharshipandya/-spotify-tracks-dataset)

Salve o arquivo como `dataset.csv` na pasta `06-spotify-project/`.

**2. Importe os dados**

```bash
python importar-dados.py
```

Isso gera o banco `spotify_insights.db` com as 3 tabelas populadas.

**3. Execute as consultas**

No VS Code com a extensão SQLite, abra o banco `spotify_insights.db` e rode os arquivos `.sql` na ordem.

---

## Tecnologias

![SQL](https://img.shields.io/badge/SQL-SQLite-blue?style=flat&logo=sqlite)
![Python](https://img.shields.io/badge/Python-3.x-yellow?style=flat&logo=python)
![Kaggle](https://img.shields.io/badge/dados-Kaggle-20BEFF?style=flat&logo=kaggle)

- **SQLite** — banco de dados local
- **Python** — script de importação do CSV
- **Kaggle** — fonte dos dados reais

---

## Fonte dos dados

Maharshi Pandya. *Spotify Tracks Dataset*. Kaggle, 2023.
Disponível em: https://www.kaggle.com/datasets/maharshipandya/-spotify-tracks-dataset
