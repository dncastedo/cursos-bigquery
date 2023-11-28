 -- TODOS OS DADOS UTILIZADOS FORAM RETIRADOS DO DATALAKE DO PODER 360 NO BIGQUERY 
 -- DISPONÍVEL EM: https://basedosdados.org/dataset/fb38dbe8-03ce-46b4-a6b7-638ade03999c?table=b6df9e1c-cbcb-4dbd-893b-8645a51773e6

--Como filtrar os dados por data em consultas SQL 
--data atual
SELECT CURRENT_DATE() AS hoje;

-- extraindo e gerando vetor de dados
SELECT
  date,
  EXTRACT(ISOYEAR FROM date) AS isoyear,
  EXTRACT(ISOWEEK FROM date) AS isoweek,
  EXTRACT(YEAR FROM date) AS year,
  EXTRACT(WEEK FROM date) AS week
FROM UNNEST(GENERATE_DATE_ARRAY('2015-12-23', '2016-01-09')) AS date
ORDER BY date; 

-- adicionando dias
SELECT DATE_ADD(DATE '2008-12-25', INTERVAL 5 DAY) AS five_dayas_later;

-- extraindo o dia da filiação
SELECT data_filiacao, EXTRACT(DAY FROM data_filiacao) AS dia
FROM `basedosdados.br_tse_filiacao_partidaria.microdados` LIMIT 1000;

-- formatando a data e extraindo dia 
SELECT data_filiacao, 
    FORMAT_DATE('%d-%m-%Y', data_filiacao) AS data_filiacao_formatada,
    EXTRACT(DAY FROM data_filiacao) AS dia
FROM `basedosdados.br_tse_filiacao_partidaria.microdados` LIMIT 1000;


-- contando os dias filiado
SELECT data_filiacao, data_desfiliacao,
    DATE_DIFF(data_desfiliacao, data_filiacao, DAY) AS tempo_filiado
FROM `basedosdados.br_tse_filiacao_partidaria.microdados` 
WHERE data_desfiliacao IS NOT NULL
LIMIT 1000;

-- contando os dias de filiado antes de 2018
SELECT data_filiacao, 
    DATE_DIFF(DATE '2018-10-07', data_filiacao, DAY) AS tempo_filiado_antes_2018
FROM `basedosdados.br_tse_filiacao_partidaria.microdados` 
WHERE EXTRACT(YEAR FROM data_filiacao) = 2018;

-- contando os dias de filiado antes de 10-07-2018
SELECT data_filiacao, 
    DATE_DIFF(DATE '2018-10-07', data_filiacao, DAY) AS tempo_filiado_antes_2018
FROM `basedosdados.br_tse_filiacao_partidaria.microdados` 
WHERE EXTRACT(YEAR FROM data_filiacao) = 2018 AND EXTRACT(MONTH FROM data_filiacao) <= 10 AND EXTRACT(MONTH FROM data_filiacao) <= 7
ORDER BY tempo_filiado_antes_2018 DESC;