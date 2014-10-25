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
GO

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
GO

-- =============================================
-- Autor: Carlos Fabrizio Arriola Carmona
-- Fecha Creación: 13/Octubre/2014
-- Descripción: Baja de la orden de compra.
-- =============================================

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.sp_mat_ordencompra_eliminar') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.sp_mat_ordencompra_eliminar
GO

CREATE PROCEDURE sp_mat_ordencompra_eliminar

	@norden nvarchar(50)

AS
BEGIN

	SET NOCOUNT ON;

	DELETE ocompra
    WHERE norden = @norden

END
GO

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
GO

-- =============================================
-- Autor: Carlos Fabrizio Arriola Carmona
-- Fecha Creación: 19/Septiembre/2014
-- Descripción: Alta del folio para las ordenes de compra.
-- =============================================

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.sp_mat_ordencomprafolio_alta') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.sp_mat_ordencomprafolio_alta
GO

CREATE PROCEDURE sp_mat_ordencomprafolio_alta

	@Consecutivo INT,
	@mod_mod VARCHAR(40),
	@usu_mod INT

AS
BEGIN

	SET NOCOUNT ON;

	INSERT INTO Folios(Tipo, Serie, Consecutivo, fec_mod, mod_mod, usu_mod)

	VALUES('ORDENCOMPRA', 'PO', @Consecutivo, GETDATE(), @mod_mod, @usu_mod)

END
GO

-- =============================================
-- Autor: Carlos Fabrizio Arriola Carmona
-- Fecha Creación: 19/Septiembre/2014
-- Descripción: Actualización del folio para dara de alta las ordenes de compra.
-- =============================================

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.sp_mat_ordencomprafolio_modificacion') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.sp_mat_ordencomprafolio_modificacion
GO

CREATE PROCEDURE sp_mat_ordencomprafolio_modificacion

	@Consecutivo INT,
	@usu_mod INT

AS
BEGIN

	SET NOCOUNT ON;

	UPDATE Folios

	SET Consecutivo = @Consecutivo,
	    fec_mod     = GETDATE(),
		usu_mod     = @usu_mod
		
	WHERE Serie     = 'PO'
END
GO

-- =============================================
-- Autor: Carlos Fabrizio Arriola Carmona
-- Fecha Creación: 23/Septiembre/2014
-- Descripción: Actualización del folio para modificar las ordenes de compra.
-- =============================================

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.sp_mat_ordencomprafoliomodif_modificacion') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.sp_mat_ordencomprafoliomodif_modificacion
GO

CREATE PROCEDURE sp_mat_ordencomprafoliomodif_modificacion

	@usu_mod INT

AS
BEGIN

	SET NOCOUNT ON;

	UPDATE Folios

	SET fec_mod     = GETDATE(),
		usu_mod     = @usu_mod
		
	WHERE Serie     = 'PO'
END
GO

-- =============================================
-- Autor: Carlos Fabrizio Arriola Carmona
-- Fecha Creación: 19/Septiembre/2014
-- Descripción: Alta del maestro para la orden de compra.
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
	@totalorden nvarchar(50),
	@Elaboro int,
	@FechaEntrada datetime

AS
BEGIN

	SET NOCOUNT ON;

	INSERT INTO ocompra
	(norden, estatus, tipoorden, proveedor, dpto,
	 condpago, confpedido, tipocompra, fechaped, fechaent,
	 moneda, comen, autdcompras, autdfinanzas, autdproduccion,
	 resprecibe, subtotal, iva, totalorden, Elaboro,
	 FechaEntrada)

	VALUES
	(@norden, @estatus, @tipoorden, @proveedor, @dpto,
	 @condpago, @confpedido, @tipocompra, @fechaped, @fechaent,
	 @moneda, @comen, @autdcompras, @autdfinanzas, @autdproduccion,
	 @resprecibe, @subtotal, @iva, @totalorden, @Elaboro,
	 @FechaEntrada)
END
GO

-- =============================================
-- Autor: Carlos Fabrizio Arriola Carmona
-- Fecha Creación: 19/Septiembre/2014
-- Descripción: Modificación del maestro para la orden de compra.
-- =============================================

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.sp_mat_ordencompra_modificacion') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.sp_mat_ordencompra_modificacion
GO

CREATE PROCEDURE sp_mat_ordencompra_modificacion

	@norden nvarchar(50),
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
	@subtotal nvarchar(50),
	@iva nvarchar(50),
	@totalorden nvarchar(50)

