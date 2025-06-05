use dbcampeonatobr;
select 
replace(replace(replace(replace(
'insert into evento(minuto,descricao,id_partida,id_jogador) values (v1,''v2'',v3,v4);'
,'v1',minuto),'v2',descricao),'v3',p.id_partida),'v4',id_jogador)
from evento e inner join 
partida p on e.id_partida = p.id_partida
where rodada = 38 order by id_evento;

delete from evento where id_partida >= 371;
SET SQL_SAFE_UPDATES=0;
update partida set gol_mandante = null , gol_visitante = null where rodada = 38;

drop trigger if exists depois_insert_evento;
delimiter $$
create trigger depois_insert_evento after insert
on evento
for each row
begin
	declare idTime int;
    -- verificar se já existe gol na partida senão fazer update de 0x0
    if (select gol_mandante from partida where id_partida = new.id_partida) is null then 
		update partida set gol_mandante = 0, gol_visitante = 0 where id_partida = new.id_partida;
    end if;
	-- verificar se teve gol favoravel do jogador
    if new.descricao in ('Gol (Pênalti)','Gol (Gol de campo)','Gol (Gol Contra)') then
		set idTime = (select id_time from jogador where id_jogador = new.id_jogador);
        if new.descricao = 'Gol (Gol Contra)' then 
			set idTime = 
            (select case when id_mandante = idTime then id_visitante else id_mandante end
            from partida where id_partida = new.id_partida);
		end if;
    end if;
    -- update na quantidade de gols
    if idTime is not null then -- só 1 dos 2 updates será executado!!
		update partida set gol_mandante = gol_mandante + 1 
        where id_partida = new.id_partida and id_mandante = idTime;
        update partida set gol_visitante = gol_visitante + 1
        where id_partida = new.id_partida and id_visitante = idTime;
    end if;
end$$
delimiter ;

select * from evento where id_partida >= 371;
select * from partida where id_partida >= 371;
insert into evento(minuto,descricao,id_partida,id_jogador) values (25,'Cartão Amarelo',371,371);
insert into evento(minuto,descricao,id_partida,id_jogador) values (45,'Gol (Pênalti)',371,280);
-- e quando for "Gol (Gol Contra)" ?????
insert into evento(minuto,descricao,id_partida,id_jogador) values (60,'Gol (Gol Contra)',371,280);