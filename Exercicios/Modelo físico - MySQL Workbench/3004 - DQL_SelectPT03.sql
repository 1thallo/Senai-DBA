-- 01. Deseja-se saber o total de gols em cada estádio
/*exemplo:
nome_estadio									quantidade
Mineirão (Estádio Governador Magalhães Pinto)	87
Morumbi (Estádio Cícero Pompeu de Toledo)		80
Maracanã										77
Neo Química Arena								48
Estádio Alfredo Jaconi							48
*/

SELECT 
  E.NO_ESTADIO AS NOME_ESTADIO,
  SUM(IFNULL(P.QT_GOL_MANDANTE, 0) + IFNULL(P.QT_GOL_VISITANTE, 0)) AS QUANTIDADE
FROM SNITB001_ESTADIO E
LEFT JOIN SNITB004_PARTIDA P ON E.ID_ESTADIO = P.ID_ESTADIO
GROUP BY E.NO_ESTADIO;


-- 02. Deseja-se saber a quantidade dos seguintes eventos realizado pelos times:
-- "Bola na Trave", "Pênalti Perdido" , "Gol anulado (Var)" pelos clubes
/*exemplo:
sigla 	Bola na Trave 	Pênalti Perdido Gol anulado (Var)
ACG		4				2				2
CAP		12				1				1
CAM		16				1				3
BAH		12				0				1
BOT		10				2				1
.
.
*/

SELECT 
  T.SG_TIME AS SIGLA,
  COUNT(CASE WHEN E.DS_EVENTO = 'Bola na Trave' THEN 1 END) AS BOLA_NA_TRAVE,
  COUNT(CASE WHEN E.DS_EVENTO = 'Pênalti Perdido' THEN 1 END) AS PENALTI_PERDIDO,
  COUNT(CASE WHEN E.DS_EVENTO = 'Gol anulado (Var)' THEN 1 END) AS GOL_ANULADO_VAR
FROM SNITB002_TIME T
INNER JOIN SNITB003_JOGADOR J ON T.ID_TIME = J.ID_TIME
INNER JOIN SNITB005_EVENTO E ON J.ID_JOGADOR = E.ID_JOGADOR
WHERE E.DS_EVENTO IN ('Bola na Trave','Pênalti Perdido','Gol anulado (Var)')
GROUP BY T.SG_TIME;


-- 03. Elabore um relatório por minuto e a quantidade de gols (não pode contar "Gol anulado (Var)")
-- e ordene pela quantidade do maior para o menor
/*exemplo:
minuto 	qt_gols
90		75
45		48
52		14
61		14
.
.
*/

SELECT 
  NR_MINUTO AS MINUTO,
  COUNT(*) AS QT_GOLS
FROM SNITB005_EVENTO
WHERE DS_EVENTO LIKE '%Gol%' AND DS_EVENTO NOT LIKE '%Var%'
GROUP BY NR_MINUTO
ORDER BY QT_GOLS DESC;

-- 04. Elabore um relatório por idade e quantidade de jogadores
-- remover data nula e posições "Auxiliar técnico" e "Técnico"
-- ordene pela idade do mais velho ao mais novo
-- select substring(curdate(),1,4) - substr(dt_nascimento,1,4) idade from jogador;
/*exemplo:
idade 	quantidade
44		1
43		1
41		1
40		1
39		3
38		4
*/

SELECT 
  YEAR(CURDATE()) - YEAR(DT_NASCIMENTO) AS IDADE,
  COUNT(*) AS QUANTIDADE
FROM SNITB003_JOGADOR
WHERE DT_NASCIMENTO IS NOT NULL 
  AND NO_POSICAO NOT IN ('Auxiliar técnico','Técnico')
GROUP BY IDADE
ORDER BY IDADE DESC;


-- 05. Elabore um relatório por jogador e quantidade de cartões, 
-- detalhar também a quantidade de Cartões Vermelho e Amarelo
-- ordene pela quantidade total de Cartões'
/* exemplo:
numero 	nome 			qt_amarelo 	qt_vermelho qt_total
16		Jadson			15			1			16
19		Emanuel Brítez	12			2			14
3		Zé Marcos		12			2			14
10		Luciano			12			1			13
.
.
*/
-- com subquery
SELECT 
  TB.*,
  TB.QT_AMARELO + TB.QT_VERMELHO AS QT_TOTAL
