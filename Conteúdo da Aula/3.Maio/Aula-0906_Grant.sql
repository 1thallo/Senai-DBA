-- mysql -u root -p -h localhost

create user 'luiz'@'%' identified by 'senai@123';

grant select, insert, update, delete on espetaria.* to 'luiz'@'%';
grant select, insert, update, delete on dbcampeonatobr.* to 'luiz'@'%';

revoke select, insert, update, delete on espetaria.* from 'luiz'@'%';
revoke select, insert, update, delete on dbcampeonatobr.* from 'luiz'@'%';

grant select, insert, update, delete on espetaria.* to 'luiz'@'%';
grant select on au_espetaria.* to 'luiz'@'%';