-- Inserção de dados fictícios para testes

INSERT INTO cursos (id_curso, nome_curso, modalidade) VALUES
(1, 'Engenharia de Software', 'Presencial'),
(2, 'Análise e Desenvolvimento de Sistemas', 'EAD'),
(3, 'Ciência da Computação', 'Presencial');

INSERT INTO alunos (id_aluno, nome_aluno, email, id_curso) VALUES
(1, 'Ana Souza', 'ana.souza@email.com', 1),
(2, 'Bruno Lima', 'bruno.lima@email.com', 1),
(3, 'Carla Mendes', 'carla.mendes@email.com', 2),
(4, 'Diego Rocha', 'diego.rocha@email.com', 2),
(5, 'Eduarda Alves', 'eduarda.alves@email.com', 3),
(6, 'Felipe Gomes', 'felipe.gomes@email.com', 3);

INSERT INTO disciplinas (id_disciplina, nome_disciplina, carga_horaria) VALUES
(1, 'Banco de Dados', 80),
(2, 'Programação I', 80),
(3, 'Engenharia de Software', 60),
(4, 'Redes de Computadores', 60),
(5, 'Estruturas de Dados', 80);

INSERT INTO matriculas (id_matricula, id_aluno, id_disciplina, semestre) VALUES
(1, 1, 1, '2026.1'),
(2, 1, 2, '2026.1'),
(3, 2, 1, '2026.1'),
(4, 2, 3, '2026.1'),
(5, 3, 2, '2026.1'),
(6, 3, 4, '2026.1'),
(7, 4, 1, '2026.1'),
(8, 4, 5, '2026.1'),
(9, 5, 3, '2026.1'),
(10, 5, 5, '2026.1'),
(11, 6, 4, '2026.1'),
(12, 6, 5, '2026.1');

INSERT INTO notas (id_nota, id_matricula, nota_1, nota_2, nota_final) VALUES
(1, 1, 8.0, 7.5, 7.75),
(2, 2, 9.0, 8.5, 8.75),
(3, 3, 6.0, 5.5, 5.75),
(4, 4, 7.0, 7.0, 7.00),
(5, 5, 8.5, 9.0, 8.75),
(6, 6, 5.0, 6.0, 5.50),
(7, 7, 4.0, 5.0, 4.50),
(8, 8, 7.5, 8.0, 7.75),
(9, 9, 9.5, 9.0, 9.25),
(10, 10, 6.5, 7.0, 6.75),
(11, 11, 8.0, 8.0, 8.00),
(12, 12, 5.5, 6.5, 6.00);