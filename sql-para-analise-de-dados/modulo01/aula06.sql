 -- TODOS OS DADOS UTILIZADOS FORAM RETIRADOS DO DATALAKE DO PODER 360 NO BIGQUERY 
 -- DISPONÍVEL EM: https://basedosdados.org/dataset/fb38dbe8-03ce-46b4-a6b7-638ade03999c?table=b6df9e1c-cbcb-4dbd-893b-8645a51773e6

-- Para que serve o COUNT em SQL + agregação com MAX, MIN e SUM

SELECT * 
FROM `basedosdados.br_tse_eleicoes.receitas_candidato` 
LIMIT 1000;

-- Buscando candidatos a governador da Bahia em 2018
SELECT DISTINCT nome_candidato, cpf_candidato 
FROM `basedosdados.br_tse_eleicoes.receitas_candidato`
WHERE ano = 2018 AND sigla_uf = 'BA' AND cargo = 'governador';

-- MAX, MIN, AVG E SUM 
SELECT MAX(valor_receita) AS max_receita, 
       MIN(valor_receita) AS min_receita, 
       AVG(valor_receita) AS avg_receita, 
       SUM(valor_receita) AS sum_receita
FROM `basedosdados.br_tse_eleicoes.receitas_candidato` 
WHERE ano = 2020 AND sigla_uf = 'BA';

-- Dados Max, Min, Avg e Sum do candidato Rui 
SELECT MAX(valor_receita) AS max_receita, 
       MIN(valor_receita) AS min_receita, 
       AVG(valor_receita) AS avg_receita, 
       SUM(valor_receita) AS sum_receita
FROM `basedosdados.br_tse_eleicoes.receitas_candidato` 
WHERE ano = 2018 AND sigla_uf = 'BA' AND cpf_candidato = '23790997587';

-- Usando COUNT para descobrir doadores 
SELECT COUNT(DISTINCT cpf_cnpj_doador) AS qtd_doadores_distintos
FROM `basedosdados.br_tse_eleicoes.receitas_candidato`
WHERE ano = 2018 AND sigla_uf = 'BA' AND cpf_candidato = '23790997587';

-- Usando COUNT para descobrir qtde doadores no geral
SELECT COUNT(DISTINCT cpf_cnpj_doador) AS qtd_doadores_distintos
FROM `basedosdados.br_tse_eleicoes.receitas_candidato`
WHERE ano = 2018 AND sigla_uf = 'SP';

SELECT ROUND(AVG(valor_receita),3)
FROM `basedosdados.br_tse_eleicoes.receitas_candidato`
WHERE ano = 2018 AND sigla_uf = 'AC' AND cargo = 'governador';

-- DESAFIO Na tabela despesas_candidato verificar quantos fornecedores diferentes
-- o gov Rui Costa teve na eleição de 2018, 
-- renomear e dizer qual foi o total de despesas, o valor máximo e mínimo

SELECT COUNT(DISTINCT cpf_cnpj_fornecedor) AS qtd_fornecedores_distintos
FROM `basedosdados.br_tse_eleicoes.despesas_candidato` 
WHERE ano = 2018 AND sigla_uf = 'BA' AND cpf_candidato = '23790997587';

SELECT ROUND(MAX(valor_despesa),3) AS max_despesa, 
       ROUND(MIN(valor_despesa),3) AS min_despesa,  
       ROUND(SUM(valor_despesa),3) AS sum_despesa
FROM `basedosdados.br_tse_eleicoes.despesas_candidato` 
WHERE ano = 2018 AND sigla_uf = 'BA' AND cpf_candidato = '23790997587';

