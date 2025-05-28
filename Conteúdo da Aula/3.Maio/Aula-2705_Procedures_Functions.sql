-- crie uma function para formatar o cpf XXX.XXX.XXX-XX
set @cpf = '01463762771';
select concat(substr(@cpf,1,3),'.',substr(@cpf,4,3),'.',substr(@cpf,7,3),'-',substr(@cpf,10,2));

delimiter $$
create function dbgeral.formatar_cpf(cpf varchar(11))
returns varchar(14)
deterministic
begin
	return concat(substr(cpf,1,3),'.',substr(cpf,4,3),'.',substr(cpf,7,3),'-',substr(cpf,10,2));
end$$
delimiter ;
select dbgeral.formatar_cpf(dbgeral.cpf_valido());


-- altere a tabela jogador e inclua uma nova coluna cpf de 14 digitos varchar

use dbcampeonatobr;
alter table dbcampeonatobr.jogador add column cpf varchar(14);
select * from dbcampeonatobr.jogador ;

delimiter $$
create procedure update_cpf_jogador()
begin
	declare cont int default 1;
    declare qt_jogador int;
    set qt_jogador = (select count(*) from dbcampeonatobr.jogador);
    while cont <= qt_jogador do
		update dbcampeonatobr.jogador 
        set cpf = dbgeral.formatar_cpf(dbgeral.cpf_valido())
        where id_jogador = cont;
		set cont = cont + 1;
    end while;
end$$
delimiter ;

call update_cpf_jogador();

update dbcampeonatobr.jogador 
set cpf = dbgeral.formatar_cpf(dbgeral.cpf_valido())
where id_jogador > 0;

select * from dbcampeonatobr.jogador;