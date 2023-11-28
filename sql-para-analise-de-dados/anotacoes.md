# SQL Para Análise De Dados 2.0 - Programação Dinâmica

## Módulo 01 

* ### Aula 02: Consultas SQL na Prática usando SELECT, DISTINCT, WHERE e LIMIT

Estrutura básica de uma consulta de recuperação:

```sql
SELECT especifíca as colunas que vão ser consultadas

FROM informa a tabela onde estão essas colunas

WHERE especifíca condições para filtrar os resultados
```

O *SELECT* é obrigatório. Já o *FROM* e o *WHERE* são opcionais.

A cláusula **DISTINCT** é utilizada para retornar apenas valores únicos em uma consulta. Ela é usada em conjunto com a instrução SELECT para eliminar duplicatas dos resultados da consulta, exibindo apenas entradas distintas.

A sintaxe básica é a seguinte:

```sql
SELECT DISTINCT coluna1, coluna2, ...
FROM nome_da_tabela
WHERE condições;
```

Já o **LIMIT** é usado para restringir o número de linhas retornadas por uma consulta. Ele é frequentemente utilizado para limitar o volume de dados recuperados, especialmente quando você está trabalhando com grandes conjuntos de resultados e só precisa de uma quantidade específica de registros. A sintaxe básica é a seguinte: 

```sql
SELECT coluna1, coluna2, ...
FROM nome_da_tabela
WHERE condições
ORDER BY coluna_ordenacao
LIMIT quantidade_de_linhas;
```
---

* ### Aula 04: Como usar ORDER BY em consultas SQL e IN, BETWEEN, LIKE e NOT

A cláusula **ORDER BY** é usada para classificar os resultados de uma consulta com base em uma ou mais colunas. Você pode ordenar em ordem ascendente (ASC) ou descendente (DESC). Exemplo:

```sql
-- Retorna nomes de clientes ordenados alfabeticamente
SELECT nome
FROM clientes
ORDER BY nome DESC;
```

A cláusula **IN** é usada para filtrar resultados que correspondem a qualquer valor em uma lista específica. Exemplo:

```sql
-- Retorna produtos cujo ID está na lista especificada
SELECT *
FROM produtos
WHERE id_produto IN (1, 3, 5);
```

A cláusula **BETWEEN** é usada para filtrar resultados dentro de um intervalo específico. Exemplo:

```sql
-- Retorna pedidos feitos entre as datas especificadas
SELECT *
FROM pedidos
WHERE data_pedido BETWEEN '2023-01-01' AND '2023-01-31';
```

A cláusula **LIKE** é usada para realizar correspondências de padrões em strings. % é usado como caractere curinga. Exemplo:

```sql
-- Retorna produtos cujo nome começa com "Camisa"
SELECT *
FROM produtos
WHERE nome_produto LIKE 'Camisa%';
```

O operador **NOT** é usado para negar uma condição. Pode ser combinado com outras cláusulas, como LIKE, IN, BETWEEN, etc. Exemplo:

```sql
-- Retorna clientes que NÃO estão em determinada cidade
SELECT *
FROM clientes
WHERE cidade NOT IN ('São Paulo', 'Rio de Janeiro');
```   
---

* ### Aula 06: Para que serve o COUNT em SQL + agregação com MAX, MIN, AVG e SUM

1. **SUM()**: calcula a soma de todos os valores em uma coluna.

```sql
-- Retorna o preço máximo dos produtos
SELECT MAX(preco)
FROM produtos;
```
<br>

2. **AVG()**: calcula a média de todos os valores em uma coluna.

```sql
-- Retorna a média dos salários dos funcionários
SELECT AVG(salario)
FROM funcionarios;
```
<br>
FFF
3. **MAX()**: retorna o valor máximo em uma coluna.

```sql
-- Retorna a soma das vendas na tabela "vendas"
SELECT SUM(valor_venda)
FROM vendas;
```
<br>

4 **MIN()**: retorna o valor mínimo em uma coluna.

