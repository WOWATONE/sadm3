-- =============================================
-- Autor: Carlos Fabrizio Arriola Carmona
-- Fecha Creación: 29/Julio/2014
-- Descripción: Alta de material y proveedor de material para el módulo de Materiales.
-- =============================================

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.sp_mat_materiales_alta') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.sp_mat_materiales_alta
GO

CREATE PROCEDURE sp_mat_materiales_alta

	@codigo nvarchar(50),
	@nombre nvarchar(200),
	@tipo   nvarchar(50),
	@caducidad nvarchar(50),
	@color nvarchar(50),
	@umedida nvarchar(50),
	@tipomateria nvarchar(50),
	@active nvarchar(50),
	@presentacion nvarchar(50),
	@cantidad nvarchar(50),
	@comentarios nvarchar(50),
	@cliente nvarchar(50),
	@proveedor nvarchar(50),
	@propcliente nvarchar(50),
	@foto nvarchar(200),
	@stockmin float, -- Stock y Movimientos
	@stockmax float,
	@inven float,
	@moneda nvarchar(50),
	@cuentacontable nvarchar(50),
	@desccuentacontable nvarchar(50),
	@pvf nvarchar(50),
	@fec_alta datetime,
	@mod_alta varchar(15),
	@usu_alta int

AS
BEGIN

	SET NOCOUNT ON;

	 INSERT INTO material

	 (codigo, nombre, tipo, caducidad, color,
	  umedida, tipomateria, active, presentacion, cantidad,
	  comentarios, cliente, proveedor, propcliente, foto,
	  stockmin, stockmax, inven, moneda, cuentacontable,
	  desccuentacontable, pvf, fec_alta, mod_alta, usu_alta)

	  VALUES

	  (@codigo, @nombre, @tipo, @caducidad, @color,
	   @umedida, @tipomateria, @active, @presentacion, @cantidad,
	   @comentarios, @cliente, @proveedor, @propcliente, @foto,
	   @stockmin, @stockmax, @inven, @moneda, @cuentacontable,
	   @desccuentacontable, @pvf, @fec_alta, @mod_alta, @usu_alta)

	   DECLARE @precioProveedor float 
	   SET @precioProveedor = CAST(@pvf as nvarchar(max))

	   INSERT INTO proveedormaterial
	   (nombre, codigo, propcliente, cliente, precio,
	    tipo, umedida, fechaalta, fec_alta, mod_alta, 
		usu_alta)

	    VALUES
	   (@proveedor, @codigo, @propcliente, @cliente, @precioProveedor, 
		@tipo, @umedida ,@fec_alta, @fec_alta, @mod_alta,
		@usu_alta)
END

-- =============================================
-- Autor: Carlos Fabrizio Arriola Carmona
-- Fecha Creación: 11/Agosto/2014
-- Descripción: Modificación de material y proveedor de material para el módulo de Materiales.
-- =============================================

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.sp_mat_materiales_modificacion') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.sp_mat_materiales_modificacion
GO

CREATE PROCEDURE sp_mat_materiales_modificacion

	@codigo nvarchar(50),
	@caducidad nvarchar(50),
	@tipomateria nvarchar(50),
	@active nvarchar(50),
	@presentacion nvarchar(50),
	@cantidad nvarchar(50),
	@comentarios nvarchar(50),
	@foto nvarchar(200),
	@stockmin float, -- Stock y Movimientos
	@stockmax float,
	@inven float,
	@moneda nvarchar(50),
	@cuentacontable nvarchar(50),
	@desccuentacontable nvarchar(50),
	@pvf nvarchar(50),
	@cliente nvarchar(50),
	@proveedor nvarchar(50),
	@propcliente nvarchar(50),
	@fec_mod datetime,
	@mod_mod varchar(15),
	@usu_mod int

AS
BEGIN

	SET NOCOUNT ON;

	UPDATE material

		SET 
			caducidad = @caducidad,
			tipomateria = @tipomateria,
			active = @active,
			presentacion = @presentacion,
			cantidad = @cantidad,
			comentarios = @comentarios,
			foto = @foto,
			stockmin =  @stockmin,
			stockmax = @stockmax,
			inven = @inven,
			moneda = @moneda,
			cuentacontable = @cuentacontable,
			desccuentacontable = @desccuentacontable,
			pvf = @pvf,
			cliente = @cliente,
			proveedor = @proveedor,
			propcliente = @propcliente,
			fec_mod = @fec_mod,
			mod_mod = @mod_mod,
			usu_mod = @usu_mod

			WHERE codigo = @codigo

END
