use dbgeral;

create table regiao(
	id int primary key,
    sigla varchar(2) not null,
    nome varchar(100) not null
);

select * from regiao;

create table estado(
	id int primary key,
    sigla varchar(2) not null,
    nome varchar(100) not null,
    regiao_id int not null,
    foreign key (regiao_id) references regiao(id)
);

select * from estado;

select * from usuario;
insert into usuario(nome, email) values ('Olho D''agua','@');
insert into usuario(nome, email) values ('Olho D\'agua','@');
insert into usuario(nome, email) values ("Olho D'agua",'@');

create table municipio(
	id int primary key,
    nome varchar(100) not null,
    estado_id int not null,
    foreign key (estado_id) references estado(id)
);

select count(*) from municipio;
select * from municipio order by 1 desc;