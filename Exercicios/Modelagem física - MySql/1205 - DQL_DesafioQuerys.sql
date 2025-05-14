USE DB_CAMPEONATO_BRASILEIRO;
USE LOCADORA;
-- Desafios 
-- 01. Apresenta a tabela de classificação do campeonato brasileiro dos resultado até a rodada 15
WITH 
    TIME_MANDANTE AS (
        SELECT
            ID_TIME_MANDANTE AS ID_TIME,
            QT_GOL_MANDANTE AS GOLS_MANDANTE,
            QT_GOL_VISITANTE AS GOLS_VISITANTE,
            NR_RODADA_CAMPEONATO  
        FROM SNITB004_PARTIDA
        WHERE NR_RODADA_CAMPEONATO <= 15  
    ),
    TIME_VISITANTE AS (
        SELECT
            ID_TIME_VISITANTE AS ID_TIME,
            QT_GOL_MANDANTE AS GOLS_MANDANTE,
            QT_GOL_VISITANTE AS GOLS_VISITANTE,
            NR_RODADA_CAMPEONATO  
        FROM SNITB004_PARTIDA
        WHERE NR_RODADA_CAMPEONATO <= 15 
    ),
    RESULTADO AS (
        SELECT
            ID_TIME,
            GOLS_MANDANTE,
            GOLS_VISITANTE,
            CASE 
                WHEN GOLS_MANDANTE > GOLS_VISITANTE THEN 3
                WHEN GOLS_MANDANTE < GOLS_VISITANTE THEN 0
                ELSE 1 
            END AS PONTOS_MANDANTE,
            CASE
                WHEN GOLS_VISITANTE > GOLS_MANDANTE THEN 3 
                WHEN GOLS_VISITANTE < GOLS_MANDANTE THEN 0 
                ELSE 1 
            END AS PONTOS_VISITANTE
        FROM TIME_MANDANTE
        UNION ALL
        SELECT 
            ID_TIME,
            GOLS_VISITANTE,
            GOLS_MANDANTE,
            CASE 
                WHEN GOLS_VISITANTE > GOLS_MANDANTE THEN 3
                WHEN GOLS_VISITANTE < GOLS_MANDANTE THEN 0
                ELSE 1 
            END AS PONTOS_MANDANTE,
            CASE
                WHEN GOLS_VISITANTE < GOLS_MANDANTE THEN 3
                WHEN GOLS_VISITANTE > GOLS_MANDANTE THEN 0
                ELSE 1
            END AS PONTOS_VISITANTE
        FROM TIME_VISITANTE
    ),
    TABELA_CLASSIFICACAO AS (
        SELECT
            ID_TIME,
            SUM(PONTOS_MANDANTE) + SUM(PONTOS_VISITANTE) AS PONTOS,
            SUM(GOLS_MANDANTE) - SUM(GOLS_VISITANTE) AS SALDO_GOLS,
            SUM(GOLS_MANDANTE) AS GOLS_MARCADOS
        FROM RESULTADO
        GROUP BY ID_TIME
    )
SELECT
    TC.ID_TIME,
    T.NO_TIME,
    TC.PONTOS,
    TC.SALDO_GOLS,
    TC.GOLS_MARCADOS 
FROM TABELA_CLASSIFICACAO TC
INNER JOIN SNITB002_TIME T ON TC.ID_TIME = T.ID_TIME
ORDER BY TC.PONTOS DESC, TC.SALDO_GOLS DESC, TC.GOLS_MARCADOS DESC;

-- ==============================================================================

-- 02. Construa uma query que mostre por exemplo:
/*
titulo                     |qt_atores|lista_atores                                                                                                                                                                          |
---------------------------+---------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
ACADEMY DINOSAUR           |       10|PENELOPE GUINESS,CHRISTIAN GABLE,LUCILLE TRACY,SANDRA PECK,JOHNNY CAGE,MENA TEMPLE,WARREN NOLTE,OPRAH KILMER,ROCK DUKAKIS,MARY KEITEL                                                 |
ACE GOLDFINGER             |        4|BOB FAWCETT,MINNIE ZELLWEGER,SEAN GUINESS,CHRIS DEPP                                                                                                                                  |
ADAPTATION HOLES           |        5|NICK WAHLBERG,BOB FAWCETT,CAMERON STREEP,RAY JOHANSSON,JULIANNE DENCH                                                                                                                 |
AFFAIR PREJUDICE           |        5|JODIE DEGENERES,SCARLETT DAMON,KENNETH PESCI,FAY WINSLET,OPRAH KILMER                                                                                                                 |
...
*/

