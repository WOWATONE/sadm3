ALTER TABLE moldes
ADD CONSTRAINT PK_moldes_conse PRIMARY KEY CLUSTERED (conse)
GO

ALTER TABLE moldes
ADD CONSTRAINT UK_moldes_cminterno UNIQUE (cminterno)
GO

ALTER TABLE ProductosMoldes
ADD CONSTRAINT UK_moldes_IdMolde_c_interno UNIQUE (IdMolde, c_interno)
GO

ALTER TABLE ProductosMoldes
ADD CONSTRAINT UK_moldes_c_interno UNIQUE (c_interno)
GO