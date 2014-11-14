-- =============================================
-- Autor: Carlos Fabrizio Arriola Carmona
-- Fecha Creación: 16/Octubre/2014
-- Descripción: Alta de registros para la tabla datosv.
-- =============================================

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.sp_datosv_alta') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.sp_datosv_alta
GO

CREATE PROCEDURE sp_datosv_alta

	@conse int,
	@material nvarchar(200),
	@cantidad nvarchar(50),
	@fecha datetime,
	@proveedor nvarchar(50),
	@entrada nvarchar(50),
    @codigo nvarchar(50),
	@lprove nvarchar(50),
	@norden nvarchar(50),
	@stockv nvarchar(50),
	@inven float,
	@estado nvarchar(50),
	@comentarios ntext,
	@ordenfabricacion nvarchar(50),
	@ubicacion nvarchar(50),
	@ban1 nvarchar(50),
	@ban2 nvarchar(50),
	@ban3 nvarchar(50),
	@LoteInterno nvarchar(50)
	
AS
BEGIN

	SET NOCOUNT ON;

	INSERT INTO datosv

	(conse, material, cantidad, fecha, proveedor,
	 entrada, codigo, lprove, norden, stockv,
	 inven, estado, comentarios, ordenfabricacion, ubicacion,
	 ban1, ban2, ban3, LoteInterno)

	 VALUES

	 (@conse, @material, @cantidad, @fecha, @proveedor,
	  @entrada, @codigo, @lprove, @norden, @stockv,
	  @inven, @estado, @comentarios, @ordenfabricacion, @ubicacion,
	  @ban1, @ban2, @ban3, @LoteInterno)

END

-- =============================================
-- Autor: Carlos Fabrizio Arriola Carmona
-- Fecha Creación: 16/Octubre/2014
-- Descripción: Modificación de registros para la tabla datosv cuando se pasa a silo de producción.
-- =============================================

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.sp_datosv_modificacion') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.sp_datosv_modificacion
GO

CREATE PROCEDURE sp_datosv_modificacion

	@conse2		INT,
	@stockv		NVARCHAR(50),
	@ubicacion	NVARCHAR(50)

AS
BEGIN

	SET NOCOUNT ON;

	UPDATE  datosv
			SET   stockv    = @stockv,
			      ubicacion = @ubicacion
			WHERE conse2    = @conse2
END
GO

-- =============================================
-- Autor: Carlos Fabrizio Arriola Carmona
-- Fecha Creación: 24/Octubre/2014
-- Descripción: Asigna la ubicación al material. 
-- =============================================

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.sp_datosv_asignar_ubicacion_rmp01') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.sp_datosv_asignar_ubicacion_rmp01
GO

CREATE PROCEDURE sp_datosv_asignar_ubicacion_rmp01

	@conse2    INT,
	@ubicacion NVARCHAR(50)

AS
BEGIN
	SET NOCOUNT ON;

    UPDATE datosv
		  SET ubicacion = @ubicacion
		  WHERE conse2 = @conse2

END
GO

-- =============================================
-- Autor: Carlos Fabrizio Arriola Carmona
-- Fecha Creación: 28/Octubre/2014
-- Descripción: Asigna la disposición del material.
-- =============================================

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.sp_datosv_asignar_conformidad') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.sp_datosv_asignar_conformidad
GO

CREATE PROCEDURE sp_datosv_asignar_conformidad

	@conse2		    INT,
	@stockv	        NVARCHAR(50),
	@estado	        NVARCHAR(50),
	@comentarios    NTEXT

AS
BEGIN
	SET NOCOUNT ON;

    UPDATE datosv
	SET   stockv      = @stockv,
		  estado      = @estado,
		  comentarios = @comentarios
	WHERE conse2   = @conse2

END
GO

-- =============================================
-- Autor: Carlos Fabrizio Arriola Carmona
-- Fecha Creación: 16/Octubre/2014
-- Descripción: Modificación de registros para la tabla datosv cuando se 
-- regresa cantidad a MPC02.
-- =============================================

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.sp_datosv_asignar_regreso_MPS02') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.sp_datosv_asignar_regreso_MPS02
GO

CREATE PROCEDURE sp_datosv_asignar_regreso_MPS02

	@conse2		INT,
	@inven      FLOAT,
	@stockv		NVARCHAR(50),
	@ubicacion	NVARCHAR(50)

AS
BEGIN

	SET NOCOUNT ON;

	UPDATE  datosv
			SET   inven     = @inven,
				  stockv    = @stockv,
			      ubicacion = @ubicacion
			WHERE conse2    = @conse2
END
GO
