 -- TODOS OS DADOS UTILIZADOS FORAM RETIRADOS DO DATALAKE DO PODER 360 NO BIG QUERY 
 -- DISPONÍVEL EM: https://basedosdados.org/dataset/fb38dbe8-03ce-46b4-a6b7-638ade03999c?table=b6df9e1c-cbcb-4dbd-893b-8645a51773e6

 -- MAOS A OBRA

-- ​Resolva os seguintes desafios 
-- a partir da tabela de microdados de pesquisas eleitorais:

​-- 1.  Quais foram os cinco institutos de pesquisa que mais realizaram entrevistas nas pesquisas realizadas em 2022 para o cargo de presidente, 
-- apresentando o total de entrevistas realizadas por cada instituto em ordem decrescente. 
SELECT instituto, SUM(quantidade_entrevistas) AS total_entrevistas
FROM `basedosdados.br_poder360_pesquisas.microdados`
WHERE ano = 2022 AND cargo = 'presidente'
GROUP BY instituto
ORDER BY total_entrevistas DESC
LIMIT 5;

-- 2.  Quantas pesquisas distintas realizadas no ano de 2022 os candidatos cotados ao cargo de presidente apareceram. Sua consulta deve estar ordenada pelo número de pesquisas por candidato de maneira decrescente.
SELECT nome_candidato, COUNT(DISTINCT(id_pesquisa)) AS nr_pesquisas
FROM `basedosdados.br_poder360_pesquisas.microdados`
WHERE ano = 2022 AND cargo = 'presidente'
GROUP BY nome_candidato
ORDER BY nr_pesquisas DESC;


-- A partir da tabela de candidatos:​​

-- 3a. Quantos candidatos com sobrenome Gomes concorreram no Ceará nos últimos 20 anos?
SELECT COUNT(DISTINCT id_candidato_bd) AS total_gomes
FROM `basedosdados.br_tse_eleicoes.candidatos` 
WHERE nome LIKE '%Gomes%' AND sigla_uf = 'CE' AND ano > 2002

-- 3b. Em que cargos concorreram candidatos com sobrenome Gomes no Ceará nos últimos 20 anos? 
SELECT DISTINCT cargo AS cargo_gomes
FROM `basedosdados.br_tse_eleicoes.candidatos`
WHERE nome LIKE '%Gomes%' AND sigla_uf = 'CE' AND ano > 2002;


-- 4a. Quantos candidatos cada partido teve em cargos do legislativo nos últimos 8 anos no seu estado (vereador, deputado federal, deputado estadual, deputado distrital).
SELECT sigla_partido,COUNT(DISTINCT id_candidato_bd) AS total_candidatos
FROM `basedosdados.br_tse_eleicoes.candidatos`
WHERE cargo IN('vereador', 'deputado federal', 'deputado estadual', 'deputado distrital') AND ano > 2015 AND sigla_uf = 'RS'
GROUP BY sigla_partido
ORDER BY total_candidatos;

-- 4b. Qual o partido com maior número total de candidatos? Qual o partido com menor número total de candidatos?
-- Maior número de candidatos em um partido
SELECT sigla_partido, COUNT(DISTINCT id_candidato_bd) as total_candidatos
FROM `basedosdados.br_tse_eleicoes.candidatos`
WHERE ano > 2015 AND cargo IN('vereador', 'deputado estadual', 'deputado federal', 'deputado distrital') AND sigla_uf = 'RS'
GROUP BY sigla_partido
ORDER BY total_candidatos DESC
LIMIT 1;

-- Menor número de candidatos em um partido
SELECT sigla_partido, COUNT(DISTINCT id_candidato_bd) as total_candidatos
FROM `basedosdados.br_tse_eleicoes.candidatos`
WHERE ano > 2015 AND cargo IN('vereador', 'deputado estadual', 'deputado federal', 'deputado distrital') AND sigla_uf = 'RS'
GROUP BY sigla_partido
ORDER BY total_candidatos
LIMIT 1;


-- 4c. Consulte também o número de candidatos por eleição, por partido e por cargo do legislativo. É possível observar alguma tendência?
SELECT cargo, ano, sigla_partido, COUNT(DISTINCT id_candidato_bd) as total_candidatos
FROM `basedosdados.br_tse_eleicoes.candidatos`
WHERE ano > 2015 AND cargo IN('vereador', 'deputado estadual', 'deputado federal', 'deputado distrital') AND sigla_uf = 'RS'
GROUP BY cargo, ano, sigla_partido
ORDER BY sigla_partido;


