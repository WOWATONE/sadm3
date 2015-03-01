-- =============================================
-- Autor: Carlos Fabrizio Arriola Carmona
-- Fecha Creación: 22/Julio/2014
-- Description: Alta de productos para el módulo de productos, clientes, proveedores.
-- =============================================

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.sp_pcp_prod_alta') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.sp_pcp_prod_alta
GO

CREATE PROCEDURE sp_pcp_prod_alta

	@desc_prod nvarchar (200),
	@c_interno nvarchar (50),
	@cliente_nombre nvarchar (100),
	@desc_com nvarchar (50),
	@pesoneto nvarchar (50),
	@peso nvarchar (50),
	@eficiencia nvarchar (50),
	@ciclo nvarchar (50),
	@material_codigo1 nvarchar (50),
	@porc1 nvarchar (50),
	@material_codigo2 nvarchar (50),
	@porc2 nvarchar (50),
	@estado nvarchar (50),
	@c_cliente nvarchar (100),
	@linea nvarchar(50),
	@nivelrevision nvarchar(50),
	@maquina nvarchar(50),
	@TipoProceso nvarchar(30),
	@TipoProducto nvarchar(20),
	@precioinven nvarchar (50),
	@precio nvarchar (50),
	@factor nvarchar(50),
	@foto nvarchar(200),
	@num_orden nvarchar(50),	-- Detalle
	@aql nvarchar(100),
	@caducidad nvarchar(50),
	@plandecontrol nvarchar(50),
	@cavidad nvarchar(50),
	@minmen nvarchar(50),
	@opmaq nvarchar(50),
	@no_item varchar(20),
	@molde nvarchar(50),
	@stockmin nvarchar(50),
	@stockmax nvarchar(50),
	@e_lote int,
	@codigodibujo nvarchar(100),
	@niving nvarchar(50),
	@fa nvarchar(50),
	@e_bolsa int,
	@e_loteb int,
	@e_caja int,
	@e_lotec int,
	@comen VARCHAR(MAX),
	@mod_alta varchar(40),
	@usu_alta int,
	@TiempoMontaje	DECIMAL(7, 2),
	@TiempoDesmontaje DECIMAL(7, 2),
	@dpto nvarchar(50), -- modif
	@quien nvarchar(50),
	@clave nvarchar(50),
	@fecha datetime,
	@hora datetime,
	@codigo nvarchar(100),
	@modificacion nvarchar(200),
	@ordenfabricacion nvarchar(50),
	@ordencliente nvarchar(50),
	@clienteproveedor nvarchar(50),
	@ubicacion nvarchar(50),
	@lote nvarchar(50),
	@modulo nvarchar(50),
	@cantidad nvarchar(50),
	@almacen nvarchar(50)

AS
BEGIN

	SET NOCOUNT ON;

	 INSERT INTO producto

			(desc_prod, c_interno, cliente_nombre, desc_com, pesoneto,
			 peso, eficiencia, ciclo, material_codigo1, porc1,
			 material_codigo2, porc2, estado, c_cliente, linea,
			 nivelrevision, maquina, TipoProceso, TipoProducto, precioinven,
			 precio, factor, foto,
			 num_orden, aql, caducidad, plandecontrol, cavidad,
			 minmen, opmaq, no_item, molde, stockmin, stockmax, 
			 e_lote, codigodibujo, niving, fa,
			 e_bolsa, e_loteb, e_caja, e_lotec, comen,
			 fec_alta, mod_alta, usu_alta, TiempoMontaje, TiempoDesmontaje)
			 
			 VALUES
			(@desc_prod, @c_interno, @cliente_nombre, @desc_com, @pesoneto,
			 @peso, @eficiencia, @ciclo, @material_codigo1, @porc1,
			 @material_codigo2, @porc2, @estado, @c_cliente, @linea,
			 @nivelrevision, @maquina, @TipoProceso, @TipoProducto, @precioinven,
			 @precio, @factor, @foto,
			 @num_orden, @aql, @caducidad, @plandecontrol, @cavidad,
			 @minmen, @opmaq, @no_item, @molde, @stockmin, @stockmax, 
			 @e_lote, @codigodibujo, @niving, @fa,
			 @e_bolsa, @e_loteb, @e_caja, @e_lotec, @comen,
			 GETDATE(), @mod_alta, @usu_alta, @TiempoMontaje, @TiempoDesmontaje)

   --  INSERT INTO tinven
		 --   (c_interno, c_num, inven, stockmin, stockmax)

			--VALUES
			--(@c_cliente + ' Rev:' + @nivelrevision, 'c_num', 0, @stockmin, @stockmax)

	
	EXEC sp_movimientos_alta @dpto, @quien, @clave, @fecha, @hora,
						    @codigo, @modificacion, @ordenfabricacion, @ordencliente, @clienteproveedor,
						    @ubicacion, @lote, @modulo, @cantidad, @almacen, null, null

