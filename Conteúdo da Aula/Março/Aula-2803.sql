use biblioteca;
-- tabela autor
CREATE TABLE `autor` (
   `codigo` int NOT NULL,
   `nome` varchar(100) NOT NULL,
   `nacionalidade` varchar(100) NOT NULL
 );
 
 -- tabela categoria
 
 create table categoria(
 codigo int,
 descricao varchar(100) not null,
 constraint PK_categoria primary key(codigo)
 );
 desc categoria;
 drop table categoria;
 
 create table livro(
 isbn varchar(13) not null,
 titulo varchar(100) not null,
 ano int not null,
 editora varchar(100) not null,
 cocategoria int not null,
 primary key(isbn),
 foreign key(cocategoria) references categoria(codigo)
 );
 
 desc livro;
 drop table livro;
 
 create table autor_livro(
 isbn varchar(13),
 coautor int,
 constraint PK_autorlivro primary key(isbn, coautor),
 constraint FK_autorlivro_livro foreign key(isbn) references livro(isbn),
 constraint FK_autorlivro_autor foreign key(coautor) references autor(codigo));
 
 desc autor_livro;
 drop table autor_livro;
 
 show create table autor_livro;
 
 alter table livro add constraint CHK_livro_ano check (ano >= 1990 and ano <= year(sysdate()));
 
 show create table livro;