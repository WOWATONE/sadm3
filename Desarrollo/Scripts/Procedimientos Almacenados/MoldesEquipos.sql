-- =============================================
-- Autor: Carlos Fabrizio Arriola Carmona
-- Fecha Creación: 13/Noviembre/2014
-- Descripción: Alta de la relacion molde-producto.
-- =============================================

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.sp_moldesequipos_productomolde_alta') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.sp_moldesequipos_productomolde_alta
GO

CREATE PROCEDURE sp_moldesequipos_productomolde_alta

	@IdMolde	        INT,
	@c_interno			NVARCHAR(50)

AS
BEGIN

	SET NOCOUNT ON;

	INSERT INTO ProductosMoldes (IdMolde, c_interno)

	VALUES(@IdMolde, @c_interno)  

END
GO

-- =============================================
-- Autor: Carlos Fabrizio Arriola Carmona
-- Fecha Creación: 13/Noviembre/2014
-- Descripción: Baja de registro de la tabla ProductosMoldes.
-- =============================================

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.sp_moldesequipos_productomolde_eliminar') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.sp_moldesequipos_productomolde_eliminar
GO

CREATE PROCEDURE sp_moldesequipos_productomolde_eliminar

	@c_interno			NVARCHAR(50)

AS
BEGIN

	SET NOCOUNT ON;

	DELETE FROM
	ProductosMoldes
	WHERE c_interno	 = @c_interno	

END
GO