END
GO

-- =============================================
-- Autor: Carlos Fabrizio Arriola Carmona
-- Fecha Creación: 24/Julio/2014
-- Description: Modificación de productos para el modulo de productos, clientes, proveedores.
-- =============================================

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.sp_pcp_prod_modificar') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.sp_pcp_prod_modificar
GO

CREATE PROCEDURE sp_pcp_prod_modificar
	
	@c_interno			NVARCHAR (50),
	@desc_prod			NVARCHAR(200),
	@cliente_nombre		NVARCHAR(100),
	@desc_com           NVARCHAR (50),
	@pesoneto           NVARCHAR (50),
	@peso               NVARCHAR (50),
	@eficiencia         NVARCHAR (50),
	@ciclo				NVARCHAR (50),
	@material_codigo1	NVARCHAR (50),
	@material_codigo2	NVARCHAR (50),
	@porc1				NVARCHAR (50),
	@porc2				NVARCHAR (50),
	@estado				NVARCHAR (50),
	@c_cliente		    NVARCHAR (100),
	@linea				NVARCHAR (50),
	@nivelrevision		NVARCHAR (50),
	@maquina			NVARCHAR (50),
	@TipoProceso		NVARCHAR (30),
	@TipoProducto		NVARCHAR (20),
	@precioinven		NVARCHAR (50),
	@precio				NVARCHAR (50),
	@factor				NVARCHAR (50),
	@foto				NVARCHAR(200),
	@num_orden			NVARCHAR(50),
	@aql				NVARCHAR(100),
	@caducidad			NVARCHAR(50),
	@plandecontrol		NVARCHAR(50),
	@cavidad			NVARCHAR(50),
	@minmen				NVARCHAR(50),
	@opmaq				NVARCHAR(50),
	@no_item			VARCHAR(20),
	@molde				NVARCHAR(50),
	@stockmin			NVARCHAR(50),
	@stockmax			NVARCHAR(50),
	@e_lote				INT,
	@codigodibujo		NVARCHAR(100),
	@niving				NVARCHAR(50),
	@fa					NVARCHAR(50),
	@e_bolsa			INT,
	@e_loteb			INT,
	@e_caja				INT,
	@e_lotec			INT,
	@comen				VARCHAR(MAX),
	@mod_mod			VARCHAR(40),
	@fec_mod			DATETIME,
	@usu_mod			INT,
	@TiempoMontaje		DECIMAL(7, 2),
	@TiempoDesmontaje	DECIMAL(7, 2)

