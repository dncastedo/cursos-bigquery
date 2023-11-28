 -- TODOS OS DADOS UTILIZADOS FORAM RETIRADOS DO DATALAKE DO PODER 360 NO BIGQUERY 
 -- DISPONÍVEL EM: https://basedosdados.org/dataset/fb38dbe8-03ce-46b4-a6b7-638ade03999c?table=b6df9e1c-cbcb-4dbd-893b-8645a51773e6v

-- O que são subconsultas SQL? Extração de dados com SQL 

-- Primeiro extrai informações sobre as receitas dos candidatos no estado do Rio de Janeiro em 2018, 
-- Em uma subconsulta calcula estatísticas resumidas (mínimo, médio e máximo) dessas receitas, agrupadas por partido.
SELECT nome_candidato, cpf_candidato, cargo, sigla_partido, SUM(valor_receita) AS receita_total  
FROM `basedosdados.br_tse_eleicoes.receitas_candidato` 
WHERE ano = 2018 AND sigla_uf IN('RJ')
GROUP BY 1, 2, 3, 4
ORDER BY 5 DESC;


-- Retorna as estatísticas resumidas (mínimo, médio e máximo) das receitas dos candidatos 
-- por partido no estado do Rio de Janeiro em 2018. 
-- Cada linha representa um partido, com informações sobre a receita mínima, média e máxima obtida pelos candidatos desse partido.
SELECT sigla_partido, 
       MIN(receita_total) AS receita_min, 
       AVG(receita_total) AS receita_media, 
       MAX(receita_total) AS receita_max
FROM
(SELECT nome_candidato, cpf_candidato, cargo, sigla_partido, SUM(valor_receita) AS receita_total  
      FROM `basedosdados.br_tse_eleicoes.receitas_candidato` 
      WHERE ano = 2018 AND sigla_uf IN('RJ')
      GROUP BY 1, 2, 3, 4
      ORDER BY 5 DESC)
GROUP BY sigla_partido;

-- A consulta final retorna estatísticas resumidas (mínimo, médio e máximo) das receitas dos candidatos 
-- no estado do Rio de Janeiro em 2018, agrupadas por cargo. Cada linha representa um cargo, 
-- com informações sobre a receita mínima, média e máxima obtida pelos candidatos que ocuparam esse cargo.
SELECT cargo, 
       MIN(receita_total) AS receita_min, 
       AVG(receita_total) AS receita_media, 
       MAX(receita_total) AS receita_max
FROM
(SELECT nome_candidato, cpf_candidato, cargo, sigla_partido, SUM(valor_receita) AS receita_total  
      FROM `basedosdados.br_tse_eleicoes.receitas_candidato` 
      WHERE ano = 2018 AND sigla_uf IN('RJ')
      GROUP BY 1, 2, 3, 4
      ORDER BY 5 DESC)
GROUP BY cargo;

-- A consulta final retorna estatísticas resumidas (mínimo, médio e máximo) das receitas dos candidatos eleitos
-- no estado do Rio de Janeiro em 2018, agrupadas por cargo, e ordenadas pela receita média em ordem decrescente. 
-- Cada linha representa um cargo, com informações sobre a receita mínima, média e máxima obtida pelos candidatos eleitos que ocuparam esse cargo.
SELECT cargo, 
       MIN(receita_total) AS receita_min, 
       AVG(receita_total) AS receita_media, 
       MAX(receita_total) AS receita_max
FROM
(SELECT nome_candidato, cpf_candidato, cargo, sigla_partido, SUM(valor_receita) AS receita_total  
      FROM `basedosdados.br_tse_eleicoes.receitas_candidato` 
      WHERE ano = 2018 AND sigla_uf IN('RJ') 
            AND id_candidato_bd IN (
              SELECT id_candidato_bd
              FROM `basedosdados.br_tse_eleicoes.resultados_candidato` 
              WHERE ano = 2018 AND sigla_uf IN('RJ') 
                AND CONTAINS_SUBSTR(resultado, 'eleito') 
                AND NOT CONTAINS_SUBSTR(resultado, 'não')
            )
      GROUP BY 1, 2, 3, 4
      ORDER BY 5 DESC)
GROUP BY 1
ORDER BY 3 DESC;

-- Busca somente os votos de quem foi eleito no município escolhido
SELECT *
  FROM `basedosdados.br_tse_eleicoes.resultados_candidato` 
  WHERE ano = 2016 AND id_municipio IN('3304557')
  AND CONTAINS_SUBSTR(resultado, 'eleito')
  AND NOT CONTAINS_SUBSTR(resultado, 'não')
ORDER BY votos;

--A consulta final retorna os resultados dos candidatos eleitos em um município específico em 2016, 
--mas apenas para aqueles que também foram candidatos em 2018, 
--ordenados pelo número de votos em ordem decrescente. 
--Cada linha representa um candidato que atende a esses critérios.
SELECT * 
FROM(
  SELECT *
  FROM `basedosdados.br_tse_eleicoes.resultados_candidato` 
  WHERE ano = 2016 AND id_municipio IN('3304557')
  AND CONTAINS_SUBSTR(resultado, 'eleito')
  AND NOT CONTAINS_SUBSTR(resultado, 'não')
)
WHERE id_candidato_bd IN(
  SELECT id_candidato_bd
  FROM `basedosdados.br_tse_eleicoes.candidatos`
  WHERE ano = 2018
)
ORDER BY votos DESC;
