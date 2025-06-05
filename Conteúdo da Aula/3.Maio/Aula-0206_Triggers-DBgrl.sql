use dbgeral;

select length(email) - length(replace(email,'@','')), email from usuario;


delimiter $$
create trigger antes_insert_usuario before insert
on usuario
for each row
begin
	if not (length(new.email) - length(replace(new.email,'@',''))) = 1 then
		signal sqlstate '45000'
        set message_text = 'E-mail inválido.';
    end if;
    set new.email = lower(new.email);
end$$
delimiter ;
insert into usuario(nome, email) values('luiz','');

delimiter $$
create trigger antes_update_usuario before update
on usuario
for each row
begin
	if not (length(new.email) - length(replace(new.email,'@',''))) = 1 then
		signal sqlstate '45000'
        set message_text = 'E-mail inválido.';
    end if;
	set new.email = lower(new.email);
end$$
delimiter ;
update usuario set email = 'luizgmail.com' where id_usuario = 1;


-- criar uma tabela de auditoria
create table au_usuario(
	id int primary key auto_increment,
    id_usuario int not null,
    nome varchar(200),
    email varchar(200),
    operacao varchar(30) not null,
    data_hora datetime default now(),
    usuario_banco varchar(100) not null
);

delimiter $$
create trigger depois_insert_usuario after insert
on usuario
for each row
begin
	insert into au_usuario(id_usuario, nome, email, operacao, usuario_banco)
    values(new.id_usuario, new.nome, new.email, 'insert', current_user());
end$$
delimiter ;

insert into usuario(nome, email) values('Luiz Felipe','luiz@gmail.com');

delimiter $$
create trigger depois_update_usuario after update
on usuario
for each row
begin
	insert into au_usuario(id_usuario, nome, email, operacao, usuario_banco)
    values(new.id_usuario, new.nome, new.email, 'update', current_user());
end$$
delimiter ;

update usuario set nome = 'Felipe', email = 'felipe@gmail.com' where id_usuario = 7;
select * from au_usuario;

set @qt = (select count(*) from locadora.cliente);
set @id = round(rand()*@qt)+1;
set @nome = (select concat(primeiro_nome,' ',ultimo_nome) from locadora.cliente where cliente_id = @id);
set @email = (select email from locadora.cliente where cliente_id = @id);
set @qtu = (select count(*) from dbgeral.usuario);
set @idu = round(rand()*@qtu)+1;
update dbgeral.usuario set nome = @nome, email = @email where id_usuario = @idu;
insert into dbgeral.usuario(nome, email) values (@nome, @email);

delimiter $$
create trigger depois_delete_usuario after delete
on usuario
for each row
begin
	insert into au_usuario(id_usuario, nome, email, operacao, usuario_banco)
    values(old.id_usuario, old.nome, old.email, 'delete', current_user());
end$$
delimiter ;
set @idu = round(rand()*@qtu)+1;
delete from dbgeral.usuario where id_usuario = @idu;