AS
BEGIN

	SET NOCOUNT ON;

	 UPDATE producto

	 SET cliente_nombre = @cliente_nombre,		
	 	 desc_prod = @desc_prod,
		 desc_com = @desc_com,
		 pesoneto = @pesoneto,
		 peso = @peso,
		 eficiencia = @eficiencia,
		 ciclo = @ciclo,
		 material_codigo1 = @material_codigo1,
		 material_codigo2 = @material_codigo2,
		 porc1 = @porc1,
		 porc2 = @porc2,
		 estado = @estado,
		 c_cliente = @c_cliente,
		 linea = @linea,
		 nivelrevision = @nivelrevision,
		 maquina = @maquina,
		 TipoProceso = @TipoProceso,
		 TipoProducto = @TipoProducto,
		 precioinven = @precioinven,
		 precio = @precio,
		 factor = @factor,
		 foto = @foto,
		 num_orden = @num_orden,
		 aql = @aql,
		 caducidad = @caducidad,
		 plandecontrol = @plandecontrol,
		 cavidad = @cavidad,
		 minmen = @minmen,
		 opmaq = @opmaq,
		 no_item = @no_item,
		 molde= @molde,
		 stockmin = @stockmin,
		 stockmax = @stockmax,
		 e_lote = @e_lote,
		 codigodibujo  = @codigodibujo,
		 niving = @niving,
		 fa = @fa,
		 e_bolsa = @e_bolsa,
		 e_loteb = @e_loteb,
		 e_caja = @e_caja,
		 e_lotec = @e_lotec,
		 comen = @comen,
		 mod_mod = @mod_mod,
		 fec_mod = GETDATE(),
		 usu_mod = @usu_mod,
		 TiempoMontaje	= @TiempoMontaje,
	     TiempoDesmontaje = @TiempoDesmontaje

		 WHERE c_interno = @c_interno
END
GO

-- =============================================
-- Autor: Carlos Fabrizio Arriola Carmona
-- Fecha Creación: 11/Sept/2014
-- Description: Alta de Inventario para el modulo de productos, clientes, proveedores.
-- =============================================
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.sp_pcp_inventario_alta') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.sp_pcp_inventario_alta
GO

CREATE PROCEDURE sp_pcp_inventario_alta

		@c_interno nvarchar(50),
		@stockmin int,
		@stockmax int

AS
BEGIN

	SET NOCOUNT ON;

	 INSERT INTO tinven(c_interno, c_num, inven, stockmin, stockmax)

	 VALUES(@c_interno, 'c_num', 0, @stockmin, @stockmax)
END

-- =============================================
-- Autor: Carlos Fabrizio Arriola Carmona
-- Fecha Creación: 11/Sept/2014
-- Description: Alta de Componente para el modulo de productos, clientes, proveedores.
-- =============================================
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.sp_pcp_inventario_componente_alta') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.sp_pcp_inventario_componente_alta
GO

CREATE PROCEDURE sp_pcp_inventario_componente_alta

		@c_interno nvarchar(50),
		@codigo nvarchar(50),
		@ban1 nvarchar(50),
		@cantidad int
AS
BEGIN

	SET NOCOUNT ON;

	 INSERT INTO componente(c_interno, codigo, ban1, cantidad)

	 VALUES(@c_interno, @codigo, @ban1, @cantidad)
END
GO

-- =============================================
-- Autor: Carlos Fabrizio Arriola Carmona
-- Fecha Creación: 12/Sept/2014
-- Description: Eliminación de Componentes para el modulo de productos, clientes, proveedores.
-- =============================================
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.sp_pcp_inventario_componente_eliminar') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.sp_pcp_inventario_componente_eliminar
GO

CREATE PROCEDURE sp_pcp_inventario_componente_eliminar

		@c_interno nvarchar(50)
AS
BEGIN

	SET NOCOUNT ON;

	 DELETE componente
	 WHERE c_interno = @c_interno

END
GO

-- =============================================
-- Autor: Carlos Fabrizio Arriola Carmona
-- Fecha Creación: 11/Sept/2014
-- Description: Alta de Empaque para el modulo de productos, clientes, proveedores.
-- =============================================
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.sp_pcp_inventario_empaque_alta') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.sp_pcp_inventario_empaque_alta
GO

