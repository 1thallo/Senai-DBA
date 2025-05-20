select * from partida where id_mandante = 11 and id_visitante = 9;
update partida set gol_mandante = 1 , horario = '2024-12-05 12:00:00' where id_partida = 364;

select row_number() over() n, c.* from vw_classificacao c;

create or replace view vw_classificacao as (
SELECT 
    id_time,
    sigla,
    nome,
    sum(PTS) PTS,
    count(*) QTJ,
    sum(VIT) VIT,
    sum(DER) DER,
    sum(GM) GM,
    sum(GC) GC,
    sum(SG) SG
    
FROM
    (SELECT 
        t.id_time,
		t.sigla,
        t.nome,
            CASE 
				WHEN gol_mandante > gol_visitante THEN 3
                WHEN gol_mandante = gol_visitante THEN 1 
                ELSE 0 END PTS,

            CASE 
				WHEN gol_mandante > gol_visitante THEN 1 ELSE 0 END VIT,
            CASE
				WHEN gol_mandante = gol_visitante THEN 1 ELSE 0 END EMP,
            CASE
				WHEN gol_mandante < gol_visitante THEN 1 ELSE 0 END DER,
            gol_mandante GM,
            gol_visitante GC,
            gol_mandante - gol_visitante SG
    FROM
        partida p
    INNER JOIN time t 
		ON p.id_mandante = t.id_time 
    
    UNION ALL 
    
    SELECT 
        t.id_time,
		t.sigla,
		t.nome,
            CASE
                WHEN gol_visitante > gol_mandante THEN 3
                WHEN gol_visitante = gol_mandante THEN 1
                ELSE 0 END PTS,
            CASE 
				WHEN gol_visitante > gol_mandante THEN 1 ELSE 0 END VIT,
            CASE
				WHEN gol_visitante = gol_mandante THEN 1 ELSE 0 END EMP,
            CASE
				WHEN gol_visitante < gol_mandante THEN 1 ELSE 0 END DER,
            gol_visitante GM,
            gol_mandante GC,
            gol_visitante - gol_mandante SG
    FROM
        partida p
    INNER JOIN time t ON p.id_visitante = t.id_time) AS TB
     GROUP BY 
        id_time,
		sigla,
		nome
        
	ORDER BY
    PTS DESC, VIT DESC, SG DESC, GM DESC);
    
    
select 
	tb.*,
    case
		when n between 1 and 6 then 'Libertadores'
        when n between 7 and 8 then 'Pré-Libertadores'
        when n between 9 and 14 then 'Sudamericana'
        when n between 17 and 20 then 'Rebaixado'
        else 'Nada'
	end Qualificacao
from (
	select 
		row_number() over() n, 
        c.* 
	from vw_classificacao c
) as tb;