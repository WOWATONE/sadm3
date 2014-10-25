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