CREATE DATABASE DB_PROJETO_RESTAURANTE;
USE DB_PROJETO_RESTAURANTE;

-- Tabela: RSTTB001_COMANDA
CREATE TABLE RSTTB001_COMANDA 
(
    ID_COMANDA INT AUTO_INCREMENT, 
    NR_MESA INT NOT NULL, 
    NO_CLIENTE VARCHAR(100), 
    DH_ABERTURA DATETIME NOT NULL, 
    DH_FECHAMENTO DATETIME NOT NULL,
    CONSTRAINT PK_RSTTB001 PRIMARY KEY (ID_COMANDA)
);

-- ==========================================================================================================
-- ID_COMANDA: Identificador único serial da comanda
-- NR_MESA: Número da mesa que a comanda pertence
-- NO_CLIENTE: Nome do cliente responsável da comanda
-- DH_ABERTURA: Data / Hora de abertura da comanda
-- DH_FECHAMENTO: Data / Hora de fechamento da comanda
-- ==========================================================================================================

-- Tabela: RSTTB002_PEDIDO
CREATE TABLE RSTTB002_PEDIDO 
(
    ID_PEDIDO INT AUTO_INCREMENT, 
    ID_COMANDA INT NOT NULL, 
    DH_PEDIDO DATETIME NOT NULL,
    CONSTRAINT PK_RSTTB002 PRIMARY KEY (ID_PEDIDO),
    CONSTRAINT FK01_RSTTB001_RSTTB002 FOREIGN KEY (ID_COMANDA) REFERENCES RSTTB001_COMANDA(ID_COMANDA)
);

-- ==========================================================================================================
-- ID_PEDIDO: Identificador único serial do pedido
-- ID_COMANDA: Identificador único da comanda
-- DH_PEDIDO: Data / Hora do pedido
-- ==========================================================================================================

-- Tabela: RSTTB003_PRODUTO
CREATE TABLE RSTTB003_PRODUTO 
(
    ID_PRODUTO INT AUTO_INCREMENT, 
    NO_PRODUTO VARCHAR(100) NOT NULL, 
    DS_PRODUTO VARCHAR(500) NOT NULL, 
    VL_PRODUTO DECIMAL(7,2) NOT NULL, 
    QT_ESTOQUE INT,
    CONSTRAINT PK_RSTTB003 PRIMARY KEY (ID_PRODUTO),
    CONSTRAINT UK01_RSTTB003 UNIQUE (NO_PRODUTO)
);

-- ==========================================================================================================
-- ID_PRODUTO: Identificador único serial do produto
-- NO_PRODUTO: Nome do produto
-- DS_PRODUTO: Descrição do produto
-- VL_PRODUTO: Valor do produto
-- QT_ESTOQUE: Quantidade em estoque
-- ==========================================================================================================

-- Tabela: RSTTB004_PRODUTO_PEDIDO
CREATE TABLE RSTTB004_PRODUTO_PEDIDO 
(
    ID_PEDIDO INT NOT NULL, 
    ID_PRODUTO INT NOT NULL, 
    QT_PRODUTO INT NOT NULL,
    CONSTRAINT PK_RSTTB004 PRIMARY KEY (ID_PEDIDO, ID_PRODUTO),
    CONSTRAINT FK01_RSTTB002_RSTTB004 FOREIGN KEY (ID_PEDIDO) REFERENCES RSTTB002_PEDIDO(ID_PEDIDO),
    CONSTRAINT FK02_RSTTB003_RSTTB004 FOREIGN KEY (ID_PRODUTO) REFERENCES RSTTB003_PRODUTO(ID_PRODUTO)
);

-- ==========================================================================================================
-- ID_PEDIDO: Identificador do pedido
-- ID_PRODUTO: Identificador do produto
-- QT_PRODUTO: Quantidade de produto no pedido
-- ==========================================================================================================

-- Índice para otimizar consultas em Produto e Pedido
CREATE INDEX IX01_RSTTB004 ON RSTTB004_PRODUTO_PEDIDO (ID_PRODUTO, ID_PEDIDO);
