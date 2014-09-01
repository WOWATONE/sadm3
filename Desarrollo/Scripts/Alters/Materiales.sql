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

--agregar identity a num a ocompra