ALTER TABLE Requerimientos
ADD CONSTRAINT UK_Requerimientos_c_interno_Mes_A�o UNIQUE (c_interno, Mes, A�o)
GO

ALTER TABLE RequerimientosActualizados
ADD CONSTRAINT UK_RequerimientosActualizados_c_interno_Mes_A�o UNIQUE (c_interno, Mes, A�o)
GO

ALTER TABLE Requerimientos
drop CONSTRAINT UK_Requerimientos_c_interno_Mes_A�o

ALTER TABLE RequerimientosActualizados
drop CONSTRAINT UK_RequerimientosActualizados_c_interno_Mes_A�o