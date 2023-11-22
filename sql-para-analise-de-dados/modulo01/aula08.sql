-- TODOS OS DADOS UTILIZADOS FORAM RETIRADOS DO DATALAKE DO PODER 360 NO BIGQUERY 
 -- DISPONÍVEL EM: https://basedosdados.org/dataset/fb38dbe8-03ce-46b4-a6b7-638ade03999c?table=b6df9e1c-cbcb-4dbd-893b-8645a51773e6

-- Como usar GROUP BY, HAVING e CASE em consultas SQL na prática

-- por estado
SELECT sigla_uf, COUNT(DISTINCT cpf_cnpj_doador) AS qtd_doadores
FROM `basedosdados.br_tse_eleicoes.receitas_candidato`
WHERE ano = 2018 AND cargo = 'governador'
GROUP BY sigla_uf
ORDER BY qtd_doadores DESC;

--por candidato
SELECT nome_candidato, COUNT(DISTINCT cpf_cnpj_doador) AS qtd_doadores
FROM `basedosdados.br_tse_eleicoes.receitas_candidato`
WHERE ano = 2018 AND sigla_uf = 'BA' AND cargo = 'governador'
GROUP BY nome_candidato
ORDER BY qtd_doadores DESC;

-- Soma da receita de doações aos candidatos ao gov na BA
SELECT nome_candidato, COUNT(DISTINCT cpf_cnpj_doador) AS qtd_doadores,
  ROUND(SUM(valor_receita),2) AS soma_valor_receita
FROM `basedosdados.br_tse_eleicoes.receitas_candidato`
WHERE ano = 2018 AND sigla_uf = 'BA' AND cargo = 'governador'
GROUP BY nome_candidato
ORDER BY soma_valor_receita DESC;

-- HAVING para filtrar agrupamentos
SELECT nome_candidato, COUNT(DISTINCT cpf_cnpj_doador) AS qtd_doadores,
  ROUND(SUM(valor_receita),2) AS soma_valor_receita
FROM `basedosdados.br_tse_eleicoes.receitas_candidato`
WHERE ano = 2018 AND sigla_uf = 'BA' AND cargo = 'governador'
GROUP BY nome_candidato
HAVING soma_valor_receita < 1000000 
ORDER BY soma_valor_receita DESC;

-- inserindo uma condicional com CASE WHEN - THEN ELSE - END AS 
-- e criando uma coluna
SELECT nome_candidato, COUNT(DISTINCT cpf_cnpj_doador) AS qtd_doadores,
  ROUND(SUM(valor_receita),2) AS soma_valor_receita,
  CASE WHEN SUM(valor_receita) > 1000000 THEN 'receita alta'
      ELSE 'receita baixa' END AS categoria_receita
FROM `basedosdados.br_tse_eleicoes.receitas_candidato`
WHERE ano = 2018 AND sigla_uf = 'BA' AND cargo = 'governador'
GROUP BY nome_candidato
ORDER BY soma_valor_receita DESC;

--Outra forma de criar uma condicional usando juntamente o IN
SELECT nome_candidato, sigla_partido, COUNT(DISTINCT cpf_cnpj_doador) AS qtd_doadores,
  ROUND(SUM(valor_receita),2) AS soma_valor_receita,
  CASE WHEN sigla_partido IN ('PT', 'PSOL', 'PCO') THEN 'esquerda'
      ELSE 'outro' END AS espectro_politico
FROM `basedosdados.br_tse_eleicoes.receitas_candidato`
WHERE ano = 2018 AND sigla_uf = 'BA' AND cargo = 'governador'
GROUP BY nome_candidato, sigla_partido
ORDER BY soma_valor_receita DESC;

-- DESAFIO: Quantos fornecedores distintos teve cada candidato a governador 
-- no estado da Bahia nas eleições de 2018 
-- e qual a soma total de despesas de cada candidato? 
-- Além dos valores solicitados sua consulta 
-- deve incluir também o nome e a sigla do partido de cada candidato.

SELECT nome_candidato, nome_partido, sigla_partido, COUNT(DISTINCT cpf_cnpj_fornecedor) AS qtd_fornecedores,
  ROUND(SUM(valor_despesa),2) AS soma_valor_despesa,
FROM `basedosdados.br_tse_eleicoes.despesas_candidato`
WHERE ano = 2018 AND sigla_uf = 'BA' AND cargo = 'governador'
GROUP BY nome_candidato, nome_partido, sigla_partido
ORDER BY soma_valor_despesa DESC;



