-- =============================================
-- Autor: Carlos Fabrizio Arriola Carmona
-- Fecha Creación: 18/Diciembre/2014
-- Descripción: Consulta de introducción requerimientos.
-- =============================================

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.sp_req_requerimientos_consulta') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.sp_req_requerimientos_consulta
GO

CREATE PROCEDURE sp_req_requerimientos_consulta

	@Consulta  NVARCHAR (MAX)

AS
BEGIN

	SET NOCOUNT ON;

EXEC sp_executesql @Consulta

END
GO

-- =============================================
-- Autor: Carlos Fabrizio Arriola Carmona
-- Fecha Creación: 06/Enero/2015
-- Descripción: Eliminación de requerimientos en base a un rango de fechas.
-- =============================================

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.sp_req_requerimientos_eliminar') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.sp_req_requerimientos_eliminar
GO

CREATE PROCEDURE sp_req_requerimientos_eliminar

	@FechaInicio VARCHAR(10),
	@FechaFin	 VARCHAR(10)
AS
BEGIN

	SET NOCOUNT ON;

	DELETE FROM
	Requerimientos
	WHERE FechaEntrada BETWEEN @FechaInicio AND @FechaFin

END
GO

-- =============================================
-- Autor: Carlos Fabrizio Arriola Carmona
-- Fecha Creación: 06/Enero/2015
-- Descripción: Alta de requerimiento.
-- =============================================

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.sp_req_requerimientos_alta') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.sp_req_requerimientos_alta
GO

CREATE PROCEDURE sp_req_requerimientos_alta
	
		@c_interno			NVARCHAR (50),
		@Mes				NVARCHAR (15),
		@Año				SMALLINT,
		@Estatus			NVARCHAR(50),
		@Requerimiento		INT,
		@PlanProduccion		INT,
		@FechaEntrada		DATE,
		@MesPlanProduccion	NVARCHAR (15)

AS
BEGIN

	SET NOCOUNT ON;

	INSERT INTO Requerimientos(c_interno, Mes, Año, Estatus, Requerimiento,
							   PlanProduccion, FechaEntrada, MesPlanProduccion)

	VALUES (@c_interno, @Mes, @Año, @Estatus, @Requerimiento,
			@PlanProduccion, @FechaEntrada, @MesPlanProduccion)

END
GO

-- =============================================
-- Autor: Carlos Fabrizio Arriola Carmona
-- Fecha Creación: 09/Enero/2015
-- Descripción: Consulta de requerimientos mensuales.
-- =============================================

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.sp_req_requerimientos_mensuales_consulta') AND type in (N'P', N'PC'))
	DROP PROCEDURE dbo.sp_req_requerimientos_mensuales_consulta
GO

CREATE PROCEDURE sp_req_requerimientos_mensuales_consulta

	@FechaGenerada				DATETIME2,
	@SesionId					UNIQUEIDENTIFIER,
	@Mes						NVARCHAR(15),
	@Año						SMALLINT

AS
BEGIN

SET NOCOUNT ON;

-- Declaración variables
DECLARE @Cod_Interno nvarchar(50)
      , @Requerimiento nvarchar(50)
      , @Requerimiento_Val INT
      , @InventarioProd BigInt
      , @StockMin BigInt
      , @PlanProduccion BigInt
      , @PiezasProducidas BigInt 
      , @HorasSMin Decimal(11,2)
      , @Resina Nvarchar(50)
      , @Prod_CicloReal Numeric(12,2)
      , @Prod_Cavidad Int
      , @Prod_Eficiencia Int
      , @Prod_Peso Numeric(12,6)
      , @Prod_OpMaq Numeric(6,3)
      , @Prod_Precio Numeric(18,9)
      , @MesC nvarchar(3)
      , @MesI Int
      , @MesAct Int
      , @FecIniD DateTime2
      , @FecFinD DateTime2      
      , @FechaAct DateTime2      
      , @VFecha DateTime2      
      , @FecIniC nvarchar(50)
      , @FecFinC nvarchar(50)      
      , @PEnviado BigInt
      , @RestaPorEnviar BigInt
      , @PPorProducir BigInt
      , @Hprod Decimal(11,2)
      , @ResInv Float
      , @ResPorProducir BigInt
      , @HorasInven Decimal(11,2)
      , @HrsPrVenta Numeric(16, 2)
      , @Vtas1 Numeric(16, 2)
      , @HrsPlan Numeric(16, 2)
      , @OperNecXGpoCicloReal Numeric(16, 2)
      , @VentaAlDia Numeric(16, 2)
      , @CifraDeNegocioProd Numeric(16, 2)
      , @VentaMensualEstimada Numeric(16, 2)
      , @CifraDeNegEstAProd Numeric(16, 2)
      , @VdMes Int 
      , @Dias_Mes Int
      , @VDia Int
      , @Dias Int
      , @VDom Int
      , @VSab Int
      , @Tot_Op Int
      , @VTurnos Int

