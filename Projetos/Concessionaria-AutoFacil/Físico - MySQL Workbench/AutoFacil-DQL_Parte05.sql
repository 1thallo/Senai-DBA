/*
Parte 5 - Consultas SQL
Crie comandos SQL para responder:

Liste todos os veículos disponíveis para venda.
Liste todas as vendas realizadas com nome do cliente, nome do vendedor e data.
Mostre os veículos vendidos em cada venda.
Liste o total de vendas (valor) por vendedor.
Mostre o total gasto por cada cliente.
Liste os veículos que ainda não foram vendidos.
*/

-- 1) Liste todos os veículos disponíveis para venda
SELECT *
FROM ATFTB003_VEICULO
WHERE IC_STATUS = 'D';

-- 2) Liste todas as vendas realizadas com nome do cliente, nome do vendedor e data.
SELECT
	NO_CLIENTE AS CLIENTE
,	NO_VENDEDOR AS VENDEDOR
,	DATE_FORMAT(DT_VENDA, '%d/%m/%Y') AS DATA_VENDA
FROM ATFTB004_VENDA TV
INNER JOIN ATFTB001_CLIENTE TC ON TC.ID_CLIENTE = TV.ID_CLIENTE
INNER JOIN ATFTB002_VENDEDOR TVE ON TVE.ID_VENDEDOR = TV.ID_VENDEDOR;

-- 3) Mostre os veículos vendidos em cada venda.
SELECT TVV.*, TV.NO_MODELO AS MODELO, TV.NO_MARCA AS MARCA, TV.AN_FABRICACAO AS "ANO DE FABRICAÇÃO", CONCAT('R$',FORMAT(VL_VEICULO, 2), " reais") AS VALOR
FROM ATFTB005_VENDA_VEICULO TVV
INNER JOIN ATFTB003_VEICULO TV ON TV.ID_VEICULO = TVV.ID_VEICULO;

-- 4) Liste o total de vendas (valor) por vendedor.
SELECT
	T2.ID_VENDEDOR
,	T2.NO_VENDEDOR
,	CONCAT("R$ ", FORMAT(SUM(T3.VL_VEICULO),2), " reais") AS 'VALOR DAS VENDAS'
FROM ATFTB004_VENDA T4
INNER JOIN ATFTB002_VENDEDOR T2 ON T2.ID_VENDEDOR = T4.ID_VENDEDOR
INNER JOIN ATFTB005_VENDA_VEICULO T5 ON T5.ID_VENDA = T4.ID_VENDA
INNER JOIN ATFTB003_VEICULO T3 ON T3.ID_VEICULO = T5.ID_VEICULO
GROUP BY T2.ID_VENDEDOR;

-- 5) Mostre o total gasto por cada cliente.
SELECT
	T1.ID_CLIENTE AS "ID do Cliente"
,	T1.NO_CLIENTE AS "Nome do Cliente"
,	CONCAT("R$ ", FORMAT(SUM(T3.VL_VEICULO),2), " reais") AS TOTAL_GASTO
FROM ATFTB004_VENDA T4
INNER JOIN ATFTB001_CLIENTE T1 ON T1.ID_CLIENTE = T4.ID_CLIENTE
INNER JOIN ATFTB005_VENDA_VEICULO T5 ON T5.ID_VENDA = T4.ID_VENDA
INNER JOIN ATFTB003_VEICULO T3 ON T3.ID_VEICULO = T5.ID_VEICULO
GROUP BY T1.ID_CLIENTE;

-- 6) Liste os veículos que ainda não foram vendidos. Obs: não vi diferença dessa pra 1 🤷‍
SELECT *
FROM ATFTB003_VEICULO
WHERE IC_STATUS = 'D';

