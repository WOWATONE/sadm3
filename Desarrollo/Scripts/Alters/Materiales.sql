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

ALTER TABLE ocompra
ADD FechaEntrada DATETIME
GO

ALTER TABLE detocompra
ADD ImporteSD NVARCHAR(50)
GO

ALTER TABLE detocompra
ADD Descuento DECIMAL(5, 2)
GO

ALTER TABLE detocompra
ADD CodigoMaterial NVARCHAR(200)
GO

ALTER TABLE datosv
ADD LoteInterno NVARCHAR(50)
GO

ALTER TABLE material
ADD Categoria VARCHAR(20)
GO

ALTER TABLE RegistroRetornoMaterial
ADD OrdenFabricacion VARCHAR(9)
GO

ALTER TABLE RegistroRetornoMaterial
ADD CantidadOriginal VARCHAR(50)
GO

ALTER TABLE RegistroRetornoMaterial
ADD Comentarios VARCHAR(200)
GO

ALTER TABLE ocompra
ADD Factura NVARCHAR(50)
GO

ALTER TABLE ocompra
ADD NumeroPedimento NVARCHAR(50)
GO

ALTER TABLE ocompra
ADD ProveedorId INT
GO

ALTER TABLE ocompra
ADD CuentaContDepto NVARCHAR(50)
GO

ALTER TABLE material
ADD ProveedorId INT
GO

ALTER TABLE proveedormaterial
ADD ProveedorId INT
GO

ALTER TABLE silo
DROP COLUMN inven
GO

ALTER TABLE silo
DROP COLUMN cargainicial
GO

ALTER TABLE silo
ADD inven FLOAT
GO

ALTER TABLE silo
ADD cargainicial FLOAT
GO

ALTER TABLE detocompra
ALTER COLUMN concepto NVARCHAR(1000) NOT NULL
GO