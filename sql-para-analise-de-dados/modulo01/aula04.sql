 -- TODOS OS DADOS UTILIZADOS FORAM RETIRADOS DO DATALAKE DO PODER 360 NO BIGQUERY 
 -- DISPONÍVEL EM: https://basedosdados.org/dataset/fb38dbe8-03ce-46b4-a6b7-638ade03999c?table=b6df9e1c-cbcb-4dbd-893b-8645a51773e6

-- Como usar o ORDER BY em consultas SQL e IN,
-- BETWEEN, LIKE e NOT

SELECT *
FROM `basedosdados.br_poder360_pesquisas.microdados` 
LIMIT 10;

-- Usando ORDER BY para ordenar em ordem alfabética invertida
SELECT DISTINCT sigla_partido
FROM `basedosdados.br_poder360_pesquisas.microdados` 
WHERE ano >= 2014 AND sigla_partido != 'N/A' AND sigla_partido != 'sem partido'
ORDER BY sigla_partido DESC;

-- Outra forma de excluir resultados da consulta usando AND NOT
SELECT DISTINCT sigla_partido
FROM `basedosdados.br_poder360_pesquisas.microdados` 
WHERE ano >= 2014 AND NOT sigla_partido = 'N/A'
LIMIT 1000;

-- Consulta dentro de um intervalo usando BETEWEEN
SELECT DISTINCT sigla_partido
FROM `basedosdados.br_poder360_pesquisas.microdados` 
WHERE ano BETWEEN 2014 AND 2020
LIMIT 1000;

-- Consulta em que o ano é 2000 ou 2014 ou 2018
SELECT DISTINCT sigla_partido
FROM `basedosdados.br_poder360_pesquisas.microdados` 
WHERE ano IN (2000,2014,2018)
LIMIT 1000;

-- Possível fazer com dados que não são numéricos também 
SELECT *
FROM `basedosdados.br_poder360_pesquisas.microdados` 
WHERE instituto IN ('Datafolha', 'Ibope') AND (sigla_uf IS NOT NULL)
ORDER BY sigla_uf
LIMIT 1000;

-- Utilizando o LIKE para buscar em dados não numéricos. Exemplos: 
-- LIKE '%P' (palavra que inicia com P), 
-- LIKE '%B%'(palavra que possui a letra B) 
-- LIKE 'P__' (palavra que inicia com P e possui duas letras)
-- LIKE '__' (qualquer palavra de duas letras)
-- LIKE '_R__' (qualquer palavra que possua R naquela posição e seja de 4 letras)
-- CARACTER DE ESCAPE: quando a palavra contém '%' ou '_', usa-se O \\ no lugar do caracter (P_ -> P\\) 

SELECT DISTINCT sigla_partido
FROM `basedosdados.br_poder360_pesquisas.microdados` 
WHERE sigla_partido LIKE 'P%'
ORDER BY sigla_partido
LIMIT 1000;

-- DESAFIO: Como consultar todas as pesquisas eleitorais realizadas no ano de 2018 para o cargo de
-- presidente no estado de São Paulo ordenado por turno
SELECT *
FROM `basedosdados.br_poder360_pesquisas.microdados` 
WHERE ano = 2018 AND cargo = 'presidente' AND sigla_uf = 'SP'
ORDER BY turno
LIMIT 1000;


