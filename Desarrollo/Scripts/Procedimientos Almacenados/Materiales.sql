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
	@mod_alta varchar(15),
	@usu_alta int,

	@dpto nvarchar(50), -- modif
	@quien nvarchar(50),
	@clave nvarchar(50),
	@fecha datetime,
	@hora datetime,
	@modificacion nvarchar(200),
	@clienteproveedor nvarchar(50),
	@modulo nvarchar(50)
AS
BEGIN

	SET NOCOUNT ON;
	
	DECLARE @fechaActualServidor DATETIME
	SET  @fechaActualServidor = GETDATE()

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
	   @desccuentacontable, @pvf, @fechaActualServidor, @mod_alta, @usu_alta)

	   DECLARE @precioProveedor float 
	   SET @precioProveedor = CAST(@pvf as nvarchar(max))

	   INSERT INTO proveedormaterial
	   (nombre, codigo, propcliente, cliente, precio,
	    tipo, umedida, fechaalta, fec_alta, mod_alta, 
		usu_alta)

	    VALUES
	   (@proveedor, @codigo, @propcliente, @cliente, @precioProveedor, 
		@tipo, @umedida ,@fechaActualServidor, @fechaActualServidor, @mod_alta,
		@usu_alta)

		EXEC sp_movimientos_alta @dpto, @quien, @clave,  @fecha, @hora,
						    @codigo, @modificacion, 'NA', 'NA', @clienteproveedor,
						    'NA', 'NA', @modulo, 'NA', 'NA', null, null
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
	@mod_mod varchar(15),
	@usu_mod int,

	@dpto nvarchar(50), -- modif
	@quien nvarchar(50),
	@clave nvarchar(50),
	@fecha datetime,
	@hora datetime,
	@modificacion nvarchar(200),
	@clienteproveedor nvarchar(50),
	@modulo nvarchar(50)
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @fechaActualServidor DATETIME
	SET  @fechaActualServidor = GETDATE()

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
			fec_mod = @fechaActualServidor,
			mod_mod = @mod_mod,
			usu_mod = @usu_mod

			WHERE codigo = @codigo

			EXEC sp_movimientos_alta @dpto, @quien, @clave, @fecha, @hora,
						             @codigo, @modificacion, 'NA', 'NA', @clienteproveedor,
						             'NA', 'NA', @modulo, 'NA', 'NA', null, null	
END

-- =============================================
-- Autor: Carlos Fabrizio Arriola Carmona
-- Fecha Creación: 17/Septiembre/2014
-- Descripción: Modificación de material y proveedor de material para el módulo de Materiales.
-- =============================================

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.sp_mat_proveedormaterial_alta') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.sp_mat_proveedormaterial_alta
GO

CREATE PROCEDURE sp_mat_proveedormaterial_alta

	@nombre nvarchar(100),
	@codigo nvarchar(50),
	@precio real,
	@umedida nvarchar(50),
	@tipo nvarchar(50),
	@propcliente nvarchar(50),
	@cliente nvarchar(50),
	@mod_alta varchar(15),
	@usu_alta int
	
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @fechaActualServidor DATETIME
	SET  @fechaActualServidor = GETDATE()

	INSERT INTO proveedormaterial
	(nombre, codigo, precio, umedida, tipo,
	 propcliente, cliente, fechaalta, fec_alta, mod_alta, 
	 usu_alta)

	VALUES
	(@nombre, @codigo, @precio, @umedida, @tipo, 
	 @propcliente, @cliente , @fechaActualServidor, @fechaActualServidor, @mod_alta,
	 @usu_alta)

END

-- =============================================
-- Autor: Carlos Fabrizio Arriola Carmona
-- Fecha Creación: 19/Septiembre/2014
-- Descripción: Alta del folio para las ordenes de compra.
-- =============================================

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.sp_mat_ordencomprafolio_alta') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.sp_mat_ordencomprafolio_alta
GO

CREATE PROCEDURE sp_mat_ordencomprafolio_alta

	@Tipo VARCHAR(20),
	@Serie VARCHAR(10),
	@Consecutivo INT,
	@mod_mod VARCHAR(40),
	@usu_mod INT

AS
BEGIN

	SET NOCOUNT ON;

	INSERT INTO Folios(Tipo, Serie, Consecutivo, fec_mod, mod_mod, usu_mod)

	VALUES(@Tipo, @Serie, @Consecutivo, GETDATE(), @mod_mod, @usu_mod)

END


-- =============================================
-- Autor: Carlos Fabrizio Arriola Carmona
-- Fecha Creación: 19/Septiembre/2014
-- Descripción: Actualización del folio para las ordenes de compra.
-- =============================================

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.sp_mat_ordencomprafolio_modificacion') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.sp_mat_ordencomprafolio_modificacion
GO

CREATE PROCEDURE sp_mat_ordencomprafolio_modificacion

	@Tipo VARCHAR(20),
	@Serie VARCHAR(10),
	@Consecutivo INT,
	@mod_mod VARCHAR(40),
	@usu_mod INT

AS
BEGIN

	SET NOCOUNT ON;

	UPDATE Folios

	SET Consecutivo = @Consecutivo,
	    fec_mod     = GETDATE(),
		mod_mod     = @mod_mod,
		usu_mod     = @usu_mod

	WHERE Serie = @Serie

END


-- =============================================
-- Autor: Carlos Fabrizio Arriola Carmona
-- Fecha Creación: 19/Septiembre/2014
-- Descripción: Alta de maestro para la orden de compra.
-- =============================================

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.sp_mat_ordencompra_alta') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.sp_mat_ordencompra_alta
GO

CREATE PROCEDURE sp_mat_ordencompra_alta

	@norden nvarchar(50),
	@estatus nvarchar(50),
	@tipoorden nvarchar(50),
	@proveedor nvarchar(50),
	@dpto nvarchar(50),
	@condpago nvarchar(50),
	@confpedido nvarchar(50),
	@tipocompra nvarchar(50),
	@fechaped datetime,
	@fechaent datetime,
	@moneda nvarchar(50),
	@comen ntext,
    @autdcompras nvarchar(50),
	@autdfinanzas nvarchar(50),
	@autdproduccion nvarchar(50),
	@resprecibe nvarchar(50),
	@subtotal nvarchar(50),
	@iva nvarchar(50),
	@totalorden nvarchar(50)

AS
BEGIN

	SET NOCOUNT ON;

	INSERT INTO ocompra
	(norden, estatus, tipoorden, proveedor, dpto,
	 condpago, confpedido, tipocompra, fechaped, fechaent,
	 moneda, comen, autdcompras, autdfinanzas, autdproduccion,
	 resprecibe, subtotal, iva, totalorden)

	VALUES
	(@norden, @estatus, @tipoorden, @proveedor, @dpto,
	 @condpago, @confpedido, @tipocompra, @fechaped, @fechaent,
	 @moneda, @comen, @autdcompras, @autdfinanzas, @autdproduccion,
	 @resprecibe, @subtotal, @iva, @totalorden)

END