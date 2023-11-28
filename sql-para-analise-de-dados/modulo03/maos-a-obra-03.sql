 -- TODOS OS DADOS UTILIZADOS FORAM RETIRADOS DO DATALAKE DO PODER 360 NO BIGQUERY 
 -- DISPONÍVEL EM: https://basedosdados.org/dataset/fb38dbe8-03ce-46b4-a6b7-638ade03999c?table=b6df9e1c-cbcb-4dbd-893b-8645a51773e6v

 -- Resolva os seguintes desafios:

--A partir da tabela de filiação partidária (nome da tabela - ​br_tse_filiacao_partidaria.microdados):
--1. Extraia da tabela a lista pessoas filiadas por ano. Responda: Qual foi o ano com mais filiações?
SELECT EXTRACT(YEAR FROM data_filiacao) as ano, COUNT(titulo_eleitoral) as filiacoes
FROM `basedosdados.br_tse_filiacao_partidaria.microdados`
GROUP BY ano
ORDER BY filiacoes DESC
LIMIT 5;

--A partir da tabela dos discursos da CPI da pandemia (nome da tabela - br_senado_cpipandemia.discursos):
--2. Contar discursos por data de sessão, apresente a data com a formatação dd/mm/yy
SELECT FORMAT_DATE('%d-%m-%y', data_sessao), COUNT(nome_discursante) as qtd_discursantes
FROM `basedosdados.br_senado_cpipandemia.discursos`
GROUP BY data_sessao
ORDER BY data_sessao
LIMIT 1000;

--3. Em quais dias da CPI o ex-ministro da saúde Mandetta foi mencionado em discursos? Extraia a data com a formatação dd/mm/yy. 
SELECT DISTINCT FORMAT_DATE('%d-%m-%y', data_sessao)
FROM `basedosdados.br_senado_cpipandemia.discursos`
WHERE CONTAINS_SUBSTR(texto_discurso, 'Mandetta') = TRUE;

--4. Em quantos discursos o ex-ministro da saúde Pazuello foi mencionado?
SELECT COUNT(*)
FROM `basedosdados.br_senado_cpipandemia.discursos`
WHERE CONTAINS_SUBSTR(texto_discurso, 'Pazuello') = TRUE

--A partir da tabela de despesas dos candidatos (nome da tabela -br_tse_eleicoes.despesas_candidato):
--5. Extraia a lista de todas as depesas do candidato a deputado federal mais votado do seu estado nas Eleições de 2022.
SELECT *
FROM `basedosdados.br_tse_eleicoes.despesas_candidato`
WHERE ano = 2022 AND id_candidato_bd = (SELECT id_candidato_bd
FROM `basedosdados.br_tse_eleicoes.resultados_candidato` as r1
WHERE cargo = 'deputado federal' AND sigla_uf = 'RS' AND ano = 2022
ORDER BY votos DESC
LIMIT 1);

--6. Considerando os candidatos ao cargo de deputado federal nas Eleições 2022 no seu estado, consulte os candidatos cuja maior despesa é maior do que o valor médio das despesas de todos os candidatos (mesmo ano, cargo e estado).
SELECT nome_candidato, sigla_partido, MAX(valor_despesa) as max_despesa_total
FROM `basedosdados.br_tse_eleicoes.despesas_candidato`
WHERE ano = 2022 AND sigla_uf = 'RS' AND cargo = 'deputado federal'
GROUP BY nome_candidato, sigla_partido
HAVING max_total > (SELECT AVG(valor_despesa)
FROM `basedosdados.br_tse_eleicoes.despesas_candidato`
WHERE ano = 2022 AND sigla_uf = 'RS' AND cargo = 'deputado federal')

--A partir da tabela de resultados das eleições (nome da tabela - br_tse_eleicoes.resultados_candidato​):
--7. Qual foi a votação mais expressiva (maior número de votos) para o cargo de vereador no seu município por eleição. Indique o número do candidato e a sigla do partido em que concorreu. 
SELECT r1.ano, r1.numero_candidato, r1.sigla_partido, r1.votos
FROM `basedosdados.br_tse_eleicoes.resultados_candidato` as r1
JOIN (SELECT ano, MAX(votos) as max_votos
FROM `basedosdados.br_tse_eleicoes.resultados_candidato`
WHERE cargo = 'vereador'AND id_municipio = '4314902'
GROUP BY ano) as r2 ON r1.ano = r2.ano AND r1.votos = r2.max_votos
WHERE r1.cargo = 'vereador'AND r1.id_municipio = '4314902'
ORDER BY ano;

--8. A partir da tabela de resultados das eleições Qual foi a votação mais expressiva (maior número de votos) para o cargo de deputado federal no seu estado por eleição. Indique o número do candidato e a sigla do partido em que concorreu.
SELECT r1.ano, r1.numero_candidato, r1.sigla_partido, r1.votos
FROM `basedosdados.br_tse_eleicoes.resultados_candidato` as r1
JOIN (SELECT ano, MAX(votos) as max_votos
FROM `basedosdados.br_tse_eleicoes.resultados_candidato`
WHERE cargo = 'deputado federal'AND sigla_uf = 'RS'
GROUP BY ano) as r2 ON r1.ano = r2.ano AND r1.votos = r2.max_votos
WHERE r1.cargo = 'deputado federal' AND r1.sigla_uf = 'RS'
ORDER BY ano;

--Questão 1 - Considerando os candidatos ao cargo de deputado estadual nas Eleições 2022 no seu estado, consulte os candidatos cuja maior receita é maior do que o valor médio das receitas de todos os candidatos (mesmo ano, cargo e estado).
SELECT nome_candidato, sigla_partido, MAX(valor_receita) as max_receita_total
FROM `basedosdados.br_tse_eleicoes.receitas_candidato`
WHERE ano = 2022 AND sigla_uf = 'RS' AND cargo = 'deputado estadual'
GROUP BY nome_candidato, sigla_partido
HAVING max_receita_total > (SELECT AVG(valor_receita)
FROM `basedosdados.br_tse_eleicoes.receitas_candidato`
WHERE ano = 2022 AND sigla_uf = 'RS' AND cargo = 'deputado estadual');

--Questão 2 - Elabore uma consulta que recupere a lista de todas as receitas do candidato a deputado federal mais votado do seu estado nas Eleições de 2022. Ordene as receitas da maior para a menor.
SELECT *
FROM `basedosdados.br_tse_eleicoes.receitas_candidato`
WHERE ano = 2022 AND id_candidato_bd = (SELECT id_candidato_bd
FROM `basedosdados.br_tse_eleicoes.resultados_candidato` as r1
WHERE cargo = 'deputado federal' AND ano = 2022 AND sigla_uf = 'SP'
ORDER BY votos DESC
LIMIT 1)
ORDER BY valor_receita DESC;