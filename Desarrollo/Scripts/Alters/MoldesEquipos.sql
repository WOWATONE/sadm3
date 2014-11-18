ALTER TABLE moldes
ADD CONSTRAINT PK_moldes_conse PRIMARY KEY CLUSTERED (conse)
GO

ALTER TABLE moldes
ADD CONSTRAINT UK_moldes_cminterno UNIQUE (cminterno)
GO
