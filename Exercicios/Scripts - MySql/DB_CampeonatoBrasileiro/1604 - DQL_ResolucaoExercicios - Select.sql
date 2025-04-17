USE DB_CAMPEONATO_BRASILEIRO;


-- banco de dados campeonatobrasileiro 

-- 01 Liste o nome e a posição de todos os jogadores.
SELECT NO_JOGADOR, NO_POSICAO
FROM SNITB003_JOGADOR;

-- 02 Liste o nome completo e a sigla de todos os times.
SELECT NO_COMPLETO_TIME AS "Nome Completo", SG_TIME AS "Sigla"
FROM SNITB002_TIME;

-- 03 Mostre os nomes dos estádios e suas respectivas capacidades.
SELECT NO_ESTADIO AS "Estádio", FORMAT(QT_CAPACIDADE, '#0.0000') AS "Capacidade"
FROM SNITB001_ESTADIO;

-- 04 Exiba todos os dados das partidas.
SELECT * FROM SNITB004_PARTIDA;

-- 05 Liste o nome dos jogadores nascidos desde o ano 2000.
SELECT NO_JOGADOR 
FROM SNITB003_JOGADOR
WHERE YEAR(DT_NASCIMENTO) < 2000;

-- 06 Mostre os eventos que ocorreram após o minuto 60.
SELECT *
FROM SNITB005_EVENTO
WHERE NR_MINUTO > 60
ORDER BY NR_MINUTO;

-- 07 Liste todas as partidas que terminaram empatadas.
SELECT *
FROM SNITB004_PARTIDA
WHERE QT_GOL_MANDANTE = QT_GOL_VISITANTE;

-- 08 Liste os times ordenados pela cidade em ordem alfabética.
SELECT *
FROM SNITB002_TIME
ORDER BY NO_COMPLETO_TIME;

-- 09 Exiba os 5 jogadores mais jovens (data de nascimento mais recentes).
SELECT *
FROM SNITB003_JOGADOR
ORDER BY DT_NASCIMENTO DESC
LIMIT 5;

-- 10 Liste os eventos ordenados do mais recente para o mais antigo (por minuto).
SELECT *
FROM SNITB005_EVENTO
ORDER BY NR_MINUTO;

