CREATE DATABASE BIBLIOTECA;
USE BIBLIOTECA;

-- ================================================================
CREATE TABLE SNITB001_LIVRO
	(
		ID_LIVRO INT AUTO_INCREMENT
		, NR_ISBN INT NOT NULL
		, NO_LIVRO VARCHAR(200) NOT NULL
		, DT_LANCAMENTO DATE NOT NULL
		, ID_CATEGORIA INT NOT NULL
        , CONSTRAINT PK_SNITB001 PRIMARY KEY (ID_LIVRO) -- Praticidade com AUTO_INCREMENT
        , CONSTRAINT UK01_SNITB001 UNIQUE KEY (NR_ISBN) -- Praticidade com UK
	);

-- Restrição de Chave Primária
-- ALTER TABLE SNITB001_LIVRO
-- ADD CONSTRAINT PK_SNITB001 PRIMARY KEY (ID_LIVRO);

-- Restrição de Chave única
-- ALTER TABLE SNITB001_LIVRO
-- ADD CONSTRAINT UK01_SNITB001 UNIQUE KEY (NR_ISBN);

-- ==============================================================
CREATE TABLE SNITB002_AUTOR
	(
		ID_AUTOR INT AUTO_INCREMENT
        , NO_AUTOR VARCHAR(150) NOT NULL
        , NO_NACIONALIDADE VARCHAR(75) NOT NULL
        , CONSTRAINT PK_SNITB002 PRIMARY KEY (ID_AUTOR) -- Melhor forma quando for um Auto_increment
        , CONSTRAINT UK01_SNITB002 UNIQUE KEY (NO_AUTOR)
    );

-- Restrição de Primary Key
-- ALTER TABLE SNITB002_AUTOR
-- ADD CONSTRAINT PK_SNITB002 PRIMARY KEY (ID_AUTOR); 

-- Restrição de Chave única
-- ALTER TABLE SNITB002_AUTOR
-- ADD CONSTRAINT UK01_SNITB002 UNIQUE KEY (NO_AUTOR);

-- ==========================================================
CREATE TABLE SNITB003_CATEGORIA
	(
		ID_CATEGORIA INT AUTO_INCREMENT
        , NO_CATEGORIA VARCHAR(100) NOT NULL
        , DS_CATEGORIA VARCHAR(255) NOT NULL
        , CONSTRAINT PK_SNITB003 PRIMARY KEY (ID_CATEGORIA) -- Praticidade com AUTO_INCREMENT
        , CONSTRAINT UK01_SNITB003 UNIQUE KEY (NO_CATEGORIA)
    );

-- Restrição de Chave Primária
-- ALTER TABLE SNITB003_CATEGORIA
-- ADD CONSTRAINT PK_SNITB003 PRIMARY KEY (ID_CATEGORIA);

-- Restrição de Chave Estrangeira após criar a Categoria
ALTER TABLE SNITB001_LIVRO 
	ADD CONSTRAINT FK01_SNITB003_SNITB001 FOREIGN KEY (ID_CATEGORIA) REFERENCES SNITB003_CATEGORIA (ID_CATEGORIA);
    
-- ====================================================================================================================
-- Tabela Associativa 
CREATE TABLE IF NOT EXISTS SNITB004_LIVRO_AUTOR
	(
		ID_AUTOR INT NOT NULL
        , ID_LIVRO INT NOT NULL
        , CONSTRAINT PK_SNITB004 PRIMARY KEY (ID_AUTOR, ID_LIVRO)
        , CONSTRAINT FK01_SNITB002_SNITB004 FOREIGN KEY (ID_AUTOR) REFERENCES SNITB002_AUTOR(ID_AUTOR)
        , CONSTRAINT FK02_SNITB001_SNITB004 FOREIGN KEY (ID_LIVRO) REFERENCES SNITB001_LIVRO(ID_LIVRO)
    );

-- Restrição de Chave Estrangeira
-- ALTER TABLE SNITB004_LIVRO_AUTOR
-- ADD CONSTRAINT FK01_SNITB001_SNITB004 FOREIGN KEY (ID_AUTOR) REFERENCES SNITB001_LIVRO (ID_LIVRO);

-- Restrição de Chave Estrangeira
-- ALTER TABLE SNITB004_LIVRO_AUTOR
-- ADD CONSTRAINT FK02_SNITB002_AUTOR FOREIGN KEY (ID_AUTOR) REFERENCES SNITB002_AUTOR (ID_AUTOR);