FROM (
  SELECT 
    J.NR_CAMISA AS NUMERO,
    J.NO_JOGADOR AS NOME,
    COUNT(CASE WHEN E.DS_EVENTO LIKE '%Amarelo%' THEN 1 END) AS QT_AMARELO,
    COUNT(CASE WHEN E.DS_EVENTO LIKE '%Vermelho%' THEN 1 END) AS QT_VERMELHO
  FROM SNITB003_JOGADOR J
  INNER JOIN SNITB005_EVENTO E ON J.ID_JOGADOR = E.ID_JOGADOR
  WHERE E.DS_EVENTO LIKE '%Cartão%'
  GROUP BY J.NR_CAMISA, J.NO_JOGADOR
) TB
ORDER BY QT_TOTAL DESC;


-- sem subquery --
SELECT 
  J.NR_CAMISA AS NUMERO,
  J.NO_JOGADOR AS NOME,
  COUNT(CASE WHEN E.DS_EVENTO LIKE '%Amarelo%' THEN 1 END) AS QT_AMARELO,
  COUNT(CASE WHEN E.DS_EVENTO LIKE '%Vermelho%' THEN 1 END) AS QT_VERMELHO,
  COUNT(*) AS QT_TOTAL
FROM SNITB003_JOGADOR J
INNER JOIN SNITB005_EVENTO E ON J.ID_JOGADOR = E.ID_JOGADOR
WHERE E.DS_EVENTO LIKE '%Cartão%'
GROUP BY J.NR_CAMISA, J.NO_JOGADOR
ORDER BY QT_TOTAL DESC;


-- 06. Deseja-se saber qual a quantidade de jogos que aconteceram por dia
/* exemplo:
dia		quantidade
sábado	98
domingo	121
terça	11
quarta	64
quinta	29
segunda	11
sexta	8
*/

SELECT 
  DAYNAME(DH_PARTIDA) AS DIA,
  COUNT(*) AS QUANTIDADE
FROM SNITB004_PARTIDA
GROUP BY DIA
ORDER BY FIELD(DIA, 'domingo','segunda-feira','terça-feira','quarta-feira','quinta-feira','sexta-feira','sábado');


-- 07. Desejase saber a quantidade total de cada evento 
-- e quantos aconteceram ate os 45min e depois dos 45min
/*exemplo:
descricao									total	ate_45		depois_45
Gol (Gol de campo)							734		327			407
Cartão Amarelo								1806	658			1148
Substituição								3256	112			3144
Bola na Trave								217		93			124
Pênalti Perdido								23		12			11
Cartão Vermelho								80		25			55
Gol anulado (Var)							39		17			22
Cartão Vermelho (Segundo Cartão Amarelo)	44		7			37
Gol (Pênalti)								71		37			34
Gol (Gol Contra)							14		5			9
*/

SELECT 
  DS_EVENTO AS DESCRICAO,
  COUNT(*) AS TOTAL,
  COUNT(CASE WHEN NR_MINUTO <= 45 THEN 1 END) AS ATE_45,
  COUNT(CASE WHEN NR_MINUTO > 45 THEN 1 END) AS DEPOIS_45
FROM SNITB005_EVENTO
GROUP BY DS_EVENTO
ORDER BY TOTAL DESC;


-- 08. Deseja-se saber a quantidade de jogador por faixa etária
/*exemplo:
faixa_etaria	qt
Entre 30 e 39	191
Entre 20 e 29	405
Entre 10 e 19	30
Entre 40 e 49	4
*/

SELECT 
  CASE 
    WHEN IDADE BETWEEN 10 AND 19 THEN 'Entre 10 e 19'
    WHEN IDADE BETWEEN 20 AND 29 THEN 'Entre 20 e 29'
    WHEN IDADE BETWEEN 30 AND 39 THEN 'Entre 30 e 39'
    WHEN IDADE BETWEEN 40 AND 49 THEN 'Entre 40 e 49'
    ELSE 'Outros'
  END AS FAIXA_ETARIA,
  COUNT(*) AS QT
FROM (
  SELECT 
    YEAR(CURDATE()) - YEAR(DT_NASCIMENTO) AS IDADE
  FROM SNITB003_JOGADOR
  WHERE DT_NASCIMENTO IS NOT NULL
    AND NO_POSICAO NOT IN ('Técnico', 'Auxiliar técnico')
) BASE
GROUP BY FAIXA_ETARIA
ORDER BY FAIXA_ETARIA;