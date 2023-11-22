# SQL Para Análise De Dados 2.0 - Programação Dinâmica

## Módulo 01 

* ### Aula 02: Consultas SQL na Prática usando SELECT, DISTINCT, WHERE e LIMIT

Estrutura básica de uma consulta de recuperação:

```
    SELECT especifíca as colunas que vão ser consultadas

    FROM informa a tabela onde estão essas colunas

    WHERE especifíca condições para filtrar os resultados
```

O *SELECT* é obrigatório. Já o *FROM* e o *WHERE* são opcionais.

A cláusula **DISTINCT** é utilizada para retornar apenas valores únicos em uma consulta. Ela é usada em conjunto com a instrução SELECT para eliminar duplicatas dos resultados da consulta, exibindo apenas entradas distintas.

A sintaxe básica é a seguinte:

```
    SELECT DISTINCT coluna1, coluna2, ...
    FROM nome_da_tabela
    WHERE condições;
```

Já o **LIMIT** é usado para restringir o número de linhas retornadas por uma consulta. Ele é frequentemente utilizado para limitar o volume de dados recuperados, especialmente quando você está trabalhando com grandes conjuntos de resultados e só precisa de uma quantidade específica de registros. A sintaxe básica é a seguinte: 

```
    SELECT coluna1, coluna2, ...
    FROM nome_da_tabela
    WHERE condições
    ORDER BY coluna_ordenacao
    LIMIT quantidade_de_linhas;
```
---

* ### Aula 04: Como usar ORDER BY em consultas SQL e IN, BETWEEN, LIKE e NOT

A cláusula **ORDER BY** é usada para classificar os resultados de uma consulta com base em uma ou mais colunas. Você pode ordenar em ordem ascendente (ASC) ou descendente (DESC). Exemplo:

```
-- Retorna nomes de clientes ordenados alfabeticamente
    SELECT nome
    FROM clientes
    ORDER BY nome DESC;
```

A cláusula **IN** é usada para filtrar resultados que correspondem a qualquer valor em uma lista específica. Exemplo:
```
-- Retorna produtos cujo ID está na lista especificada
    SELECT *
    FROM produtos
    WHERE id_produto IN (1, 3, 5);
```
A cláusula **BETWEEN** é usada para filtrar resultados dentro de um intervalo específico. Exemplo:

```
-- Retorna pedidos feitos entre as datas especificadas
    SELECT *
    FROM pedidos
    WHERE data_pedido BETWEEN '2023-01-01' AND '2023-01-31';
```
A cláusula **LIKE** é usada para realizar correspondências de padrões em strings. % é usado como caractere curinga. Exemplo:

```
-- Retorna produtos cujo nome começa com "Camisa"
    SELECT *
    FROM produtos
    WHERE nome_produto LIKE 'Camisa%';
```
O operador **NOT** é usado para negar uma condição. Pode ser combinado com outras cláusulas, como LIKE, IN, BETWEEN, etc. Exemplo:

```
-- Retorna clientes que NÃO estão em determinada cidade
    SELECT *
    FROM clientes
    WHERE cidade NOT IN ('São Paulo', 'Rio de Janeiro');
```   
---

* ### Aula 06: Para que serve o COUNT em SQL + agregação com MAX, MIN, AVG e SUM

* **SUM()**: calcula a soma de todos os valores em uma coluna.
```
-- Retorna o preço máximo dos produtos
    SELECT MAX(preco)
    FROM produtos;
```
<br>

* **AVG()**: calcula a média de todos os valores em uma coluna.
```
-- Retorna a média dos salários dos funcionários
    SELECT AVG(salario)
    FROM funcionarios;
```
<br>

* **MAX()**: retorna o valor máximo em uma coluna.
```
-- Retorna a soma das vendas na tabela "vendas"
    SELECT SUM(valor_venda)
    FROM vendas;
```
<br>

* **MIN()**: retorna o valor mínimo em uma coluna.
```
-- Retorna o preço mínimo dos produtos
    SELECT MIN(preco)
    FROM produtos;
```
<br>

* **COUNT()**: conta o número de registros em uma tabela.
```
-- Retorna o número total de clientes na tabela "clientes"
    SELECT COUNT(*)
    FROM clientes;
```
---

* ### Aula 08: Como usar GROUP BY, HAVING e CASE em consultas SQL na prática

A cláusula **GROUP BY** é usada para agrupar linhas que têm os mesmos valores em determinadas colunas. Geralmente, é combinada com funções de agregação, como COUNT, SUM, AVG, etc.

```
-- Retorna a contagem de produtos em cada categoria
    SELECT categoria, COUNT(*) as total_produtos
    FROM produtos
    GROUP BY categoria;
```
<br>

A cláusula **HAVING** é usada em conjunto com GROUP BY para filtrar resultados de grupos. Funciona como uma cláusula WHERE, mas é aplicada após a agregação.

```
-- Retorna a contagem de produtos apenas para categorias com mais de 5 produtos
    SELECT categoria, COUNT(*) as total_produtos
    FROM produtos
    GROUP BY categoria
    HAVING COUNT(*) > 5;
```
<br>

A expressão **CASE WHEN THEN END** é usada para realizar operações condicionais em uma consulta. Pode ser usado em várias formas, mas comumente é utilizado para criar colunas condicionais.

```
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

* [Mãos à obra 01](modulo01/maos-a-obra01.sql)  


---

## Módulo 02 

* ### Aula 01: Ordem de processamento lógico da instrução SELECT

Considerando a sintaxe padrão escrevemos as cláusulas na ordem abaixo:
```
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
```
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

```
    SELECT sigla_partido, COUNT(raca) AS nr_candidatos FROM `base de dados` 

    WHERE sigla_uf = 'PE' AND raca = 'preta' AND ano = 2022

    GROUP BY sigla_partido 

    ORDER BY nr_candidatos DESC;
```

A ordem de processamente dessa consulta seria:

```
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

* INNER JOIN retorna registros com correspondência em ambas as tabelas.
```
    SELECT * 
    FROM TabelaA
    INNER JOIN TabelaB ON TabelaA.ID = TabelaB.ID;
```

* LEFT OUTER JOIN retorna todos os registros da tabela à esquerda e os correspondentes da tabela à direita.
```
    SELECT * 
    FROM TabelaA
    INNER JOIN TabelaB ON TabelaA.ID = TabelaB.ID;
```

* RIGHT OUTER JOIN retorna todos os registros da tabela à direita e os correspondentes da tabela à esquerda.
```
    SELECT * 
    FROM TabelaA
    RIGHT JOIN TabelaB ON TabelaA.ID = TabelaB.ID;
```

* FULL OUTER JOIN retorna todos os registros quando há uma correspondência em uma das tabelas, preenchendo com nulos quando não há correspondência.
```
    SELECT * 
    FROM TabelaA
    FULL OUTER JOIN TabelaB ON TabelaA.ID = TabelaB.ID;
```

### Prática em SQL:

* [Aula 04](modulo02/aula04.sql) 

* [Aula 08](modulo02/aula08.sql) 

* [Mãos à obra 02](modulo02/maos-a-obra02.sql) 