-- Declaración de cursor
DECLARE cur_reqmen CURSOR FOR 
 SELECT CodigoInterno, Requerimiento, InventarioProd, StockMin, PlanProduccion, PiezasProducidas
      , Resina, Prod_CicloReal, Prod_Cavidad, Prod_Eficiencia, Prod_Peso, Prod_OpMaq, Prod_Precio
   FROM RequerimientosMensuales
  WHERE SesionId = @SesionId
  ORDER BY CodigoInterno;


-- Codigo procedimiento
SET @HrsPrVenta = 0
SET @Vtas1 = 0
SET @HrsPlan = 0
SET @OperNecXGpoCicloReal = 0
SET @VentaAlDia = 0
SET @CifraDeNegocioProd = 0
SET @VentaMensualEstimada = 0
SET @CifraDeNegEstAProd = 0
SET @Tot_Op = 0


SET @MesC = CASE WHEN @Mes = 'ENERO' THEN '01'
                 WHEN @Mes = 'FEBRERO' THEN '02'
                 WHEN @Mes = 'MARZO' THEN '03'
                 WHEN @Mes = 'ABRIL' THEN '04'
                 WHEN @Mes = 'MAYO' THEN '05'
                 WHEN @Mes = 'JUNIO' THEN '06'
                 WHEN @Mes = 'JULIO' THEN '07'
                 WHEN @Mes = 'AGOSTO' THEN '08'
                 WHEN @Mes = 'SEPTIEMBRE' THEN '09'
                 WHEN @Mes = 'OCTUBRE' THEN '10'
                 WHEN @Mes = 'NOVIEMBRE' THEN '11'
                 WHEN @Mes = 'DICIEMBRE' THEN '12'
             END;

SET @FechaAct = Getdate()
SET @MesI = CAST(@MesC AS Int);
SET @MesAct = Month(@FechaAct);

-- Genera fecha inicial
SET @FecIniC = CAST(@Año AS char(4))  + '-' + @MesC + '-01 00:00:00.0000000'
SET @FecIniD = CONVERT(DATETIME2, @FecIniC, 121);
-- Genera fecha final
SET @FecFinD = DATEADD(month, 1, @FecIniD)
SET @FecFinD = DATEADD(second, -1, @FecFinD)

-- Obtiene dias del mes
SET @Dias_Mes = DAY(@FecFinD)

-- Ini: Elimina registros antiguos de tablas temporales
DELETE 
  FROM RequerimientosMensuales
 WHERE FechaGenerada <= DATEADD(day, -1, @FechaGenerada) 
    OR SesionId = @SesionId;

DELETE 
  FROM RequerimientosMenTot
 WHERE FechaGenerada <= DATEADD(day, -1, @FechaGenerada) 
    OR SesionId = @SesionId;   
-- Fin: Elimina registros antiguos de tablas temporales   
   

INSERT INTO RequerimientosMensuales ( SesionId, FechaGenerada, Conse, CodigoInterno, Requerimiento
                                    , InventarioProd, StockMin, HorasSMin, PlanProduccion
                                    , PiezasProducidas, PEnviado, RestaPorEnviar, PPorProducir, HProd
                                    , ResInv, ResPorProducir, Resina, HorasInven, Prod_CicloReal
                                    , Prod_Cavidad, Prod_Eficiencia, Prod_Peso, Prod_Opmaq, Prod_Precio )

SELECT @SesionId, @FechaGenerada, row_number() OVER(ORDER BY PRO.c_interno), PRO.c_interno AS CodigoInterno
     , REQ.Requerimiento, TIN.inven AS InventarioProd
     , PRO.stockmin AS StockMin, 0 AS HorasSMin, REQ.PlanProduccion AS PlanProduccion, ETISUB.PiezasProducidas
     , 0 AS PEnviado, 0 AS RestaPorEnviar, 0 AS PPorProducir, 0 AS HProd, 0 AS ResInv, 0 AS ResPorProducir
     , PRO.material_codigo1 AS Resina, 0 AS HorasInven
     , CAST(Isnull(PRO.cicloreal,'0') AS Numeric(12,2))  AS Prod_CicloReal
     , CAST(Isnull(PRO.cavidad,'0') AS Int) as Prod_Cavidad
     , CAST(Isnull(PRO.eficiencia,'0') AS Int) as Prod_Eficiencia
     , CAST(Isnull(PRO.peso,'0') AS Numeric(12,6)) as Prod_Peso
     , CAST(Isnull(PRO.opmaq,'0') AS Numeric(6,3)) as Prod_Opmaq
     , CAST(Isnull(PRO.precio,'0') AS Numeric(20,10)) as Prod_Precio
 FROM producto AS PRO 
 LEFT JOIN Requerimientos AS REQ ON PRO.c_interno = REQ.c_interno 
       AND REQ.Mes = @Mes AND REQ.Año = @Año
 LEFT JOIN tinven AS TIN ON TIN.c_interno = PRO.c_interno
 LEFT JOIN (
             SELECT ETI.c_interno, SUM(piezas) AS PiezasProducidas
               FROM etiquetaspallete AS ETI
              GROUP BY ETI.c_interno
           ) AS ETISUB ON ETISUB.c_interno = PRO.c_interno
 WHERE PRO.estado = 'A' 

