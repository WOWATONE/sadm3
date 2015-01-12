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

	@FechaGenerada		DATETIME2,
	@SesionId			UNIQUEIDENTIFIER
AS
BEGIN

SET NOCOUNT ON;

SELECT PRO.c_interno, REQ.Requerimiento, REQ.PlanProduccion,
PRO.stockmin, PRO.material_codigo1, TIN.inven
FROM producto AS PRO 
LEFT JOIN Requerimientos AS REQ ON PRO.c_interno = REQ.c_interno AND
REQ.Mes = 'OCTUBRE' AND REQ.Año = 2014
LEFT JOIN tinven AS TIN ON TIN.c_interno = PRO.c_interno

WHERE PRO.estado = 'A' 

SELECT *
FROM PRODUCTO

SELECT *
FROM tinven

--	INSERT INTO table2 (WEEK, NoTrans, Spend)
--SELECT @WEEK, Transactions, Spend
--FROM table1 (NOLOCK)

END
GO

SELECT *
FROM producto
WHERE PRO.estado = 'A' 

select *
from requerimientos

select c_interno, sum(2500) AS PiezasProducidas
from etiquetaspallete
group by c_interno


select *
from etiquetaspallete