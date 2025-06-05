set @idade = 67;
set @fx = (select @idade div 10);
select concat('Entre ',@fx,'0 e ',@fx,'9 anos');
select replace('Entre X0 e X9 anos','X',@fx);

-- argumentos da procedure
set @sgm = 'GER';
set @golm = 0;
set @golv = 3;
set @sgv = 'COR';
-- begin -- dentro da procedure 
set @idmandante = (select id_time from dbcampeonatobr.time where sigla = @sgm);
set @idvisitante = (select id_time from dbcampeonatobr.time where sigla = @sgv);
set @idpartida = (select id_partida from dbcampeonatobr.partida 
					where id_mandante = @idmandante and id_visitante = @idvisitante);
update dbcampeonatobr.partida set gol_mandante = @golm, gol_visitante = @golv 
where id_partida = @idpartida;
-- end$$
select * from dbcampeonatobr.partida where id_partida = @idpartida;