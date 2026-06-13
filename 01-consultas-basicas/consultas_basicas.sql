--SELECT 
SELECT * FROM alunos;

--WHERE
SELECT *
FROM alunos
WHERE id_curso = 1;

--ORDER BY 
SELECT *
FROM alunos
ORDER BY nome_aluno;

-- LIMIT
SELECT * FROM alunos
ORDER BY nome_aluno
LIMIT 3;

--DISTINCT 
SELECT DISTINCT modalidade
FROM cursos;

-- LIKE
SELECT * FROM alunos
WHERE nome_aluno LIKE 'A%';