-- =============================================
-- Autor: Carlos Fabrizio Arriola Carmona
-- Fecha Creación: 01/Agosto/2014
-- Description: 
-- =============================================

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.sp_ordfab_FinProduccion') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.sp_ordfab_FinProduccion

GO

CREATE PROCEDURE sp_ordfab_FinProduccion

	@ordenfabricacion nvarchar(50),
	@ordencliente nvarchar(50)

AS
BEGIN
	
	SET NOCOUNT ON;

	UPDATE ordenfabricacion
		SET estatus = 'FIN DE PRODUCCION',
		    estado  = NULL
		WHERE ordenfabricacion = @ordenfabricacion

	IF @ordencliente <> 'INTERNA'
	BEGIN
		UPDATE ordencliente
			SET estado = 'TERMINADA'
			WHERE ordenfabricacion = @ordenfabricacion
	END

END
