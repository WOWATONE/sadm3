-- =============================================
-- Autor: Carlos Fabrizio Arriola Carmona
-- Fecha Creación: 16/Octubre/2014
-- Descripción: Alta de registros para la tabla datosv.
-- =============================================

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.sp_datosv_alta') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.sp_datosv_alta
GO

CREATE PROCEDURE sp_datosv_alta

	@conse				INT,
	@material			NVARCHAR(200),
	@cantidad			NVARCHAR(50),
	@fecha				DATETIME,
	@proveedor			NVARCHAR(50),
	@entrada			NVARCHAR(50),
    @codigo				NVARCHAR(50),
	@lprove				NVARCHAR(50),
	@norden				NVARCHAR(50),
	@stockv				NVARCHAR(50),
	@inven				FLOAT,
	@estado				NVARCHAR(50),
	@comentarios		NTEXT,
	@ordenfabricacion	NVARCHAR(50),
	@ubicacion			NVARCHAR(50),
	@ban1				NVARCHAR(50),
	@ban2				NVARCHAR(50),
	@ban3				NVARCHAR(50),
	@LoteInterno		NVARCHAR(50),
	@ReferenciaLoteId	INT,
	@ClaseResina		VARCHAR(100)	
	
AS
BEGIN

	SET NOCOUNT ON;

	INSERT INTO datosv

	(conse, material, cantidad, fecha, proveedor,
	 entrada, codigo, lprove, norden, stockv,
	 inven, estado, comentarios, ordenfabricacion, ubicacion,
	 ban1, ban2, ban3, LoteInterno, ReferenciaLoteId,
	 ClaseResina)

	 VALUES

	 (@conse, @material, @cantidad, @fecha, @proveedor,
	  @entrada, @codigo, @lprove, @norden, @stockv,
	  @inven, @estado, @comentarios, @ordenfabricacion, @ubicacion,
	  @ban1, @ban2, @ban3, @LoteInterno, @ReferenciaLoteId,
	  @ClaseResina)
END
GO

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
	@comentarios    NTEXT,
	@ubicacion		NVARCHAR(50)

AS
BEGIN
	SET NOCOUNT ON;

    UPDATE datosv
	SET   stockv      = @stockv,
		  estado      = @estado,
		  comentarios = @comentarios,
		  ubicacion   = @ubicacion
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

	@conse2				INT,
	@inven				FLOAT,
	@stockv				NVARCHAR(50),
	@ubicacion			NVARCHAR(50),
	@ordenfabricacion   NVARCHAR(50)

AS
BEGIN

	SET NOCOUNT ON;

	UPDATE  datosv
			SET   inven            = @inven,
				  stockv           = @stockv,
			      ubicacion		   = @ubicacion,
				  ordenfabricacion = @ordenfabricacion
			WHERE conse2           = @conse2
END
GO

-- =============================================
-- Autor: Carlos Fabrizio Arriola Carmona
-- Fecha Creación: 14/Enero/2015
-- Descripción: Procedimiento almacenado para establecer a nulo algunos valores.
-- =============================================

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.sp_datosv_PasarMaterialSilo') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.sp_datosv_PasarMaterialSilo
GO

CREATE PROCEDURE sp_datosv_PasarMaterialSilo

		@ordenfabricacion   NVARCHAR(50),
		@ubicacion			NVARCHAR(50),
		@conse2				INT,
		@stockv				NVARCHAR(50)	

AS
BEGIN

	SET NOCOUNT ON;

		UPDATE  datosv
			--SET   inven                = 0 ,
			SET
			      ordenfabricacion     = @ordenfabricacion,
				  ubicacion			   = @ubicacion,  
				  stockv               = @stockv
			WHERE conse2               = @conse2
END
GO

-- =============================================
-- Autor: Carlos Fabrizio Arriola Carmona
-- Fecha Creación: 19/Enero/2015
-- Descripción: Procedimiento utilizado para sumar cantidades de lotes.
-- =============================================

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.sp_datosv_SumarLotes') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.sp_datosv_SumarLotes
GO

CREATE PROCEDURE sp_datosv_SumarLotes

		@ordenfabricacion   NVARCHAR(50),
		@ubicacion			NVARCHAR(50),
		@conse2				INT,
		@stockv				NVARCHAR(50),
		@inven				FLOAT

AS
BEGIN

	SET NOCOUNT ON;

		UPDATE  datosv
			SET   inven             = @inven,
			      ordenfabricacion  = @ordenfabricacion,
				  ubicacion			= @ubicacion,  
				  stockv            = @stockv
			WHERE conse2            = @conse2

END
GO

-- =============================================
-- Autor: Carlos Fabrizio Arriola Carmona
-- Fecha Creación: 27/Febrero/2014
-- Descripción: Actualiza la cantidad de inventario de un registro.
-- =============================================

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.sp_datosv_ActualizarInventario') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.sp_datosv_ActualizarInventario
GO

CREATE PROCEDURE sp_datosv_ActualizarInventario

	@conse2    INT,
	@inven	   FLOAT

AS
BEGIN
	SET NOCOUNT ON;

    UPDATE datosv
		  SET inven = @inven
		  WHERE conse2 = @conse2

END
GO

-- =============================================
-- Autor: Carlos Fabrizio Arriola Carmona
-- Fecha Creación: 20/Marzo/2015
-- Descripción: Elimina un registro de la tabla de datosv.
-- =============================================

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.sp_datosv_baja') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.sp_datosv_baja
GO

CREATE PROCEDURE sp_datosv_baja

	@conse2    INT

AS
BEGIN
	SET NOCOUNT ON;

    DELETE datosv
    WHERE conse2 = @conse2

END
GO

-- =============================================
-- Autor: Carlos Fabrizio Arriola Carmona
-- Fecha Creación: 20/Marzo/2015
-- Descripción: Actualiza un registro de la tabla de datosv.
-- =============================================

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.sp_datosv_ActualizarMezcla') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.sp_datosv_ActualizarMezcla
GO

CREATE PROCEDURE sp_datosv_ActualizarMezcla

	@conse2       INT,
	@inven	      FLOAT,
	@ubicacion    NVARCHAR(50),
	@LoteInterno  NVARCHAR(50)

AS
BEGIN
	SET NOCOUNT ON;

    UPDATE datosv
	SET inven       = @inven,
	    ubicacion   = @ubicacion,
		LoteInterno = @LoteInterno

    WHERE conse2 = @conse2

END
GO


-- =============================================
-- Autor: Carlos Fabrizio Arriola Carmona
-- Fecha Creación: 20/Marzo/2015
-- Descripción: Elimina un registro de la tabla de datosv.
-- =============================================

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.sp_datosv_ActualizarMezcla2') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.sp_datosv_ActualizarMezcla2
GO

CREATE PROCEDURE sp_datosv_ActualizarMezcla2

	@conse2       INT,
	@inven	      FLOAT,
	@ubicacion    NVARCHAR(50)

AS
BEGIN
	SET NOCOUNT ON;

    UPDATE datosv
	SET inven       = @inven,
	    ubicacion   = @ubicacion

    WHERE conse2 = @conse2

END
GO
