-- _______________________________________________________________________________
/*
02. function faixa_etaria
Implemente uma função no MySQL chamada faixa_etaria que recebe como entrada um valor do tipo DATE e retorne a faixa etária em VARCHAR.

A função deve ser not determinística, pois cada execução pode gerar um valor diferente, seguido de reads sql data.
Utilize a função idade() para obter a idade atual.
Utilize o calculo com div para facilitar a implementação.
As faixas etárias devem ser sempre ser entre *0 e *9 Exemplos:
A idade 08 deve ficar Entre 00 e 09 anos.
A idade 26 deve ficar Entre 20 e 29 anos.
A idade 41 deve ficar Entre 40 e 49 anos.
select faixa_etaria('1987-07-21');
-- Entre 30 e 40 anos
*/
DROP FUNCTION IF EXISTS faixa_etaria;
DELIMITER __

	CREATE FUNCTION faixa_etaria(v_valor DATE) RETURNS VARCHAR(100)
	NOT DETERMINISTIC
	READS SQL DATA 
		BEGIN
			DECLARE v_mensagem, v_idade VARCHAR(100);
            SET v_idade = SUBSTR(idade(v_valor), 1, 2);
            
            SET v_mensagem = CONCAT("A idade ", v_idade, " deve ficar entre ");
            RETURN v_mensagem;
		END __;
DELIMITER ;

SELECT faixa_etaria('1987-07-21') AS "Faixa Etária"; -- Deve retornar "Entre 30 e 40 anos"