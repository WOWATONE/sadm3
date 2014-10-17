ALTER TABLE material
ADD CONSTRAINT UK_Material_codigo UNIQUE (codigo)
GO

ALTER TABLE detocompra
ALTER COLUMN concepto NVARCHAR(200)
GO

ALTER TABLE datosr
ALTER COLUMN dscripcion NVARCHAR(200)
GO

ALTER TABLE [dbo].proveedormaterial
ADD fec_alta DATETIME
GO

ALTER TABLE [dbo].proveedormaterial
ADD mod_alta VARCHAR(40)
GO

ALTER TABLE [dbo].proveedormaterial
ADD usu_alta INT
GO

ALTER TABLE [dbo].proveedormaterial
ADD fec_baja DATETIME
GO

ALTER TABLE [dbo].proveedormaterial
ADD mod_baja VARCHAR(15)
GO

ALTER TABLE [dbo].proveedormaterial
ADD usu_baja INT
GO

ALTER TABLE [dbo].proveedormaterial
ADD fec_mod DATETIME
GO

ALTER TABLE [dbo].proveedormaterial
ADD mod_mod VARCHAR(15)
GO

ALTER TABLE [dbo].proveedormaterial
ADD usu_mod INT
GO

ALTER TABLE ocompra 
DROP COLUMN conse
GO

ALTER TABLE ocompra
ADD conse INT IDENTITY(1,1)
GO

ALTER TABLE detocompra 
DROP COLUMN conse
GO

ALTER TABLE detocompra
ADD conse INT IDENTITY(1,1)
GO

ALTER TABLE ocompra
ADD Elaboro INT
GO

ALTER TABLE Permisos
ADD CONSTRAINT FK_ModuloSistemaID FOREIGN KEY (ModuloSistemaId) REFERENCES ModulosSistema(ModuloSistemaId)
GO

ALTER TABLE PermisosUsuarios
ADD CONSTRAINT FK_IdPermiso FOREIGN KEY (IdPermiso) REFERENCES Permisos(PermisoId)
GO

ALTER TABLE detocompra 
ADD CantidadPedida NVARCHAR(50)
GO

ALTER TABLE detocompra 
ADD Lote VARCHAR(30)
GO

ALTER TABLE detocompra
ADD NumeroItem INT
GO

ALTER TABLE ocompra
ADD CONSTRAINT PK_ocompra_conse PRIMARY KEY CLUSTERED (conse)
GO

ALTER TABLE detocompra
ADD CONSTRAINT PK_detocompra_conse PRIMARY KEY CLUSTERED (conse)
GO

ALTER TABLE pw
ALTER COLUMN num_empt INT
GO

ALTER TABLE detocompra
ADD mod_alta VARCHAR(40)
GO

ALTER TABLE detocompra
ADD Ubicacion NVARCHAR(50)
GO