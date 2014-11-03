-- =============================================
-- Autor: Carlos Fabrizio Arriola Carmona
-- Fecha Creación: 17/Octubre/2014
-- Descripción: Alta para la tabla modif.
-- =============================================

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.sp_movimientos_alta') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.sp_movimientos_alta
GO

CREATE PROCEDURE sp_movimientos_alta

	@dpto nvarchar(50),
	@quien   nvarchar(50),
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
	@ban1 nvarchar(50),
	@ban2 nvarchar(50)

AS
BEGIN

	SET NOCOUNT ON;

	 INSERT INTO modif
	 (dpto, quien, clave, fecha, hora, 
	  codigo, modificacion, ordenfabricacion, ordencliente, clienteproveedor,
      ubicacion, lote, modulo, cantidad, almacen,
      ban1, ban2)

	  VALUES

	  (@dpto, @quien, @clave, @fecha, @hora,
       @codigo, @modificacion, @ordenfabricacion, @ordencliente, @clienteproveedor,
       @ubicacion, @lote, @modulo, @cantidad, @almacen,
       @ban1, @ban2)
END