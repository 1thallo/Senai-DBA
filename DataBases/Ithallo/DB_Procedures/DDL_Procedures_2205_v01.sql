CREATE DATABASE DB_PROCEDURES;
USE DB_PROCEDURES;

-- __________________________________________________________________________________________________________

CREATE TABLE DBPTB001_USUARIO(
	ID_USUARIO INT AUTO_INCREMENT
    , NO_USUARIO VARCHAR(200) NOT NULL
    , EE_USUARIO VARCHAR(200) NOT NULL
    , CONSTRAINT PK_DBPTB001 PRIMARY KEY (ID_USUARIO)
    , CONSTRAINT UK_DBPTB001 UNIQUE (NO_USUARIO)
);

-- ==========================================================================================================
-- __________________________________________________________________________________________________________

DELIMITER $$
	CREATE PROCEDURE INCLUIR_USUARIO(v_nome VARCHAR(200), v_email VARCHAR (200))
		BEGIN
			INSERT INTO DBPTB001_USUARIO(NO_USUARIO, EE_USUARIO) VALUES (v_nome, v_email);
		END $$
DELIMITER ;

CALL INCLUIR_USUARIO('Ithallo', 'ithallo@gmail.com');
CALL INCLUIR_USUARIO('Leandro', 'leandro@gmail.com');
CALL INCLUIR_USUARIO('Rodrigues', 'rodrigues@gmail.com');
CALL INCLUIR_USUARIO('Barbosa', 'barbosa@gmail.com');
SELECT * FROM DBPTB001_USUARIO;

-- ==========================================================================================================
-- __________________________________________________________________________________________________________

DELIMITER //
	CREATE PROCEDURE CONTAR_USUARIO(OUT v_quantidade INT)
		BEGIN
			SELECT COUNT(*) 
            INTO v_quantidade -- Armazena o count no parâmetro de saída
            FROM DBPTB001_USUARIO;
		END //
DELIMITER ;

CALL CONTAR_USUARIO(@quantidade); -- Armazena o valor de v_quantidade dentro da variável definida quantidade
SELECT @quantidade; -- Seleciona o valor da variável

-- ==========================================================================================================
-- __________________________________________________________________________________________________________

CALL INCLUIR_USUARIO('Rodrigo', 'rodrigo@gmail.com');
CALL CONTAR_USUARIO(@quantidade2);
SELECT @quantidade, @quantidade2;

-- ==========================================================================================================
-- __________________________________________________________________________________________________________

DELIMITER %%
	CREATE PROCEDURE ATUALIZAR_EMAIL(v_id_usuario INT, v_novo_email VARCHAR(200))
		BEGIN
			IF EXISTS(SELECT 1 FROM DBPTB001_USUARIO WHERE ID_USUARIO = v_id_usuario) THEN
				UPDATE DBPTB001_USUARIO SET EE_EMAIL = v_novo_email WHERE ID_USUARIO = v_id_usuario;
			ELSE
				SIGNAL SQLSTATE '45000' SET message_text = 'Usuário não encontrado';
			END IF;
        END %%
DELIMITER ;

CALL ATUALIZAR_EMAIL(1, 'ithallo123@gmail.com');
SELECT * FROM DBPTB001_USUARIO;

-- ==========================================================================================================
-- __________________________________________________________________________________________________________
