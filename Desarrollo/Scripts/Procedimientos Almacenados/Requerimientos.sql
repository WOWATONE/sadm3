-- =============================================
-- Autor: Carlos Fabrizio Arriola Carmona
-- Fecha Creación: 18/Diciembre/2014
-- Description: Consulta de introducción requerimientos.
-- =============================================

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.sp_req_introduccion_requerimientos') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.sp_req_introduccion_requerimientos
GO

CREATE PROCEDURE sp_req_introduccion_requerimientos

	@Consulta  NVARCHAR (MAX)

AS
BEGIN

	SET NOCOUNT ON;

EXEC sp_executesql @Consulta

END