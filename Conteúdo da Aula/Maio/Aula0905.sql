-- lista de functions no MYSQL

-- 1. functions de string
-- ASCII(): Retorna o código ASCII do primeiro caractere
select ascii('luiz');
select ascii('l');

-- CHAR_LENGTH() / LENGTH: Retorna o tamanho de uma string
select char_length('senai'), length('senai');

-- CONCAT(): Concatenar strings
select concat('senai','@','123');

-- CONCAT_WS(): Concatenar strings com separador
select concat_ws('*','senai','@','123');

-- INSTR(): Retorna a posição da primeira ocorrência de uma substring
select instr('senai','na');

-- LEFT() / RIGHT(): Retorna os primeiros ou últimos caracteres
select left('senai',2), right('senai',2);

-- LOWER() / UPPER(): Converte string para minúsculo ou maiúsculo
select lower('seNAi'), upper('seNAi');

-- LPAD() / RPAD(): Preenche uma string no início ou fim
select lpad('Oi',10,'.'), rpad('Oi',10,'.');

-- LTRIM() / RTRIM(): Remove espaços da esquerda ou da direita
-- TRIM(): Remove espaços das extremidades
select ltrim('    xx   '), rtrim('    xx   '), trim('    xx   ');

-- MID() / SUBTRING() / SUBSTR(): Extrai parte de uma string
select 
	mid('1234-67-90',1,4),
    substr('1234-67-90',6,2),
    substring('1234-67-90',9,2)
    ;

-- REPLACE(): Substitui parte de uma string
select replace('seai','ea','ena');

-- REVERSE(): Inverte a string
select reverse('987654321');

-- SPACE(): Retorna uma quantidade X de espaços
select concat('A',space(23),'Z');

-- 2. functions numéricas
-- ABS(): Retorna o valor sempre positivo
select abs(-89), abs(89);

-- CEIL() / CEILING(): Arredonda sempre pra cima
select ceil(2.9), ceiling(2.00001);
select ceil(-2.9), ceiling(-2.00001);

-- FLOOR(): Arredonda sempre para baixo
select floor(2.9), floor(2.00001);
select floor(-2.9), floor(-2.00001);

-- ROUND(): Arredonda de *.0 até *.4 para baixo e *.5 até *.9 para cima
select round(2.4) , round(2.5);
select round(2.5555,2);

-- Operações matemáticas
select (5+9)*7/(7-4);

-- DIV: Realiza a divisão inteira
select 10 DIV 8, 10/8, floor(10/8); 

-- MOD(): Retorna o resto da divisão
select mod(10,8);
select mod(10,2), mod(11,2); -- se resto = 0 par se resto = 1 impar

select 6257/57;
select 6257 div 57 , mod(6257,57);

-- PI(): Retorna o valor de pi
select pi();
select round(pi(),20);

-- POW() / POWER(): Eleva um número à potencia
select pow(4,2), power(4,2);

-- RAND(): Retorna um número aleatório
select rand();
select floor(rand()*11); -- aleatório de 0 até 10 
select floor(rand()*60)+1; -- aleatório de 1 até 60

-- SIGN(): Retorna o sinal de um número (-1, 0, 1)
select sign(-87), sign(0), sign(2025);

-- SQRT(): Calcula a raiz quadrada
select sqrt(64), sqrt(49), sqrt(36), sqrt(25), sqrt(16), sqrt(9), sqrt(4);

-- TRUNCATE(): trunca/corta um número para o número especificado de casa decimais
select truncate(1.8,0), truncate(1.4,0), truncate(1.6665,2);
select round(1.8,0), round(1.4,0);
select ceil(1.8), ceil(1.4);
select floor(1.8), floor(1.4);

-- 3. functions de datas
-- ADDDATE() / DATE_ADD(): Adiciona um intervalo a uma data
select adddate('2025-05-07',48);
select adddate(curdate(),48);

-- CURDATE() / CURRENT_DATE(): Retorna a data atual
select curdate(), current_date();

-- CURTIME(): Retorna a hora atual
select curtime();