-- Abre cursor
OPEN cur_reqmen

-- Asigna campos del cursor a variables
FETCH NEXT FROM cur_reqmen
 INTO @Cod_Interno, @Requerimiento, @InventarioProd, @StockMin, @PlanProduccion, @PiezasProducidas
    , @Resina, @Prod_CicloReal, @Prod_Cavidad, @Prod_Eficiencia, @Prod_Peso, @Prod_OpMaq, @Prod_Precio


-- Ciclo para recorrer cursor
WHILE @@FETCH_STATUS = 0
BEGIN
  SET @Requerimiento_Val = CAST(@Requerimiento AS Int);
  -- Ini: Calcula HRS. S. MIN
  SET @HorasSMin = 0;
  IF (@InventarioProd < @StockMin) AND @Prod_CicloReal > 0
    BEGIN
      SET @HorasSMin = @StockMin - @InventarioProd;
      SET @HorasSMin = @HorasSMin / ((3600 / @Prod_CicloReal) * @Prod_Cavidad);
      SET @HorasSMin = @HorasSMin + (@HorasSMin * (1 - (@Prod_Eficiencia / 100)));
    END
  -- Fin: Calcula HRS. S. MIN    
    
  -- Ini: Calcula P. ENVIADO
  SELECT @PEnviado = ISNULL(SUM(da.cant),0) 
    FROM remision re
   INNER JOIN datos da ON re.remision = da.nremision
   WHERE da.nparte = @Cod_Interno
     AND re.fecha between @FecIniD AND @FecFinD;
  -- Fin: Calcula P. ENVIADO     
     
  -- Ini: Calcula RESTA X ENV.
  SET @RestaPorEnviar = 0;
  IF @Requerimiento_Val > 0 
    BEGIN
      SET @RestaPorEnviar = @Requerimiento_Val - @PEnviado;
      If @RestaPorEnviar < 0 
        SET @RestaPorEnviar = 0
      
      -- Venta Mensual Estimada  
      SET @VentaMensualEstimada = @VentaMensualEstimada + (@Requerimiento_Val * @Prod_Precio)
    END     
  -- Fin: Calcula RESTA X ENV.

  -- Ini: Calcula P. X PROD.
  SET @PPorProducir = 0;
  IF @PlanProduccion > 0 
    BEGIN
      IF @PlanProduccion > @PiezasProducidas 
           SET @PPorProducir = @PlanProduccion - @PiezasProducidas;

      -- Calcula cifra de negocio estimada a producir
      SET @CifraDeNegEstAProd = @CifraDeNegEstAProd + (@PlanProduccion * @Prod_Precio)
    END
  -- Fin: Calcula P. X PROD.

  -- Ini: Calcula H. PROD
  IF @Prod_CicloReal > 0
    BEGIN
      SET @Hprod = @PPorProducir / ((3600 / @Prod_CicloReal) * @Prod_Cavidad);
      SET @Hprod = @Hprod + (@Hprod * (1 - (@Prod_Eficiencia / 100)));
      
      -- Para calcular el total de operadores
      SET @Tot_Op = @Tot_Op + (@Hprod * @Prod_OpMaq)
    END
  -- Fin: Calcula H. PROD    
  
  -- Ini: Obtiene RES. EN INV.
  SELECT @ResInv = ISNULL(inven,0)
    FROM material 
   WHERE nombre = @Resina;
  -- Fin: Obtiene RES. EN INV.   
  
  -- Ini: Calcula RES. P/PROD
  SET @ResPorProducir = 0
  IF @PPorProducir > 0 
    SET @ResPorProducir = @PPorProducir * (@Prod_Peso / 1000)
  -- Fin: Calcula RES. P/PROD    
    
  -- Ini: Calcula HRS INVEN.
  SET @HorasInven = 0
  IF @Prod_CicloReal > 0 
    BEGIN
      SET @HorasInven = @InventarioProd / ((3600 / @Prod_CicloReal) * @Prod_Cavidad);
      SET @HorasInven = @HorasInven + (@HorasInven * (1 - (@Prod_Eficiencia / 100)));
    END     
  -- Fin: Calcula HRS INVEN.    
     
  -- Actualiza campos     
  UPDATE RequerimientosMensuales
     SET Requerimiento = IsNull(@Requerimiento,'NO REQ') 
       , HorasSMin = @HorasSMin 
       , PEnviado = @PEnviado
       , RestaPorEnviar = @RestaPorEnviar
       , PPorProducir = @PPorProducir
       , Hprod = @Hprod
       , ResInv = @ResInv
       , ResPorProducir = @ResPorProducir
       , HorasInven = @HorasInven
   WHERE SesionId = @SesionId
     AND CodigoInterno = @Cod_Interno;
     
  -- Ini: Calcula HRS PR. VENTA
  IF @Requerimiento_Val > 0 AND @Prod_CicloReal > 0
    BEGIN
      SET @Vtas1 = @Requerimiento_Val / ((3600 / @Prod_CicloReal) * @Prod_Cavidad)
      SET @HrsPrVenta = @HrsPrVenta + @Vtas1 + (@Vtas1 * (1 - (@Prod_Eficiencia) / 100))
    END
  -- Fin: Calcula HRS PR. VENTA    

  -- Ini: Calcula HRS PLAN
  SET @Vtas1 = 0
  IF @PlanProduccion > 0 AND @Prod_CicloReal > 0 
    BEGIN  
      SET @Vtas1 = @PlanProduccion / ((3600 / @Prod_CicloReal) * @Prod_Cavidad)
      SET @HrsPlan = @HrsPlan + @Vtas1 + (@Vtas1 * (1 - (@Prod_Eficiencia / 100)))
    END
  -- Fin: Calcula HRS PLAN  

  -- Ini: Calcula Cifra de Negocio Prod.
  IF @PiezasProducidas > 0
    SET @CifraDeNegocioProd = @CifraDeNegocioProd + (@PiezasProducidas * @Prod_Precio)
  -- Fin: Calcula Cifra de Negocio Prod.  

  -- Asigna campos del cursor a variables
  FETCH NEXT FROM cur_reqmen
   INTO @Cod_Interno, @Requerimiento, @InventarioProd, @StockMin, @PlanProduccion, @PiezasProducidas
      , @Resina, @Prod_CicloReal, @Prod_Cavidad, @Prod_Eficiencia, @Prod_Peso, @Prod_OpMaq, @Prod_Precio