CREATE PROCEDURE sp_pcp_inventario_empaque_alta

		@c_interno nvarchar(50),
		@empaque nvarchar(50),
		@cantidad float,
		@ban1 nvarchar(50)
AS
BEGIN

	SET NOCOUNT ON;

	 INSERT INTO empaque(c_interno, empaque, cantidad, ban1)

	 VALUES(@c_interno, @empaque, @cantidad, @ban1)
END
GO

-- =============================================
-- Autor: Carlos Fabrizio Arriola Carmona
-- Fecha Creación: 11/Sept/2014
-- Description: Modificación de Empaque para el modulo de productos, clientes, proveedores.
-- =============================================
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.sp_pcp_inventario_empaque_eliminar') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.sp_pcp_inventario_empaque_eliminar
GO

CREATE PROCEDURE sp_pcp_inventario_empaque_eliminar

		@c_interno nvarchar(50)
AS
BEGIN

	SET NOCOUNT ON;

	 DELETE empaque
	 WHERE c_interno = @c_interno

END
GO

-- =============================================
-- Autor: Carlos Fabrizio Arriola Carmona
-- Fecha Creación: 29/Julio/2014
-- Description: Alta de cliente para el módulo de productos, clientes, proveedores.
-- =============================================
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.sp_pcp_cliente_alta') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.sp_pcp_cliente_alta
GO

CREATE PROCEDURE sp_pcp_cliente_alta

	@nombre nvarchar(240),
	@nombre_comp nvarchar(240),
	@VF nvarchar(50),
	@c_proveedor nvarchar(50),
	@cuentacontable nvarchar(50),
	@nombre_fact nvarchar(240),
	@direccion ntext,
	@active nvarchar(50),
	@rfc nvarchar(50),
	@pitex nvarchar(50),
	@desccuentacontable nvarchar(100),
	@pais nvarchar(50),
	@ciudad nvarchar(240),
	@expv nvarchar(50), --Export/import
	@pedido nvarchar(50),
	@ciudad_fact nvarchar(50),
	@agente nvarchar(240),
	@embarcado ntext ,
	@direccion_fact ntext,
	@reglas ntext,
	@impv nvarchar(50),
	@actividad nvarchar(50),
	@diasemb nvarchar(50),
	@incoterms nvarchar(50),
	@pais_emb nvarchar(50),
	@pais_fact nvarchar(50),
	@maquila nvarchar(50),
	@patente nvarchar (50),
	@contacto1 nvarchar(120),
	@mail1 nvarchar(50),
	@telefono1 nvarchar(50),
	@fax1 nvarchar(50),
	@funcion1 nvarchar(50),
	@contacto2 nvarchar(120),
	@mail2 nvarchar(50),
	@telefono2 nvarchar(50),
	@fax2 nvarchar(50),
	@funcion2 nvarchar(50),
	@moneda nvarchar(50),
	@modopago nvarchar(50),
	@cuenta1 nvarchar(50),
	@cep1 ntext,
	@credito ntext,
	@metodopago nvarchar(50),
	@iva nvarchar(50),
	@descuento nvarchar(50),
	@cep2 ntext,
	@mod_alta varchar(40),
	@usu_alta int,

	@dpto nvarchar(50), -- modif
	@quien nvarchar(50),
	@clave nvarchar(50),
	@fecha datetime,
	@hora datetime,
	@codigo nvarchar(100),
	@modificacion nvarchar(200),
	@ordenfabricacion nvarchar(50),
	@ordencliente nvarchar(50),
	@clienteproveedor nvarchar(50),
	@ubicacion nvarchar(50),
	@lote nvarchar(50),
	@modulo nvarchar(50),
	@cantidad nvarchar(50),
	@almacen nvarchar(50),
	@Tipo		VARCHAR(20),
	@col_fact	NVARCHAR(50),
	@tax_id		NVARCHAR(50),
	@codigopais NVARCHAR(50),
	@monedapais NVARCHAR(50),
	@cod_postal NVARCHAR(50),
	@num_ob10	NVARCHAR(50)

