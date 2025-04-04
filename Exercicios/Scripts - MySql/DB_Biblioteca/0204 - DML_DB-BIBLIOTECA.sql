USE BIBLIOTECA;

DESC SNITB001_LIVRO;
DESC SNITB002_AUTOR;
DESC SNITB003_CATEGORIA;
DESC SNITB004_LIVRO_AUTOR;
DESC SNITB005_EDITORA;
DESC SNITB006_EDITORA_CONTATO;
-- ==============================================================================================================================================
-- ALTER TABLE SNITB001_LIVRO
-- MODIFY NR_ISBN BIGINT; --> Tive de alterar pois estava como INT, acaba não suportando o tamanho do ISBN
    
INSERT INTO SNITB001_LIVRO (NR_ISBN, NO_LIVRO, DT_LANCAMENTO, ID_CATEGORIA, ID_EDITORA) 
	VALUES 
    (11111111, 'Livro de Terror', '2025-04-02',1,1),
    (9898581050379, 'À Espera de um Milagre', '2013-04-24', 5, 4),
    (8560280944, 'It: A coisa', '2014-07-24', 1,4);

SELECT * FROM SNITB001_LIVRO;

-- ==============================================================================================================================================
-- ALTER TABLE SNITB002_AUTOR
-- ADD COLUMN DT_NASCIMENTO DATE NOT NULL; -- > Adicionar coluna Data de Nascimento antes de inserir

INSERT INTO SNITB002_AUTOR(NO_AUTOR, NO_NACIONALIDADE, DT_NASCIMENTO) 
	VALUES 
    ('Monteiro Lobato', 'Brasileiro','1882-04-18'),
	('Stephen King', 'Estado-unidense','1947-11-21'),
	('Machado de Assis', 'Brasileiro','1839-06-21'),
	('Clarice Lispector', 'Brasileira','1920-12-10'),
	('Ariano Suassuna', 'Brasileiro','1927-06-16');

SELECT * FROM SNITB002_AUTOR;

-- ==============================================================================================================================================
INSERT INTO SNITB003_CATEGORIA (NO_CATEGORIA, DS_CATEGORIA)
	VALUES
    ('Terror', 'Categoria de terror para pessoas que gostam de tomar susto.'),
    ('Ficção', 'Categoria de ficção para pessoas que gostam ficção.'),
    ('Romance', 'Categoria de romance para pessoas que gostam de romance.'),
    ('Infantil', 'Categoria de teor infantil para crianças que gostam.'),
    ('Suspense', 'Categoria de suspense para pessoas que gostam de suspense.'),
    ('Ação', 'Categoria de ação para pessoas que gostam de ação.');
    
SELECT * FROM SNITB003_CATEGORIA;
-- =============================================================================================================================================
-- Tabela Associativa entre livro e autor
INSERT INTO SNITB004_LIVRO_AUTOR(ID_AUTOR,ID_LIVRO)
	VALUES
	(2,6),
    (2,7);
    
SELECT * FROM SNITB004_LIVRO_AUTOR;

-- Inner join para visualizar o nome livro, nome autor, data lancamento e categoria
SELECT TL.NO_LIVRO, TA.NO_AUTOR, TL.DT_LANCAMENTO, TC.NO_CATEGORIA
FROM SNITB004_LIVRO_AUTOR TLA
INNER JOIN SNITB001_LIVRO TL ON TL.ID_LIVRO = TLA.ID_LIVRO
INNER JOIN SNITB002_AUTOR TA ON TA.ID_AUTOR = TLA.ID_AUTOR
INNER JOIN SNITB003_CATEGORIA TC ON TC.ID_CATEGORIA = TL.ID_CATEGORIA;
-- =======================================================================================================================================
-- ALTER TABLE SNITB005_EDITORA
-- MODIFY NR_CNPJ BIGINT; --> Tive de fazer alteração pois não suportou o tamanho do CNPJ como INT

INSERT INTO SNITB005_EDITORA (NR_CNPJ, NO_EDITORA) 
	VALUES 
    (123456789, 'Editora .LTDA'),
    (31894140000184, 'Suma Economica Grafica e Editora LTDA.');
    
SELECT * FROM SNITB005_EDITORA;
-- ============================================================================================================================================
-- ALTER TABLE SNITB006_EDITORA_CONTATO
-- MODIFY NR_TELEFONE_CONTATO VARCHAR(25);
    
INSERT INTO SNITB006_EDITORA_CONTATO (ID_EDITORA, NR_TELEFONE_CONTATO)
	VALUES
    (1, '+55 (61) 94002-8922'),
    (1, '+55 (61) 91111-1111'),
    (4, '+55 (61) 92222-2222');
    
SELECT * FROM SNITB006_EDITORA_CONTATO;