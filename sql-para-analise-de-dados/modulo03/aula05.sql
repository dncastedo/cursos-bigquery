 -- TODOS OS DADOS UTILIZADOS FORAM RETIRADOS DO DATALAKE DO PODER 360 NO BIGQUERY 
 -- DISPONÍVEL EM: https://basedosdados.org/dataset/fb38dbe8-03ce-46b4-a6b7-638ade03999c?table=b6df9e1c-cbcb-4dbd-893b-8645a51773e6

-- Como lidar com STRINGS em consultas SQL

--LEFT(id_municipio, 2) AS id_uf: Isso cria uma nova coluna chamada id_uf 
-- que consiste nos dois primeiros caracteres da coluna id_municipio. 
-- Isso pode ser usado para extrair o código da unidade federativa (UF) a partir do código do município.
SELECT *, LEFT(id_municipio, 2) AS id_uf 
FROM `basedosdados.br_tse_eleicoes.candidatos` 
WHERE ano > 2014
LIMIT 1000;

-- concatenando o número, o caracteres e nome na urna na nova coluna
SELECT *, CONCAT(numero, '-', nome_urna) AS numero_nome_urna 
FROM `basedosdados.br_tse_eleicoes.candidatos` 
WHERE ano > 2014
LIMIT 1000;

-- buscando todas as colunbas em que a coluna nome_urna contém 'Bolsonaro' no ano de 2016
SELECT *
FROM `basedosdados.br_tse_eleicoes.candidatos` 
WHERE CONTAINS_SUBSTR(nome_urna, 'Bolsonaro') = TRUE AND ano = 2016;

-- buscando todas as colunbas em que a coluna nome_urna contém 'Bolsonaro' no ano de 2020
SELECT *
FROM `basedosdados.br_tse_eleicoes.candidatos` 
WHERE CONTAINS_SUBSTR(nome_urna, 'Bolsonaro') = TRUE AND ano = 2020;

-- buscando todas as colunbas em que a coluna nome_urna contém 'Bolsonaro' no ano de 2020 e a coluna nome 
-- não contém o nome Bolsonaro no ano de 2020
SELECT *
FROM `basedosdados.br_tse_eleicoes.candidatos` 
WHERE CONTAINS_SUBSTR(nome_urna, 'Bolsonaro') = TRUE AND CONTAINS_SUBSTR(nome, 'Bolsonaro') = FALSE AND ano = 2020;

-- DESAFIO pesquisar outros tipos de substring
SELECT *
FROM `basedosdados.br_tse_eleicoes.candidatos` 
WHERE CONTAINS_SUBSTR(nome_urna, 'Lula') = TRUE AND ano = 2000;

SELECT *
FROM `basedosdados.br_tse_eleicoes.candidatos` 
WHERE CONTAINS_SUBSTR(nome_urna, 'Lula') = TRUE AND ano = 2006;

SELECT *
FROM `basedosdados.br_tse_eleicoes.candidatos` 
WHERE CONTAINS_SUBSTR(nome_urna, 'Lula') = TRUE AND CONTAINS_SUBSTR(nome, 'Bolsonaro') = FALSE AND ano = 2020;