-- Restrição de Chave Primária (As duas FK's são as chaves primárias -> Tabela Associativa)
-- ALTER TABLE SNITB004_LIVRO_AUTOR
-- ADD CONSTRAINT PK_SNITB004 PRIMARY KEY (ID_AUTOR, ID_LIVRO);

-- =====================================================================================================================
-- Tabela editora do livro
CREATE TABLE SNITB005_EDITORA
	(
		ID_EDITORA INT AUTO_INCREMENT
        , NR_CNPJ INT NOT NULL
        , NO_EDITORA VARCHAR(200) NOT NULL
		, CONSTRAINT PK_SNITB005 PRIMARY KEY (ID_EDITORA)
		, CONSTRAINT UK01_SNITB005 UNIQUE KEY (NR_CNPJ)
    );
-- =====================================================================================================================

CREATE TABLE SNITB006_EDITORA_CONTATO
	(
		ID_EDITORA_CONTATO INT AUTO_INCREMENT
        , ID_EDITORA INT (15)
        , NR_TELEFONE_CONTATO INT
        , CONSTRAINT PK_SNITB006 PRIMARY KEY (ID_EDITORA_CONTATO)
        , CONSTRAINT FK01_SNITB005 FOREIGN KEY (ID_EDITORA) REFERENCES SNITB005_EDITORA (ID_EDITORA)
    );

-- Inserindo a coluna que irei referenciar a EEDITORA do LIVRO
ALTER TABLE SNITB001_LIVRO
	ADD COLUMN ID_EDITORA INT;

-- Inserindo Chave Estrangeira da Editora na tabela LIVRO
ALTER TABLE SNITB001_LIVRO
	ADD CONSTRAINT FK02_SNITB001 FOREIGN KEY (ID_EDITORA) REFERENCES SNITB005_EDITORA (ID_EDITORA);

-- Alterei após aviso no ID_EDITORA INT (15):1681 Integer display width is deprecated and will be removed in a future release.
ALTER TABLE SNITB006_EDITORA_CONTATO
	MODIFY NR_TELEFONE_CONTATO INT;

-- ==============================================================================================================================
-- Área de Checks Constraints

-- Verifica se o ano dentro da data de lançamento é menor que o ano atual
ALTER TABLE SNITB001_LIVRO
	ADD CONSTRAINT CC01_SNITB001
		CHECK (DT_LANCAMENTO <= YEAR(sysdate()));

ALTER TABLE SNITB001_LIVRO
	DROP CONSTRAINT CC01_SNITB001;

SELECT YEAR(sysdate());

-- =====================================================================================================================
-- Comandos Utilitários
show tables;
DESCRIBE snitb001_livro;
DESCRIBE snitb002_autor;
DESCRIBE snitb003_CATEGORIA;
DESCRIBE snitb004_LIVRO_AUTOR;
DESCRIBE snitb005_EDITORA;
DESCRIBE snitb006_EDITORA_CONTATO;
-- =====================================================================================================================
-- Comando para deletar o banco de dados
DROP DATABASE BIBLIOTECA;
-- =====================================================================================================================
-- Comando para deletar a tabela
DROP TABLE IF EXISTS SNITB001_LIVRO;
DROP TABLE IF EXISTS SNITB002_AUTOR;
DROP TABLE IF EXISTS SNITB003_CATEGORIA;
DROP TABLE IF EXISTS SNITB004_LIVRO_AUTOR;
DROP TABLE IF EXISTS SNITB005_EDITORA;
DROP TABLE IF EXISTS SNITB006_EDITORA_CONTATO;
-- =====================================================================================================================
-- Comando para deletar a chave estrangeira
ALTER TABLE SNITB001_LIVRO
	DROP FOREIGN KEY FK01_SNITB003_SNITB001;
ALTER TABLE SNITB001_LIVRO
	DROP FOREIGN KEY FK02_SNITB001;
ALTER TABLE SNITB004_LIVRO_AUTOR
	DROP FOREIGN KEY FK01_SNITB001_SNITB004;
ALTER TABLE SNITB004_LIVRO_AUTOR
	DROP FOREIGN KEY FK02_SNITB002_AUTOR;
ALTER TABLE SNITB006_EDITORA_CONTATO
	DROP FOREIGN KEY FK01_SNITB005;
ALTER TABLE SNITB001_LIVRO
	DROP FOREIGN KEY FK02_SNITB001;
-- =====================================================================================================================
-- Comando para deletar a chave primária
ALTER TABLE SNITB001_LIVRO
	DROP PRIMARY KEY;
ALTER TABLE SNITB002_AUTOR
	DROP PRIMARY KEY;
ALTER TABLE SNITB003_CATEGORIA
	DROP PRIMARY KEY;
ALTER TABLE SNITB004_LIVRO_AUTOR
	DROP PRIMARY KEY;
ALTER TABLE SNITB005_EDITORA
	DROP PRIMARY KEY;
ALTER TABLE SNITB006_EDITORA_CONTATO
	DROP PRIMARY KEY;
-- =====================================================================================================================
-- Comando para deletar a chave única
ALTER TABLE SNITB001_LIVRO
	DROP INDEX UK01_SNITB001;
ALTER TABLE SNITB002_AUTOR
	DROP INDEX UK01_SNITB002;
ALTER TABLE SNITB003_CATEGORIA
	DROP INDEX UK01_SNITB003;
ALTER TABLE SNITB005_EDITORA
	DROP INDEX UK01_SNITB005;
-- =====================================================================================================================
-- Comando para deletar a constraint
ALTER TABLE SNITB001_LIVRO
	DROP CONSTRAINT PK_SNITB001;
ALTER TABLE SNITB002_AUTOR
	DROP CONSTRAINT PK_SNITB002;
ALTER TABLE SNITB003_CATEGORIA
	DROP CONSTRAINT PK_SNITB003;
ALTER TABLE SNITB004_LIVRO_AUTOR
	DROP CONSTRAINT PK_SNITB004;
ALTER TABLE SNITB005_EDITORA
	DROP CONSTRAINT PK_SNITB005;
ALTER TABLE SNITB006_EDITORA_CONTATO
	DROP CONSTRAINT PK_SNITB006;
-- =====================================================================================================================
-- Comando para deletar a constraint de check
ALTER TABLE SNITB001_LIVRO
	DROP CONSTRAINT CC01_SNITB001;
-- =====================================================================================================================