AS
BEGIN

	SET NOCOUNT ON;

	 INSERT INTO cliente

	 (nombre, nombre_comp, VF, c_proveedor, cuentacontable,
	  nombre_fact, direccion, active, rfc, pitex,
	  desccuentacontable, pais, ciudad, expv, pedido,
	  ciudad_fact, agente, embarcado, direccion_fact, reglas,
	  impv, actividad, diasemb, incoterms, pais_emb,
	  pais_fact, maquila, patente, contacto1, mail1,
	  telefono1, fax1, funcion1, contacto2, mail2,
	  telefono2, fax2, funcion2, moneda, modopago,
	  cuenta1, cep1, credito, metodopago, iva,
	  descuento, cep2, fec_alta, mod_alta, usu_alta,
	  Tipo, col_fact, tax_id, codigopais, monedapais,
	  cod_postal, num_ob10)

	  VALUES
	  (@nombre, @nombre_comp, @VF, @c_proveedor, @cuentacontable,
	   @nombre_fact, @direccion, @active, @rfc, @pitex,
	   @desccuentacontable, @pais, @ciudad, @expv, @pedido,
	   @ciudad_fact, @agente, @embarcado, @direccion_fact, @reglas,
	   @impv, @actividad, @diasemb, @incoterms, @pais_emb,
	   @pais_fact, @maquila, @patente,  @contacto1, @mail1,
	   @telefono1, @fax1, @funcion1, @contacto2, @mail2,
	   @telefono2, @fax2, @funcion2, @moneda, @modopago,
	   @cuenta1, @cep1, @credito, @metodopago, @iva,
	   @descuento, @cep2, GETDATE(), @mod_alta, @usu_alta,
	   @Tipo, @col_fact, @tax_id, @codigopais, @monedapais,
	   @cod_postal, @num_ob10)

	   EXEC sp_movimientos_alta @dpto, @quien, @clave, @fecha, @hora,
						    @codigo, @modificacion, @ordenfabricacion, @ordencliente, @clienteproveedor,
						    @ubicacion, @lote, @modulo, @cantidad, @almacen, null, null

END
GO

-- =============================================
-- Autor: Carlos Fabrizio Arriola Carmona
-- Fecha Creación: 30/Julio/2014
-- Description: Modificación de cliente para el módulo de productos, clientes, proveedores.
-- =============================================

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.sp_pcp_cliente_modificacion') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.sp_pcp_cliente_modificacion
GO

