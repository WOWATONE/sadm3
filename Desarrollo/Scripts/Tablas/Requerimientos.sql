CREATE TABLE Requerimientos
(
	c_interno			NVARCHAR(50),
	Mes					NVARCHAR(15),
	Año					SMALLINT,
	Estatus				NVARCHAR(50),
	Requerimiento		INT,
	PlanProduccion		INT,
	FechaEntrada		DATE,
	MesPlanProduccion	NVARCHAR(15)
)
GO

CREATE TABLE RequerimientosMensuales
(
	SesionId			UNIQUEIDENTIFIER,
	FechaGenerada		DATETIME2,
	CodigoInterno		NVARCHAR(50),
	Requerimiento		NVARCHAR(50),
	InventarioProd		INT,
	StockMin			INT,
	HorasSMin			DECIMAL(11,2),
	PlanProduccion		INT,
	PiezasProducidas	INT,
	PEnviado			INT,
	RestaPorEnviar		INT,
	PPorProducir		INT,
	HProd				DECIMAL(11,2),
	ResInv				INT,
	ResPorProducir		INT,
	Resina				NVARCHAR(50),
	HorasInven			DECIMAL(11,2)
)
GO