```sql
-- Retorna o preço mínimo dos produtos
SELECT MIN(preco)
FROM produtos;
```
<br>

5. **COUNT()**: conta o número de registros em uma tabela.

```sql
-- Retorna o número total de clientes na tabela "clientes"
SELECT COUNT(*)
FROM clientes;
```
---

* ### Aula 08: Como usar GROUP BY, HAVING e CASE em consultas SQL na prática

A cláusula **GROUP BY** é usada para agrupar linhas que têm os mesmos valores em determinadas colunas. Geralmente, é combinada com funções de agregação, como COUNT, SUM, AVG, etc.

```sql
-- Retorna a contagem de produtos em cada categoria
SELECT categoria, COUNT(*) as total_produtos
FROM produtos
GROUP BY categoria;
```
<br>

A cláusula **HAVING** é usada em conjunto com GROUP BY para filtrar resultados de grupos. Funciona como uma cláusula WHERE, mas é aplicada após a agregação.

```sql
-- Retorna a contagem de produtos apenas para categorias com mais de 5 produtos
SELECT categoria, COUNT(*) as total_produtos
FROM produtos
GROUP BY categoria
HAVING COUNT(*) > 5;
```
<br>

A expressão **CASE WHEN THEN END** é usada para realizar operações condicionais em uma consulta. Pode ser usado em várias formas, mas comumente é utilizado para criar colunas condicionais.

```sql
-- Retorna uma coluna indicando se o produto é caro ou barato
SELECT nome_produto, preco,
    CASE
        WHEN preco > 100 THEN 'Caro'
        ELSE 'Barato'
    END as tipo_preco
FROM produtos;
```
---

### Prática em SQL:

* [Aula 02](modulo01/aula02.sql) 

* [Aula 04](modulo01/aula04.sql) 

* [Aula 06](modulo01/aula06.sql) 

* [Aula 08](modulo01/aula08.sql) 

* [Mãos à obra 01](modulo01/maos-a-obra-01.sql)  


---

## Módulo 02 

* ### Aula 01: Ordem de processamento lógico da instrução SELECT

Considerando a sintaxe padrão escrevemos as cláusulas na ordem abaixo:

```sql
SELECT

DISTINCT

FROM

ON

JOIN

WHERE

GROUP BY

HAVING

ORDER BY
```

No entanto, a ordem lógica de processamento é:

```sql
FROM

JOIN

WHERE

GROUP BY

HAVING

SELECT

DISTINCT

ORDER BY

TOP
```

Como a cláusula SELECT é a etapa 8, qualquer alias de coluna ou coluna derivada definida naquela cláusula não poderá ser referenciada por cláusulas precedentes. Porém, poderão ser referenciadas por cláusulas subsequentes, como a cláusula ORDER BY.
Obs.:Essa ordem determina quando os objetos definidos em uma etapa são disponibilizados para as cláusulas em etapas subsequentes. Vale ressaltar que essa ordem pode sofrer alguma variação em sistemas gerenciadores de bancos de dados diferentes, mas essa é uma boa lista de referência para se levar em conta quando elaboramos nossas consultas.

Tomemos como exemplo a consulta a seguir:

```sql
SELECT sigla_partido, COUNT(raca) AS nr_candidatos FROM `base de dados` 

WHERE sigla_uf = 'PE' AND raca = 'preta' AND ano = 2022

GROUP BY sigla_partido 

ORDER BY nr_candidatos DESC;
```

A ordem de processamente dessa consulta seria:

```sql
FROM `basedosdados.br_tse_eleicoes.candidatos` 

WHERE sigla_uf = 'PE' AND raca = 'preta' AND ano = 2022

GROUP BY sigla_partido

SELECT sigla_partido, COUNT(raca) AS nr_candidatos 

ORDER BY nr_candidatos DESC
```

---

* ### Aula 02: Por que os DADOS são armazenados em várias TABELAS em um de Bancos de Dados? Normalização e SQL

