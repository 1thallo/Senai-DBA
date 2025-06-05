delimiter $$
create function dbgeral.idade(dtn date)
returns int
not deterministic
reads sql data
begin
	return datediff(curdate(),dtn) div 365.25;
end$$
delimiter ;

select dbgeral.idade('1987-05-29'), datediff(curdate(),'1987-05-29');

delimiter $$
create function dbgeral.faixa_etaria(dtn date)
returns varchar(30)
not deterministic
reads sql data
begin
	declare idade int;
    declare fx varchar(30);
    set idade = (select dbgeral.idade(dtn));
    set fx = (select idade div 10);
	return replace('Entre *0 e *9 anos','*',fx);
end$$
delimiter ;
select dbgeral.faixa_etaria('1987-07-21');


delimiter $$
create procedure atualizar_gol_partida(sgm varchar(3), golm int, golv int, sgv varchar(3))
begin 
declare idmandante int;
declare idvisitante int;
declare idpartida int;
set idmandante = (select id_time from dbcampeonatobr.time where sigla = sgm);
set idvisitante = (select id_time from dbcampeonatobr.time where sigla = sgv);
set idpartida = (select id_partida from dbcampeonatobr.partida 
					where id_mandante = idmandante and id_visitante = idvisitante);
update dbcampeonatobr.partida set gol_mandante = golm, gol_visitante = golv 
where id_partida = idpartida;
end$$
delimiter ;

SET SQL_SAFE_UPDATES=0;
update partida set gol_mandante = null, gol_visitante = null where rodada = 38;
select * from dbcampeonatobr.partida where rodada = 38;
-- RODADA 38
CALL atualizar_gol_partida('GRE',0,3,'COR');
CALL atualizar_gol_partida('CAM',1,0,'CAP');
CALL atualizar_gol_partida('BAH',2,0,'ACG');
CALL atualizar_gol_partida('FLA',2,2,'VIT');
CALL atualizar_gol_partida('BOT',2,1,'SAO');
CALL atualizar_gol_partida('PAL',0,1,'FLU');
CALL atualizar_gol_partida('RBB',5,1,'CRI');
CALL atualizar_gol_partida('FOR',3,0,'INT');
CALL atualizar_gol_partida('CUI',1,2,'VAS');
CALL atualizar_gol_partida('JUV',0,1,'CRU');

delimiter $$
create procedure gerar_resultado_aleatorio()
begin
	declare contador int default 1;
    while contador <= 380 do
		update dbcampeonatobr.partida
		set gol_mandante = round(rand()*6) , gol_visitante = round(rand()*6)
		where id_partida = contador;
		set contador = contador + 1;
	end while;
end$$
delimiter ;
select * from dbcampeonatobr.vw_classificacao;
call gerar_resultado_aleatorio();
-- drop procedure gerar_resultado_aleatorio;