-- https://www.hackerrank.com/challenges/select-all-sql/problem?isFullScreen=true
SELECT * FROM CITY

-- =============================================================================================

-- https://www.hackerrank.com/challenges/select-by-id/problem?isFullScreen=true
SELECT * FROM CITY WHERE ID = 1661;

-- ==============================================================================================

-- https://www.hackerrank.com/challenges/japanese-cities-attributes/problem?isFullScreen=true
SELECT * FROM CITY WHERE COUNTRYCODE = 'JPN';

-- ===============================================================================================

-- https://www.hackerrank.com/challenges/japanese-cities-name/problem?isFullScreen=true
SELECT NAME FROM CITY WHERE COUNTRYCODE = 'JPN';

-- ================================================================================================

-- https://www.hackerrank.com/challenges/revising-the-select-query/problem?isFullScreen=true

 SELECT * FROM CITY WHERE POPULATION > 100000 AND COUNTRYCODE = 'USA';

-- ==================================================================================================

-- https://www.hackerrank.com/challenges/revising-the-select-query-2/problem?isFullScreen=true

SELECT NAME FROM CITY WHERE POPULATION > 120000 AND COUNTRYCODE = 'USA';

-- =================================================================================================

-- https://www.hackerrank.com/challenges/weather-observation-station-1/problem?isFullScreen=true
SELECT CITY, STATE FROM STATION;

-- =================================================================================================

-- -- https://www.hackerrank.com/challenges/weather-observation-station-3/problem?isFullScreen=true
SELECT DISTINCT CITY FROM STATION WHERE MOD(ID,2) = 0;

-- =================================================================================================

-- https://www.hackerrank.com/challenges/weather-observation-station-4/problem?isFullScreen=true
SELECT COUNT(CITY) - COUNT(DISTINCT CITY)
FROM STATION;

-- =================================================================================================

-- https://www.hackerrank.com/challenges/weather-observation-station-5/problem?isFullScreen=true
(SELECT CITY, LENGTH(CITY)
FROM STATION
ORDER BY LENGTH(CITY) ASC, CITY ASC
LIMIT 1)
UNION
(SELECT CITY, LENGTH(CITY)
FROM STATION
ORDER BY LENGTH(CITY) DESC, CITY ASC
LIMIT 1)

-- ==================================================================================================

-- https://www.hackerrank.com/challenges/weather-observation-station-6/problem?isFullScreen=true

SELECT DISTINCT(CITY)
FROM STATION 
WHERE (CITY LIKE "A%") 
    OR (CITY LIKE "E%")
    OR (CITY LIKE "I%")
    OR (CITY LIKE "O%")
    OR (CITY LIKE "U%");

/* >> OPÇÃO 02 <<
SELECT DISTINCT(CITY)
FROM STATION 
WHERE CITY REGEXP '^[aeiou]'; -- fora dos colchetes indica o inicio da string, dentro do colchetes indica negação (NOT IN)
*/

/* >> OPÇÃO 03 <<
SELECT DISTINCT(CITY)
FROM STATION 
WHERE SUBSTR(CITY, 1, 1) IN ('A', 'E', 'I', 'O', 'U');
*/

-- ===================================================================================================

-- https://www.hackerrank.com/challenges/weather-observation-station-7/problem?isFullScreen=true

SELECT DISTINCT CITY
FROM STATION
WHERE CITY REGEXP '[aeiou]$' -- o sinal de cifrao indica o fim da string

/* >> Opcao 02
SELECT DISTINCT(CITY)
FROM STATION 
WHERE (CITY LIKE "%A") 
    OR (CITY LIKE "%E")
    OR (CITY LIKE "%I")
    OR (CITY LIKE "%O")
    OR (CITY LIKE "%U");
*/

-- ==================================================================================================

-- https://www.hackerrank.com/challenges/weather-observation-station-8/problem?isFullScreen=true

SELECT DISTINCT CITY
FROM STATION
WHERE 
    (CITY LIKE 'a%' OR CITY LIKE 'e%' OR CITY LIKE 'i%' OR CITY LIKE 'o%' OR CITY LIKE 'u%')
    AND
    (CITY LIKE '%a' OR CITY LIKE '%e' OR CITY LIKE '%i' OR CITY LIKE '%o' OR CITY LIKE '%u');

/* -- COM REGEXP --
SELECT DISTINCT CITY
FROM STATION
WHERE CITY REGEXP '^[aeiou].*[aeiou]$'; -- ^ - Indica inicio da string, $ - Indica o fim da string. O ".*" - Permite qualquer caractere no meio da string
*/

-- =====================================================================================================

-- https://www.hackerrank.com/challenges/weather-observation-station-9/problem?isFullScreen=true

SELECT DISTINCT CITY FROM STATION
WHERE CITY REGEXP '^[^aeiou]'

-- ==================================================================================================

-- https://www.hackerrank.com/challenges/weather-observation-station-10/problem?isFullScreen=true

SELECT DISTINCT CITY
FROM STATION
WHERE CITY NOT REGEXP '[aeiou]$'; -- NOT inverte o uso, entao nao termina em aeiou

-- =====================================================================================================

-- https://www.hackerrank.com/challenges/weather-observation-station-11/problem?isFullScreen=true

SELECT DISTINCT CITY 
FROM STATION
WHERE CITY NOT REGEXP '^[aeiou].*[aeiou]$' --  ".*" - Permite qualquer caractere no meio da string

-- =====================================================================================================

-- https://www.hackerrank.com/challenges/weather-observation-station-12/problem?isFullScreen=true

SELECT DISTINCT CITY 
FROM STATION
WHERE CITY NOT REGEXP '^[aeiou]'
AND CITY NOT REGEXP '[aeiou]$' -- AND atende a necessidade das duas condições serem verdadeiras

-- ====================================================================================================

-- https://www.hackerrank.com/challenges/more-than-75-marks/problem?isFullScreen=true

SELECT NAME
FROM STUDENTS
WHERE MARKS > 75
ORDER BY RIGHT(NAME, 3), ID ASC; -- RIGHT - ordena pelo os ultimos 3 caracteres começando da direita, caso seja igual ordena pela ID Crescente

-- ===============================================================================================================

-- https://www.hackerrank.com/challenges/name-of-employees/problem?isFullScreen=true
SELECT NAME
FROM EMPLOYEE
ORDER BY NAME

-- ==========================================================================================================

-- https://www.hackerrank.com/challenges/salary-of-employees/problem?isFullScreen=true

SELECT NAME
FROM EMPLOYEE
WHERE SALARY > 2000
AND MONTHS < 10
ORDER BY EMPLOYEE_ID