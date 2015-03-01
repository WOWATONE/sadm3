ALTER TABLE Requerimientos
ADD CONSTRAINT UK_Requerimientos_c_interno_Mes_Año UNIQUE (c_interno, Mes, Año)
GO

