DROP DATABASE IF EXISTS DB_AUTOFACIL;
CREATE DATABASE DB_AUTOFACIL;
USE DB_AUTOFACIL;

CREATE TABLE ATFTB001_CLIENTE (
    ID_CLIENTE INT AUTO_INCREMENT COMMENT 'Identificador único serial do cliente.' ,
    NR_CPF CHAR(11) NOT NULL COMMENT 'Número do Cadastro de Pessoa Física do cliente.',
    NO_CLIENTE VARCHAR(200) NOT NULL COMMENT 'Nome do cliente.',
    CONSTRAINT PK_ATFTB001 PRIMARY KEY (ID_CLIENTE),
    CONSTRAINT UK01_ATFTB001 UNIQUE (NO_CLIENTE, NR_CPF)
) COMMENT = 'Armazena dados sobre os clientes da concessionária.';

CREATE TABLE ATFTB002_VENDEDOR (
    ID_VENDEDOR INT AUTO_INCREMENT COMMENT 'Identificador único serial do vendedor.',
    NR_MATRICULA BIGINT NOT NULL COMMENT 'Número da matrícula do vendedor.',
    NO_VENDEDOR VARCHAR(200) NOT NULL COMMENT 'Nome do vendedor.',
    CONSTRAINT PK_ATFTB002 PRIMARY KEY (ID_VENDEDOR),
    CONSTRAINT UK01_ATFTB002 UNIQUE (NR_MATRICULA, NO_VENDEDOR)
) COMMENT = 'Armazena dados sobre os vendedores da concessionária.';


CREATE TABLE ATFTB003_VEICULO (
    ID_VEICULO BIGINT AUTO_INCREMENT COMMENT 'Identificador único serial do veículo.',
    NO_MODELO VARCHAR(50) NOT NULL COMMENT 'Nome do modelo do veículo.',
    NO_MARCA VARCHAR(50) NOT NULL COMMENT 'Nome da marca do veículo.',
    AN_FABRICACAO INT NOT NULL COMMENT 'Ano de fabricação do veículo.',
    VL_VEICULO DECIMAL(10,2) NOT NULL COMMENT 'Valor do veículo.',
    IC_STATUS CHAR(1) NOT NULL COMMENT 'Indicador da disponibilidade: D - Disponível / V - Vendido.',
    CONSTRAINT PK_ATFTB003 PRIMARY KEY (ID_VEICULO),
    CONSTRAINT CC01_ATFTB003 CHECK (IC_STATUS IN ('D', 'V'))
) COMMENT = 'Armazena dados sobre os veículos da concessionária.';


CREATE TABLE ATFTB004_VENDA (
    ID_VENDA BIGINT AUTO_INCREMENT COMMENT 'Identificador único serial da venda.',
    DT_VENDA DATE NOT NULL COMMENT 'Data em que a venda foi realizada.',
    ID_CLIENTE INT NOT NULL COMMENT 'Identificador do cliente que realizou a venda.',
    ID_VENDEDOR INT NOT NULL COMMENT 'Identificador do vendedor que realizou a venda.',
    CONSTRAINT PK_ATFTB004 PRIMARY KEY (ID_VENDA),
    CONSTRAINT FK01_ATFTB001_ATFTB004 FOREIGN KEY (ID_CLIENTE) 
		REFERENCES ATFTB001_CLIENTE(ID_CLIENTE),
	CONSTRAINT FK02_ATFTB002_ATFTB004 FOREIGN KEY (ID_VENDEDOR)
		REFERENCES ATFTB002_VENDEDOR (ID_VENDEDOR)
) COMMENT = 'Armazena dados sobre as vendas realizadas na concessionária.';

CREATE TABLE ATFTB005_VENDA_VEICULO(
	ID_VENDA BIGINT COMMENT 'Identificador da venda.',
    ID_VEICULO BIGINT COMMENT 'Identificador do veículo',
    CONSTRAINT PK_ATFTB005 PRIMARY KEY (ID_VENDA, ID_VEICULO),
    CONSTRAINT FK01_ATFTB004_ATFTB005 FOREIGN KEY (ID_VENDA)
		REFERENCES ATFTB004_VENDA (ID_VENDA),
	CONSTRAINT FK02_ATFTB003_ATFTB005 FOREIGN KEY (ID_VEICULO)
		REFERENCES ATFTB003_VEICULO (ID_VEICULO)
) COMMENT = 'Tabela associativa entre veículos e vendas.';

CREATE TABLE ATFTB101_TELEFONE_CLIENTE (
    ID_TELEFONE_CLIENTE INT AUTO_INCREMENT COMMENT 'Identificador único serial do telefone do cliente.',
    ID_CLIENTE INT NOT NULL COMMENT 'Identificador do cliente.',
    NR_TELEFONE VARCHAR(25) NOT NULL COMMENT 'Número de telefone.',
    IC_TIPO_TELEFONE CHAR(1) NOT NULL DEFAULT 'P' COMMENT 'Indicador do tipo do telefone: (C - Comercial, P - Pessoal, T - Trabalho)',
    CONSTRAINT PK_ATFTB101 PRIMARY KEY (ID_TELEFONE_CLIENTE),
    CONSTRAINT FK01_ATFTB001_ATFTB101 FOREIGN KEY (ID_CLIENTE)
        REFERENCES ATFTB001_CLIENTE (ID_CLIENTE),
    CONSTRAINT CC01_ATFTB101 CHECK (IC_TIPO_TELEFONE IN ('C', 'P', 'T'))
) COMMENT = 'Armazena dados dos telefones do cliente.';

CREATE TABLE ATFTB102_TELEFONE_VENDEDOR (
    ID_TELEFONE_VENDEDOR INT AUTO_INCREMENT COMMENT 'Identificador único serial do telefone do vendedor.',
    ID_VENDEDOR INT NOT NULL COMMENT 'Identificador do vendedor.',
    NR_TELEFONE_VENDEDOR VARCHAR(20) NOT NULL COMMENT 'Número de telefone do vendedor.',
    IC_TIPO_TELEFONE CHAR(1) NOT NULL DEFAULT 'P' COMMENT 'Indicador do tipo de telefone: (T - Trabalho, P - Pessoal).',
    CONSTRAINT PK_ATFTB102 PRIMARY KEY (ID_TELEFONE_VENDEDOR),
    CONSTRAINT FK01_ATFTB002_ATFTB102 FOREIGN KEY (ID_VENDEDOR)
        REFERENCES ATFTB002_VENDEDOR (ID_VENDEDOR),
    CONSTRAINT CC01_ATFTB102 CHECK (IC_TIPO_TELEFONE IN ('P', 'T'))
) COMMENT = 'Armazena dados dos telefones dos vendedores.';