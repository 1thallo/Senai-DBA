SELECT 
    base , count(*) qt
FROM
    (SELECT 
        nome, 'campeontabr' base
    FROM
        dbcampeonatobr.jogador 
	UNION 
    SELECT 
        CONCAT(primeiro_nome, ' ', ultimo_nome), 'locadora'
    FROM
        locadora.cliente) AS tb
WHERE
    nome LIKE '%x%'
    group by base;

use locadora;
select 
ano_de_lancamento,
classificacao,
count(*) qt
from filme
group by ano_de_lancamento,
classificacao
;

select 
classificacao,
count(case when ano_de_lancamento = '2006' then 1 end) ano_2006,
count(case when ano_de_lancamento = '2007' then 1 end) ano_2007,
count(case when ano_de_lancamento = '2008' then 1 end) ano_2008
from 
filme
group by
classificacao;

select 
ano_de_lancamento,
count(case when classificacao = 'PG' then 1 else null end) "PG",
count(case when classificacao = 'G' then 1 end) "G",
count(case when classificacao = 'NC-17' then 1 end) "NC-17",
count(case when classificacao = 'PG-13' then 1 end) "PG-13",
count(case when classificacao = 'R' then 1 end) "R"
from filme
group by
ano_de_lancamento;