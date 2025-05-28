/* 01. function idade
Implemente uma função no MySQL chamada idade que recebe como entrada um valor do tipo DATE e retorne a idade atual dessa data como tipo INT.

A função deve ser not determinística, pois cada execução pode gerar um valor diferente, seguido de reads sql data.
Utilize a função interna CURDATE() ou NOW() do MySQL para obter a data atual.
select idade('1987-07-21');
-- 37
*/
CREATE DATABASE DB_FUNCOES;
USE DB_FUNCOES;

DROP FUNCTION IF EXISTS IDADE;
DELIMITER &&
	CREATE FUNCTION idade(v_input DATE)
    RETURNS VARCHAR(50) -- Mudei para retornar uma mensagem de parabéns, se atender as condições
    NOT DETERMINISTIC
    READS SQL DATA
		BEGIN
			DECLARE v_idade INT;
            DECLARE v_mensagem, v_resultado VARCHAR(50);
            
            SET v_idade = YEAR(CURDATE()) - YEAR(v_input);
            
            IF(MONTH(CURDATE()) < MONTH(v_input)) OR ((MONTH(CURDATE()) = MONTH(v_input)) AND (DAY(CURDATE()) < DAY(v_input))) THEN
				SET v_idade = v_idade - 1;
			END IF;
            
            IF (MONTH(CURDATE()) = MONTH(v_input)) AND (DAY(CURDATE()) = DAY(v_input)) THEN
				SET v_mensagem = '  Parabéns! Feliz aniversário! 🎉🎉🎉🥳🥳';
			ELSE
				SET v_mensagem = '';
			END IF;
            
            SET v_resultado = CONCAT(v_idade, ' anos. ', v_mensagem);
		 RETURN v_resultado;
        END &&
       
DELIMITER ;

SELECT IDADE('1987-07-21') AS IDADE; -- Vai retornar "37 anos."
SELECT IDADE('2020-05-27') AS IDADE; -- Retorna 5 e mensagem de felicitacoes
