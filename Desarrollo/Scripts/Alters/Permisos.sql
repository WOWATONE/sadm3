ALTER TABLE PermisosUsuarios
ADD CONSTRAINT UK_PermisosUsuarios_UsuarioId_PermisoId UNIQUE (UsuarioId, PermisoId)
GO

ALTER TABLE Permisos
ADD CONSTRAINT UK_Permisos_Permiso UNIQUE(Permiso)