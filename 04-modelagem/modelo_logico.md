# Modelo lógico

O banco foi estruturado para representar um sistema acadêmico simples.

## Relacionamentos

- Um curso pode ter vários alunos.
- Um aluno pertence a um curso.
- Um aluno pode estar matriculado em várias disciplinas.
- Uma disciplina pode ter vários alunos matriculados.
- Cada matrícula possui um registro de notas.

## Cardinalidades

- cursos 1:N alunos
- alunos 1:N matriculas
- disciplinas 1:N matriculas
- matriculas 1:1 notas