A normalização é um processo de design de banco de dados que visa reduzir a redundância e a dependência de dados. Ela envolve a organização de dados em estruturas lógicas para minimizar a duplicação e garantir a integridade dos dados.
O modelo relacional é baseado no conceito de tabelas (relações) que se relacionam entre si por meio de chaves. Cada tabela tem colunas que representam atributos, e as linhas contêm instâncias desses atributos. Ao dividir os dados em várias tabelas relacionadas, o modelo relacional permite uma representação mais clara e eficiente das relações entre diferentes tipos de dados. Isso facilita consultas complexas e modificações no banco de dados.

Vantagens:
* Economia de Espaço: Normalizar reduz a redundância, economizando espaço de armazenamento.
* Manutenção Facilitada: Mudanças nos dados são mais fáceis de implementar e menos propensas a erros.
* Integridade dos Dados: Evita problemas de inconsistência e mantém a integridade referencial.

---

* ### Aula 04: Usando JOIN em consultas SQL para combinar tabelas

Nesta aula você irá aprender junções em SQL, criando consultas básicas com JOIN dados de duas ou mais tabelas em uma única consulta​. Além disso, iremos solucionar o desafio da aula 4. 
Vale ressaltar que o  JOIN é uma das funcionalidades mais importantes do SQL, permitindo que você combine dados de várias tabelas para realizar análises mais complexas e obter informações mais precisas a partir dos dados armazenados no banco de dados.​para realizar análises mais complexas e obter informações mais precisas a partir dos dados armazenados no banco de dados.

---

* ### Aula 06: Diferença entre Chave Primária e Chave Estrangeira? Entendendo chaves nos bancos de dados

Uma chave primária é um campo (ou um conjunto de campos) em uma tabela que identifica exclusivamente cada registro na tabela.
Deve conter valores únicos e não nulos. Isso significa que cada linha na tabela deve ter um valor diferente na coluna que é a chave primária.
A chave primária é usada para garantir a integridade dos dados e facilitar a indexação, acelerando a recuperação de informações.
Uma chave estrangeira é um campo em uma tabela que está vinculado à chave primária de outra tabela. Ela estabelece uma relação entre as duas tabelas.
A chave estrangeira é usada para garantir a integridade referencial, o que significa que não é possível ter valores na chave estrangeira que não existam na chave primária referenciada. A tabela que contém a chave estrangeira é chamada de tabela "filha" ou "referenciadora", enquanto a tabela referenciada é chamada de tabela "pai" ou "referenciada".

---

* ### Aula 08: Diferença entre INNER JOIN e OUTER JOIN | Tipos de JOINS em SQL

1. **INNER JOIN retorna registros com correspondência em ambas as tabelas.**
    ```sql
    SELECT * 
    FROM TabelaA
    INNER JOIN TabelaB ON TabelaA.ID = TabelaB.ID;
    ```

2. **LEFT OUTER JOIN retorna todos os registros da tabela à esquerda e os correspondentes da tabela à direita.**
    ```sql
    SELECT * 
    FROM TabelaA
    INNER JOIN TabelaB ON TabelaA.ID = TabelaB.ID;
    ```

3. **RIGHT OUTER JOIN retorna todos os registros da tabela à direita e os correspondentes da tabela à esquerda.**
    ```sql
    SELECT * 
    FROM TabelaA
    RIGHT JOIN TabelaB ON TabelaA.ID = TabelaB.ID;
    ```

4. **FULL OUTER JOIN retorna todos os registros quando há uma correspondência em uma das tabelas, preenchendo com nulos quando não há correspondência.**
    ```sql
    SELECT * 
    FROM TabelaA
    FULL OUTER JOIN TabelaB ON TabelaA.ID = TabelaB.ID;
    ```

### Prática em SQL:

* [Aula 04](modulo02/aula04.sql) 

* [Aula 08](modulo02/aula08.sql) 

* [Mãos à obra 02](modulo02/maos-a-obra-02.sql) 



## Módulo 03

* ### Aula 02: Quais são os tipos de dados em SQL?

