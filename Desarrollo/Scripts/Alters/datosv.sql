ALTER TABLE datosv
ADD CantLoteRestante FLOAT
GO

ALTER TABLE datosv
ADD LoteIntAcumulado NVARCHAR(50)
GO

ALTER TABLE datosv
ADD ReferenciaLoteId INT
GO

ALTER TABLE datosv
ADD ClaseResina VARCHAR(100)
GO
