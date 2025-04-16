USE W3SCHOOLS;

SELECT SUBSTR("ITHALLO LEANDRO RODRIGUES BARBOSA", 9) AS NOME UNION all
SELECT MID("Ithallo Leandro Rodrigues Barbosa", 9);

SELECT RIGHT("Ithallo Leandro Rodrigues Barbosa", 7);
SELECT LEFT("Ithallo Leandro Rodrigues Barbosa", 7);


/* 
Cláusula SELECT LIMIT
Usada para especificar o número de registros a serem retornados
*/

SELECT
	TC.CategoryName AS "Categoria",
	MIN(TP.PRICE) AS "Menor",
    MAX(TP.PRICE) AS "Maior",
    AVG(TP.PRICE) AS "Média",
    SUM(TP.PRICE) AS "Soma",
    COUNT(*) AS "Quantidade de Produtos"
FROM Products TP
INNER JOIN Categories TC ON TC.categoryID = TP.categoryID 
GROUP BY TC.categoryID;

SELECT 
	CONCAT('Cliente: ',TC.CustomerName) AS "Nome do Cliente"
    , IFNULL(TBO.OrderID, "Cliente não fez nenhum pedido") AS "ID do Pedido"
FROM Customers TC
LEFT JOIN Orders TBO ON TC.CustomerID = TBO.CustomerID
ORDER BY TC.CustomerName;

SELECT TBO.OrderID, TC.Customername, TS.Shippername
FROM Orders TBO
Inner join Customers tc on tc.CustomerID = tbo.customerid
inner join shippers ts on ts.shipperid = tbo.shipperid
WHERE TC.Country = 'Brazil'
GROUP BY TC.Customername
order by tbo.orderid;