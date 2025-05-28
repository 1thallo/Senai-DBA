/*
04. procedure gerar_resultado_aleatorio
Crie uma Stored Procedure chamada gerar_resultado_aleatorio que preencha aleatoriamente os campos de gols em uma tabela chamada partida. A procedure deve:

Iterar por todos os registros da tabela partida, utilizando um contador para identificar o campo id_partida.
Gerar valores aleatórios para os campos:
gol_mandante: Um número inteiro aleatório entre 0 e 6.
gol_visitante: Um número inteiro aleatório entre 0 e 6.
Atualizar os valores gerados para cada registro identificado pelo id_partida.
Parar a execução ao atingir o último registro (ou quando o contador chegar a 380, que representa o número total de partidas no contexto fornecido).
call gerar_resultado_aleatorio();
select * from classificacao;
*/
DROP PROCEDURE IF EXISTS gerar_resultado_aleatorio;
DELIMITER $$

CREATE PROCEDURE gerar_resultado_aleatorio()
BEGIN
    DECLARE v_id INT DEFAULT 1;
    DECLARE v_max INT DEFAULT 380;
    DECLARE v_gol_mandante INT;
    DECLARE v_gol_visitante INT;

    WHILE v_id <= v_max DO

        SET v_gol_mandante = FLOOR(RAND() * 7);
        SET v_gol_visitante = FLOOR(RAND() * 7);

        UPDATE partida
        SET gol_mandante = v_gol_mandante,
            gol_visitante = v_gol_visitante
        WHERE id_partida = v_id;

        SET v_id = v_id + 1;
    END WHILE;
END $$

DELIMITER ;

CALL gerar_resultado_aleatorio();
SELECT * FROM classificacao;