SELECT
    F.TITULO,
    COUNT(*) QT_ATOR,
    GROUP_CONCAT(CONCAT_WS(' ', PRIMEIRO_NOME, ULTIMO_NOME)) LISTA_ATORES
FROM FILME_ATOR FA
INNER JOIN FILME F ON F.FILME_ID = FA.FILME_ID
INNER JOIN ATOR A ON A.ATOR_ID = FA.ATOR_ID
GROUP BY F.TITULO;

-- =====================================================================

-- 03. Construa uma query que mostre por exemplo:
/*
ator                |qt_filmes|lista_filmes                                                                                                                                                                                                                                                   |
--------------------+---------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
ADAM GRANT          |       18|ANNIE IDENTITY,BALLROOM MOCKINGBIRD,DISCIPLE MOTHER,FIREBALL PHILADELPHIA,GLADIATOR WESTWARD,GLORY TRACY,GROUNDHOG UNCUT,HAPPINESS UNITED,IDOLS SNATCHERS,LOSER HUSTLER,MARS ROMAN,MIDNIGHT WESTWARD,OPERATION OPERATION,SEABISCUIT PUNK,SPLENDOR PATTON,TADPOL|
ADAM HOPPER         |       22|BLINDNESS GUN,BLOOD ARGONAUTS,CHAMBER ITALIAN,CLERKS ANGELS,CLUELESS BUCKET,FICTION CHRISTMAS,GABLES METROPOLIS,GREASE YOUTH,HEAVEN FREEDOM,LOVERBOY ATTACKS,MASKED BUBBLE,MOCKINGBIRD HOLLYWOOD,NOON PAPI,OPEN AFRICAN,PRINCESS GIANT,SADDLE ANTITRUST,SLEEPY |
AL GARLAND          |       26|BILL OTHERS,BREAKFAST GOLDFINGER,CHITTY LOCK,DALMATIONS SWEDEN,DRIFTER COMMANDMENTS,ENOUGH RAGING,GLASS DYING,GRAIL FRANKENSTEIN,HANDICAP BOONDOCK,HOLIDAY GAMES,HOUSE DYNAMITE,JACKET FRISCO,MUPPET MILE,OSCAR GOLD,PARK CITIZEN,POTTER CONNECTICUT,ROCK INSTI|
...
*/

SELECT
    CONCAT(PRIMEIRO_NOME, " ", ULTIMO_NOME) ATOR,
    COUNT(F.FILME_ID) AS QT_FILMES,
    GROUP_CONCAT(F.TITULO ORDER BY F.TITULO SEPARATOR ',') AS LISTA_FILMES
FROM FILME_ATOR FA
INNER JOIN FILME F ON F.FILME_ID = FA.FILME_ID
INNER JOIN ATOR A ON A.ATOR_ID = FA.ATOR_ID
GROUP BY ATOR
ORDER BY ATOR, QT_FILMES;

-- ============================================================================================
-- 04. Construa uma query que mostre por exemplo:
/*
titulo                     |duracao_minuto|duracao_filme|
---------------------------+--------------+-------------+
ACADEMY DINOSAUR           |            86|1h:26m       |
ACE GOLDFINGER             |            48|0h:48m       |
ADAPTATION HOLES           |            50|0h:50m       |
*/

SELECT
    TITULO,
    DURACAO_DO_FILME DURACAO_MINUTO,
    CONCAT(DURACAO_DO_FILME DIV 60, 'H:', MOD(DURACAO_DO_FILME,60), 'M') AS DURACAO_FILME
FROM FILME;

-- ============================================================================================
-- 05. Construa uma query que mostre por exemplo:
/*
data_de_aluguel    |data_de_devolucao  |dias_alugado|tempo_alugado         |
-------------------+-------------------+------------+----------------------+
2005-05-24 22:53:30|2005-05-26 22:04:30|           2|0 semana(s) e 2 dia(s)|
2005-05-24 22:54:33|2005-05-28 19:40:33|           4|0 semana(s) e 4 dia(s)|
2005-05-24 23:03:39|2005-06-01 22:12:39|           8|1 semana(s) e 1 dia(s)|
...
*/
SELECT 
	TB.*,
    CONCAT(DIAS_ALUGADOS DIV 7, ' SEMANA(S) E ' , MOD(DIAS_ALUGADOS,7), ' DIA(S)') AS TEMPO_ALUGADO
FROM (
	SELECT 
		DATA_DE_ALUGUEL,
		DATA_DE_DEVOLUCAO,
		DATEDIFF(DATA_DE_DEVOLUCAO, DATA_DE_ALUGUEL) AS DIAS_ALUGADOS
	FROM ALUGUEL
) TB;