CREATE PROCEDURE sp_pcp_cliente_modificacion

	@nombre nvarchar(240),
	@nombre_comp nvarchar(240),
	@VF nvarchar(50),
	@c_proveedor nvarchar(50),
	@cuentacontable nvarchar(50),
	@nombre_fact nvarchar(240),
	@direccion ntext,
	@active nvarchar(50),
	@rfc nvarchar(50),
	@pitex nvarchar(50),
	@desccuentacontable nvarchar(100),
	@pais nvarchar(50),
	@ciudad nvarchar(240),
	@expv nvarchar(50), --Export/import
	@pedido nvarchar(50),
	@ciudad_fact nvarchar(50),
	@agente nvarchar(240),
	@embarcado ntext ,
	@direccion_fact ntext,
	@reglas ntext,
	@impv nvarchar(50),
	@actividad nvarchar(50),
	@diasemb nvarchar(50),
	@incoterms nvarchar(50),
	@pais_emb nvarchar(50),
	@pais_fact nvarchar(50),
	@maquila nvarchar(50),
	@patente nvarchar (50),
	@contacto1 nvarchar(120),
	@mail1 nvarchar(50),
	@telefono1 nvarchar(50),
	@fax1 nvarchar(50),
	@funcion1 nvarchar(50),
	@contacto2 nvarchar(120),
	@mail2 nvarchar(50),
	@telefono2 nvarchar(50),
	@fax2 nvarchar(50),
	@funcion2 nvarchar(50),
	@moneda nvarchar(50),
	@modopago nvarchar(50),
	@cuenta1 nvarchar(50),
	@cep1 ntext,
	@credito ntext,
	@metodopago nvarchar(50),
	@iva nvarchar(50),
	@descuento nvarchar(50),
	@cep2 ntext,
	@mod_mod varchar(40),
	@usu_mod int,

	@dpto nvarchar(50), -- modif
	@quien nvarchar(50),
	@clave nvarchar(50),
	@fecha datetime,
	@hora datetime,
	@codigo nvarchar(100),
	@modificacion nvarchar(200),
	@ordenfabricacion nvarchar(50),
	@ordencliente nvarchar(50),
	@clienteproveedor nvarchar(50),
	@ubicacion nvarchar(50),
	@lote nvarchar(50),
	@modulo nvarchar(50),
	@cantidad nvarchar(50),
	@almacen nvarchar(50),
	@Tipo		VARCHAR(20),
	@col_fact	NVARCHAR(50),
	@tax_id		NVARCHAR(50),
	@codigopais NVARCHAR(50),
	@monedapais NVARCHAR(50),
	@cod_postal NVARCHAR(50),
	@num_ob10	NVARCHAR(50)

AS
BEGIN

		
	SET NOCOUNT ON;

	UPDATE cliente

		SET nombre_comp = @nombre_comp,
			VF = @VF,
			c_proveedor = @c_proveedor,
			cuentacontable = @cuentacontable,
			nombre_fact = @nombre_fact,
			direccion= @direccion,
			active = @active,
			rfc = @rfc,
			pitex = @pitex,
			desccuentacontable = @desccuentacontable,
			pais = @pais,
			ciudad = @ciudad,
			expv = @expv,
			pedido = @pedido,
			ciudad_fact = @ciudad_fact,
			agente = @agente,
			embarcado = @embarcado,
			direccion_fact = @direccion_fact,
			reglas = @reglas,
			impv = @impv,
			actividad = @actividad,
			diasemb = @diasemb,
			incoterms = @incoterms,
			pais_emb = @pais_emb,
			pais_fact = @pais_fact,
			maquila = @maquila,
			patente = @patente,
			contacto1 = @contacto1,
			mail1 = @mail1,
			telefono1 = @telefono1,
			fax1 = @fax1,
			funcion1 = @funcion1,
			contacto2 = @contacto2,
			mail2 = @mail2,
			telefono2 = @telefono2,
			fax2 = @fax2,
			funcion2 = @funcion2,
			moneda = @moneda,
			modopago = @modopago,
			cuenta1 = @cuenta1,
			cep1 = @cep1,
			credito = @credito,
			metodopago = @metodopago,
			iva = @iva,
			descuento = @descuento,
			cep2 = @cep2,
			fec_mod = GETDATE(),
			mod_mod  = @mod_mod,
			usu_mod  = @usu_mod,
			Tipo     = @Tipo,
			col_fact = @col_fact,
			tax_id	 = @tax_id,
			codigopais = @codigopais,
			monedapais = @monedapais,
			cod_postal = @cod_postal,	
			num_ob10  = @num_ob10
			 
			WHERE nombre = @nombre

   EXEC sp_movimientos_alta @dpto, @quien, @clave, @fecha, @hora,
						    @codigo, @modificacion, @ordenfabricacion, @ordencliente, @clienteproveedor,
						    @ubicacion, @lote, @modulo, @cantidad, @almacen, null, null
END
GO

-- =============================================
-- Autor: Carlos Fabrizio Arriola Carmona
-- Fecha Creación: 25/Julio/2014
-- Description: Alta de proveedor para el módulo de productos, clientes, proveedores.
-- =============================================

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.sp_pcp_prov_alta') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.sp_pcp_prov_alta
GO

