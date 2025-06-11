drop database if exists espetaria;
create database espetaria;
use espetaria;

create table produto(
	id_produto int primary key auto_increment,
	nome varchar(100) not null,
	descricao varchar(250) not null,
	preco decimal(7,2) not null,
	quantidade int
); 

create table comanda(
	id_comanda int primary key auto_increment,
	numero int not null,
	mesa int not null,
	nome_cliente varchar(150),
	data_hora_abertura datetime not null,
	data_hora_fechamento datetime
);

create table pedido(
	id_pedido int primary key auto_increment,
	data_hora datetime not null,
	id_produto int not null,
	id_comanda int not null,
	quantidade int not null,
	foreign key (id_produto) references produto(id_produto),
	foreign key (id_comanda) references comanda(id_comanda)
);

insert into espetaria.comanda(numero,mesa,data_hora_abertura)
values (floor(rand()*60)+1,floor(rand()*60)+1,now());

set @max_produto = (select count(*) from espetaria.produto);
set @max_comanda = (select count(*) from espetaria.comanda);

select @max_produto, @max_comanda;

insert into espetaria.pedido(data_hora,id_produto,id_comanda,quantidade)
values(now(),floor(rand()*@max_produto)+1,floor(rand()*@max_comanda)+1,floor(rand()*5)+1);

select * from espetaria.pedido;
select * from espetaria.comanda;
select * from espetaria.produto;

drop database if exists au_espetaria;
create database au_espetaria;

create table au_espetaria.comanda(
	id int primary key auto_increment,
    id_comanda int not null,
	numero int not null,
	mesa int not null,
	nome_cliente varchar(150),
	data_hora_abertura datetime not null,
	data_hora_fechamento datetime,
    operacao varchar(30) not null,
    data_hora datetime default now(),
    usuario_banco varchar(100) not null
);
desc espetaria.comanda;
delimiter $$
create trigger depois_insert_comanda after insert
on espetaria.comanda
for each row
begin
	insert into au_espetaria.comanda(
    id_comanda,
	numero,
	mesa,
	nome_cliente,
	data_hora_abertura,
	data_hora_fechamento, 
    operacao, 
    usuario_banco)
    values(
    new.id_comanda,
	new.numero,
	new.mesa,
	new.nome_cliente,
	new.data_hora_abertura,
	new.data_hora_fechamento, 
    'insert', 
    current_user());
end$$
delimiter ;
