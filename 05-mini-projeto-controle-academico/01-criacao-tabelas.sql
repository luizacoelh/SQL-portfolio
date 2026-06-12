-- Sistema de Controle Acadêmico Simples
-- Criação das tabelas principais com proteção contra duplicidade

CREATE TABLE IF NOT EXISTS cursos (
    id_curso INTEGER PRIMARY KEY,
    nome_curso TEXT NOT NULL,
    modalidade TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS alunos (
    id_aluno INTEGER PRIMARY KEY,
    nome_aluno TEXT NOT NULL,
    email TEXT NOT NULL,
    id_curso INTEGER NOT NULL,
    FOREIGN KEY (id_curso) REFERENCES cursos(id_curso)
);

CREATE TABLE IF NOT EXISTS disciplinas (
    id_disciplina INTEGER PRIMARY KEY,
    nome_disciplina TEXT NOT NULL,
    carga_horaria INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS matriculas (
    id_matricula INTEGER PRIMARY KEY,
    id_aluno INTEGER NOT NULL,
    id_disciplina INTEGER NOT NULL,
    semestre TEXT NOT NULL,
    FOREIGN KEY (id_aluno) REFERENCES alunos(id_aluno),
    FOREIGN KEY (id_disciplina) REFERENCES disciplinas(id_disciplina)
);

CREATE TABLE IF NOT EXISTS notas (
    id_nota INTEGER PRIMARY KEY,
    id_matricula INTEGER NOT NULL,
    nota_1 REAL NOT NULL,
    nota_2 REAL NOT NULL,
    nota_final REAL NOT NULL,
    FOREIGN KEY (id_matricula) REFERENCES matriculas(id_matricula)
);