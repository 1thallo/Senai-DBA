drop database if exists dbgeral;
create database dbgeral;
use dbgeral;

delimiter $$
create function quadrado(numero int)
returns int 
deterministic 
begin
	declare resultado int;
    set resultado = numero * numero;
    return resultado;
end$$
delimiter ;

select quadrado(5);

delimiter $$
create function bem_vindo(nome varchar(200), genero char(1))
returns varchar(250)
deterministic
begin
	declare mensagem varchar(250);
    if genero = 'm' then 
		set mensagem = concat('Bem vindo ',nome);
    elseif genero = 'f' then
		set mensagem = concat('Bem vinda ',nome);
    else
		set mensagem = concat('Bem vindes ',nome);
    end if;
    return mensagem;
end$$
delimiter ;
drop function bem_vindo;
select bem_vindo('luiz','x');

delimiter $$
create function parouimpar(numero int)
returns varchar(10)
deterministic
begin
	if mod(numero,2) = 0 then
		return 'Par';
	else 
		return 'Impar';
	end if;
end$$
delimiter ;
-- drop function parouimpar;
select parouimpar(7);

delimiter $$
create function anobissexto(numero int)
returns varchar(100)
deterministic
begin
	if mod(numero,4) = 0 then
		return 'Sim ano bissexto';
	else 
		return 'Não é ano bissexto';
	end if;
end$$
delimiter ;
drop function anobissexto;
select anobissexto(2023);

delimiter $$
create function aleatorio()
returns int
not deterministic
reads sql data
begin
	declare valor int;
    set valor = floor((rand()*1000)+1);
    return valor;
end$$
delimiter ;
-- drop function aleatorio;
select aleatorio();