 -- TODOS OS DADOS UTILIZADOS FORAM RETIRADOS DO DATALAKE DO PODER 360 NO BIGQUERY 
 -- DISPONÍVEL EM: https://basedosdados.org/dataset/fb38dbe8-03ce-46b4-a6b7-638ade03999c?table=b6df9e1c-cbcb-4dbd-893b-8645a51773e6

 --Resolva os seguintes desafios:
​
--1. Quais foram os 10 candidatos com votação mais expressiva (maior número de votos) para o cargo de deputado federal no seu estado no ano de 2022?
-- Indique o nome, o número do candidato e a sigla do partido em que concorreu.
SELECT cand.ano, cand.nome, res.numero_candidato, res.sigla_partido, res.cargo, res.votos, res.resultado
FROM `basedosdados.br_tse_eleicoes.resultados_candidato` as res JOIN `basedosdados.br_tse_eleicoes.candidatos` as cand
ON res.id_candidato_bd = cand.id_candidato_bd
WHERE cand.ano = 2022 AND res.ano = 2022 AND res.sigla_uf = 'RS' AND res.cargo = 'deputado federal'
ORDER BY votos DESC
LIMIT 10;


-- 2.  Quais foram as 5 votações mais expressivas em uma única zona para o cargo
-- de deputado federal no seu estado no ano de 2022? Indique o ano, a zona, os 
-- votos, e o nome_urna do candidato que recebeu cada uma das votações listadas. 
SELECT z.ano, z.votos, z.zona, z.id_candidato_bd, cand.nome_urna
FROM `basedosdados.br_tse_eleicoes.candidatos` as cand JOIN `basedosdados.br_tse_eleicoes.resultados_candidato_municipio_zona` as z
ON cand.id_candidato_bd = z.id_candidato_bd
WHERE z.ano = 2022 AND cand.ano = 2022 AND cand.sigla_uf = 'RS' AND cand.cargo = 'deputado federal'
ORDER BY z.votos DESC
LIMIT 5;

-- 3. Qual foi a despesa total de cada candidato eleito em 2022 para o cargo de deputado estadual no seu estado? 
-- O resultado de sua consulta deve exibir o nome do candidato, o resultado, e a despesa total, em ordem decrescente da despesa total.
SELECT desp.id_candidato_bd, desp.nome_candidato, res.resultado, SUM(valor_despesa) AS despesa_total
FROM `basedosdados.br_tse_eleicoes.despesas_candidato` as desp JOIN `basedosdados.br_tse_eleicoes.resultados_candidato` AS res
ON desp.id_candidato_bd = res.id_candidato_bd
WHERE desp.ano = 2022 AND res.ano = 2022 AND desp.sigla_uf = 'AC' AND res.resultado LIKE '%eleito por%' AND desp.cargo = 'deputado estadual'
GROUP BY desp.id_candidato_bd, desp.nome_candidato, res.resultado
ORDER BY despesa_total DESC;

-- 4. Qual foi o custo por voto dos candidatos a governador do seu estado nas eleições de 2022.
SELECT desp.id_candidato_bd, desp.nome_candidato, res.resultado, res.votos, SUM(valor_despesa)/res.votos as custo_por_voto
FROM `basedosdados.br_tse_eleicoes.despesas_candidato` as desp JOIN `basedosdados.br_tse_eleicoes.resultados_candidato` AS res
ON desp.id_candidato_bd = res.id_candidato_bd
WHERE desp.ano = 2022 AND res.ano = 2022 AND desp.sigla_uf = 'RS' AND desp.cargo = 'governador'
GROUP BY desp.id_candidato_bd, desp.nome_candidato, res.resultado, res.votos
ORDER BY res.votos DESC;

-- 5. Qual foi o custo por voto (receita total/votos) de cada candidato eleito em 2018 para o cargo de deputado federal no estado do Rio de Janeiro? 
-- O resultado de sua consulta deve exibir o nome do candidato, o resultado,o número de votos, a receita total e o custo por voto, em ordem decrescente do custo por voto.
SELECT desp.id_candidato_bd, desp.nome_candidato, res.resultado, res.votos, SUM(valor_receita) as receita_total, 
SUM(valor_receita)/res.votos as custo_por_voto
FROM `basedosdados.br_tse_eleicoes.receitas_candidato` as desp JOIN `basedosdados.br_tse_eleicoes.resultados_candidato` AS res
ON desp.id_candidato_bd = res.id_candidato_bd
WHERE desp.ano = 2018 AND res.ano = 2018 AND desp.sigla_uf = 'RJ' AND res.resultado LIKE '%eleito por%' AND desp.cargo = 'deputado federal'
GROUP BY desp.id_candidato_bd, desp.nome_candidato, res.resultado, res.votos
ORDER BY custo_por_voto DESC;

-- 6. Liste os candidatos que mudaram de nome na urna de 2018 para 2022 no seu estado. Quantos resultados sua consulta retornou?
SELECT r1.nome, r1.nome_urna, r1.ano, r1.sigla_partido, r2.nome, r2.nome_urna, r2.ano, r2.sigla_partido
FROM `basedosdados.br_tse_eleicoes.candidatos` as r1 JOIN `basedosdados.br_tse_eleicoes.candidatos` as r2
ON r1.id_candidato_bd = r2.id_candidato_bd
WHERE r1.ano = 2018 AND r2.ano = 2022 AND r1.sigla_uf = 'RJ' AND r1.nome_urna != r2.nome_urna
LIMIT 100;

-- 1. Encontre os candidatos a deputado federal do seu estado que foram eleitos em 2014 e 2018.
-- 2. Escolha um entre os candidatos e encontre os dez maiores doadores na eleição de 2014. Quantos são CNPJ?
-- 3. Para esse mesmo candidato encontre os dez maiores doadores na eleição de 2018.
SELECT r1.numero_candidato, r1.votos, r1.resultado, r2.numero_candidato, r2.resultado
FROM `basedosdados.br_tse_eleicoes.resultados_candidato` as r1 JOIN `basedosdados.br_tse_eleicoes.resultados_candidato` as r2
ON r1.id_candidato_bd = r2.id_candidato_bd
WHERE r1.ano = 2014 AND r2.ano = 2018 AND r1.sigla_uf = 'RS' AND r1.cargo = 'deputado federal' AND r1.resultado LIKE '%eleito por%' AND r2.resultado LIKE '%eleito por%'
ORDER BY votos DESC
LIMIT 100;

SELECT cpf_cnpj_doador, SUM(valor_receita) as doacao
FROM `basedosdados.br_tse_eleicoes.receitas_candidato`
WHERE ano = 2014 AND numero_candidato = '2522' AND sigla_uf = 'RS' AND cargo = 'deputado federal'
GROUP BY cpf_cnpj_doador
ORDER BY doacao DESC
LIMIT 10;

SELECT cpf_cnpj_doador, SUM(valor_receita) as doacao
FROM `basedosdados.br_tse_eleicoes.receitas_candidato`
WHERE ano = 2014 AND numero_candidato = '2522' AND sigla_uf = 'RS' AND cargo = 'deputado federal'
GROUP BY cpf_cnpj_doador
ORDER BY doacao DESC
LIMIT 10;