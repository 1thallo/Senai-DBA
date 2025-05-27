use dbgeral;

delimiter $$
create function comparacao(n1 int, n2 int)
returns varchar(250)
deterministic
begin
	declare mensagem varchar(250);
    if n1 > n2 then 
		set mensagem = concat(n1,' > ',n2);
    elseif n1 < n2 then
		set mensagem = concat(n1,' < ',n2);
    else
		set mensagem = concat(n1,' = ',n2);
    end if;
    return mensagem;
end$$
delimiter ;

select comparacao(9,5), comparacao(5,9) , comparacao(9,9);

delimiter $$
create function data_br(dt date)
returns varchar(250)
deterministic
begin
	return date_format(dt,'%d/%m/%Y');
end$$
delimiter ;
-- drop function data_br;
select data_br('1987-07-21');

delimiter $$
create function signo(dt date)
returns varchar(250)
deterministic
begin
	declare msg varchar(250);
    declare dtf varchar(4);
    set dtf = date_format(dt,'%m%d');
	if dtf between '0321' and '0419' then set msg = 'Áries'; end if;
	if dtf between '0420' and '0520' then set msg = 'Touro'; end if;
	if dtf between '0521' and '0620' then set msg = 'Gêmeos'; end if;
	if dtf between '0621' and '0722' then set msg = 'Câncer'; end if;
	if dtf between '0723' and '0822' then set msg = 'Leão'; end if;
	if dtf between '0823' and '0922' then set msg = 'Virgem'; end if;
	if dtf between '0923' and '1022' then set msg = 'Libra'; end if;
	if dtf between '1023' and '1121' then set msg = 'Escorpião'; end if;
	if dtf >= '1122' and dtf <= '1221' then set msg = 'Sagitário'; end if;
	if dtf >= '1222' or dtf <= '0119' then set msg = 'Capricórnio'; end if;
	if dtf between '0120' and '0218' then set msg = 'Aquário'; end if;
	if dtf between '0219' and '0320' then set msg = 'Peixes'; end if;
    return msg;
end$$
delimiter ;
drop function signo;

select round(rand()*(10-9)+9);

delimiter $$
create function valor_aleatorio(min int, max int)
returns int
not deterministic 
reads sql data
begin
	return round(rand()*(max-min)+min);
end$$
delimiter ;
drop function valor_aleatorio;
select valor_aleatorio(5,6);


select 
	nome, 
	dbgeral.data_br(dt_nascimento), 
    dbgeral.signo(dt_nascimento) 
from dbcampeonatobr.jogador;

select 
    dbgeral.signo(dt_nascimento) signo,
    count(*) qt
from dbcampeonatobr.jogador
	group by signo;