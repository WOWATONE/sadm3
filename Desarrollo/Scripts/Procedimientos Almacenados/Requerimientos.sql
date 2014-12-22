-- =============================================
-- Autor: Carlos Fabrizio Arriola Carmona
-- Fecha Creación: 18/Diciembre/2014
-- Description: Consulta de introducción requerimientos.
-- =============================================

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.sp_introduccion_requerimientos') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.sp_introduccion_requerimientos
GO

CREATE PROCEDURE sp_introduccion_requerimientos

	@Meses NVARCHAR (100)

AS
BEGIN

	SET NOCOUNT ON;


DECLARE @Consulta AS NVARCHAR(MAX)

SET @Consulta = 
N''


SELECT PRO.c_interno, PRO.cliente_nombre, PRO.maquina,
SUM(DAT.total)/12 AS PromedioMensual, TIN.inven
FROM producto AS PRO
LEFT JOIN datosr AS DAT ON PRO.c_interno = DAT.nparte
LEFT JOIN remisionr AS REM ON DAT.nremision = REM.nremision
LEFT JOIN tinven AS TIN ON PRO.c_interno = TIN.c_interno
LEFT JOIN requerimientos AS REQ ON PRO.c_interno = REQ.c_interno
WHERE REM.fechadate BETWEEN '20131201' AND '20141130 23:59:59'
AND REQ.FechaEntrada BETWEEN '2014-11-01' AND '2014-11-01'
GROUP BY PRO.c_interno, PRO.cliente_nombre, PRO.maquina, TIN.inven

SELECT  *
FROM requerimientos
------------------
SELECT *
FROM
(
	SELECT c_interno, mes, cant, 'CANT' as cant1
	FROM requerimientos
) AS R
PIVOT
(
	SUM(cant) FOR mes IN ([OCTUBRE], [NOVIEMBRE], [DICIEMBRE])
) AS pv1

UNION ALL

SELECT *
FROM
(
	SELECT c_interno, mes, PlanProduccion,'PLANPRODUCCION' as cant1
	FROM requerimientos
) AS R
PIVOT
(
	SUM(PlanProduccion) FOR mes IN ([OCTUBRE], [NOVIEMBRE], [DICIEMBRE])
) AS pv1



