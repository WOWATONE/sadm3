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

ALTER TABLE producto
ADD CONSTRAINT UK_Producto_desc_prod UNIQUE (desc_prod )
GO

ALTER TABLE producto
ADD CONSTRAINT UK_Producto_c_interno UNIQUE (c_interno )
GO

--
ALTER TABLE cliente
ADD CONSTRAINT UK_Cliente_nombre UNIQUE (nombre)
GO

ALTER TABLE cliente
ADD CONSTRAINT UK_Cliente_nombre_comp UNIQUE (nombre_comp )
GO

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
ADD CONSTRAINT UK_Proveedor_nombre UNIQUE (nombre)
GO

ALTER TABLE proveedor
ADD CondicionesPago VARCHAR(10)
GO

ALTER TABLE proveedor
ADD Moneda NVARCHAR(50)
GO

ALTER TABLE producto
ADD TiempoMontaje INT
GO

ALTER TABLE producto
ADD TiempoDesmontaje INT
GO

ALTER TABLE producto
ADD TiempoMontaje INT
GO

ALTER TABLE rechazosop
ADD CONSTRAINT FK_c_interno FOREIGN KEY (c_interno) REFERENCES producto(c_interno)
GO

ALTER TABLE producto
ADD TiempoMontaje DECIMAL(7, 2)
GO

ALTER TABLE producto
ADD TiempoDesmontaje DECIMAL(7, 2)
GO

ALTER TABLE Cliente
ADD Tipo VARCHAR(20)
GO

ALTER TABLE producto_cc
DROP COLUMN id_prod_cc
GO

ALTER TABLE producto_cc
ADD id_prod_cc INT 
GO

ALTER TABLE producto_cc
ADD CONSTRAINT PK_id_prod_cc PRIMARY KEY (id_prod_cc)
GO

ALTER TABLE producto_cc
DROP CONSTRAINT UK_Producto_cc
GO

ALTER TABLE producto_cc
ADD CONSTRAINT UK_Producto_cc UNIQUE (id_prod_cc)
GO

ALTER TABLE producto
ADD comen VARCHAR(MAX)
GO

ALTER TABLE datosr
ADD comen VARCHAR(MAX)
GO
