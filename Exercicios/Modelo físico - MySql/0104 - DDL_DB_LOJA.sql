CREATE DATABASE DB_LOJA;
USE DB_LOJA;

CREATE TABLE SNITB001_CLIENTE
	(
		ID_CLIENTE INT AUTO_INCREMENT
        , NO_CLIENTE VARCHAR(150) NOT NULL
        , VL_LIMITE_CREDITO DECIMAL(4,2) NOT NULL
        , IC_STATUS CHAR(1) NOT NULL-- Indicador do status: 'A' - Ativo, 'I' - Inativo
        , NR_CEP VARCHAR(10) NOT NULL
        , NO_LOGRADOURO VARCHAR(200) NOT NULL
        , NR_CASA INT NOT NULL
        , CONSTRAINT PK_SNITB001 PRIMARY KEY (ID_CLIENTE)
        , CONSTRAINT UK01_SNITB001 UNIQUE (NO_CLIENTE)
    );

CREATE TABLE SNITB002_PEDIDO
	(
		ID_PEDIDO INT AUTO_INCREMENT
        , DT_PEDIDO DATE NOT NULL
		, VL_TOTAL_PEDIDO DECIMAL(4,2) NOT NULL
        , ID_CLIENTE INT NOT NULL
        , CONSTRAINT PK_SNITB002 PRIMARY KEY (ID_PEDIDO)
        , CONSTRAINT FK01_SNITB001_SNITB002 FOREIGN KEY (ID_CLIENTE) 
			REFERENCES SNITB001_CLIENTE (ID_CLIENTE)
    );

CREATE TABLE SNITB003_CATEGORIA
	(
		ID_CATEGORIA INT AUTO_INCREMENT
        , NO_CATEGORIA VARCHAR(100) NOT NULL
        , DS_CATEGORIA VARCHAR(255)
        , CONSTRAINT PK_SNITB003 PRIMARY KEY (ID_CATEGORIA)
        , CONSTRAINT UK01_SNITB003 UNIQUE (NO_CATEGORIA)
    );

CREATE TABLE SNITB004_PRODUTO
	(
		ID_PRODUTO INT AUTO_INCREMENT
        , NO_PRODUTO VARCHAR(150) NOT NULL
        , VL_PRODUTO DECIMAL(5,2) NOT NULL
        , ID_CATEGORIA INT NOT NULL
        , CONSTRAINT PK_SNITB004 PRIMARY KEY (ID_PRODUTO)
        , CONSTRAINT FK01_SNITB003_SNITB004 FOREIGN KEY (ID_CATEGORIA)
			REFERENCES SNITB003_CATEGORIA (ID_CATEGORIA)
		, CONSTRAINT UK01_SNITB004 UNIQUE (NO_PRODUTO)
    );
    
    CREATE TABLE SNITB005_PRODUTO_PEDIDO
		(
			ID_PRODUTO INT 
            , ID_PEDIDO INT
            , QT_PRODUTO_PEDIDO INT NOT NULL
            , CONSTRAINT PK_SNITB005 PRIMARY KEY (ID_PRODUTO, ID_PEDIDO)
            , CONSTRAINT FK01_SNITB004_SNITB005 FOREIGN KEY (ID_PRODUTO)
				REFERENCES SNITB004_PRODUTO (ID_PRODUTO)
			, CONSTRAINT FK02_SNITB002_SNITB005 FOREIGN KEY (ID_PEDIDO)
				REFERENCES SNITB002_PEDIDO (ID_PEDIDO)
        );