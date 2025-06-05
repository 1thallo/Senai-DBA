USE DBGERAL;
DROP FUNCTION IF EXISTS DBGERAL.cpf_valido;
DELIMITER $$

CREATE FUNCTION DBGERAL.cpf_valido() 
RETURNS VARCHAR(11)
NOT DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE cont INT DEFAULT 1;
    DECLARE cpf VARCHAR(11) DEFAULT '';
    DECLARE dig, dig1, dig2 INT DEFAULT 0;

    WHILE cont <= 9 DO
        SET dig = FLOOR(RAND() * 10); 
        SET cpf = CONCAT(cpf, dig);
        SET dig1 = dig1 + ((11 - cont) * dig);
        SET dig2 = dig2 + ((12 - cont) * dig);
        SET cont = cont + 1;
    END WHILE;

    SET dig1 = dig1 MOD 11;
    IF dig1 < 2 THEN 
        SET dig1 = 0;
    ELSE 
        SET dig1 = 11 - dig1;
    END IF;
    SET cpf = CONCAT(cpf, dig1);

    SET dig2 = dig2 + (dig1 * 2);
    SET dig2 = dig2 MOD 11;
    IF dig2 < 2 THEN 
        SET dig2 = 0;
    ELSE 
        SET dig2 = 11 - dig2;
    END IF;
    SET cpf = CONCAT(cpf, dig2);

    RETURN cpf;
END $$
DELIMITER ;


--
DROP FUNCTION IF EXISTS DBGERAL.CPF;

DELIMITER $$
CREATE FUNCTION DBGERAL.cpf()
RETURNS VARCHAR(11)
NOT DETERMINISTIC
READS SQL DATA
	BEGIN
		DECLARE CONT INT DEFAULT 1;
		DECLARE CPF VARCHAR(11) DEFAULT '';
        WHILE CONT <= 11 DO
			SET CPF = CONCAT(CPF, ROUND(RAND()*9));
            SET CONT = CONT + 1;
		END WHILE;
        RETURN CPF;
	END $$
DELIMITER ;

SELECT  DBGERAL.CPF_VALIDO();

-- Crie uma function para formatar o cpf XXX.XXX.XXX-XX
DELIMITER $$

CREATE FUNCTION DBGERAL_FORMATA_CPF(v_cpf varchar(11))
RETURNS VARCHAR(14)
NOT DETERMINISTIC
	BEGIN
		DECLARE CPF_FORMATADO VARCHAR(14);
		cpf_formatado = CONCAT(SUBSTR(v_cpf, 1, 3), '.' SUBSTR(v_cpf, 4, 3), '.', SUBSTR(v_cpf, 8, 3), '-', SUBSTR(v_cpf, 10, 2));
        RETURN cpf_formatado;
    END $$

DELIMITER ;