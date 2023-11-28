​Neste último módulo as questões solicitadas são questões utilizadas em entrevistas para analisar o conhecimento dos candidatos. Todas elas se referem a tópicos que foram abordados no curso.

Dicas: Lembre-se de não ser muito prolixo em suas respostas, evite copiar e colar as respostas pois em uma entevista você precisa ser capaz de explicar conceitos com suas próprias palavras. 

Responda as questões abaixo:


1. **O que é SQL e qual é a sua finalidade?**

SQL é uma linguagem de consulta estruturada (porque deve seguir uma sintaxe específica )que serve pra realizar consultas 
e manipular dados em bancos de dados relacionais

2. **O que é uma chave primária e qual é o seu propósito em um banco de dados?**

Chave primária é um campo ou conjunto de campos com valores exclusivos por toda a tabela. Serve para identificar
de forma única cada linha dessa tabela.

3. **Como você pode selecionar todas as colunas de uma tabela em uma consulta SQL?**

Usando o * no SELECT

4. **Explique a diferença entre as cláusulas "WHERE" e "HAVING" em uma consulta SQL.**

A cláusula WHERE é usada para fiiltrar registros de acordo com condições específicas aplicadas as colunas fora de uma agrupamento de dados
```sql
SELECT nome, idade
FROM clientes
WHERE idade > 25;
```

Já a cláusula HAVING é usada junto com o GROUP BY para filtrar resultados de agregações.
Exemplo:
```sql 
SELECT cidade, COUNT(*) as total_clientes
FROM clientes
GROUP BY cidade
HAVING total_clientes > 10;
```

5. **Como você pode combinar dados de duas ou mais tabelas em uma única consulta SQL?**

Usando JOINS, que usa a chave comum entre as tabelas pra fazer essa junção.

6. **O que é uma função de agregação em SQL? Dê exemplos de algumas funções de agregação comuns.**

São funções que operam em um conjunto de valores e retorna um único valor resumido. São elas COUNT(), MAX(), MIN(), AVG(), SUM()

Retorna a soma dos valores de uma coluna

```sql
SELECT SUM(valor) FROM tabela;
```

7. **Como você pode ordenar os resultados de uma consulta SQL em ordem crescente ou decrescente?**

ORDER BY 'atributo' ASC ou DESC;

8. **O que é uma subconsulta em SQL? Como você pode usar uma subconsulta em uma consulta maior?**

 É uma consulta incorporada dentro de outra consulta, permitindo que você realize operações mais complexas e obtenha resultados mais específicos. 
 A subconsulta é executada internamente e seu resultado é utilizado pela consulta externa.
 Pode aparecer na cláusula SELECT, FROM, WHERE, ou HAVING e normalmente é utilizada com operadores de comparação, como =, >, <, IN, NOT IN, EXISTS, entre outros.

 Exemplo de subconsulta na cláusula WHERE. Busca o salário na tabela funcionários onde ele for maior que a média da coluna salário
```sql
SELECT nome, salario
FROM funcionarios
WHERE salario > (SELECT AVG(salario) FROM funcionarios);
```

9. **Como você pode agrupar os resultados de uma consulta SQL com base em uma ou mais colunas?**

GROUP BY 'atributo', utilizada com cláusulas de agregação

10. **O que é normalização de banco de dados e por que é importante?**

A normalização de banco de dados é um processo no design de bancos de dados relacionais que visa organizar e estruturar as tabelas de maneira eficiente, reduzindo a redundância de dados e mantendo a integridade dos dados. Esse processo é importante para garantir que um banco de dados seja eficiente, livre de anomalias e fácil de manter.
