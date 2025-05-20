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

-- FLOOR(): Arredonda sempre para baixo
select floor(2.9), floor(2.00001);

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

-- PI(): Retorna o valor de pi
select pi();
select round(pi(),20);

-- POW() / POWER(): Eleva um número à potencia
select pow(4,2), power(4,2);