-- ====================================================

/*
02. function data_br
Implemente uma função no MySQL chamada data_br que receba como entrada um valor do tipo DATE e retorne uma string no formato brasileiro de data, ou seja, dd/mm/yyyy.

Requisitos:

. A função deve ser determinística.
. Utilize a função interna DATE_FORMAT do MySQL para formatar a data.
. Certifique-se de que o retorno seja do tipo VARCHAR com comprimento adequado para suportar o formato brasileiro.
select data_br('1987-07-21'), data_br(curdate());
-- retorno
-- 21/07/1987  	19/05/2025
*/

DROP FUNCTION IF EXISTS DATA_BR;

DELIMITER //
CREATE FUNCTION DATA_BR(v_data DATE)
RETURNS VARCHAR(11)
DETERMINISTIC
	BEGIN
		DECLARE data_formatada VARCHAR(11);
			SET data_formatada = DATE_FORMAT(v_data, '%d/%m/%Y');
		RETURN data_formatada;
    END //
DELIMITER ;

SELECT DATA_BR('2004-10-01') AS "Data de Nascimento", DATA_BR(CURDATE()) AS "Data de Hoje";

-- ================================================================================================