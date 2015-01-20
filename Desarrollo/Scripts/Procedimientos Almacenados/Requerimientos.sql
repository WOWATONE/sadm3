-- =============================================
-- Autor: Carlos Fabrizio Arriola Carmona
-- Fecha Creación: 18/Diciembre/2014
-- Descripción: Consulta de introducción requerimientos.
-- =============================================

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.sp_req_requerimientos_consulta') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.sp_req_requerimientos_consulta
GO

CREATE PROCEDURE sp_req_requerimientos_consulta

	@Consulta  NVARCHAR (MAX)

AS
BEGIN

	SET NOCOUNT ON;

EXEC sp_executesql @Consulta

END
GO

-- =============================================
-- Autor: Carlos Fabrizio Arriola Carmona
-- Fecha Creación: 06/Enero/2015
-- Descripción: Eliminación de requerimientos en base a un rango de fechas.
-- =============================================

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.sp_req_requerimientos_eliminar') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.sp_req_requerimientos_eliminar
GO

CREATE PROCEDURE sp_req_requerimientos_eliminar

	@FechaInicio VARCHAR(10),
	@FechaFin	 VARCHAR(10)
AS
BEGIN

	SET NOCOUNT ON;

	DELETE FROM
	Requerimientos
	WHERE FechaEntrada BETWEEN @FechaInicio AND @FechaFin

END
GO

-- =============================================
-- Autor: Carlos Fabrizio Arriola Carmona
-- Fecha Creación: 06/Enero/2015
-- Descripción: Alta de requerimiento.
-- =============================================

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.sp_req_requerimientos_alta') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.sp_req_requerimientos_alta
GO

CREATE PROCEDURE sp_req_requerimientos_alta
	
		@c_interno			NVARCHAR (50),
		@Mes				NVARCHAR (15),
		@Año				SMALLINT,
		@Estatus			NVARCHAR(50),
		@Requerimiento		INT,
		@PlanProduccion		INT,
		@FechaEntrada		DATE,
		@MesPlanProduccion	NVARCHAR (15)

AS
BEGIN

	SET NOCOUNT ON;

	INSERT INTO Requerimientos(c_interno, Mes, Año, Estatus, Requerimiento,
							   PlanProduccion, FechaEntrada, MesPlanProduccion)

	VALUES (@c_interno, @Mes, @Año, @Estatus, @Requerimiento,
			@PlanProduccion, @FechaEntrada, @MesPlanProduccion)

END
GO

-- =============================================
-- Autor: Carlos Fabrizio Arriola Carmona
-- Fecha Creación: 09/Enero/2015
-- Descripción: Consulta de requerimientos mensuales.
-- =============================================

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.sp_req_requerimientos_mensuales_consulta') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.sp_req_requerimientos_mensuales_consulta
GO

CREATE PROCEDURE sp_req_requerimientos_mensuales_consulta

	@FechaGenerada				DATETIME2,
	@FechaGeneradaDiaAnterior   DATETIME2,
	@SesionId					UNIQUEIDENTIFIER,
	@Mes						NVARCHAR(15),
	@Año						SMALLINT

AS
BEGIN

SET NOCOUNT ON;

DELETE 
FROM RequerimientosMensuales
WHERE FechaGenerada <= @FechaGeneradaDiaAnterior

INSERT INTO RequerimientosMensuales 
(SesionId, FechaGenerada, CodigoInterno, Requerimiento, InventarioProd,
StockMin, HorasSMin, PlanProduccion, PiezasProducidas, PEnviado,
RestaPorEnviar, PPorProducir, HProd, ResInv, ResPorProducir,
Resina, HorasInven)

SELECT @SesionId, @FechaGenerada, PRO.c_interno AS CodigoInterno, REQ.Requerimiento, TIN.inven AS InventarioProd,
PRO.stockmin AS StockMin, 0 AS HorasSMin, REQ.PlanProduccion AS PlanProduccion, ETISUB.PiezasProducidas, 0 AS PEnviado,
0 AS RestaPorEnviar, 0 AS PPorProducir, 0 AS HProd, 0 AS ResInv, 0 AS ResPorProducir,
PRO.material_codigo1 AS Resina, 0 AS HorasInven
FROM producto AS PRO 
LEFT JOIN Requerimientos AS REQ ON PRO.c_interno = REQ.c_interno AND
REQ.Mes = @Mes AND REQ.Año = @Año
LEFT JOIN tinven AS TIN ON TIN.c_interno = PRO.c_interno
LEFT JOIN 
(
SELECT ETI.c_interno, SUM(piezas) AS PiezasProducidas
FROM etiquetaspallete AS ETI
GROUP BY ETI.c_interno
) AS ETISUB ON ETISUB.c_interno = PRO.c_interno
WHERE PRO.estado = 'A' 

SELECT REQMEN.CodigoInterno, ISNULL(REQMEN.Requerimiento, 'NO REQ') AS Requerimiento, REQMEN.InventarioProd,
REQMEN.StockMin, 
 CASE 
      WHEN REQMEN.InventarioProd < REQMEN.StockMin 
	  THEN 
		(REQMEN.StockMin - REQMEN.InventarioProd) / ((3600/PROD.cicloreal) * PROD.cavidad) +

		((REQMEN.StockMin - REQMEN.InventarioProd) / ((3600/PROD.cicloreal) * PROD.cavidad)) * (1 -(PROD.eficiencia / 100))
	  ELSE 0

END AS HorasSMin, 
REQMEN.PlanProduccion, REQMEN.PiezasProducidas, REQMEN.PEnviado


, REQMEN.RestaPorEnviar, 
REQMEN.PPorProducir, REQMEN.HProd, REQMEN.ResInv, REQMEN.ResPorProducir,
REQMEN.Resina, REQMEN.HorasInven
FROM RequerimientosMensuales AS REQMEN
LEFT JOIN producto AS PROD ON REQMEN.CodigoInterno = PROD.c_interno

WHERE SesionId = @SesionId  

END
GO

DECLARE @SesionId uniqueidentifier
SET @SesionId = NEWID()

EXEC sp_req_requerimientos_mensuales_consulta '2015/01/17', '2015/01/16', @SesionId, 'OCTUBRE', 2014

select *
from RequerimientosMensuales

delete from
RequerimientosMensuales

select *
from producto


SELECT SUM(total)
FROM datos
