 -- TODOS OS DADOS UTILIZADOS FORAM RETIRADOS DO DATALAKE DO PODER 360 NO BIGQUERY 
 -- DISPONÍVEL EM: https://basedosdados.org/dataset/fb38dbe8-03ce-46b4-a6b7-638ade03999c?table=b6df9e1c-cbcb-4dbd-893b-8645a51773e6

 -- Consultas SQL na Prática Usando SELECT, DISTINCT, WHERE e LIMIT

 -- SELEC <atributos>
 -- FROM <tabelas>
 -- WHERE [condição]
 -- ; (indica o final da instrução)

SELECT *
FROM `basedosdados.br_poder360_pesquisas.microdados` 
LIMIT 10;

SELECT ano, cargo, sigla_partido
FROM `basedosdados.br_poder360_pesquisas.microdados` 
LIMIT 1000;

-- todos os campos
SELECT *
FROM `basedosdados.br_poder360_pesquisas.microdados` 
LIMIT 1000;

-- onde o município for Duque de Caxias
SELECT ano, cargo, sigla_partido
FROM `basedosdados.br_poder360_pesquisas.microdados`
WHERE nome_municipio = 'Duque de Caxias' 
LIMIT 1000;

-- traz todos os institutos sem repetir
SELECT DISTINCT instituto
FROM `basedosdados.br_poder360_pesquisas.microdados` 

-- Somente dados do instituto Datadolha a partir do ano de 2014
SELECT *
FROM `basedosdados.br_poder360_pesquisas.microdados` 
WHERE instituto = 'Datafolha' AND ano > 2013;
LIMIT 1000;

-- Pesquisas dos institutos Datafolha e Ibope do ano de 2018 no estado de SP
SELECT *
FROM `basedosdados.br_poder360_pesquisas.microdados` 
WHERE (instituto = 'Datafolha' OR  instituto = 'Ibope') AND ano = 2018 AND sigla_uf = 'SP'
LIMIT 1000;

-- Descobrindo quais institutos fizeram pesquisa em SP no ano de 2018
SELECT DISTINCT instituto
FROM `basedosdados.br_poder360_pesquisas.microdados` 
WHERE ano = 2018 AND sigla_uf = 'SP';

-- DESAFIO: Qual a consulta para descobrir as siglas dos partidos que apareceram em pesquisar eleitorais de 2014 até 2023
SELECT DISTINCT sigla_partido
FROM `basedosdados.br_poder360_pesquisas.microdados` 
WHERE ano >= 2014 AND sigla_partido != 'N/A' AND sigla_partido != 'sem partido';