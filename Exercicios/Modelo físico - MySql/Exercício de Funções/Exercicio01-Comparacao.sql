/* 
01. function comparacao
Implemente uma função no MySQL chamada comparacao que receba como entrada 2 numeros do tipo INT e retorne o 2 números e entre o simbolode comparação.

Requisitos:

A função deve ser determinística.
Utilize if elseif e else para fazer as devidas comparações para colocar o simbolo correto > < ou =.
Certifique-se de que o retorno seja do tipo VARCHAR com comprimento adequado para suportar o retorno completo.
select comparacao(9,5), comparacao(5,9) , comparacao(9,9);
   retorno 
   9 > 5    5 < 9    9 = 9
*/

DROP FUNCTION IF EXISTS COMPARACAO;
DELIMITER $$
CREATE FUNCTION COMPARACAO(NUMERO1 INT, NUMERO2 INT)
RETURNS VARCHAR(5)
DETERMINISTIC
	BEGIN
		IF NUMERO1 > NUMERO2 THEN
			RETURN CONCAT(NUMERO1, " > ", NUMERO2);
		ELSEIF NUMERO1 < NUMERO2 THEN
			RETURN CONCAT(NUMERO2, " > ", NUMERO1);
		ELSE
			RETURN CONCAT(NUMERO1, " = ", NUMERO2);
		END IF;
	END $$
DELIMITER ;

SELECT COMPARACAO(9,5), COMPARACAO(5,9), COMPARACAO(9,9);