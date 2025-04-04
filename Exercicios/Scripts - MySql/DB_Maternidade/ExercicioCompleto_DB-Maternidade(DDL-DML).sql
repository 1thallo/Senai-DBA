DROP DATABASE IF EXISTS DB_MATERNIDADE;
CREATE DATABASE DB_MATERNIDADE;
USE DB_MATERNIDADE;

CREATE TABLE SNITB001_MAE
	(
		ID_MAE INT AUTO_INCREMENT
        , NR_RG BIGINT NOT NULL
        , NO_MAE VARCHAR(150) NOT NULL
        , ED_MAE VARCHAR(100) NOT NULL
        , NR_TELEFONE_MAE VARCHAR(25) NOT NULL -- Inserir números formatados '-'
        , DT_NASCIMENTO DATE NOT NULL
        , CONSTRAINT PK_SNITB001 PRIMARY KEY (ID_MAE)
        , CONSTRAINT UK01_SNITB001 UNIQUE (NO_MAE)
        , CONSTRAINT UK02_SNITB001 UNIQUE (NR_RG)
    );

CREATE TABLE SNITB002_MEDICO
	(
		ID_MEDICO INT AUTO_INCREMENT
        , NR_CRM INT NOT NULL
        , NO_MEDICO VARCHAR(120) NOT NULL
        , NO_ESPECIALIDADE VARCHAR(100) NOT NULL
        , CONSTRAINT PK_SNITB002 PRIMARY KEY (ID_MEDICO)
        , CONSTRAINT UK01_SNITB002 UNIQUE (NR_CRM)
    );

CREATE TABLE SNITB003_TELEFONE_MEDICO
	(
		ID_TELEFONE_MEDICO INT AUTO_INCREMENT
        , ID_MEDICO INT NOT NULL
        , NR_TELEFONE_MEDICO VARCHAR(50) NOT NULL
        , IC_TIPO_TELEFONE VARCHAR(40) NOT NULL -- Indicador do tipo do telefone: "Comercial", "Pessoal" etc.
        , CONSTRAINT PK_SNITB003 PRIMARY KEY (ID_TELEFONE_MEDICO)
        , CONSTRAINT FK01_SNITB002_SNITB003 FOREIGN KEY (ID_MEDICO)
			REFERENCES SNITB002_MEDICO (ID_MEDICO)
    );

CREATE TABLE SNITB004_BEBE
	(
		ID_BEBE INT AUTO_INCREMENT
        , NO_BEBE VARCHAR(150) NOT NULL
        , DT_NASCIMENTO TIMESTAMP DEFAULT now() NOT NULL
        , QT_PESO DECIMAL(5,4) NOT NULL
        , VL_ALTURA INT NOT NULL-- Int para ser em CM,
        , ID_MEDICO INT NOT NULL
        , ID_MAE INT NOT NULL
        , CONSTRAINT PK_SNITB004 PRIMARY KEY (ID_BEBE)
        , CONSTRAINT FK01_SNITB002_SNITB004 FOREIGN KEY (ID_MEDICO)
			REFERENCES SNITB002_MEDICO (ID_MEDICO)
		, CONSTRAINT FK02_SNITB001_SNITB004 FOREIGN KEY (ID_MAE)
			REFERENCES SNITB001_MAE (ID_MAE)
    );

-- ===============================================================================================================
-- 									--->  INSERÇÃO DE DADOS <---

INSERT INTO SNITB002_MEDICO (NR_CRM, NO_MEDICO, NO_ESPECIALIDADE)
	VALUES
    (1010, 'Dr. João Silva', 'Pediatra' ),
    (1020, 'Dra. Maria Oliveira', 'Pediatra'),
    (1030, 'Dr. Carlos Santos', 'Pediatra');
    
SELECT * FROM SNITB002_MEDICO;
DESCRIBE SNITB002_MEDICO;

-- ================================================================================

INSERT INTO SNITB003_TELEFONE_MEDICO (ID_MEDICO, NR_TELEFONE_MEDICO, IC_TIPO_TELEFONE)
	VALUES
    (1, '(11)92345-6789', 'Profissional'),
    (2, '(71)98765-4321', 'Profissional'),
    (3, '(21)91234-5678', 'Profissional');

