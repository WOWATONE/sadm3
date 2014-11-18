-- =============================================
-- Autor: Carlos Fabrizio Arriola Carmona
-- Fecha Creación: 13/Noviembre/2014
-- Descripción: Modificacion de la columna cmcliente para agregar los productos ligados
-- a un molde.
-- =============================================

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.sp_moldesequipos_productomolde_modificacion') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.sp_moldesequipos_productomolde_modificacion
GO

CREATE PROCEDURE sp_moldesequipos_productomolde_modificacion

	@cminterno	        NVARCHAR(50),
	@ProductoClave		NVARCHAR(50)

AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @cmcliente	NVARCHAR(250)

	SET @cmcliente = (SELECT cmcliente 
					  FROM moldes 
					  WHERE cminterno = @cminterno)

	 UPDATE moldes
		SET 
			cmcliente = @cmcliente + @ProductoClave + '/ '

			WHERE cminterno = @cminterno

END
GO