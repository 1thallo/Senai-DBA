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

delimiter $$
create trigger depois_update_comanda after update
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
    'update', 
    current_user());
end$$
delimiter ;

delimiter $$
create trigger depois_delete_comanda after delete
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
    old.id_comanda,
	old.numero,
	old.mesa,
	old.nome_cliente,
	old.data_hora_abertura,
	old.data_hora_fechamento, 
    'delete', 
    current_user());
end$$
delimiter ;

create table au_espetaria.produto(
	id int primary key auto_increment,
    id_produto int not null,
	nome varchar(100) not null,
	descricao varchar(250) not null,
	preco decimal(7,2) not null,
	quantidade int,
    operacao varchar(30) not null,
    data_hora datetime default now(),
    usuario_banco varchar(100) not null    
); 

desc espetaria.produto;
delimiter $$
create trigger depois_insert_produto after insert
on espetaria.produto
for each row
begin
	insert into au_espetaria.produto(
    id_produto,
	nome,
	descricao,
	preco,
	quantidade, 
    operacao, 
    usuario_banco)
    values(
    new.id_produto,
	new.nome,
	new.descricao,
	new.preco,
	new.quantidade, 
    'insert', 
    current_user());
end$$
delimiter ;

delimiter $$
create trigger depois_update_produto after update
on espetaria.produto
for each row
begin
	insert into au_espetaria.produto(
    id_produto,
	nome,
	descricao,
	preco,
	quantidade, 
    operacao, 
    usuario_banco)
    values(
    new.id_produto,
	new.nome,
	new.descricao,
	new.preco,
	new.quantidade, 
    'update', 
    current_user());
end$$
delimiter ;

delimiter $$
create trigger depois_delete_produto after delete
on espetaria.produto
for each row
begin
	insert into au_espetaria.produto(
    id_produto,
	nome,
	descricao,
	preco,
	quantidade, 
    operacao, 
    usuario_banco)
    values(
    old.id_produto,
	old.nome,
	old.descricao,
	old.preco,
	old.quantidade, 
    'delete', 
    current_user());
end$$
delimiter ;

create table au_espetaria.pedido(
	id int primary key auto_increment,
    id_pedido int not null,
	data_hora datetime not null,
	id_produto int not null,
	id_comanda int not null,
	quantidade int not null,
    operacao varchar(30) not null,
    usuario_banco varchar(100) not null    
);

desc espetaria.pedido;
delimiter $$
create trigger depois_insert_pedido after insert
on espetaria.pedido
for each row
begin
	insert into au_espetaria.pedido(
    id_pedido,
	data_hora,
	id_produto,
	id_comanda,
	quantidade, 
    operacao, 
    usuario_banco)
    values(
    new.id_pedido,
	new.data_hora,
	new.id_produto,
	new.id_comanda,
    new.quantidade,
    'insert', 
    current_user());
end$$
delimiter ;

delimiter $$
create trigger depois_update_pedido after update
on espetaria.pedido
for each row
begin
	insert into au_espetaria.pedido(
    id_pedido,
	data_hora,
	id_produto,
	id_comanda,
	quantidade, 
    operacao, 
    usuario_banco)
    values(
    new.id_pedido,
	new.data_hora,
	new.id_produto,
	new.id_comanda,
    new.quantidade,
    'update', 
    current_user());
end$$
delimiter ;

delimiter $$
create trigger depois_insert_delete after delete
on espetaria.pedido
for each row
begin
	insert into au_espetaria.pedido(
    id_pedido,
	data_hora,
	id_produto,
	id_comanda,
	quantidade, 
    operacao, 
    usuario_banco)
    values(
    old.id_pedido,
	old.data_hora,
	old.id_produto,
	old.id_comanda,
    old.quantidade,
    'delete', 
    current_user());
end$$
delimiter ;

INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (1,'Chopp Brahma (350ml) (happy hour). Preço válido para as segundas feiras','',4.99,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (2,'Camarão Lêdulce 2P ( happy hour ). preço válido para as segundas feiras.','Camarões servidos sobre arroz cremoso com ervilhas ernpresunto, envolvido ao molho branco. Gratinado comrnqueijos mussarela. Acompanha batata palha.',74.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (3,'Chopp Brahma (360ml) (happy hour)','',6.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (4,'Cozumel ( happy hour )','',9.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (5,'Caipirinha de Limão ( happy hour )','',9.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (6,'GT Clássico ( happy hour )','Gin, limão siciliano, alecrim, tônica',19.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (7,'Soda Italiana ( happy hour )','Maçã verde, tangerina e granadine.',16.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (8,'Cerveja spaten 600ml. (Happy hour)','',9.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (9,'Carpaccio com molho de mostarda (Happy hour)','Lâminas de lagarto com molho de mostarda, rúcula, parmesão ralado - Acompanha torradinhas.',39.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (10,'Cerveja Original (600ML) ( happy hour )','Proibido ser servida em balde com gelo.rnConsumo no local.',9.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (11,'Camarão crocante c/ alho ( happy hour )','Camarões com casca fritos e servidos com alho e limão.',69.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (12,'Croquete de queijo e bacon ( happy hour )','8 unidades.',34.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (13,'Pastéis LêDulce  ( Carne ou queijo) ( happy hour )','8 UNIDADES',34.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (14,'Frango a passarinho ( happy hour )','Cortes de frango fritos, servidos com alho e cebola crispy.',39.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (15,'Filé a milanesa c/ batatas fritas.','',89.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (16,'Isca de tilápia ( happy hour )','Iscas de tilápia empanadas na farinha Panko.rnAcompanha molho da casa.',49.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (17,'Strogonoff de Frango','',34.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (18,'Parmegiana de Frango','',39.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (19,'Parmegiana de Filé','',49.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (20,'Picanha','',69.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (21,'Salmão','',69.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (22,'Filé de Frango','',34.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (23,'Tilápia','',42.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (24,'Picanha Suína','',39.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (25,'Contra-Filé ','',49.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (26,'Ancho ','',49.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (27,'Carne de Sol','',44.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (28,'Camarão caipira','Camarão com bacon e milho ao molho branco. ',47.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (29,'Strogonoff de Camarão','',47.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (30,'Parmegiana de Tilápia','',44.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (31,'Tilápia ao molho de Camarões','',54.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (32,'Picadinho de Filé Mignon','',45.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (33,'Rodízio  R$89,90 por pessoa','',89.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (34,'Carpaccio com molho de mostarda','Lâminas de lagarto com molho de mostarda, rúcula, parmesão ralado - Acompanha torradinhas.',49.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (35,'Small de frios','Tábua de frios com queijo provolone, presunto, salame, tomates cereja, azeitonas e palmito.',49.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (36,'Ceviche de Tilápia ','Cubos de tilápia marinados no suco de limão, suco de laranja , temperados com pimentões coloridos, cebola roxa, pimenta dedo de moça, leite de coco e coentro.',39.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (37,'Escondidinho de camarão ','',39.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (38,'Escondidinho de carne seca','',29.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (39,'Carta fechada  (8 unid)','Pastéis recheados com linguiça mineira, queijo e couve. Servidos com geleia de pimenta.',45.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (40,'Pastéis de Camarão - 8 unidades','Pastéis recheados com creme de camarão ',49.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (41,'Pastéis LêDulce - 8 unidades','Carne ou queijo acompanhado de maionese defumada.',44.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (42,'Arancini de Camarão. (6 unid)','Bolinho de risoto recheado com camarão e queijo. Servidos com molho de goiabada picante. ',59.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (43,'Croquete de queijo e bacon. (8 unid)','Acompanha molho rose.',39.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (44,'Croc Chicken - 8 unidades','Bolinhos de frango crocantes recheados com queijo cremoso - Acompanha molho barbecue.',44.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (45,'Bolinho de Bacalhau','10 unidades de bolinho de bacalhau acompanhado de molho tártaro.',59.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (46,'Isca de Tilápia','Iscas de peixe empanadas, acompanha molho tártaro.',59.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (47,'Isca de Frango','Iscas de Frango empanadas, acompanha molho da casa.',49.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (48,'Torresminho c mandioca ','',49.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (49,'Batata Frita com Cheddar e Bacon','',39.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (50,'Batata Frita com Filé Mignon','Batata frita com 150gr de filé mignon com molho especial de queijo',49.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (51,'Batata Frita Tradicional com Ketchup','',35.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (52,'Camarão Alho e Óleo S/Casca','',89.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (53,'Carne de Sol com Mandioca','',119.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (54,'Picanha com Mandioca','500gr de picanha em bife com mandioca cozida ou frita ',159.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (55,'Costelinha Suína','Baby ribs ao molho barbecue acompanhado de batata rústica.',69.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (56,'Steack angus c/ manteiga de café de paris','Steak angus ( steaks do coração da paleta ) grelhados servidos sob manteiga de ervas. Acompanha arroz a lionese (cebola juliene, ervilha e salsinha) e batatas fritas.',159.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (57,'Filé ao alho com brócolis','Filé mignon grelhado, acompanhado de brócolis, banana empanada e  batatas rústicas.',129.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (58,'Filé ao molho de Gorgonzola','Filé Mignon ao molho de queijo gorgonzola. Acompanha arroz de brócolis e batata frita',139.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (59,'Filet au Poivre','Filé regado ao molho de pimenta acompanhado de arroz piamontese e batatas gratinadas.',129.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (60,'Escalope de filé ao molho de vinho','Escalope de filé grelhado, regado ao molho de vinho. Servido com talharim ao molho Alfredo ( creme de leite, parmesão e raspas de limão siciliano )',149.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (61,'Medalhão de Filé ao molho mostarda','Medalhões de filé mignon envoltos em bacon, regados com molho de mostarda e servidos com arroz branco e batatas recheadas.',139.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (62,'Medalhão de filé ao molho fungi','Medalhões de filé envoltos no bacon, regados ao molho fungi. Servidos com risoto de parmesão.',159.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (63,'Parmê da Lê de Filé','Acompanha arroz e fritas.',99.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (64,'Parmê da Lê de Frango','Acompanha arroz e fritas.',89.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (65,'Frango à Kiev','Frango empanado, recheado com queijo e presunto acompanhadornde arroz cremoso com açafrão e batata chips',89.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (66,'Frango crocante','Filé de frango grelhado em crosta de pão, servido sobre cama de creme de brócolis e gorgonzola. Acompanha espaguete ao molho de sálvia.',99.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (67,'Carne de sol cremosa','Carne de sol desfiada ao molho bechamel sobre arroz de leite com cubos de queijo coalho e gratinada .',89.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (68,'Bacalhau à Moda do Chefe','Bacalhau grelhado servido com a cama de pimentões, purê de batata acompanhado de arroz de alho.',159.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (69,'Salmão ao molho de amêndoas','Salmão grelhado e regado ao molho de amêndoas. Acompanha risoto de parmesão e legumes salteados.',159.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (70,'Peixe a Belle Meunièrie','Peixe grelhado servido com molho à Belle Meunière acompanhado de arroz com brócolis rne purê de batatas.',159.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (71,'Peixe à delícia','Peixe grelhado servido ao molho bechamel, banana frita e gratinado com queijo. acompanha Arroz branco e purê de batatas.',119.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (72,'Pirarucu ao molho de Alcaparras','Pirarucu grelhado ao molho de alcaparras,  servido com arroz de leite de Coco e salada.',109.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (73,'Bacalhau à Gomes de Sá','Lascas de bacalhau refogadas no azeite acrescidos com alho, cebola, azeitonas pretas, batata e ovo.  Acompanha arroz branco.',139.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (74,'Salmão Grelhado','Salmão grelhado com molho de maracujá e mix de legumes grelhados.',179.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (75,'Peixe do sertão','Pescada amarela grelhada, gratinada com queijo coalho e rapadura. Servido com baião de dois cremoso e purê de batatas.',149.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (76,'Peixe grelhado','Pescada amarela grelhada, servida com arroz com brócolis e purê de batatas.',109.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (77,'Anchova assada a moda do chef','Anchova assada, regada ao molho de uvas, alcaparras e champignon. Servido com Arroz de amêndoas e legumes salteados.',139.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (78,'Robalo ao molho de manga','Filé de robalo empanado com gergelim, servido sobre molho de manga. Acompanha arroz a grega e batata chips.',139.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (79,'Moqueca LêDulce de Filé de Peixe','Acompanha arroz branco e pirão.',169.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (80,'Moqueca à brasileira','Moqueca de filé de pescada amarela, com repolho, batata, cenoura e ovos cozidos. Servida com arroz branco e pirão.',149.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (81,'Moqueca de robalo','Moqueca de posta de robalo com pimentões, cebola, tomate, leite do coco e dendê. Acompanha arroz branco e pirão.',139.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (82,'Camarões na abóbora','Camarões refogados com pimentões, cebola, tomate e creme de abóbora. Servido com arroz de brócolis e purê de batatas.',129.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (83,'Camarões no coco','Camarões refogados com tomates, cebola, leite de coco e molho bechamel, servidos no próprio coco. Acompanha Arroz branco e batatas sauté.',129.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (84,'Camarão ao alho poró','Filé de camarão refogado com alho poró, champignon,  vinho branco e molho bechamel. Acompanha arroz branco e batata chips.',99.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (85,'Paella','Camarões, Lula, Peixe, Polvo, Mexilhões com e sem casca.',229.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (86,'Mix de Frutos do Mar Grelhados','Mexilhão sem casca, Camarões, Lula, Cauda de Lagosta, Filé de peixe, Polvo, Mexilhões com casca, Tomate. Acompanha arroz apimentado.',249.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (87,'Flat iron','O flat iron vem da região do ombro do boi, também conhecida como paleta, e é conhecido pela sua maciez e sabor incrível.rn*Paleta fina, sem gordura*rnEscolha 2 guarnições.',59.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (88,'Carne de Sol','',49.95,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (89,'Arroz Biro Biro','',9.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (90,'Arroz Piamontese','',9.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (91,'Farofa de Ovos','',9.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (92,'Feijão Tropeiro','',9.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (93,'Feijão Carioca','',9.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (94,'Mandioca','',9.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (95,'Batata Frita','',9.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (96,'Purê de Batatas','',9.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (97,'Legumes Salteados','',9.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (98,'Salada Juliana','Alface americana, cenoura, tomate, palmito, batata palha, queijornparmesão e molho de mostarda, maionese e mel.',29.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (99,'Salada LêDulce','Folhas de rúcula, alface americana, lascas de frango defumado, nozes e molho ‘’da chefe’’ com azeite, mostarda, limão, sal e parmesão ralado.',34.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (100,'Salada tropical com camarões','Mix de folhas, cenoura, tomate cereja, abacaxi grelhado, castanha de caju, camarões grelhados e molho de mostarda e mel.',45.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (101,'Talharim LêDulce','Talharim a carbonara. rnrnAlérgicos: contém ovo e bacon. ',39.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (102,'Espaguete com camarões ao sugo','',49.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (103,'Espaguete com camarões ao molho branco','',49.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (104,'Risoto de Filé','',49.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (105,'Risoto de Camarão','',59.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (106,'Risoto de carne de sol','',45.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (107,'Polvo ao molho pesto c/ risoto negro','Tentáculos de polvo grelhados e regados ao molho pesto de manjericão. Acompanha risoto negro de parmesão.',89.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (108,'Risoto camarão ao alho poró','',59.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (109,'LêDulcinha de Frango','Filezinho de frango empanado, arroz branco, feijão carioca e fritas.',29.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (110,'LêDulcinha de Carne','Filezinho de mignon, arroz branco, feijão carioca e fritas)',29.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (111,'LêDulcinha de Massa','Espaguetinho ao molho sugo com carne moída.',29.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (112,'ESPAGUETE DE ABOBRINHA AO MOLHO SUGO DE CASA E CRÓTONS DE CARNE DE SOJA','',29.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (113,'LASANHA DE BERINJELA COM PALMITO','',29.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (114,'Churros com Doce de Leite','',29.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (115,'Cocada LêDulce com sorvete','',24.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (116,'Cheesecake de frutas vermelhas','Torta de queijo e calda de frutas vermelhas.',29.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (117,'Pudim','Pudim de leite condensado',14.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (118,'Suspiro Lêdulce','Creme de ninho em camadas com geleia de morango e suspiros.',29.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (119,'Petit Gatêau de Chocolate','Bolinho cremoso de chocolate acompanhado de sorvete de creme.',24.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (120,'Baked gelaska','Sorvete de creme recheado com geleia de morango e merengue suíço flamejado no topo.',25.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (121,'Refrigerantes','',7.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (122,'Suco Detox','Couve com Laranja e Gengibre (500ML)rnOurnAbacaxi, Água de coco e Hortelã (500ML',15.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (123,'Soda Italiana','Frutas Vermelhas, Maçã Verde ou Tangerina',22.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (124,'Água com gás','',7.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (125,'Água sem gás','',6.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (126,'Água de Côco','',9.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (127,'Água Tônica','',7.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (128,'Schweppes Citrus','',7.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (129,'Café Expresso','',5.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (130,'H2O / H2O Limoneto','',9.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (131,'Amstel','',14.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (132,'Antárctica Original','',14.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (133,'Brahma Duplo Malte','',14.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (134,'Budweiser','',14.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (135,'Stella Artois','',15.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (136,'Heineken','',17.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (137,'Chopp Brahma (350ML)','',10.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (138,'Cervejas 0,00 Álcool','',11.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (139,'Preparo do Cozumel','',10.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (140,'Limão Espremido','',2.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (141,'Budweiser','',11.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (142,'Corona Extra','',12.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (143,'Heineken','',11.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (144,'Stella Artois','',11.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (145,'Pina Colada','Rum Bacardi, purê de côco e suco de abacaxi',23.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (146,'Mojito Clássico','Rum Bacardi xarope simples, hortelã, suco de limão e água com gás',22.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (147,'Cozumel','375 ml cerveja ou chopp, suco de limão, gelo e sal na borda do copo',21.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (148,'Cuervo Margarita','Tequila, licor Cointreau , suco de limão',23.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (149,'Aperol Spritz','Aperol, Espumante, Laranja,bahia, água com gás',27.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (150,'Refresco','Monin Gengibre, suco limão, Monin maça verde,rnAgua com gás, rodelas limão siciliano',19.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (151,'GT Red','Monin cranberry, hibisco desidratado, limão siciliano, tônica',19.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (152,'Verão','Monin chá verde, Monin cranberry, rodela limão taiti, água com rngás',19.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (153,'Caipirinha','Limão, Abacaxi, Abacaxi c/ Hortelã, Frutas Vermelhas, Morango, Maracujá, Cítrico*, Cajú*, Cajá*, Jabuticaba*rnrn*Verificar Disponibilidade',19.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (154,'Sake','',19.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (155,'Arco Íris','Sorvete morango, amora, leite, calda blue,rnleite condensado',19.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (156,'Negroni','Gin, vermouth rosso, campari e laranja',27.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (157,'TriLêgal','Tequila, cointreau, limão, cranberry, curaçau blue e maçã verde.',25.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (158,'Clericot','Espumante rosê, suco de laranja, cranberry, morango e maçã verde.',24.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (159,'Snow','Tequila, suco de limão, curaçau blue e licor fino de pêssego.',25.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (160,'Rose','Rum, suco de limão e xarope de toranja.',24.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (161,'Lemon ','Energético monster ice tea lemon, xarope de maçã verde, sumo de limão, alecrim.rnrnrnrn',30.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (162,'Peach','Energético monster ice tea peach, melaço de cana, sumo de limão',24.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (163,'Caipirinha do sertão ','Caipirinha feita com cachaça 51, limão e rapadura.',22.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (164,'Campari','',11.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (165,'Martini Bianco','',11.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (166,'Rum Bacardi','',11.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (167,'Tequilo Jose Cuervo Especial GOLD','',18.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (168,'Tequilo Jose Cuervo Especial SILVER','',18.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (169,'Cachaça São Francisco','',9.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (170,'Cachaça Seleta','',9.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (171,'Cachaça de Banana','',10.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (172,'Cachaça Germana','',14.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (173,'Cachaça Vale Verde','',13.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (174,'Cachaça Sagatiba','',9.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (175,'Cachaça ParaTudo','',7.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (176,'Chivas Regal','',22.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (177,'Jack Daniel\'s','',22.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (178,'Johnnie Walker Black Label','',24.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (179,'Johnnie Walker Red Label','',19.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (180,'Old Parr','',22.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (181,'Absolut','',19.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (182,'Smirnoff','',14.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (183,'Tanqueray','',20.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (184,'Amarula','',19.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (185,'Cointreau','',19.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (186,'Licor 43','',19.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (187,'Red Bull','',15.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (188,'Combo Smirnoff + 6 red bull','',179.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (189,'Combo Absolut + 6 red bull','',249.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (190,'Combo Tanqueray + 6 red bull','',299.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (191,'Combo Chivas + 6 red bull','',349.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (192,'Combo Old par + 6 red bull','',349.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (193,'Combo Jack Daniel\'s + 6 red bull','',349.90,50);
INSERT INTO `produto` (`id_produto`,`nome`,`descricao`,`preco`,`quantidade`) VALUES (194,'Combo Red Label + 6 red bull','',269.90,50);


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

select * from au_espetaria.pedido;
select * from au_espetaria.comanda;
select * from au_espetaria.produto;