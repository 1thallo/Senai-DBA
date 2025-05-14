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