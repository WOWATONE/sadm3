ALTER TABLE [dbo].[producto] 
ADD ban4 NVARCHAR(50) NULL
GO

ALTER TABLE [dbo].[producto] 
ADD niving NVARCHAR(50) NULL
GO


ALTER TABLE [dbo].[producto]
ADD TipoProceso VARCHAR(30)
GO

ALTER TABLE [dbo].[producto]
ADD TipoProducto VARCHAR(20)
GO

ALTER TABLE [dbo].[producto]
ADD fec_alta DATETIME
GO

ALTER TABLE [dbo].[producto]
ADD mod_alta VARCHAR(40)
GO

ALTER TABLE [dbo].[producto]
ADD usu_alta INT
GO

ALTER TABLE [dbo].[producto]
ADD fec_baja DATETIME
GO

ALTER TABLE [dbo].[producto]
ADD mod_baja VARCHAR(40)
GO

ALTER TABLE [dbo].[producto]
ADD usu_baja INT
GO

ALTER TABLE [dbo].[producto]
ADD fec_mod DATETIME
GO

ALTER TABLE [dbo].[producto]
ADD mod_mod VARCHAR(40)
GO

ALTER TABLE [dbo].[producto]
ADD usu_mod INT
GO

--
ALTER TABLE cliente
ADD colonia VARCHAR(200)
GO

ALTER TABLE [dbo].[cliente]
ADD fec_alta DATETIME
GO

ALTER TABLE [dbo].[cliente]
ADD mod_alta VARCHAR(40)
GO

ALTER TABLE [dbo].[cliente]
ADD usu_alta INT
GO

ALTER TABLE [dbo].[cliente]
ADD fec_baja DATETIME
GO

ALTER TABLE [dbo].[cliente]
ADD mod_baja VARCHAR(40)
GO

ALTER TABLE [dbo].[cliente]
ADD usu_baja INT
GO

ALTER TABLE [dbo].[cliente]
ADD fec_mod DATETIME
GO

ALTER TABLE [dbo].[cliente]
ADD mod_mod VARCHAR(40)
GO

ALTER TABLE [dbo].[cliente]
ADD usu_mod INT
GO

--
ALTER TABLE proveedor
ADD CONSTRAINT UK_Proveedor_codigo UNIQUE (nombre)
GO

ALTER TABLE [dbo].[proveedor]
ADD fec_alta DATETIME
GO

ALTER TABLE [dbo].[proveedor]
ADD mod_alta VARCHAR(40)
GO

ALTER TABLE [dbo].[proveedor]
ADD usu_alta INT
GO

ALTER TABLE [dbo].[proveedor]
ADD fec_baja DATETIME
GO

ALTER TABLE [dbo].[proveedor]
ADD mod_baja VARCHAR(40)
GO

ALTER TABLE [dbo].[proveedor]
ADD usu_baja INT
GO

ALTER TABLE [dbo].[proveedor]
ADD fec_mod DATETIME
GO

ALTER TABLE [dbo].[proveedor]
ADD mod_mod VARCHAR(40)
GO

ALTER TABLE [dbo].[proveedor]
ADD usu_mod INT
GO

ALTER TABLE proveedor
ADD CONSTRAINT UK_Proveedor_codigo UNIQUE (nombre)