-- CURRENT_TIMESTAMP(): Retorna a data e hora atual
select current_timestamp();

-- DATEDIFF(): Retorna a diferença em dias entre 2 datas
select datediff('2025-06-24','2025-05-07');
select datediff(curdate(),'2025-01-01');
select datediff('2025-12-31',curdate());
-- quantos dias de vida você já passou??
select datediff(curdate(),'1987-07-21');
-- calcular idade atual
select datediff(curdate(),'1987-07-21') div 365.25;

-- DATE_FORMAT(): formata uma data para um formato especificado
select date_format(curdate(),'%d/%m/%Y');
select date_format(curdate(),'%Y');
select date_format(curdate(),'%y');

/*
Especificador
%Y Ano com 4 dígitos 2025
%y Ano com 2 dígitos 25
%m Mês (2 dígitos) 01 a 12
%d Dia do mês (2 dígitos) 01 a 31
%H Hora (24h) 00 a 23
%i Minutos 00 a 59
%s Segundos 00 a 59
*/

-- https://dev.mysql.com/doc/refman/8.4/en/date-and-time-functions.html#function_date-format

-- DAY(), MONTH(), YEAR(): Retornar dia, mês, ano
select day(curdate()), month(curdate()), year(curdate());

-- DAYNAME(), MONTHNAME(): Retorna o nome do dia/mês
set lc_time_names=pt_BR; -- modifica o idioma para pt_BR
select dayname(curdate()), monthname(curdate());

-- DAYOFMONTH(), DAYOFWEEK(), DAYOFYEAR(): Retorna o dia do mês/semana/ano
select dayofmonth(curdate()), dayofweek(curdate()), dayofyear(curdate());

-- STR_TO_DATE(): Converte uma string em data
select str_to_date('21/07/1987','%d/%m/%Y');

-- NOW(): Retorna a data e hora atual
select now();

-- 4. Funções de controle de fluxo 
-- IF(): Condicional simples
select if(5=4,'sim','não');
select if(5=5,'sim','não');

set @nota = 5; -- declaração de variavel
select if(@nota >= 7, 'Aprovado','Reprovado');
select if(@nota >= 7, 'Aprovado',if(@nota >= 4,'Recuperação','Reprovado'));

-- CASE: Estrutura de múltipla condições
select case when 'A' = 'B' then 'sim' else 'não' end;
select case when @nota >= 7 then 'Aprovado'
			when @nota >= 4 then 'Recuperação'
			else 'Reprovado' end "status", concat('Nota = ',@nota) "Nota";

-- IFNULL(): Substitui NULL por um valor
select ifnull(null,0), ifnull(null,'X1');

-- NULLIF(): Retorna NULL se os valores forem iguais
select nullif('a1','a2'), nullif('a0','a0');

set @vl1 = 'a01';
set @vl2 = 'a00';
select case when @vl1 = @vl2 then null else @vl1 end;

-- 5. Funções de Encryption e Hashing
-- MD5(): Retorna o hash MD5
select md5('senha');

-- SHA1(), SHA2(): Retorna SHA
select sha1('abc');
select sha2('abc',224);
select sha2('abc',256);
select sha2('abc',512);

-- AES_ENCRYPT(), AES_DECRYPT(): Criptografia AES
set block_encryption_mode = 'aes-256-cbc';
set @key_str = SHA2('frase secreta',512);
set @init_vector = random_bytes(16);
set @crypt_str = aes_encrypt('texto para criptografia',@key_str,@init_vector);
select @crypt_str;
select cast(aes_decrypt(@crypt_str,@key_str,@init_vector) as char);

-- 6. Funções variadas
-- VERSION(): Retorna a versão do mysql
select version();

-- DATABASE(): Retorna a base de dados atual
use locadora;
use dbcampeonatobr;
select database();

-- USER() / CURRENT_USER(): Retorna o usuário conectado
select user(), current_user();

-- UUID(): Gera um identificador único
select uuid();

-- 7. Funções de agregação
-- COUNT(): Conta a quantidade de registros
select count(*) from locadora.pais;

