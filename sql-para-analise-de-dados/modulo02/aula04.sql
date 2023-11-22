 -- TODOS OS DADOS UTILIZADOS FORAM RETIRADOS DO DATALAKE DO PODER 360 NO BIGQUERY 
 -- DISPONÍVEL EM: https://basedosdados.org/dataset/fb38dbe8-03ce-46b4-a6b7-638ade03999c?table=b6df9e1c-cbcb-4dbd-893b-8645a51773e6

-- Usando JOIN em consultas SQL para combinar tabelas

-- Verificando o total de bens por candidato
SELECT id_candidato_bd, SUM(valor_item) AS bens_total 
FROM `basedosdados.br_tse_eleicoes.bens_candidato` 
WHERE ano = 2018 AND sigla_uf = 'BA'
GROUP BY id_candidato_bd
ORDER BY bens_total DESC;

-- Fazendo junção entre tabelas para filtrar novas informações
SELECT bens.id_candidato_bd,cands.nome_urna,  SUM(valor_item) AS bens_total 
FROM `basedosdados.br_tse_eleicoes.bens_candidato` AS bens JOIN `basedosdados.br_tse_eleicoes.candidatos` AS cands
ON bens.id_candidato_bd = cands.id_candidato_bd
WHERE bens.ano = 2018 AND bens.sigla_uf = 'BA' AND cands.ano = 2018 AND cands.cargo = 'governador'
GROUP BY bens.id_candidato_bd, cands.nome_urna
ORDER BY bens_total DESC;