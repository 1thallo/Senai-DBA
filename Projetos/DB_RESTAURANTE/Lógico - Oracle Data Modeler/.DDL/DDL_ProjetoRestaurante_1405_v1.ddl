-- Gerado por Oracle SQL Developer Data Modeler 24.3.1.351.0831
--   em:        2025-05-14 20:59:05 BRT
--   site:      Oracle Database 21c
--   tipo:      Oracle Database 21c



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE RSTTB001_COMANDA 
    ( 
     ID_COMANDA    NUMBER DEFAULT SQ01_RSTTB001.nextval  NOT NULL , 
     NR_MESA       NUMBER  NOT NULL , 
     NO_CLIENTE    VARCHAR2 (100 CHAR) , 
     DH_ABERTURA   TIMESTAMP  NOT NULL , 
     DH_FECHAMENTO TIMESTAMP  NOT NULL 
    ) 
;

COMMENT ON COLUMN RSTTB001_COMANDA.ID_COMANDA IS 'Identificador único serial da comanda.' 
;

COMMENT ON COLUMN RSTTB001_COMANDA.NR_MESA IS 'Número da mesa que a comanda pertence.' 
;

COMMENT ON COLUMN RSTTB001_COMANDA.NO_CLIENTE IS 'Nome do cliente responsável da comanda.' 
;

COMMENT ON COLUMN RSTTB001_COMANDA.DH_ABERTURA IS 'Data / Hora de abertura da comanda.' 
;

COMMENT ON COLUMN RSTTB001_COMANDA.DH_FECHAMENTO IS 'Data / Hora de fechamento da comanda.' 
;

ALTER TABLE RSTTB001_COMANDA 
    ADD CONSTRAINT PK_RSTTB001 PRIMARY KEY ( ID_COMANDA ) ;

CREATE TABLE RSTTB002_PEDIDO 
    ( 
     ID_PEDIDO  NUMBER DEFAULT SQ01_RSTTB002.nextval  NOT NULL , 
     ID_COMANDA NUMBER  NOT NULL , 
     DH_PEDIDO  TIMESTAMP  NOT NULL 
    ) 
;

COMMENT ON COLUMN RSTTB002_PEDIDO.ID_PEDIDO IS 'Identificador único serial do pedido.' 
;

COMMENT ON COLUMN RSTTB002_PEDIDO.ID_COMANDA IS 'Identificador único da comanda.' 
;

COMMENT ON COLUMN RSTTB002_PEDIDO.DH_PEDIDO IS 'Data / Hora do pedido.' 
;

ALTER TABLE RSTTB002_PEDIDO 
    ADD CONSTRAINT PK_RSTTB002 PRIMARY KEY ( ID_PEDIDO ) ;

CREATE TABLE RSTTB003_PRODUTO 
    ( 
     ID_PRODUTO NUMBER DEFAULT SQ01_RSTTB003.nextval  NOT NULL , 
     NO_PRODUTO VARCHAR2 (100 CHAR)  NOT NULL , 
     DS_PRODUTO VARCHAR2 (500 CHAR)  NOT NULL , 
     VL_PRODUTO NUMBER (7,2)  NOT NULL , 
     QT_ESTOQUE NUMBER 
    ) 
;

COMMENT ON COLUMN RSTTB003_PRODUTO.ID_PRODUTO IS 'Identificador único serial do produto.' 
;

COMMENT ON COLUMN RSTTB003_PRODUTO.NO_PRODUTO IS 'Nome do produto.' 
;

COMMENT ON COLUMN RSTTB003_PRODUTO.DS_PRODUTO IS 'Descrição do produto.' 
;

COMMENT ON COLUMN RSTTB003_PRODUTO.VL_PRODUTO IS 'Valor do produto.' 
;

COMMENT ON COLUMN RSTTB003_PRODUTO.QT_ESTOQUE IS 'Quantidade em estoque.' 
;

ALTER TABLE RSTTB003_PRODUTO 
    ADD CONSTRAINT PK_RSTTB003 PRIMARY KEY ( ID_PRODUTO ) ;

ALTER TABLE RSTTB003_PRODUTO 
    ADD CONSTRAINT UK01_RSTTB003 UNIQUE ( NO_PRODUTO ) ;

CREATE TABLE RSTTB004_PRODUTO_PEDIDO 
    ( 
     ID_PEDIDO  NUMBER  NOT NULL , 
     ID_PRODUTO NUMBER  NOT NULL , 
     QT_PRODUTO NUMBER  NOT NULL 
    ) 
;

COMMENT ON COLUMN RSTTB004_PRODUTO_PEDIDO.ID_PEDIDO IS 'Identificador do pedido.' 
;

COMMENT ON COLUMN RSTTB004_PRODUTO_PEDIDO.ID_PRODUTO IS 'Identificador do produto.' 
;

COMMENT ON COLUMN RSTTB004_PRODUTO_PEDIDO.QT_PRODUTO IS 'Quantidade de produto no pedido.' 
;
CREATE INDEX IX01_RSTTB004 ON RSTTB004_PRODUTO_PEDIDO 
    ( 
     ID_PRODUTO ASC , 
     ID_PEDIDO ASC 
    ) 
;

ALTER TABLE RSTTB004_PRODUTO_PEDIDO 
    ADD CONSTRAINT PK_RSTTB004 PRIMARY KEY ( ID_PEDIDO, ID_PRODUTO ) ;

ALTER TABLE RSTTB002_PEDIDO 
    ADD CONSTRAINT FK01_RSTTB001_RSTTB002 FOREIGN KEY 
    ( 
     ID_COMANDA
    ) 
    REFERENCES RSTTB001_COMANDA 
    ( 
     ID_COMANDA
    ) 
;

ALTER TABLE RSTTB004_PRODUTO_PEDIDO 
    ADD CONSTRAINT FK01_RSTTB002_RSTTB004 FOREIGN KEY 
    ( 
     ID_PEDIDO
    ) 
    REFERENCES RSTTB002_PEDIDO 
    ( 
     ID_PEDIDO
    ) 
;

ALTER TABLE RSTTB004_PRODUTO_PEDIDO 
    ADD CONSTRAINT FK02_RSTTB003_RSTTB004 FOREIGN KEY 
    ( 
     ID_PRODUTO
    ) 
    REFERENCES RSTTB003_PRODUTO 
    ( 
     ID_PRODUTO
    ) 
;

CREATE SEQUENCE SQ01_RSTTB001 
START WITH 1 
    NOCACHE 
    ORDER ;

CREATE SEQUENCE SQ01_RSTTB002 
START WITH 1 
    NOCACHE 
    ORDER ;

CREATE SEQUENCE SQ01_RSTTB003 
START WITH 1 
    NOCACHE 
    ORDER ;



-- Relatório do Resumo do Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                             4
-- CREATE INDEX                             1
-- ALTER TABLE                              8
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          3
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
