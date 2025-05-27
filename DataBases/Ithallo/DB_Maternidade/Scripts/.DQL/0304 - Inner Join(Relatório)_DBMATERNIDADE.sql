USE DB_MATERNIDADE;

-- Junção de informações do parto 
-- ====================================================================================================================
-- SELECT * FROM SNITB004_BEBE;
-- Query to retrieve detailed information about newborns, their mothers, and attending doctors
SELECT 
    TBB.NO_BEBE AS "Nome do bebê"
    , DATE_FORMAT(TBB.DT_NASCIMENTO, '%d/%m/%Y') AS "Data de Nascimento"
    , CONCAT(TBB.QT_PESO, " quilogramas") AS "Peso do bebê"
    , CONCAT(TBB.VL_ALTURA, " centímetros") AS "Altura do bebê"
    , TM.NO_MEDICO AS "Nome do médico"
    , TMAE.NO_MAE AS "Nome da mãe"
    , TMAE.NR_RG AS "RG da mãe"
    , TMAE.NR_TELEFONE_MAE AS "Telefone da mãe"
    , TMAE.ED_MAE AS "Endereço completo da mãe"
FROM SNITB004_BEBE TBB
INNER JOIN SNITB002_MEDICO TM ON TM.ID_MEDICO = TBB.ID_MEDICO
INNER JOIN SNITB001_MAE TMAE ON TMAE.ID_MAE = TBB.ID_MAE;
