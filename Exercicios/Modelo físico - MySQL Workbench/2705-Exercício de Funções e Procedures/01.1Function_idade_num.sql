DROP FUNCTION IF EXISTS idade_num;
DELIMITER $$

    CREATE FUNCTION idade_num(v_input DATE) RETURNS INT
    NOT DETERMINISTIC
    READS SQL DATA
    BEGIN
        DECLARE v_idade INT;
    
        SET v_idade = YEAR(CURDATE()) - YEAR(v_input);
    
        IF (MONTH(CURDATE()) < MONTH(v_input)) OR 
            ((MONTH(CURDATE()) = MONTH(v_input)) AND (DAY(CURDATE()) < DAY(v_input))) THEN
            SET v_idade = v_idade - 1;
        END IF;

    RETURN v_idade;
END $$

DELIMITER ;
