--COUNT 
SELECT COUNT(*) AS total_alunos
FROM alunos;

SELECT AVG(nota_final) AS media_notas
FROM notas;

--GROUP BY 
SELECT
    id_curso,
    COUNT(*) AS quantidade
FROM alunos
GROUP BY id_curso;

--HAVING 
SELECT
    id_curso,
    COUNT(*) AS quantidade
FROM alunos
GROUP BY id_curso
HAVING COUNT(*) > 1;