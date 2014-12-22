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
	@Categoria varchar(30),
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
	@mod_alta varchar(40),
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

	 (codigo, Categoria, nombre, tipo, caducidad, color,
	  umedida, tipomateria, active, presentacion, cantidad,
	  comentarios, cliente, proveedor, propcliente, foto,
	  stockmin, stockmax, inven, moneda, cuentacontable,
	  desccuentacontable, pvf, fec_alta, mod_alta, usu_alta)

	  VALUES

	  (@codigo, @Categoria, @nombre, @tipo, @caducidad, @color,
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

	@codigo		        NVARCHAR(50),
	@nombre		        NVARCHAR(200),
	@Categoria          VARCHAR(30),
	@tipo		        NVARCHAR(50),
	@caducidad          NVARCHAR(50),
	@color		        NVARCHAR(50),
	@umedida            NVARCHAR(50),
	@tipomateria        NVARCHAR(50),
	@active		        NVARCHAR(50),
	@presentacion       NVARCHAR(50),
	@cantidad           NVARCHAR(50),
	@comentarios        NVARCHAR(50),
	@cliente            NVARCHAR(50),
	@proveedor	        NVARCHAR(50),
	@propcliente        NVARCHAR(50),
	@foto               NVARCHAR(200),
	@stockmin	        FLOAT, -- Stock y Movimientos
	@stockmax	        FLOAT,
	@inven		        FLOAT,
	@moneda			    NVARCHAR(50),
	@cuentacontable     NVARCHAR(50),
	@desccuentacontable NVARCHAR(50),
	@pvf                NVARCHAR(50),
	@fec_mod			DATETIME,
	@mod_mod			VARCHAR(40),
	@usu_mod			INT

AS
BEGIN

	SET NOCOUNT ON;
	UPDATE material

		SET 
			codigo = @codigo,
			nombre = @nombre,
			Categoria = @Categoria,
			tipo = @tipo,
			caducidad = @caducidad,
			color = @color,
			umedida = @umedida,
			tipomateria = @tipomateria,
			active = @active,
			presentacion =  @presentacion,
			cantidad = @cantidad,
			comentarios = @comentarios,
			cliente = @cliente,
			proveedor = @proveedor,
			propcliente = @propcliente,
			foto = @foto,
			stockmin = @stockmin,
			stockmax = @stockmax,
			inven = @inven,
			moneda = @moneda,
			cuentacontable = @cuentacontable,
			desccuentacontable = @desccuentacontable,
			pvf = @pvf,
			fec_mod = @fec_mod,
			mod_mod = @mod_mod,
			usu_mod = @usu_mod

			WHERE codigo = @codigo

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

	@nombre			NVARCHAR(100),
	@codigo			NVARCHAR(50),
	@precio			REAL,
	@umedida		NVARCHAR(50),
	@tipo			NVARCHAR(50),
	@propcliente	NVARCHAR(50),
	@cliente		NVARCHAR(50),
	@mod_alta		VARCHAR(15),
	@usu_alta		INT,
	@fec_alta		DATETIME

	
AS
BEGIN

	SET NOCOUNT ON;

	INSERT INTO proveedormaterial
	(nombre, codigo, precio, umedida, tipo,
	 propcliente, cliente, fechaalta, mod_alta, usu_alta,
	 fec_alta)

	VALUES
	(@nombre, @codigo, @precio, @umedida, @tipo, 
	 @propcliente, @cliente , @fec_alta, @mod_alta, @usu_alta,
	 @fec_alta)

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

	@Tipo		 VARCHAR(20),
	@Serie		 VARCHAR(10),
	@Consecutivo INT,
	@fec_mod	 DATETIME,
	@mod_mod     VARCHAR(40),
	@usu_mod     INT

AS
BEGIN

	SET NOCOUNT ON;

	INSERT INTO Folios(Tipo, Serie, Consecutivo , fec_mod, mod_mod, 
					   usu_mod)

	VALUES(@Tipo, @Serie, @Consecutivo, @fec_mod, @mod_mod, @usu_mod)

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

	@Serie		 VARCHAR(10),
	@Consecutivo INT,
	@fec_mod	 DATETIME,
	@usu_mod	 INT
	
AS
BEGIN

	SET NOCOUNT ON;

	UPDATE Folios

	SET Consecutivo = @Consecutivo,
	    fec_mod     = @fec_mod,
		usu_mod     = @usu_mod
		
	WHERE Serie     = @Serie
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
	@FechaEntrada datetime,
	@Factura		 NVARCHAR(50),
	@NumeroPedimento NVARCHAR(50)

AS
BEGIN

	SET NOCOUNT ON;

	INSERT INTO ocompra
	(norden, estatus, tipoorden, proveedor, dpto,
	 condpago, confpedido, tipocompra, fechaped, fechaent,
	 moneda, comen, autdcompras, autdfinanzas, autdproduccion,
	 resprecibe, subtotal, iva, totalorden, Elaboro,
	 FechaEntrada, Factura, NumeroPedimento)

	VALUES
	(@norden, @estatus, @tipoorden, @proveedor, @dpto,
	 @condpago, @confpedido, @tipocompra, @fechaped, @fechaent,
	 @moneda, @comen, @autdcompras, @autdfinanzas, @autdproduccion,
	 @resprecibe, @subtotal, @iva, @totalorden, @Elaboro,
	 @FechaEntrada, @Factura, @NumeroPedimento)
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

	@norden			 NVARCHAR(50),
	@FechaEntrada	 DATETIME,
	@Factura		 NVARCHAR(50),
	@NumeroPedimento NVARCHAR(50)

AS
BEGIN

	SET NOCOUNT ON;

    UPDATE ocompra
		  SET estatus     = 'X PAGAR',
		  FechaEntrada    = @FechaEntrada,
		  Factura		  = @Factura,
		  NumeroPedimento = @NumeroPedimento
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
-- Fecha Creación: 28/Octubre/2014
-- Descripción: Registro recivo de materiales.
-- =============================================

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.sp_mat_registro_recivo_materiales') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.sp_mat_registro_recivo_materiales
GO

CREATE PROCEDURE sp_mat_registro_recivo_materiales

	@registro		 NVARCHAR(50),
	@entrada		 NVARCHAR(50),
	@aprobadopor	 NVARCHAR(50),
	@estatus		 NVARCHAR(50),
	@almacen		 NVARCHAR(50),
	@derogacion		 NVARCHAR(50),
	@fechaderogacion DATETIME,
	@fichanc		 NVARCHAR (50),
	@fecha			 DATETIME,
	@ban1			 NVARCHAR(50),
	@ban2			 NVARCHAR(50),
	@ban3			 NVARCHAR(50)

AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO registrorecmat
	(registro, entrada, aprobadopor, estatus, almacen,
	 derogacion, fechaderogacion, fichanc, fecha, ban1,
	 ban2, ban3)
	 
	VALUES
	(@registro, @entrada, @aprobadopor, @estatus, @almacen,
	 @derogacion, @fechaderogacion, @fichanc, @fecha, @ban1,
	 @ban2, @ban3)

END
GO

-- =============================================
-- Autor: Carlos Fabrizio Arriola Carmona
-- Fecha Creación: 01/Noviembre/2014
-- Descripción: Agrega un registro a la tabla silo.
-- =============================================

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.sp_mat_alta_silo') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.sp_mat_alta_silo
GO

CREATE PROCEDURE sp_mat_alta_silo

	@codigosilo			NVARCHAR(50),
	@tequipo_codigo		NVARCHAR(50),
	@estatus			NVARCHAR(50),
	@material_codigo	NVARCHAR(50),
	@cargainicial		INT,
	@inven				INT,
	@producto_c_interno NVARCHAR(50),
	@fechacarga			DATETIME,
	@datosv_lprove		NVARCHAR(50),
	@ordenfabricacion   NVARCHAR(50),
	@material_tipo		NVARCHAR(50),
	@descripcion		NTEXT,
	@ban1				NVARCHAR(50),
	@ban2				NVARCHAR(50)

AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO silo
	(codigosilo, tequipo_codigo, estatus, material_codigo, cargainicial,
	 inven, producto_c_interno, fechacarga, datosv_lprove, ordenfabricacion,
	 material_tipo, descripcion, ban1, ban2) 

	 VALUES
	(@codigosilo, @tequipo_codigo, @estatus, @material_codigo, @cargainicial,
	 @inven, @producto_c_interno, @fechacarga, @datosv_lprove, @ordenfabricacion,
	 @material_tipo, @descripcion, @ban1, @ban2) 

END
GO

-- =============================================
-- Autor: Carlos Fabrizio Arriola Carmona
-- Fecha Creación: 01/Noviembre/2014
-- Descripción: Modifica un registro a la tabla silo.
-- =============================================

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.sp_mat_modificacion_silo') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.sp_mat_modificacion_silo
GO

CREATE PROCEDURE sp_mat_modificacion_silo

	@codigosilo			NVARCHAR(50),
	@estatus			NVARCHAR(50),
	@material_codigo	NVARCHAR(50),
	@material_tipo		NVARCHAR(50),
	@cargainicial		INT,
	@inven				INT,
	@datosv_lprove		NVARCHAR(50)

AS
BEGIN
	SET NOCOUNT ON;

    UPDATE silo
	SET    estatus         = @estatus,
		   material_codigo = @material_codigo,
		   material_tipo   = @material_tipo,
		   cargainicial    = @cargainicial,
		   inven		   = @inven,
		   datosv_lprove   = @datosv_lprove

	WHERE codigosilo = @codigosilo

END
GO

-- =============================================
-- Autor: Carlos Fabrizio Arriola Carmona
-- Fecha Creación: 07/Noviembre/2014
-- Descripción: Alta de registro en la tabla tlaymat
-- =============================================

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.sp_mat_alta_laymat') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.sp_mat_alta_laymat
GO

CREATE PROCEDURE sp_mat_alta_laymat

	@posicion	    NVARCHAR(50),
	@contenido      NVARCHAR(50),
	@cantidad       NVARCHAR(50),
	@unidad         NVARCHAR(50),
	@tipo           NVARCHAR(50),
	@porv           NVARCHAR(50),
	@porcm          NVARCHAR(50),
	@lote		    NVARCHAR(50),
	@fecha		    DATETIME,
	@hora		    DATETIME,
	@identificacion	NVARCHAR(50),
	@responsable	NVARCHAR(50),
	@comentarios    NVARCHAR(50),
	@ban1			NVARCHAR(50),
	@ban2			NVARCHAR(50)

AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO tlaymat

	(posicion, contenido, cantidad, unidad, tipo,
	 porv, porcm, lote, fecha, hora,
	 identificacion, responsable, comentarios, ban1, ban2)

	 VALUES
	 (@posicion, @contenido, @cantidad, @unidad, @tipo,
	  @porv, @porcm, @lote, @fecha, @hora,
	  @identificacion, @responsable, @comentarios, @ban1, @ban2)

END
GO

-- =============================================
-- Autor: Carlos Fabrizio Arriola Carmona
-- Fecha Creación: 01/Noviembre/2014
-- Descripción: Actualiza la tabla tlaymat por la ubicación.
-- =============================================

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.sp_mat_modificacion_laymat') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.sp_mat_modificacion_laymat
GO

CREATE PROCEDURE sp_mat_modificacion_laymat

	@posicion	    NVARCHAR(50),
	@contenido      NVARCHAR(50),
	@cantidad       NVARCHAR(50),
	@unidad         NVARCHAR(50),
	@tipo           NVARCHAR(50),
	@porv           NVARCHAR(50),
	@porcm          NVARCHAR(50),
	@lote		    NVARCHAR(50),
	@fecha		    DATETIME,
	@hora		    DATETIME,
	@identificacion	NVARCHAR(50),
	@responsable	NVARCHAR(50),
	@comentarios    NVARCHAR(50),
	@ban1			NVARCHAR(50),
	@ban2			NVARCHAR(50)

AS
BEGIN
	SET NOCOUNT ON;

	UPDATE tlaymat
			SET 
			    contenido      = @contenido,
				cantidad       = @cantidad,
				unidad         = @unidad,
				tipo           = @tipo,
				porv	       = @porv,
				porcm          = @porcm,
				lote	       = @lote,
				fecha          = @fecha,
				hora           = @hora,
				identificacion = @identificacion,
				responsable    = @responsable,
				comentarios    = @comentarios,
				ban1		   = @ban1,
				ban2		   = @ban2

			WHERE posicion = @posicion
END
GO

-- =============================================
-- Autor: Carlos Fabrizio Arriola Carmona
-- Fecha Creación: 01/Noviembre/2014
-- Descripción: Agrega un registro a la tabla notacarga.
-- =============================================

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.sp_mat_alta_notacarga') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.sp_mat_alta_notacarga
GO

CREATE PROCEDURE sp_mat_alta_notacarga

	@notadecarga		NVARCHAR(50),
	@tipom				NTEXT,
	@ordenfabricacion	NVARCHAR(50),
	@indiceof			NVARCHAR(50),
	@fecha				NVARCHAR(50),
	@hora				NVARCHAR(50),
	@codigomateria		NVARCHAR(50),
	@loteinterno		NVARCHAR(50),
	@loteexterno		NVARCHAR(50),
	@tecnico			NVARCHAR(50),
	@ccsilo				NVARCHAR(50),
	@ctsilo				NVARCHAR(50),
	@idensilo			NVARCHAR(50),
	@c_interno			NVARCHAR(50),
	@des_prod			NVARCHAR(50),
	@ban1				NVARCHAR(50),
	@ban2				NVARCHAR(50),
	@ban3				NVARCHAR(50)

AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO notacarga
	 (notadecarga, tipom, ordenfabricacion, indiceof, fecha,
	  hora, codigomateria, loteinterno, loteexterno, tecnico,
	  ccsilo, ctsilo, idensilo, c_interno, des_prod,
	  ban1, ban2, ban3)

	 VALUES
	 (@notadecarga, @tipom, @ordenfabricacion, @indiceof, @fecha,
	  @hora, @codigomateria, @loteinterno, @loteexterno, @tecnico,
	  @ccsilo, @ctsilo, @idensilo, @c_interno, @des_prod,
	  @ban1, @ban2, @ban3)

END
GO

-- =============================================
-- Autor: Carlos Fabrizio Arriola Carmona
-- Fecha Creación: 01/Noviembre/2014
-- Descripción: Agrega un registro a la tabla registroretornomaterial
-- =============================================

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.sp_mat_alta_registroretornomaterial') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.sp_mat_alta_registroretornomaterial
GO

CREATE PROCEDURE sp_mat_alta_registroretornomaterial

	@registro			NVARCHAR(50),
	@fecha				NVARCHAR(50),
	@hora				NVARCHAR(50),
	@almacen			NVARCHAR(50),
	@rack				NVARCHAR(50),
	@ubicacion			NVARCHAR(50),
	@material_codigo	NVARCHAR(50),
	@material_nombre	NVARCHAR(50),
	@datosv_lprove		NVARCHAR(50),
	@tecnico			NVARCHAR(50),
	@cantidad			NVARCHAR(50),
	@ban1				NVARCHAR(50),
	@ban2				NVARCHAR(50),
	@OrdenFabricacion   VARCHAR(9),
	@CantidadOriginal   VARCHAR(50),
	@Comentarios		VARCHAR(200)

AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO registroretornomaterial

	(registro, fecha, hora, almacen, rack,
	 ubicacion, material_codigo, material_nombre, datosv_lprove, tecnico,
	 cantidad, ban1, ban2, OrdenFabricacion, CantidadOriginal,
	 Comentarios)

	 VALUES
	 (@registro, @fecha, @hora, @almacen, @rack,
	  @ubicacion, @material_codigo, @material_nombre, @datosv_lprove, @tecnico,
	  @cantidad, @ban1, @ban2, @OrdenFabricacion, @CantidadOriginal,
	  @Comentarios)

END
GO

-- =============================================
-- Autor: Carlos Fabrizio Arriola Carmona
-- Fecha Creación: 01/Noviembre/2014
-- Descripción: Vacia el silo.
-- =============================================

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.sp_mat_vaciarsilo') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.sp_mat_vaciarsilo
GO

CREATE PROCEDURE sp_mat_vaciarsilo

	@codigosilo				NVARCHAR(50),
	@estatus				NVARCHAR(50),
	@material_codigo		NVARCHAR(50),
	@cargainicial			INT,
	@inven					INT,
	@producto_c_interno		NVARCHAR(50),
	@fechacarga				DATETIME,
	@datosv_lprove			NVARCHAR(50),
	@ordenfabricacion		NVARCHAR(50),
	@material_tipo			NVARCHAR(50),
	@descripcion			NTEXT

AS
BEGIN
	SET NOCOUNT ON;

	UPDATE silo
			SET 

			estatus		       = @estatus,
			material_codigo    = @material_codigo,
			cargainicial	   = @cargainicial,
			inven			   = @inven,
			producto_c_interno = @producto_c_interno,
			fechacarga		   = @fechacarga,
			datosv_lprove	   = @datosv_lprove,
			ordenfabricacion   = @ordenfabricacion,
			material_tipo	   = @material_tipo,
			descripcion		   = @descripcion

			WHERE codigosilo = @codigosilo

END
GO

-- =============================================
-- Autor: Carlos Fabrizio Arriola Carmona
-- Fecha Creación: 01/Noviembre/2014
-- Descripción: Consulta el inventario de materiales por almacen.
-- =============================================

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.sp_mat_ConsultaMaterialPorAlmacen') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].sp_mat_ConsultaMaterialPorAlmacen
GO

CREATE PROCEDURE sp_mat_ConsultaMaterialPorAlmacen

AS
BEGIN
	SET NOCOUNT ON;

SELECT ROW_NUMBER() OVER (ORDER BY codigo)  AS num, 
	codigo, material, TablaPivote.Categoria, TablaPivote.tipo, TablaPivote.pvf,
	TablaPivote.stockmin, TablaPivote.stockmax, 
	[RMP01], [MPC02], [MPNC01], [MPS03]
FROM
(
	SELECT DAT.codigo, DAT.material, MAT.Categoria, MAT.tipo, MAT.pvf,
	MAT.stockmin, MAT.stockmax, DAT.inven, DAT.stockv
	FROM datosv AS DAT
	LEFT JOIN material AS MAT
	ON DAT.codigo = MAT.codigo) AS SourceTable
PIVOT
(
	SUM(inven)
	FOR stockv IN ([RMP01], [MPC02], [MPNC01], [MPS03])
) AS TablaPivote;

END
GO