Os tipos de dados em SQL são definidos para cada coluna em uma tabela e especificam o tipo de dados que a coluna pode conter. Aqui estão algumas categorias de tipos de dados em SQL:

1. **Numéricos Exatos**: bigint, numeric, bit, smallint, decimal, smallmoney, int, tinyint, money.
2. **Numéricos Aproximados**: float, real.
3. **Data e Hora**: date, datetimeoffset, datetime2, smalldatetime, datetime, time.
4. **Strings de Caracteres**: char, varchar, text.
5. **Strings de Caracteres Unicode**: nchar, nvarchar, ntext.
6. **Strings Binárias**: binary, varbinary.


* ### Aula 03: Como filtrar os dados por data em consultas SQL
Para filtrar dados por data em consultas SQL, você pode usar a cláusula `WHERE` juntamente com operadores de comparação. Aqui estão alguns exemplos:

1. **Filtrar por uma data específica**:
   ```sql
   SELECT * FROM tabela WHERE data = 'YYYY-MM-DD';
   ```
2. **Filtrar entre duas datas**:
   ```sql
   SELECT * FROM tabela WHERE data BETWEEN 'YYYY-MM-DD' AND 'YYYY-MM-DD';
   ```
3. **Filtrar por um intervalo de datas**:
   ```sql
   SELECT MONTH(DataCadastro) AS MesCadastro, YEAR(DataCadastro) AS AnoCadastro 
   FROM tabela 
   WHERE DataCadastro BETWEEN '2013-01-01' AND '2013-01-31' 
   GROUP BY MesCadastro;
   ```
4. **Filtrar o registro mais recente**:
   ```sql
   SELECT TOP 1 vr_preco FROM tabela WHERE dt_data = (SELECT MAX(dt_data) FROM tabela);
   ```


* ### Aula 05: Manipulando STRINGS em SQL

1. **SUBSTRING**: Esta função é usada para extrair uma parte de uma string.
   ```sql
   SELECT SUBSTRING('Hello World', 1, 5) AS ExtractString;
   ```
   No exemplo acima, a função SUBSTRING extrai os primeiros 5 caracteres da string 'Hello World', começando na posição 1 (H). O resultado seria 'Hello'.

2. **REPLACE**: Esta função é usada para substituir todas as ocorrências de uma substring dentro de uma string.
   ```sql
   SELECT REPLACE('Hello World', 'World', 'SQL') AS ReplaceString;
   ```
   No exemplo acima, a função REPLACE substitui 'World' por 'SQL' na string 'Hello World'. O resultado seria 'Hello SQL'.

3. **CHARINDEX**: Esta função retorna a posição inicial da primeira ocorrência de uma substring em uma string.
   ```sql
   SELECT CHARINDEX('World', 'Hello World') AS IndexOfString;
   ```
   No exemplo acima, a função CHARINDEX retorna a posição da string 'World' na string 'Hello World'. O resultado seria 7.

4. **LTRIM** e **RTRIM**: Estas funções são usadas para remover espaços à esquerda ou à direita de uma string.
   ```sql
   SELECT LTRIM('   Hello World') AS LTrimString;
   SELECT RTRIM('Hello World   ') AS RTrimString;
   ```
   Nos exemplos acima, a função LTRIM remove espaços à esquerda da string '   Hello World', e a função RTRIM remove espaços à direita da string 'Hello World   '. O resultado seria 'Hello World' em ambos os casos.



* ### Aula 06: O que são subconsultas em Bancos de Dados? Subquerys SQL

Subconsultas, ou subquerys, em SQL referem-se a consultas embutidas dentro de outras consultas. Essas subconsultas são usadas para fornecer valores para as cláusulas WHERE, FROM, SELECT ou HAVING de uma consulta principal. Elas ajudam a realizar operações mais complexas ao permitir que os resultados de uma consulta sejam usados como entrada para outra.

Existem dois tipos principais de subconsultas:

**Subconsulta Escalar:**

