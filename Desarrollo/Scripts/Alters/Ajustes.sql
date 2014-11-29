ALTER TABLE ConfigRackSilos
ADD CONSTRAINT UK_ConfigRackSilos_Codigo UNIQUE (Codigo)
GO

ALTER TABLE ConfigRackSilos
ADD CONSTRAINT PK_ConfigRackSilos_IdConfig PRIMARY KEY CLUSTERED (IdConfig)
GO
