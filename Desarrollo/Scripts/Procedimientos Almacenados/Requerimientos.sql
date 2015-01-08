-- =============================================
-- Autor: Carlos Fabrizio Arriola Carmona
-- Fecha Creación: 18/Diciembre/2014
-- Description: Consulta de introducción requerimientos.
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
-- Description: Eliminación de requerimientos en base a un rango de fechas.
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
-- Description: Alta de requerimiento.
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