SELECT * FROM SNITB003_TELEFONE_MEDICO;

-- Visualizar nome do médico, o telefone dele e o tipo
SELECT TM.NO_MEDICO,  TTM.NR_TELEFONE_MEDICO, TTM.IC_TIPO_TELEFONE
FROM SNITB003_TELEFONE_MEDICO TTM
INNER JOIN SNITB002_MEDICO TM ON TM.ID_MEDICO = TTM.ID_MEDICO;

DESCRIBE SNITB003_TELEFONE_MEDICO;

-- ================================================================================
ALTER TABLE snitb001_mae
AUTO_INCREMENT = 8;

INSERT INTO SNITB001_MAE (NR_RG, NO_MAE, ED_MAE, NR_TELEFONE_MAE, DT_NASCIMENTO)
	VALUES
	(1234567890, 'Eliana', 'Rua das Flores,100,São Paulo,SP', '(11)91234-5678', '1973-11-22'),
    (2345678901,'Ivete Sangalo', 'Av. Oceânica,200,Salvador,BA', '(71)99876-5432', '1972-05-27' ),
	(3456789012, 'Claudia Leitte', 'Rua das Estrelas,300,Rio de Janeiro,RJ', '(21)98765-4321', '1980-07-10'),
    (4567890123, 'Nívea Stelmann', 'Alameda das Palmeiras,150,Niterói,RJ', '(21)91234-1234' , '1974-04-06'),
    (5678901234, 'Andréa Sorvetão', 'Rua do Sol,50,São Paulo,SP', '(11)92345-6789' , '1973-10-01'),
	(6789012345, 'Simone Mendes', 'Rua Sertaneja,500,Goiânia,GO', '(69)93456-7890' , '1984-05-24'),
	(7890123456, 'Samara Felippo', 'Rua dos Artistas,250,Rio de Janeiro,RJ', '(21)95678-4321' , '1978-10-06');
    
SELECT * FROM SNITB001_MAE;
DESCRIBE SNITB001_MAE;

-- ===============================================================================================

INSERT INTO SNITB004_BEBE(NO_BEBE, DT_NASCIMENTO, QT_PESO, VL_ALTURA, ID_MEDICO, ID_MAE) 
	VALUES
    ('Giovanna', '1997-02-02', 3.50, 50, 3,12),
    ('Stephanie', '1999-06-05', 3.45, 49, 2, 12),
    ('Felipe', '2003-11-15', 3.55, 51, 2, 12),
    ('Miguel', '2004-07-11', 3.30, 49, 3,11),
    ('Davi', '2009-01-20', 3.45, 50, 3, 10),
    ('Alícia', '2009-07-28', 3.40, 49, 2, 14),
    ('Marcelo', '2009-10-02', 3.60, 52, 3, 9),
    ('Arthur', '2011-08-10', 3.50, 50, 1, 8),
    ('Rafael', '2012-08-15', 3.55, 51, 1, 10),
    ('Lara', '2013-05-15', 3.20, 47, 3, 14),  
    ('Henry', '2014-02-03', 3.60, 50, 2, 13),
    ('Bruna', '2014-04-10', 3.10, 47, 3, 11),
    ('Manuela', '2017-09-10', 3.20, 48, 2, 8),
    ('Helena', '2018-02-10', 3.35, 49, 2, 9),
    ('Marina', '2018-02-10', 3.40, 49, 1, 9),
    ('Bela', '2019-08-20', 3.25, 48,2, 10),  
    ('Zaya', '2021-02-22', 3.30, 48, 1, 13);
SELECT * FROM SNITB004_BEBE;

-- Junção de informações do parto
SELECT TBB.NO_BEBE, TBB.DT_NASCIMENTO, TM.NO_MEDICO, TMAE.NO_MAE, TMAE.NR_RG ,TMAE.NR_TELEFONE_MAE, TMAE.ED_MAE
FROM SNITB004_BEBE TBB
INNER JOIN SNITB002_MEDICO TM ON TM.ID_MEDICO = TBB.ID_MEDICO
INNER JOIN SNITB001_MAE TMAE ON TMAE.ID_MAE = TBB.ID_MAE;

DESCRIBE SNITB004_BEBE;