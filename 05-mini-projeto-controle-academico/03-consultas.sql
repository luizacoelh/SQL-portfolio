-- Consulta 1 — Listar alunos com seus cursos (INNER JOIN) 
SELECT 
    alunos.nome_aluno,
    alunos.email,
    cursos.nome_curso,
    cursos.modalidade
FROM alunos
INNER JOIN cursos 
    ON alunos.id_curso = cursos.id_curso
ORDER BY cursos.nome_curso, alunos.nome_aluno;


-- Consulta 2 — Quantidade de alunos por curso(LEFT JOIN, COUNT, GROUP BY, ORDER BY)
SELECT 
    cursos.nome_curso,
    COUNT(alunos.id_aluno) AS quantidade_alunos
FROM cursos
LEFT JOIN alunos 
    ON cursos.id_curso = alunos.id_curso
GROUP BY cursos.nome_curso
ORDER BY quantidade_alunos DESC;


--Consulta 3 — Alunos matriculados por disciplina
SELECT 
    disciplinas.nome_disciplina,
    alunos.nome_aluno,
    matriculas.semestre
FROM matriculas
INNER JOIN alunos 
    ON matriculas.id_aluno = alunos.id_aluno
INNER JOIN disciplinas 
    ON matriculas.id_disciplina = disciplinas.id_disciplina
ORDER BY disciplinas.nome_disciplina, alunos.nome_aluno;


-- Consulta 4 — Disciplinas com mais matrículas
SELECT 
    disciplinas.nome_disciplina,
    COUNT(matriculas.id_matricula) AS total_matriculas
FROM disciplinas
INNER JOIN matriculas 
    ON disciplinas.id_disciplina = matriculas.id_disciplina
GROUP BY disciplinas.nome_disciplina
ORDER BY total_matriculas DESC;


--Consulta 5 — Média final de cada aluno(AVG, ROUND, GROUP BY, JOIN)
SELECT 
    alunos.nome_aluno,
    ROUND(AVG(notas.nota_final), 2) AS media_geral
FROM alunos
INNER JOIN matriculas 
    ON alunos.id_aluno = matriculas.id_aluno
INNER JOIN notas 
    ON matriculas.id_matricula = notas.id_matricula
GROUP BY alunos.nome_aluno
ORDER BY media_geral DESC;


--Consulta 6 — Situação de aprovação por disciplina(CASE)
SELECT 
    alunos.nome_aluno,
    cursos.nome_curso,
    ROUND(AVG(notas.nota_final), 2) AS media_geral
FROM alunos
INNER JOIN cursos 
    ON alunos.id_curso = cursos.id_curso
INNER JOIN matriculas 
    ON alunos.id_aluno = matriculas.id_aluno
INNER JOIN notas 
    ON matriculas.id_matricula = notas.id_matricula
GROUP BY alunos.nome_aluno, cursos.nome_curso
ORDER BY media_geral DESC;


-- Consulta 7 — Ranking dos alunos por média geral
SELECT 
    alunos.nome_aluno,
    cursos.nome_curso,
    ROUND(AVG(notas.nota_final), 2) AS media_geral
FROM alunos
INNER JOIN cursos 
    ON alunos.id_curso = cursos.id_curso
INNER JOIN matriculas 
    ON alunos.id_aluno = matriculas.id_aluno
INNER JOIN notas 
    ON matriculas.id_matricula = notas.id_matricula
GROUP BY alunos.nome_aluno, cursos.nome_curso
ORDER BY media_geral DESC;