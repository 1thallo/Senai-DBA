/*
04. function valor_aleatorio
Implemente uma função no MySQL chamada valor_aleatorio que receba dois parâmetros inteiros: min (valor mínimo) e max (valor máximo). A função deve retornar um número inteiro aleatório dentro do intervalo fechado definido pelos parâmetros fornecidos, ou seja, o valor retornado deve estar entre min e max (inclusive).

Requisitos:

A função deve ser not determinística, pois cada execução pode gerar um valor diferente.
Utilize a função interna RAND() do MySQL para gerar números aleatórios.
Garanta que o número retornado seja arredondado para o inteiro mais próximo, sem casas decimais.
Valide os cálculos de modo que o número gerado esteja adequadamente dentro do intervalo fornecido pelos parâmetros.
select valor_aleatorio(5,15);
select valor_aleatorio(5,15);
select valor_aleatorio(5,15);
select valor_aleatorio(5,15);
select valor_aleatorio(5,15);
select valor_aleatorio(5,15);
select valor_aleatorio(5,15);
*/

DROP FUNCTION IF EXISTS VALOR_ALEATORIO;

DELIMITER //

CREATE FUNCTION VALOR_ALEATORIO(MIN INT, MAX INT) 
RETURNS INT
NOT DETERMINISTIC
READS SQL DATA 
	BEGIN
		DECLARE RESULTADO INT;
        
        IF MIN >= MAX THEN
			SET RESULTADO = NULL;
		ELSE
			SET RESULTADO = FLOOR(RAND() * (MAX - MIN + 1)) + MIN;
		END IF;
        
        RETURN RESULTADO;
	END //

DELIMITER ;

select valor_aleatorio(5,15);
select valor_aleatorio(5,15);
select valor_aleatorio(5,15);
select valor_aleatorio(5,15);
select valor_aleatorio(5,15);
select valor_aleatorio(5,15);
select valor_aleatorio(5,15);