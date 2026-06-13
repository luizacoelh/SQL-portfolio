--INNER JOIN 
SELECT
    alunos.nome_aluno,
    cursos.nome_curso
FROM alunos
INNER JOIN cursos
ON alunos.id_curso = cursos.id_curso;

--LEFT JOIN 
SELECT
    cursos.nome_curso,
    alunos.nome_aluno
FROM cursos
LEFT JOIN alunos
ON cursos.id_curso = alunos.id_curso;

--JOIN COM 3 Tabelas 
SELECT
    alunos.nome_aluno,
    disciplinas.nome_disciplina
FROM matriculas
INNER JOIN alunos
ON matriculas.id_aluno = alunos.id_aluno
INNER JOIN disciplinas
ON matriculas.id_disciplina = disciplinas.id_disciplina;