CREATE PROCEDURE sp_pcp_prov_alta
	
	@nombre nvarchar(50),
	@razonsocial nvarchar(50),
	@cuentacontable nvarchar(50),
	@desccuentacontable nvarchar(50),
	@ciudad nvarchar(50),
	@pais nvarchar(50),
	@incoterms nvarchar(50),
	@rfc nvarchar(50),
	@direccion nvarchar(50),
	@comentarios ntext,
	@contacto nvarchar(50),
	@email nvarchar(50),
	@telefono nvarchar(50),
	@fax nvarchar(50),
	@funcion nvarchar(50),
	@mod_alta varchar(40),
	@usu_alta int,
	@CondicionesPago VARCHAR(10),
	@Moneda		     NVARCHAR(50),

	@dpto nvarchar(50), -- modif
	@quien nvarchar(50),
	@clave nvarchar(50),
	@fecha datetime,
	@hora datetime,
	@codigo nvarchar(100),
	@modificacion nvarchar(200),
	@ordenfabricacion nvarchar(50),
	@ordencliente nvarchar(50),
	@clienteproveedor nvarchar(50),
	@ubicacion nvarchar(50),
	@lote nvarchar(50),
	@modulo nvarchar(50),
	@cantidad nvarchar(50),
	@almacen nvarchar(50)


AS
BEGIN

	SET NOCOUNT ON;

	 INSERT INTO proveedor

	 (nombre, razonsocial, cuentacontable, desccuentacontable, ciudad,
	  pais, incoterms, rfc, direccion, comentarios,
	  contacto, email, telefono, fax, funcion,
	  fec_alta, mod_alta, usu_alta, CondicionesPago, Moneda)

	  VALUES

	  (@nombre, @razonsocial, @cuentacontable, @desccuentacontable, @ciudad,
	   @pais, @incoterms, @rfc, @direccion, @comentarios,
	   @contacto, @email, @telefono, @fax, @funcion,
	   GETDATE(), @mod_alta, @usu_alta, @CondicionesPago, @Moneda)

	   EXEC sp_movimientos_alta @dpto, @quien, @clave, @fecha, @hora,
								@codigo, @modificacion, @ordenfabricacion, @ordencliente, @clienteproveedor,
								@ubicacion, @lote, @modulo, @cantidad, @almacen,
								null, null


END
GO

-- =============================================
-- Autor: Carlos Fabrizio Arriola Carmona
-- Fecha Creación: 28/Julio/2014
-- Description: Modificación de proveedor para el módulo de productos, clientes, proveedores.
-- =============================================

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.sp_pcp_prov_modificar') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.sp_pcp_prov_modificar
GO

CREATE PROCEDURE sp_pcp_prov_modificar
	
	@nombre nvarchar(50),
	@razonsocial nvarchar(50),
	@cuentacontable nvarchar(50),
	@desccuentacontable nvarchar(50),
	@ciudad nvarchar(50),
	@pais nvarchar(50),
	@incoterms nvarchar(50),
	@rfc nvarchar(50),
	@direccion nvarchar(50),
	@comentarios ntext,
	@contacto nvarchar(50),
	@email nvarchar(50),
	@telefono nvarchar(50),
	@fax nvarchar(50),
	@funcion nvarchar(50),
	@mod_mod varchar(40),
	@usu_mod int,
	@CondicionesPago VARCHAR(10),
	@Moneda		     NVARCHAR(50),

	@dpto nvarchar(50), -- modif
	@quien nvarchar(50),
	@clave nvarchar(50),
	@fecha datetime,
	@hora datetime,
	@codigo nvarchar(100),
	@modificacion nvarchar(200),
	@ordenfabricacion nvarchar(50),
	@ordencliente nvarchar(50),
	@clienteproveedor nvarchar(50),
	@ubicacion nvarchar(50),
	@lote nvarchar(50),
	@modulo nvarchar(50),
	@cantidad nvarchar(50),
	@almacen nvarchar(50)