AS
BEGIN

	SET NOCOUNT ON;

	UPDATE ocompra
		SET 
		    tipoorden   = @tipoorden,
			proveedor   = @proveedor,
			dpto	    = @dpto,
			condpago    = @condpago,
			confpedido  = @confpedido,
			tipocompra  = @tipocompra,
			fechaped    = @fechaped,
			fechaent    = @fechaent,
			moneda      = @moneda,
			comen       = @comen,
			subtotal    = @subtotal,
			iva         = @iva,
			totalorden  = @totalorden

		WHERE norden = @norden
END
GO

-- =============================================
-- Autor: Carlos Fabrizio Arriola Carmona
-- Fecha Creación: 19/Septiembre/2014
-- Descripción: Establece el estado de la orden de compra a cancelado.
-- =============================================

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.sp_mat_ordencompra_cancelar') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.sp_mat_ordencompra_cancelar
GO

CREATE PROCEDURE sp_mat_ordencompra_cancelar

	@norden nvarchar(50)

AS
BEGIN

	SET NOCOUNT ON;

		UPDATE ocompra
		SET  estatus = 'CANCELADA'
		WHERE norden = @norden
END
GO

-- =============================================
-- Autor: Carlos Fabrizio Arriola Carmona
-- Fecha Creación: 19/Septiembre/2014
-- Descripción: Alta del detalle para la orden de compra.
-- =============================================

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.sp_mat_ordencompradetalle_alta') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.sp_mat_ordencompradetalle_alta
GO

CREATE PROCEDURE sp_mat_ordencompradetalle_alta

	@norden nvarchar(50),
	@cantidad nvarchar(50),
	@concepto nvarchar(200),
	@preciouni nvarchar(50),
	@importedet nvarchar(50),
	@unimed nvarchar(50),
	@CantidadPedida nvarchar(50),
	@Lote varchar(30),
	@NumeroItem int,
	@ImporteSD nvarchar(50),
	@Descuento decimal(5,2),
	@CodigoMaterial nvarchar(200)

AS
BEGIN

	SET NOCOUNT ON;

	INSERT INTO detocompra
	(norden, cantidad, concepto, preciouni, importedet,
	 unimed, CantidadPedida, Lote, NumeroItem, ImporteSD,
	 Descuento, CodigoMaterial)
	 
	VALUES
	(@norden, @cantidad, @concepto, @preciouni, @importedet,
	 @unimed, @CantidadPedida, @Lote, @NumeroItem, @ImporteSD,
	 @Descuento, @CodigoMaterial)

END
GO

-- =============================================
-- Autor: Carlos Fabrizio Arriola Carmona
-- Fecha Creación: 19/Septiembre/2014
-- Descripción: Baja del detalle para la orden de compra.
-- =============================================

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.sp_mat_ordencompradetalle_eliminar') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.sp_mat_ordencompradetalle_eliminar
GO

CREATE PROCEDURE sp_mat_ordencompradetalle_eliminar

	@norden nvarchar(50)

AS
BEGIN

	SET NOCOUNT ON;

	DELETE detocompra
    WHERE norden = @norden

END
GO

-- =============================================
-- Autor: Carlos Fabrizio Arriola Carmona
-- Fecha Creación: 01/Octubre/2014
-- Descripción: Cambio de estatus para autorizar compras.
-- =============================================

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.sp_mat_ordencompra_autorizar_compras') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.sp_mat_ordencompra_autorizar_compras
GO

CREATE PROCEDURE sp_mat_ordencompra_autorizar_compras

	@norden nvarchar(50)

AS
BEGIN

	SET NOCOUNT ON;

	UPDATE ocompra
		  SET  autdcompras = 'OK'
		  WHERE norden = @norden

END
GO

-- =============================================
-- Autor: Carlos Fabrizio Arriola Carmona
-- Fecha Creación: 01/Octubre/2014
-- Descripción: Cambio de estatus para autorizar finanzas.
-- =============================================

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.sp_mat_ordencompra_autorizar_finanzas') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.sp_mat_ordencompra_autorizar_finanzas
GO

CREATE PROCEDURE sp_mat_ordencompra_autorizar_finanzas

	@norden nvarchar(50)

