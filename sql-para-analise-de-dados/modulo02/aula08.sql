 -- TODOS OS DADOS UTILIZADOS FORAM RETIRADOS DO DATALAKE DO PODER 360 NO BIGQUERY 
 -- DISPONÍVEL EM: https://basedosdados.org/dataset/fb38dbe8-03ce-46b4-a6b7-638ade03999c?table=b6df9e1c-cbcb-4dbd-893b-8645a51773e6

-- Diferença entre INNER JOIN e OUTER JOIN | Tipos de JOINS em SQL
-- Joins Implícitos
SELECT bens.id_candidato_bd,cands.nome_urna,  SUM(valor_item) AS bens_total 
FROM `basedosdados.br_tse_eleicoes.bens_candidato` AS bens, `basedosdados.br_tse_eleicoes.candidatos` AS cands
WHERE bens.ano = 2018 AND bens.sigla_uf = 'BA' AND cands.ano = 2018 AND cands.cargo = 'governador' AND bens.id_candidato_bd = cands.id_candidato_bd
GROUP BY bens.id_candidato_bd, cands.nome_urna
ORDER BY bens_total DESC;

-- DESAFIO: Considerando as tabelas dos dados das eleições brasileiras, 
-- crie duas perguntas que você possa responder 
-- com uma consulta SQL que utilize dois tipos de JOINS diferentes.