Retorna um único valor e geralmente é usada em operações de comparação.

Exemplo:

```sql
SELECT nome
FROM clientes
WHERE idade > (SELECT AVG(idade) FROM clientes);
```

**Subconsulta de Tabela:**

Retorna um conjunto de resultados (uma tabela virtual) e pode ser usada em operações que normalmente aceitam tabelas.

Exemplo:
```sql
SELECT nome, idade
FROM clientes
WHERE (idade, cidade) IN (SELECT MAX(idade), cidade FROM clientes GROUP BY cidade);
```

As subconsultas podem aparecer em várias cláusulas SQL:

SELECT:

Para fornecer valores para uma coluna na consulta principal.
FROM:

Para criar uma tabela temporária usada pela consulta principal.
WHERE:

Para filtrar os resultados com base em uma condição especificada na subconsulta.
HAVING:

Similar ao WHERE, mas usado com operações de agrupamento.
Aqui está um exemplo que usa uma subconsulta em uma cláusula WHERE para encontrar funcionários que ganham mais do que a média salarial:

```sql
SELECT nome, salario
FROM funcionarios
WHERE salario > (SELECT AVG(salario) FROM funcionarios);
```
A subconsulta (SELECT AVG(salario) FROM funcionarios) fornece a média salarial, que é usada como critério para filtrar os resultados da consulta principal. Subconsultas são poderosas e flexíveis, permitindo a criação de consultas SQL mais avançadas e específicas.

### Prática em SQL:

* [Aula 03](modulo03/aula03.sql) 

* [Aula 05](modulo03/aula05.sql)

* [Aula 07](modulo03/aula07.sql)

* [Mãos à obra 03](modulo03/maos-a-obra-03.sql)


## Módulo 04 

* ### Aula 02: SQL em entrevistas de emprego | O que esperar e como se preparar?

**O que esperar das entrevistas?**

Você deve esperar dois tipos de avaliação em entrevistas: perguntas sobre os fundamentos de SQL e implementação de consultas na prática.

**Como se preparar?**

- Estudar questões frequentemente perguntadas em entrevistas, você pode utilizar sites como o [Interview Query](https://www.interviewquery.com/p/data-science-sql-interview-questions#sql-concepts-for-data-science-interviews) ou utilizar o ChatGPT para criar perguntas.

**- Sites para praticar:**

[SQLZoo](https://sqlzoo.net/wiki/SQL_Tutorial): Este site oferece exercícios práticos, desde instruções SELECT básicas até consultas mais complicadas. Cada página possui um conjunto de dados de amostra e várias perguntas, onde você pode praticar SQL.

[SQL Fiddle](http://sqlfiddle.com/), DB-Fiddle, DB-Fiddle: Siter populares para gerar rapidamente bancos de dados de amostra e escrever código SQL neles. Eles podem ser usado para prática de SQL e suportam diferentes versões de SQL.

[HackerRank](https://www.hackerrank.com/): Este site permite praticar suas habilidades em muitos linguagens diferentes, incluindo SQL. Existem muitos desafios SQL no site, cada um com um conjunto de dados de amostra, uma pergunta para responder com SQL e um ambiente para submissão das consultas.

[SQL Bolt](https://sqlbolt.com/): Este site ensina SQL e inclui vários exercícios em cada conceito.

[Oracle Live SQL](https://livesql.oracle.com/apex/f?p=590:1000): Uma ferramenta criada pela Oracle que permite escrever e executar código SQL em um banco de dados Oracle online. Também disponibliza alguns scripts úteisem uma biblioteca de códigos e vários tutoriais para te ajudar a melhorar seu SQL.

[StackExchange Data Explorer](https://data.stackexchange.com/stackoverflow/query/new): Uma seção do site que permite escrever e executar consultas contra seu banco de dados, que inclui tabelas para postagens, votos, tags e muito mais. Você pode escrever suas próprias consultas. É útil porque usa um


### Prática em SQL:

* [Mãos à obra 04](modulo04/maos-a-obra-04.md) 


