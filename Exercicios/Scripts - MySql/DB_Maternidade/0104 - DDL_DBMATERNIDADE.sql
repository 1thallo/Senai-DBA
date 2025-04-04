CREATE DATABASE DB_MATERNIDADE;
USE DB_MATERNIDADE;

CREATE TABLE SNITB001_MAE
	(
		ID_MAE INT AUTO_INCREMENT
        , NR_RG INT NOT NULL
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
        , NR_TELEFONE_MEDICO INT NOT NULL
        , IC_TIPO_TELEFONE CHAR(1) NOT NULL -- Indicador do tipo do telefone: "Comercial", "Pessoal" etc.
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