ALTER TABLE Requerimientos
ADD CONSTRAINT UK_Requerimientos_c_interno_Mes_Año UNIQUE (c_interno, Mes, Año)
GO

ALTER TABLE RequerimientosActualizados
ADD CONSTRAINT UK_RequerimientosActualizados_c_interno_Mes_Año UNIQUE (c_interno, Mes, Año)
GO

ALTER TABLE Requerimientos
drop CONSTRAINT UK_Requerimientos_c_interno_Mes_Año

ALTER TABLE RequerimientosActualizados
drop CONSTRAINT UK_RequerimientosActualizados_c_interno_Mes_Año