-- A partir da tabela de resultados das eleições:​

-- 5. Qual foi a votação mais expressiva (maior número de votos) para o cargo de vereador no seu município por eleição. Indique o número do candidato e a sigla do partido em que concorreu.
SELECT * 
FROM `basedosdados.br_bd_diretorios_brasil.municipio`
WHERE nome = 'Caxias do Sul'

SELECT ano, MAX(votos) AS max_votos
FROM `basedosdados.br_tse_eleicoes.resultados_candidato_municipio`
WHERE cargo = 'vereador' AND id_municipio = '4305108'
GROUP BY ano
ORDER BY ano;

SELECT ano, numero_candidato, sigla_partido, votos
FROM `basedosdados.br_tse_eleicoes.resultados_candidato`
WHERE cargo = 'vereador'AND ano = 2020 AND id_municipio = '4305108'
ORDER BY votos DESC
LIMIT 1;

SELECT ano, numero_candidato, sigla_partido, votos
FROM `basedosdados.br_tse_eleicoes.resultados_candidato`
WHERE cargo = 'vereador'AND ano = 2016 AND id_municipio = '4305108'
ORDER BY votos DESC
LIMIT 1;

SELECT r1.ano, r1.numero_candidato, r1.sigla_partido, r1.votos
FROM `basedosdados.br_tse_eleicoes.resultados_candidato` as r1
JOIN (SELECT ano, MAX(votos) as max_votos
FROM `basedosdados.br_tse_eleicoes.resultados_candidato`
WHERE cargo = 'vereador'AND id_municipio = '4314902'
GROUP BY ano) as r2 ON r1.ano = r2.ano AND r1.votos = r2.max_votos
WHERE r1.cargo = 'vereador'AND r1.id_municipio = '4314902'
ORDER BY ano;


-- 6. Qual foi a votação mais expressiva (maior número de votos) para o cargo de deputado federal no seu estado por eleição. Indique o número do candidato e a sigla do partido em que concorreu.​​​

SELECT ano, MAX(votos) as max_votos
FROM `basedosdados.br_tse_eleicoes.resultados_candidato`
WHERE cargo = 'deputado federal'AND sigla_uf = 'RS'
GROUP BY ano
ORDER BY ano;

SELECT ano, numero_candidato, sigla_partido, votos
FROM `basedosdados.br_tse_eleicoes.resultados_candidato`
WHERE cargo = 'deputado federal' AND sigla_uf = 'RS' AND ano = 2018
ORDER BY votos DESC LIMIT 1;

SELECT ano, numero_candidato, sigla_partido, votos
FROM `basedosdados.br_tse_eleicoes.resultados_candidato`
WHERE cargo = 'deputado federal' AND sigla_uf = 'RS' AND ano = 2014
ORDER BY votos DESC
LIMIT 1;

SELECT r1.ano, r1.numero_candidato, r1.sigla_partido, r1.votos
FROM `basedosdados.br_tse_eleicoes.resultados_candidato` as r1
JOIN (SELECT ano, MAX(votos) as max_votos
FROM `basedosdados.br_tse_eleicoes.resultados_candidato`
WHERE cargo = 'deputado federal'AND sigla_uf = 'RS'
GROUP BY ano) as r2 ON r1.ano = r2.ano AND r1.votos = r2.max_votos
WHERE r1.cargo = 'deputado federal' AND r1.sigla_uf = 'RS'
ORDER BY ano;


-- Invertendo o processo: 

-- 7a. Agora, vamos praticar a habilidade de criar hipóteses e elaborar perguntas a partir dos dados, crie duas novas perguntas que possam ser respondidas com uma consulta SQL aos dados utilzados neste módulo, diferentes de todos os desafios propostos nesse módulo.
-- 7b. Tente implementar a consulta que respondem as perguntas que você criou.

-- Qual o partido que mais ganhou eleições para presidente?
SELECT sigla_partido, COUNT(DISTINCT sigla_partido) AS total
FROM `basedosdados.br_tse_eleicoes.resultados_candidato`
WHERE cargo = 'presidente' AND resultado = 'eleito'
GROUP BY sigla_partido
ORDER BY total DESC;

-- Qual o partido que mais gastou durante as eleições?
SELECT sigla_partido, SUM(valor_despesa) AS total_gasto
FROM `basedosdados.br_tse_eleicoes.despesas_candidato`
GROUP BY sigla_partido
ORDER BY total_gasto DESC;
