use dbgeral;

select * from usuario;
set @tx = 'uma VEZ fLamenGo';
set @retorno = '';
set @tx = lower(@tx);
set @i = instr(@tx,' ');
set @txf = substr(@tx,1,@i);
set @tx = trim(substr(@tx,@i));
set @retorno = concat(@retorno,concat(upper(substr(@txf,1,1)),substr(@txf,2)));
select concat(@retorno,concat(upper(substr(@tx,1,1)),substr(@tx,2))), @i;

drop function if exists PrimeiraLetraPalavra;
delimiter $$
create function PrimeiraLetraPalavra(tx varchar(250))
returns varchar(250)
deterministic 
begin
	declare retorno varchar(250) default '';
    declare txf varchar(250) default '';
    declare i int;
    set tx = lower(tx);
    -- set i = instr(tx,' '); remover 
    while instr(tx,' ') > 0 do
		set i = instr(tx,' ');
		set txf = substr(tx,1,i);
        set tx = trim(substr(tx,i));
        set retorno = concat(retorno,concat(upper(substr(txf,1,1)),substr(txf,2)));
    end while;
    set retorno = concat(retorno,concat(upper(substr(tx,1,1)),substr(tx,2)));
    return retorno;
end$$
delimiter ;
select PrimeiraLetraPalavra('qual quer palavra a primeira letra vai ficar em maiuscula');