-- MAX(), MIN(): Retorna o maior, menor valor
select max(valor), min(valor) from locadora.pagamento;

-- SUM(): Soma os valores
select sum(valor) from locadora.pagamento;

-- GROUP_CONCAT(): Concatena valores de uma coluna em um único resultado, separados por virgula
select p.pais, group_concat(c.cidade), count(*) qt from locadora.pais p 
inner join locadora.cidade c on p.pais_id = c.pais_id
group by p.pais;

-- OVER (PARTITION BY) cláusula determina o particionamento e a ordenação de um conjunto de linhas
select cliente_id, primeiro_nome, ultimo_nome, data_de_aluguel, titulo, qt from (
select 
	c.cliente_id,
    c.primeiro_nome,
    c.ultimo_nome,
    a.data_de_aluguel,
    f.titulo,
    count(*) over(partition by c.cliente_id) qt,
    row_number() over(partition by c.cliente_id order by data_de_aluguel desc) recente
from locadora.cliente c
inner join locadora.aluguel a on c.cliente_id = a.cliente_id
inner join locadora.inventario i on a.inventario_id = i.inventario_id
inner join locadora.filme f on i.filme_id = f.filme_id
order by c.cliente_id, data_de_aluguel desc) tb
where recente = 1;


-- A cláusula WITH é usada para definir tabelas temporárias ou conjuntos de resultados
-- Pode ser conhecida por Common Table Expression (CTE)

with 
mandante as (
select 
	id_mandante id_time,
    gol_mandante gm,
    gol_visitante gc
from dbcampeonatobr.partida
),
visitante as (
select 
	id_visitante id_time,
    gol_visitante gm,
    gol_mandante gc
from dbcampeonatobr.partida
),
jogos as (
select * from mandante
union all
select * from visitante
)
select 
	t.id_time,
    sigla,
    nome,
    sum(case when gm > gc then 3 when gm = gc then 1 else 0 end) pts,
    count(*) qtj,
    count(case when gm > gc then 1 end) vit,
    count(case when gm < gc then 1 end) der,
    count(case when gm = gc then 1 end) emp,
    sum(gm) gm,
    sum(gc) gc,
    sum(gm-gc) sg
from jogos j 
inner join dbcampeonatobr.time t on j.id_time = t.id_time
group by 
	t.id_time,
    sigla,
    nome
order by pts desc, vit desc, sg desc, gm desc
;
select * from dbcampeonatobr.vw_classificacao;

-- 7. Funções JSON
/*
Comandos javascript executados no navegador
j = '{"nome":"luiz felipe","idade":37}' // salva uma string em uma variavel "j"
obj = JSON.parse(j) // converte a variavel "j" em json e salva na variavel "obj"
obj.nome // retorna só o valor do nome
obj.idade // retorna só o valor da idade
*/

-- JSON_OBJECT(): Cria uma informação no formato json
set @j = json_object('nome','luiz felipe','idade',37);
select @j;

-- JSON_VALUE(): Retorna uma informação de um json
select json_value(@j,'$.nome') nome , json_value(@j,'$.idade') idade;

set @j = json_object('nome','luiz felipe','idade',37,'parentes',
					json_object('mae','maria','pai','everaldo'));
select @j;
select 
	json_value(@j,'$.nome') nome , 
    json_value(@j,'$.idade') idade,
    json_value(@j,'$.parentes.mae') mae,
    json_value(@j,'$.parentes.pai') pai;

select json_object('id',id_time,'sigla',sigla) from dbcampeonatobr.time;

set @j = json_object('nome','luiz felipe','idade',37,'parentes',
					json_object('mae','maria','pai','everaldo',
                    'irmaos',json_array('amanda','isadora')));
select @j;

select 
	*
    from 
    json_table(@j,'$'
		columns (nome varchar(200) path '$.nome',
				idade int path '$.idade',
				mae varchar(200) path '$.parentes.mae',
				pai varchar(200) path '$.parentes.pai',
				nested path '$.parentes.irmaos[*]' columns (irmaos varchar(200) path '$')
				)
			) jt;