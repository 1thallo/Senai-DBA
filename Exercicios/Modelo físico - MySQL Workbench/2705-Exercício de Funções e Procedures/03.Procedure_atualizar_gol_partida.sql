/*
03. procedure atualizar_gol_partida
Crie uma Stored Procedure chamada atualizar_gol_partida que preencha os campos de gols na tabela partida. A procedure deve:

Receber a sigla dos times mandates e visitantes
Receber o número de gols do mandante e visitante
Para teste limpe antes os resultados da rodada 38
update partida set gol_mandante = null, gol_visitante = null where rodada = 38;
-- RODADA 38
CALL atualizar_gol_partida('GRE',0,3,'COR');
CALL atualizar_gol_partida('CAM',1,0,'CAP');
CALL atualizar_gol_partida('BAH',2,0,'ACG');
CALL atualizar_gol_partida('FLA',2,2,'VIT');
CALL atualizar_gol_partida('BOT',2,1,'SAO');
CALL atualizar_gol_partida('PAL',0,1,'FLU');
CALL atualizar_gol_partida('RBB',5,1,'CRI');
CALL atualizar_gol_partida('FOR',3,0,'INT');
CALL atualizar_gol_partida('CUI',1,2,'VAS');
CALL atualizar_gol_partida('JUV',0,1,'CRU');
*/
DROP PROCEDURE IF EXISTS atualizar_gol_partida;

DELIMITER $$
CREATE PROCEDURE atualizar_gol_partida(
    IN p_sigla_mandante VARCHAR(3),
    IN p_gol_mandante INT,
    IN p_gol_visitante INT,
    IN p_sigla_visitante VARCHAR(3)
)

    BEGIN
        UPDATE partida
        SET gol_mandante = p_gol_mandante,
            gol_visitante = p_gol_visitante
        WHERE rodada = 38
        AND mandante = p_sigla_mandante
        AND visitante = p_sigla_visitante;
    END $$

DELIMITER ;

update partida set gol_mandante = null, gol_visitante = null where rodada = 38;
CALL atualizar_gol_partida('GRE',0,3,'COR');
CALL atualizar_gol_partida('CAM',1,0,'CAP');
CALL atualizar_gol_partida('BAH',2,0,'ACG');
CALL atualizar_gol_partida('FLA',2,2,'VIT');
CALL atualizar_gol_partida('BOT',2,1,'SAO');
CALL atualizar_gol_partida('PAL',0,1,'FLU');
CALL atualizar_gol_partida('RBB',5,1,'CRI');
CALL atualizar_gol_partida('FOR',3,0,'INT');
CALL atualizar_gol_partida('CUI',1,2,'VAS');
CALL atualizar_gol_partida('JUV',0,1,'CRU');