AS
BEGIN

	SET NOCOUNT ON;

	UPDATE ocompra
		  SET  autdfinanzas = 'OK'
		  WHERE norden = @norden

END
GO

-- =============================================
-- Autor: Carlos Fabrizio Arriola Carmona
-- Fecha Creación: 01/Octubre/2014
-- Descripción: Cambio de estatus para autorizar producción.
-- =============================================

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.sp_mat_ordencompra_autorizar_produccion') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.sp_mat_ordencompra_autorizar_produccion
GO

CREATE PROCEDURE sp_mat_ordencompra_autorizar_produccion

	@norden nvarchar(50)

AS
BEGIN

	SET NOCOUNT ON;

	UPDATE ocompra
		  SET  autdproduccion = 'OK'
		  WHERE norden = @norden

END
GO

-- =============================================
-- Autor: Carlos Fabrizio Arriola Carmona
-- Fecha Creación: 01/Octubre/2014
-- Descripción: Cambio de estatus de la orden de compra.
-- =============================================

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.sp_mat_ordencompra_estatus_porconfirmar') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.sp_mat_ordencompra_estatus_porconfirmar
GO

CREATE PROCEDURE sp_mat_ordencompra_estatus_porconfirmar

	@norden nvarchar(50)

AS
BEGIN

	SET NOCOUNT ON;

    UPDATE ocompra
		  SET estatus = 'X CONFIRMAR'
		  WHERE norden = @norden

END
GO

-- =============================================
-- Autor: Carlos Fabrizio Arriola Carmona
-- Fecha Creación: 07/Octubre/2014
-- Descripción: Cambio de estatus de la orden de compra.
-- =============================================

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.sp_mat_ordencompra_estatus_porrecibir') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.sp_mat_ordencompra_estatus_porrecibir
GO

CREATE PROCEDURE sp_mat_ordencompra_estatus_porrecibir
	@norden nvarchar(50)
AS
BEGIN

	SET NOCOUNT ON;

    UPDATE ocompra
		  SET estatus = 'X RECIBIR'
		  WHERE norden = @norden

END
GO

-- =============================================
-- Autor: Carlos Fabrizio Arriola Carmona
-- Fecha Creación: 06/Octubre/2014
-- Descripción: Cambio de estatus de la orden de compra.
-- =============================================

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.sp_mat_ordencompra_estatus_porpagar') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.sp_mat_ordencompra_estatus_porpagar
GO

CREATE PROCEDURE sp_mat_ordencompra_estatus_porpagar		

	@norden nvarchar(50),
	@FechaEntrada datetime

AS
BEGIN

	SET NOCOUNT ON;

    UPDATE ocompra
		  SET estatus = 'X PAGAR',
		  FechaEntrada  = @FechaEntrada
		  WHERE norden = @norden

END
GO

-- =============================================
-- Autor: Carlos Fabrizio Arriola Carmona
-- Fecha Creación: 06/Octubre/2014
-- Descripción: Cambio de estatus de la orden de compra.
-- =============================================

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.sp_mat_ordencompra_estatus_pagada') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.sp_mat_ordencompra_estatus_pagada
GO

CREATE PROCEDURE sp_mat_ordencompra_estatus_pagada

	@norden nvarchar(50)

AS
BEGIN
	SET NOCOUNT ON;

    UPDATE ocompra
		  SET estatus = 'PAGADA'
		  WHERE norden = @norden

END
GO

-- =============================================
-- Autor: Carlos Fabrizio Arriola Carmona
-- Fecha Creación: 10/Octubre/2014
-- Descripción: Cambio de estatus de la orden de compra.
-- =============================================

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.sp_mat_ordencompra_estatus_historica') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.sp_mat_ordencompra_estatus_historica
GO

CREATE PROCEDURE sp_mat_ordencompra_estatus_historica

	@norden nvarchar(50)

AS
BEGIN
	SET NOCOUNT ON;

    UPDATE ocompra
		  SET estatus = 'HISTORICA'
		  WHERE norden = @norden

END
GO

-- =============================================
-- Autor: Carlos Fabrizio Arriola Carmona
-- Fecha Creación: 24/Octubre/2014
-- Descripción: Asigna la ubicación al material. 
-- =============================================

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.sp_mat_asignar_ubicacion_rmp01') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.sp_mat_asignar_ubicacion_rmp01
GO

CREATE PROCEDURE sp_mat_asignar_ubicacion_rmp01

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