END 
-- Cierra cursor
CLOSE cur_reqmen;
-- Limpia cursor de la memoria
DEALLOCATE cur_reqmen;

-- Ini: Calcula Venta Al Día
SELECT @VentaAldia = IsNull(Sum(subtotal), 0) 
  FROM remisionr 
 WHERE fechadate BETWEEN @FecIniD AND @FecFinD
   AND tipo = 'FAC';
-- Fin: Calcula Venta Al Día

-- Ini: Oper. Nec. X Grupo Ciclo Real
SET @VdMes = @Dias_Mes
IF @MesAct = @MesI 
  BEGIN
    SET @VDia = Day(@FechaAct)
    SET @Dias = @VdMes - @VDia + 1
    SET @VDom = 0
    SET @VSab = 0
    SET @VTurnos = 0
    SET @VFecha = @FechaAct 
    
    
    WHILE @VDia <= @VdMes
      BEGIN
        If DATEPART ( Weekday, @FechaAct ) = 1
            SET @VDom = @VDom + 1;
        Else
            If DATEPART ( Weekday, @FechaAct ) = 7
                SET @VSab = @VSab + 1;

        SET @vfecha = DATEADD(day, 1, @vfecha);
        SET @VDia = @VDia + 1;
      END
    SET @VTurnos = (@Dias * 3) - (@VDom * 3) - @VSab
    SET @Tot_Op = ((((@Tot_Op) / 8) / (@VTurnos / 3))) / 3
  END
ELSE
  BEGIN
    SET @Tot_Op = ((((@Tot_Op) / 8) / (73 / 3))) / 3  
  END
SET @OperNecXGpoCicloReal = @Tot_Op + 0.4
-- Fin: Oper. Nec. X Grupo Ciclo Real


-- Inserta Totales
INSERT INTO RequerimientosMenTot ( SesionId   , FechaGenerada, HrsPrVenta , HrsPlan , OperNecXGpoCicloReal  
                                 , VentaAlDia , CifraDeNegocioProd , VentaMensualEstimada , CifraDeNegEstAProd )
                          VALUES ( @SesionId  , @FechaGenerada, @HrsPrVenta, @HrsPlan, @OperNecXGpoCicloReal
                                 , @VentaAlDia, @CifraDeNegocioProd, @VentaMensualEstimada, @CifraDeNegEstAProd );


SELECT *
FROM RequerimientosMensuales
WHERE SesionId = @SesionId  

END
GO