use dbgeral;
create table usuario(
	id_usuario int primary key auto_increment,
    nome varchar(200) not null,
    email varchar(200) not null
);

delimiter $$
create procedure incluir_usuario(v_nome varchar(200), v_email varchar(200))
begin
	insert into usuario(nome, email) values (v_nome, v_email);
end$$
delimiter ;

call incluir_usuario('luiz','luiz@gmail.com');
call incluir_usuario('felipe','felipe@gmail.com');
call incluir_usuario('chapolin','chapolin@gmail.com');
select * from usuario;

delimiter $$
create procedure contar_usuario(out qt int)
begin
	select count(*) into qt from usuario;
end$$
delimiter ;

call contar_usuario(@total);
select @total;-- mostra o valor retornado pela procedure
call incluir_usuario('seu madruga','donramon@gmail.com');
call contar_usuario(@total2);
select @total, @total2;

delimiter $$
create procedure atualizar_email(id int, novo_email varchar(200))
begin
	if exists (select 1 from usuario where id_usuario = id) then
		update usuario set email = novo_email where id_usuario = id;
    else 
		signal sqlstate '45000' set message_text = 'Usuário não encontrado';
    end if;
end$$
delimiter ;
call atualizar_email(2,'luiz.maia@gmail.com');
select * from usuario;

delimiter $$
create procedure exemplo_while(v1 int)
begin
	declare contador int default 1;
    while contador <= v1 do
		select concat('Contador: ',contador);
        set contador = contador + 1;
    end while;
end$$
delimiter ;
call exemplo_while(10);
-- drop procedure exemplo_while;

delimiter $$
create procedure dbcampeonatobr.prc_rodada(rdd int)
begin 
drop temporary table if exists tb_rodada;
create temporary table tb_rodada as
with 
mandante as (
select 
	rodada, -- incluido
    id_mandante id_time,
    gol_mandante gm,
    gol_visitante gc
from dbcampeonatobr.partida
),
visitante as (
select 
	rodada, -- incluido
	id_visitante id_time,
    gol_visitante gm,
    gol_mandante gc
from dbcampeonatobr.partida
),
jogos as (
select * from mandante
union all
select * from visitante
)
select 
	t.id_time,
    sigla,
    nome,
    sum(case when gm > gc then 3 when gm = gc then 1 else 0 end) pts,
    count(*) qtj,
    count(case when gm > gc then 1 end) vit,
    count(case when gm < gc then 1 end) der,
    count(case when gm = gc then 1 end) emp,
    sum(gm) gm,
    sum(gc) gc,
    sum(gm-gc) sg
from jogos j 
inner join dbcampeonatobr.time t on j.id_time = t.id_time
where rodada <= rdd -- incluido
group by 
	t.id_time,
    sigla,
    nome
order by pts desc, vit desc, sg desc, gm desc;
end$$
delimiter ;

call dbcampeonatobr.prc_rodada(10);