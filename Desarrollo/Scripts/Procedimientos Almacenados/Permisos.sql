-- =============================================
-- Autor: Carlos Fabrizio Arriola Carmona
-- Fecha Creación: 14/Octubre/2014
-- Descripción: Alta de permisos por usuario.
-- =============================================

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.sp_permisos_permiso_alta') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.sp_permisos_permiso_alta
GO

CREATE PROCEDURE sp_permisos_permiso_alta

	@UsuarioId			INT,
	@PermisoId			INT,
	@FechaModificacion	DATETIME
AS
BEGIN

SET NOCOUNT ON;

	 INSERT INTO PermisosUsuarios(UsuarioId, PermisoId, FechaModificacion)

	 VALUES(@UsuarioId, @PermisoId, @FechaModificacion)

END
GO

-- =============================================
-- Autor: Carlos Fabrizio Arriola Carmona
-- Fecha Creación: 14/Octubre/2014
-- Descripción: Baja de permisos por usuario.
-- =============================================

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.sp_permisos_permiso_eliminar') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.sp_permisos_permiso_eliminar
GO

CREATE PROCEDURE sp_permisos_permiso_eliminar

	@UsuarioId INT
AS
BEGIN

SET NOCOUNT ON;

	DELETE PermisosUsuarios
	WHERE UsuarioId = @UsuarioId

END