USE exemplosenai;

-- Tabela de usuário -- 
SELECT * FROM USUARIO;
DESCRIBE USUARIO;
-- ====================

-- Tabela de Auditoria -- 
SELECT * FROM AUDITORIA_USUARIO;
DESCRIBE AUDITORIA_USUARIO;
-- ==============================

-- =========================================
--        >> Descrição do Problema <<       |
-- > Executar 5 Inserts                     |
-- > Executar 5 Updates                     |
-- > Executar 5 deletes                     |
-- =========================================

-- -------------------------------  >> INSERTS << ---------------------------------
INSERT INTO USUARIO (NOME, EMAIL)                                      
	VALUES                                                                        
    ('Ithallo Leandro R. Barbosa', 'ithallo.ilrb@gmail.com'), -- ID: 89           |
    ('Ithallo Rodrigues Leandro Barbosa', 'ithallo.irlb@gmail.com'), -- ID: 54    |
    ('Ithallo Barbosa Rodrigues Leandro', 'ithallo.ibrl'), -- ID: 55              |
	('Leandro Ithallo Barbosa Rodrigues', 'ithallo.libr@gmail.com'), -- ID: 56    |
    ('Barbosa Rodrigues Ithallo Leandro', 'ithallo.bril@gmail.com'); -- ID: 57    |

-- =================================================================================

-- -------------------------------  >> UPDATES << ---------------------------------
UPDATE USUARIO                                                                 -- |
	SET email = 'ithallo.ilrb@oulook.com'                                      -- |
	WHERE id = 53;                                                             -- |
                                                                               -- |
UPDATE USUARIO                                                                 -- |
	SET email = 'ithallo.irlb@facebook.com'                                    -- |
    WHERE id = 54;                                                             -- |
                                                                               -- |
UPDATE USUARIO                                                                 -- |
	SET email = 'ithallo.ibrl@gmail.com'                                       -- |
    WHERE id = 55;                                                             -- |
                                                                               -- |
UPDATE USUARIO                                                                 -- |
	SET email = 'ithallo.libr@youtube.com'                                     -- |
    WHERE id = 56;                                                             -- |
                                                                               -- |
UPDATE USUARIO                                                                 -- |
	SET email = 'ithallo.bril@orkut.com'                                       -- |
    WHERE id = 57;                                                             -- |
                                                                               -- |
UPDATE USUARIO                                                                 -- |
	SET email = 'ithallo.bril@orkut.com'                                       -- |
    where id = 57;                                                             -- |
-- ================================================================================

-- -------------------------------  >> DELETES << ---------------------------------
DELETE from usuario where id = 89;                                             -- |  
DELETE from usuario where id = 57;                                             -- |
DELETE from usuario where id = 56;                                             -- |
DELETE from usuario where id = 55;                                             -- |
DELETE from usuario where id = 54;                                             -- |
-- ================================================================================

-- -------------------------------  >> SELECT DAS MINHAS OPERAÇÕES NO BANCO DE DADOS << ---------------------------------
SELECT * FROM AUDITORIA_USUARIO WHERE EXECUTOR = 'ithallo@'                                                          -- |
-- ======================================================================================================================