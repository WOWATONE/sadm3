-- =============================================
-- Autor: Carlos Fabrizio Arriola Carmona
-- Fecha Creación: 14/Octubre/2014
-- Descripción: Alta de permisos.
-- =============================================

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.sp_permisos_permiso_alta') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.sp_permisos_permiso_alta
GO

CREATE PROCEDURE sp_permisos_permiso_alta

	@ModuloSistemaId INT,
	@Permiso VARCHAR (100)

AS
BEGIN

SET NOCOUNT ON;

	 INSERT INTO Permisos(ModuloSistemaId, Permiso)

	 VALUES(@ModuloSistemaId, @Permiso)

END

-- =============================================
-- Autor: Carlos Fabrizio Arriola Carmona
-- Fecha Creación: 14/Octubre/2014
-- Description: Modificación de permisos.
-- =============================================

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.sp_permisos_permiso_modificar') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.sp_permisos_permiso_modificar
GO

CREATE PROCEDURE sp_permisos_permiso_modificar

	@PermisoId INT,
	@ModuloSistemaId INT,
	@Permiso VARCHAR(100)

AS
BEGIN

SET NOCOUNT ON;

	UPDATE Permisos
		
	SET ModuloSistemaId = @ModuloSistemaId,
	    Permiso         = @Permiso
		WHERE PermisoId = @PermisoId

END

-- =============================================
-- Autor: Carlos Fabrizio Arriola Carmona
-- Fecha Creación: 14/Octubre/2014
-- Descripción: Baja de permisos.
-- =============================================

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.sp_permisos_permiso_eliminar') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.sp_permisos_permiso_eliminar
GO

CREATE PROCEDURE sp_permisos_permiso_eliminar

	@PermisoId INT
AS
BEGIN

SET NOCOUNT ON;

	DELETE Permisos
	WHERE PermisoId = @PermisoId

END

-- =============================================
-- Autor: Carlos Fabrizio Arriola Carmona
-- Fecha Creación: 14/Octubre/2014
-- Descripción: Alta de permisos por usuario.
-- =============================================

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.sp_permisos_permiso_alta') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.sp_permisos_permiso_alta
GO

CREATE PROCEDURE sp_permisos_permiso_alta

	@IdUsuario INT,
	@IdPermiso INT

AS
BEGIN

SET NOCOUNT ON;

	 INSERT INTO PermisosUsuario(IdUsuario, IdPermiso, FechaModificacion)

	 VALUES(@IdUsuario, @IdPermiso, GETDATE())

END

-- =============================================
-- Autor: Carlos Fabrizio Arriola Carmona
-- Fecha Creación: 14/Octubre/2014
-- Descripción: Modificación de permisos por usuario.
-- =============================================

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.sp_permisos_permiso_modificacion') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.sp_permisos_permiso_modificacion
GO

CREATE PROCEDURE sp_permisos_permiso_modificacion

	@PermisoUsuarioId INT,
	@IdUsuario INT,
	@IdPermiso INT

AS
BEGIN

SET NOCOUNT ON;

	UPDATE PermisosUsuarios
		
	SET IdUsuario         = @IdUsuario,
	    IdPermiso         = @IdPermiso,
		FechaModificacion = GETDATE()
		WHERE PermisoUsuarioId = @PermisoUsuarioId

END

-- =============================================
-- Autor: Carlos Fabrizio Arriola Carmona
-- Fecha Creación: 14/Octubre/2014
-- Descripción: Baja de permisos por usuario.
-- =============================================

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.sp_permisos_permiso_eliminar') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.sp_permisos_permiso_eliminar
GO

CREATE PROCEDURE sp_permisos_permiso_eliminar

	@PermisoUsuarioId INT
AS
BEGIN

SET NOCOUNT ON;

	DELETE PermisosUsuarios
	WHERE PermisoUsuarioId = @PermisoUsuarioId

END