use dbgeral;

select * from usuario;

set autocommit = 0;
start transaction;
insert into usuario(nome, email) values('Bill Clinton','bill@gmail.com');
rollback; -- desfazer 
commit; -- confirmar

insert into usuario(nome, email) values('Pedro','pedro@gmail.com');
savepoint sp1; -- Criamos um ponto a ser salvo
insert into usuario(nome, email) values('Laura','laura@gmail.com');
rollback to sp1; -- Apenas 'Laura' será desfeita, 'Pedro' permanece
commit;

-- rollback não funciona para DDL
create table tb01(col int);
desc tb01;
rollback;

set autocommit = 1;