AS
BEGIN

	SET NOCOUNT ON;

	 UPDATE proveedor

	 SET razonsocial = @razonsocial,
		 cuentacontable = @cuentacontable,
		 desccuentacontable = @desccuentacontable,
		 ciudad = @ciudad,
		 pais = @pais,
		 incoterms = @incoterms,
		 rfc = @rfc,
		 direccion = @direccion,
		 comentarios = @comentarios,
		 contacto = @contacto,
		 email = @email,
		 telefono = @telefono,
		 fax = @fax,
		 funcion = @funcion,
		 fec_mod = GETDATE(),
		 mod_mod = @mod_mod,
		 usu_mod = @usu_mod,
		 CondicionesPago = @CondicionesPago,
		 Moneda = @Moneda

		 WHERE nombre = @nombre

		 EXEC sp_movimientos_alta @dpto, @quien, @clave, @fecha, @hora,
								@codigo, @modificacion, @ordenfabricacion, @ordencliente, @clienteproveedor,
								@ubicacion, @lote, @modulo, @cantidad, @almacen,
								null, null
END
GO

-- =============================================
-- Autor: Carlos Fabrizio Arriola Carmona
-- Fecha Creación: 28/Julio/2014
-- Description: Alta de producto para el módulo a de productos, clientes, proveedores.
-- =============================================

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.sp_pcp_prod_certificado_alta') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.sp_pcp_prod_certificado_alta
GO

CREATE PROCEDURE sp_pcp_prod_certificado_alta
	
	@id_prod_cc				INT,
	@c_interno				NVARCHAR(50),
	@no_cota				NVARCHAR(10),
	@caracteristicas		NVARCHAR(250),
	@resultados				NVARCHAR(250),
	@frecuencia_ins			NVARCHAR(250),
	@metodo_ins				NVARCHAR(250),
	@estudio_proc	 		NVARCHAR(250),
	@img_caracteristicas	NVARCHAR(250)

AS
BEGIN

	SET NOCOUNT ON;

	INSERT INTO producto_cc
	(id_prod_cc, c_interno, no_cota, caracteristicas, resultados, 
	 frecuencia_ins, metodo_ins, estudio_proc, img_caracteristicas)

	VALUES

	(@id_prod_cc, @c_interno, @no_cota, @caracteristicas, @resultados,
	  @frecuencia_ins, @metodo_ins, @estudio_proc, @img_caracteristicas	)

END
GO

-- =============================================
-- Autor: Carlos Fabrizio Arriola Carmona
-- Fecha Creación: 28/Julio/2014
-- Description: Modificación de producto para el módulo a de productos, clientes, proveedores.
-- =============================================

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.sp_pcp_prod_certificado_modificar') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.sp_pcp_prod_certificado_modificar
GO

CREATE PROCEDURE sp_pcp_prod_certificado_modificar
	
	@id_prod_cc				INT,
	@no_cota				NVARCHAR(10),
	@caracteristicas		NVARCHAR(250),
	@resultados				NVARCHAR(250),
	@frecuencia_ins			NVARCHAR(250),
	@metodo_ins				NVARCHAR(250),
	@estudio_proc			NVARCHAR(250),
	@img_caracteristicas	NVARCHAR(250)

AS
BEGIN

	SET NOCOUNT ON;

	  UPDATE producto_cc
		SET no_cota             = @no_cota,
			caracteristicas     = @caracteristicas,
			resultados          = @resultados,
			frecuencia_ins      = @frecuencia_ins,
			metodo_ins          = @metodo_ins,
			estudio_proc        = @estudio_proc,
			img_caracteristicas = @img_caracteristicas

		WHERE id_prod_cc = @id_prod_cc
END
GO