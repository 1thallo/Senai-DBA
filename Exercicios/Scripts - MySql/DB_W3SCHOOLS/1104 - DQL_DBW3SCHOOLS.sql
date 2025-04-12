use w3schools;
-- link da base w3schools
-- https://github.com/AndrejWeb/w3schools-database/blob/master/w3schools.sql

-- categories = categorias
-- customers = clientes
-- employees = funcionários
-- orders = pedidos
-- order_details = detalhes do pedido
-- products = produtos
-- shippers = transportadores
-- suppliers = fornecedores

/*
Instrução SQL SELECT
A instrução SELECT é usada para selecionar dados de um banco de dados.
*/
SELECT CustomerName, City FROM Customers;

/*
A instrução SQL SELECT DISTINCT
A instrução SELECT DISTINCT é usada para retornar apenas valores distintos (diferentes).
*/
SELECT DISTINCT Country FROM Customers;
SELECT count(*), count(distinct country) FROM Customers;

/*
A cláusula SQL WHERE
A WHERE cláusula é usada para filtrar registros.
Ele é usado para extrair apenas os registros que atendem a uma condição especificada.
*/
SELECT * FROM Customers WHERE Country = 'Mexico';

/*
Operadores de comparação SQL
= Igual a
> Maior que
< Menor que
>= Maior ou igual a
<= Menor ou igual a
<> Diferente de
*/

/*
A ORDEM SQL POR
A palavra-chave ORDER BY é usada para classificar 
o conjunto de resultados em ordem crescente ou decrescente.
*/
SELECT * FROM Products ORDER BY Price;
SELECT * FROM Products ORDER BY Price DESC;
SELECT * FROM Products ORDER BY Price, ProductID;
SELECT * FROM Customers
WHERE Country = 'Brazil'
ORDER BY Country ASC, City ASC, CustomerName DESC;

/*
O operador SQL AND
A cláusula WHERE pode conter um ou muitos operadores AND.
O operador AND é usado para filtrar registros com base em mais 
de uma condição, 
*/
-- Exemplo: Selecione todos os clientes da Espanha que começam com a letra 'G':
SELECT COUNT(*) FROM Customers WHERE Country = 'Spain';
SELECT COUNT(*) FROM Customers WHERE Country = 'Brazil';
SELECT COUNT(*) FROM Customers WHERE Country = 'Brazil' or Country = 'Spain';

/*
Operadores AND vs OR
O operador AND exibe um registro se todas as condições forem VERDADEIRAS.
O operador OR exibe um registro se qualquer uma das condições for VERDADEIRA.
*/

/*
(AND) Todas as condições devem ser verdadeiras
A seguinte instrução SQL seleciona todos os campos Customersonde 
Country "Alemanha" E City "Berlim" E PostalCode é maior que 12000:
*/
SELECT * FROM Customers WHERE Country = 'Germany' AND City = 'Berlin' AND PostalCode > 12000;

/*
Combinando AND e OR
Você pode combinar os operadores AND e OR
A seguinte instrução SQL seleciona todos os clientes da Espanha que começam com "G" ou "R".
Certifique-se de usar parênteses para obter o resultado correto.
*/
SELECT count(*) FROM Customers WHERE Country = 'Spain' 
AND CustomerName LIKE 'G%';
SELECT count(*) FROM Customers WHERE Country = 'Spain' 
AND CustomerName LIKE 'R%';
SELECT * FROM Customers WHERE Country = 'Spain' 
AND CustomerName LIKE 'G%' OR CustomerName LIKE 'R%';
SELECT * FROM Customers WHERE Country = 'Spain' 
AND (CustomerName LIKE 'G%' OR CustomerName LIKE 'R%');

/*
O operador SQL OR
A cláusula WHERE pode conter um ou mais operadores OR.
O operador OR é usado para filtrar registros com base em mais de uma condição, 
se você quisesse retornar todos os clientes da Alemanha, mas também aqueles da Espanha:
*/
SELECT * FROM Customers WHERE Country = 'Germany' OR Country = 'Spain';

/*
Operador NOT
O operador NOT é usado em combinação com outros operadores para fornecer o resultado oposto, 
também chamado de resultado negativo.
*/
-- Na instrução select abaixo, queremos retornar todos os clientes que NÃO são da Espanha:
SELECT * FROM Customers WHERE NOT Country = 'Spain';

-- Selecione clientes que não começam com a letra 'A':
SELECT * FROM Customers WHERE CustomerName NOT LIKE 'A%' ORDER BY CustomerName;

/*
O que é um valor NULL?
Um campo com valor NULL é um campo sem valor.
Se um campo em uma tabela for opcional, é possível inserir um novo registro ou atualizar um registro sem adicionar um valor a esse campo. 
Então, o campo será salvo com um valor NULL.
Nota: Um valor NULL é diferente de um valor zero ou de um campo que contém espaços. 
Um campo com um valor NULL é aquele que foi deixado em branco durante a criação do registro!
Como testar valores NULL?
Não é possível testar valores NULL com operadores de comparação, como =, < ou <>.
Teremos que usar os operadores IS NULL and IS NOT NULL em vez disso.
*/
-- Deixar alguns registros com o endereço NULL
UPDATE Customers SET Address = NULL WHERE CustomerID = 3 OR CustomerID = 5;
-- Selecionar espeficicamente os registro que não tem preenchimento no endereço
SELECT * FROM Customers WHERE Address IS NULL;

/*
Operador SQL IN
O operador IN permite que você especifique vários valores em uma cláusula WHERE.
O operador IN é uma abreviação para múltiplas condições OR.
*/
-- Retornar todos os clientes da 'Alemanha', 'França' ou 'Reino Unido'
SELECT * FROM Customers WHERE Country IN ('Germany', 'France', 'UK');

-- Retornar todos os clientes que NÃO são da 'Alemanha', 'França' ou 'Reino Unido':
SELECT * FROM Customers WHERE Country NOT IN ('Germany', 'France', 'UK');

/*
IN (SELECT)
Você também pode usar IN com uma subconsulta na cláusula WHERE.
Com uma subconsulta, você pode retornar todos os registros da consulta principal que estão presentes no resultado da subconsulta.
Nota: subconsulta é um select dentro de outro select isolado por ()
*/
-- Seleciona todos os clientes : Total 91
SELECT count(*) FROM Customers;
-- Retorna o ID de todos os clientes que fizeram algum pedido
SELECT DISTINCT CustomerID FROM Orders;
-- Retorna todos os clientes que têm um pedido na tabela Pedidos : Total 74
SELECT count(*) FROM Customers WHERE CustomerID IN (SELECT DISTINCT CustomerID FROM Orders);
-- Retorna todos os clientes que NÃO fizeram nenhum pedido na tabela Pedidos : Total 17
SELECT count(*) FROM Customers WHERE CustomerID NOT IN (SELECT DISTINCT CustomerID FROM Orders);

select * from Customers where country = 'Brazil';
select * from orders where Customerid in (15,21,31,34);
select * from orders where Customerid in (select Customerid from Customers where country = 'Brazil');