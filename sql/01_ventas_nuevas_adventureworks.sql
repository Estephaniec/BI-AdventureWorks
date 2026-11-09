--SalesOrderHeader
SELECT TOP (1000) [SalesOrderID]
      ,[RevisionNumber]
      ,[OrderDate]
      ,[DueDate]
      ,[ShipDate]
      ,[Status]
      ,[OnlineOrderFlag]
      ,[SalesOrderNumber]
      ,[PurchaseOrderNumber]
      ,[AccountNumber]
      ,[CustomerID]
      ,[SalesPersonID]
      ,[TerritoryID]
      ,[BillToAddressID]
      ,[ShipToAddressID]
      ,[ShipMethodID]
      ,[CreditCardID]
      ,[CreditCardApprovalCode]
      ,[CurrencyRateID]
      ,[SubTotal]
      ,[TaxAmt]
      ,[Freight]
      ,[TotalDue]
      ,[Comment]
      ,[rowguid]
      ,[ModifiedDate]
  FROM [AdventureWorks2022].[Sales].[SalesOrderHeader]

SELECT MAX(OrderDate) AS FechaMasReciente
FROM Sales.SalesOrderHeader; --FechaMasReciente: 2025-07-10 00:00:00.000

SELECT *
FROM Sales.SalesOrderHeader
WHERE OnlineOrderFlag = 1 AND OrderDate = '2025-07-01'

--Insertar nuevas ventas (10)
INSERT INTO Sales.SalesOrderHeader
(
    RevisionNumber,
    OrderDate,
    DueDate,
    ShipDate,
    Status,
    OnlineOrderFlag,
    PurchaseOrderNumber,
    AccountNumber,
    CustomerID,
    SalesPersonID,
    TerritoryID,
    BillToAddressID,
    ShipToAddressID,
    ShipMethodID,
    CreditCardID,
    CreditCardApprovalCode,
    CurrencyRateID,
    SubTotal,
    TaxAmt,
    Freight,
    Comment,
    rowguid,
    ModifiedDate
)
SELECT
    8,
    FechaNueva,
    DATEADD(DAY, 12, FechaNueva),
    DATEADD(DAY, 7, FechaNueva),
    5,
    1,
    'PO999999555',
    '10-2025-999999',
    CustomerID,
    SalesPersonID,
    TerritoryID,
    BillToAddressID,
    ShipToAddressID,
    ShipMethodID,
    CreditCardID,
    CreditCardApprovalCode,
    CurrencyRateID,
    SubTotal,
    TaxAmt,
    Freight,
    NULL,
    NEWID(),
    FechaNueva
FROM
(
    SELECT 
        CustomerID,
        SalesPersonID,
        TerritoryID,
        BillToAddressID,
        ShipToAddressID,
        ShipMethodID,
        CreditCardID,
        CreditCardApprovalCode,
        CurrencyRateID,
        SubTotal,
        TaxAmt,
        Freight,
        DATEADD(DAY, v.NumDia, '2025-07-01') AS FechaNueva
    FROM Sales.SalesOrderHeader h
    CROSS JOIN (VALUES (0),(1),(2),(3),(4),(5),(6),(7),(8),(9)) AS v(NumDia)
    WHERE h.SalesOrderID = 43659
) AS Datos;

--Revisar inserción correcta
SELECT TOP 50 *
FROM Sales.SalesOrderHeader
ORDER BY OrderDate DESC;

-- Siguientes inserciones (30)
INSERT INTO Sales.SalesOrderHeader
(
    RevisionNumber,
    OrderDate,
    DueDate,
    ShipDate,
    Status,
    OnlineOrderFlag,
    PurchaseOrderNumber,
    AccountNumber,
    CustomerID,
    SalesPersonID,
    TerritoryID,
    BillToAddressID,
    ShipToAddressID,
    ShipMethodID,
    CreditCardID,
    CreditCardApprovalCode,
    CurrencyRateID,
    SubTotal,
    TaxAmt,
    Freight,
    Comment,
    rowguid,
    ModifiedDate
)
SELECT
    8,
    FechaNueva,
    DATEADD(DAY, 12, FechaNueva),
    DATEADD(DAY, 7, FechaNueva),
    5,
    1,
    'PO888888888',
    '10-4020-888888',
    CustomerID,
    SalesPersonID,
    TerritoryID,
    BillToAddressID,
    ShipToAddressID,
    ShipMethodID,
    CreditCardID,
    CreditCardApprovalCode,
    CurrencyRateID,
    SubTotal,
    TaxAmt,
    Freight,
    NULL,
    NEWID(),
    FechaNueva
FROM
(
    SELECT 
        CustomerID,
        SalesPersonID,
        TerritoryID,
        BillToAddressID,
        ShipToAddressID,
        ShipMethodID,
        CreditCardID,
        CreditCardApprovalCode,
        CurrencyRateID,
        SubTotal,
        TaxAmt,
        Freight,
        DATEADD(DAY, v.NumDia, '2014-07-11') AS FechaNueva
    FROM Sales.SalesOrderHeader h
    CROSS JOIN (
        VALUES 
            (0),(1),(2),(3),(4),(5),(6),(7),(8),(9),
            (10),(11),(12),(13),(14),(15),(16),(17),(18),(19),
            (20),(21),(22),(23),(24),(25),(26),(27),(28),(29)
    ) AS v(NumDia)
    WHERE h.SalesOrderID = 43659
) AS Datos;

--40 hasta el momentom ingredar otras 30
INSERT INTO Sales.SalesOrderHeader
(
    RevisionNumber,
    OrderDate,
    DueDate,
    ShipDate,
    Status,
    OnlineOrderFlag,
    PurchaseOrderNumber,
    AccountNumber,
    CustomerID,
    SalesPersonID,
    TerritoryID,
    BillToAddressID,
    ShipToAddressID,
    ShipMethodID,
    CreditCardID,
    CreditCardApprovalCode,
    CurrencyRateID,
    SubTotal,
    TaxAmt,
    Freight,
    Comment,
    rowguid,
    ModifiedDate
)
SELECT
    8,
    FechaNueva,
    DATEADD(DAY, 12, FechaNueva),
    DATEADD(DAY, 7, FechaNueva),
    5,
    1,
    'PO777777777',
    '10-4020-777777',
    CustomerID,
    SalesPersonID,
    TerritoryID,
    BillToAddressID,
    ShipToAddressID,
    ShipMethodID,
    CreditCardID,
    CreditCardApprovalCode,
    CurrencyRateID,
    SubTotal,
    TaxAmt,
    Freight,
    NULL,
    NEWID(),
    FechaNueva
FROM
(
    SELECT 
        CustomerID,
        SalesPersonID,
        TerritoryID,
        BillToAddressID,
        ShipToAddressID,
        ShipMethodID,
        CreditCardID,
        CreditCardApprovalCode,
        CurrencyRateID,
        SubTotal,
        TaxAmt,
        Freight,
        DATEADD(DAY, v.NumDia, '2025-11-24') AS FechaNueva
    FROM Sales.SalesOrderHeader h
    CROSS JOIN (
        VALUES 
            (0),(1),(2),(3),(4),(5),(6),(7),(8),(9),
            (10),(11),(12),(13),(14),(15),(16),(17),(18),(19),
            (20),(21),(22),(23),(24),(25),(26),(27),(28),(29)
    ) AS v(NumDia)
    WHERE h.SalesOrderID = 43659
) AS Datos;

SELECT TOP 100 *
FROM Sales.SalesOrderHeader
ORDER BY OrderDate DESC;

--Pultimos 30
INSERT INTO Sales.SalesOrderHeader
(
    RevisionNumber,
    OrderDate,
    DueDate,
    ShipDate,
    Status,
    OnlineOrderFlag,
    PurchaseOrderNumber,
    AccountNumber,
    CustomerID,
    SalesPersonID,
    TerritoryID,
    BillToAddressID,
    ShipToAddressID,
    ShipMethodID,
    CreditCardID,
    CreditCardApprovalCode,
    CurrencyRateID,
    SubTotal,
    TaxAmt,
    Freight,
    Comment,
    rowguid,
    ModifiedDate
)
SELECT
    8,
    FechaNueva,
    DATEADD(DAY, 12, FechaNueva),
    DATEADD(DAY, 7, FechaNueva),
    5,
    1,
    'PO666666666',
    '10-4020-666666',
    CustomerID,
    SalesPersonID,
    TerritoryID,
    BillToAddressID,
    ShipToAddressID,
    ShipMethodID,
    CreditCardID,
    CreditCardApprovalCode,
    CurrencyRateID,
    SubTotal,
    TaxAmt,
    Freight,
    NULL,
    NEWID(),
    FechaNueva
FROM
(
    SELECT 
        CustomerID,
        SalesPersonID,
        TerritoryID,
        BillToAddressID,
        ShipToAddressID,
        ShipMethodID,
        CreditCardID,
        CreditCardApprovalCode,
        CurrencyRateID,
        SubTotal,
        TaxAmt,
        Freight,
        DATEADD(DAY, v.NumDia, '2025-12-09') AS FechaNueva
    FROM Sales.SalesOrderHeader h
    CROSS JOIN (
        VALUES 
            (0),(1),(2),(3),(4),(5),(6),(7),(8),(9),
            (10),(11),(12),(13),(14),(15),(16),(17),(18),(19),
            (20),(21),(22),(23),(24),(25),(26),(27),(28),(29)
    ) AS v(NumDia)
    WHERE h.SalesOrderID = 43659
) AS Datos;

  --Revisar DW
SELECT  * 
FROM FactInternetSales
ORDER BY OrderDate DESC;


sp_help 'FactInternetSales'



-- ver dimensión fecha
EXEC sp_help 'DimDate';

SELECT MIN(DateKey) AS MinDate, MAX(DateKey) AS MaxDate
FROM DimDate;

--Extender dimensión
DECLARE @StartDate DATE = '2025-01-01';
DECLARE @EndDate   DATE = '2025-12-31';

WHILE @StartDate <= @EndDate
BEGIN
    DECLARE
        @DateKey INT = CONVERT(INT, CONVERT(VARCHAR(8), @StartDate, 112)),
        @DayNumberOfWeek TINYINT = DATEPART(WEEKDAY, @StartDate),
        @DayNameEnglish NVARCHAR(20) = DATENAME(WEEKDAY, @StartDate),
        @DayNameSpanish NVARCHAR(20),
        @DayNameFrench  NVARCHAR(20),
        @MonthEnglish   NVARCHAR(20) = DATENAME(MONTH, @StartDate),
        @MonthSpanish   NVARCHAR(20),
        @MonthFrench    NVARCHAR(20),
        @MonthNumber TINYINT = MONTH(@StartDate),
        @CalendarQuarter TINYINT = DATEPART(QUARTER, @StartDate),
        @CalendarYear SMALLINT = YEAR(@StartDate),
        @CalendarSemester TINYINT = CASE WHEN MONTH(@StartDate) <= 6 THEN 1 ELSE 2 END,
        @FiscalYear SMALLINT,
        @FiscalQuarter TINYINT,
        @FiscalSemester TINYINT;

    -- Traducción de días
    SET @DayNameSpanish =
        CASE @DayNameEnglish
            WHEN 'Monday' THEN N'Lunes'
            WHEN 'Tuesday' THEN N'Martes'
            WHEN 'Wednesday' THEN N'Miércoles'
            WHEN 'Thursday' THEN N'Jueves'
            WHEN 'Friday' THEN N'Viernes'
            WHEN 'Saturday' THEN N'Sábado'
            WHEN 'Sunday' THEN N'Domingo'
        END;

    SET @DayNameFrench =
        CASE @DayNameEnglish
            WHEN 'Monday' THEN N'Lundi'
            WHEN 'Tuesday' THEN N'Mardi'
            WHEN 'Wednesday' THEN N'Mercredi'
            WHEN 'Thursday' THEN N'Jeudi'
            WHEN 'Friday' THEN N'Vendredi'
            WHEN 'Saturday' THEN N'Samedi'
            WHEN 'Sunday' THEN N'Dimanche'
        END;

    -- Traducción de meses
    SET @MonthSpanish =
        CASE @MonthEnglish
            WHEN 'January' THEN N'Enero'
            WHEN 'February' THEN N'Febrero'
            WHEN 'March' THEN N'Marzo'
            WHEN 'April' THEN N'Abril'
            WHEN 'May' THEN N'Mayo'
            WHEN 'June' THEN N'Junio'
            WHEN 'July' THEN N'Julio'
            WHEN 'August' THEN N'Agosto'
            WHEN 'September' THEN N'Septiembre'
            WHEN 'October' THEN N'Octubre'
            WHEN 'November' THEN N'Noviembre'
            WHEN 'December' THEN N'Diciembre'
        END;

    SET @MonthFrench =
        CASE @MonthEnglish
            WHEN 'January' THEN N'Janvier'
            WHEN 'February' THEN N'Février'
            WHEN 'March' THEN N'Mars'
            WHEN 'April' THEN N'Avril'
            WHEN 'May' THEN N'Mai'
            WHEN 'June' THEN N'Juin'
            WHEN 'July' THEN N'Juillet'
            WHEN 'August' THEN N'Août'
            WHEN 'September' THEN N'Septembre'
            WHEN 'October' THEN N'Octobre'
            WHEN 'November' THEN N'Novembre'
            WHEN 'December' THEN N'Décembre'
        END;

    -- Lógica Fiscal estándar AdventureWorks (fiscal comienza en Julio)
    SET @FiscalYear = CASE WHEN MONTH(@StartDate) >= 7
                           THEN YEAR(@StartDate) + 1
                           ELSE YEAR(@StartDate)
                      END;

    SET @FiscalQuarter =
        CASE
            WHEN MONTH(@StartDate) BETWEEN 7 AND 9  THEN 1
            WHEN MONTH(@StartDate) BETWEEN 10 AND 12 THEN 2
            WHEN MONTH(@StartDate) BETWEEN 1 AND 3  THEN 3
            WHEN MONTH(@StartDate) BETWEEN 4 AND 6  THEN 4
        END;

    SET @FiscalSemester = CASE
                             WHEN MONTH(@StartDate) BETWEEN 7 AND 12 THEN 1
                             ELSE 2
                          END;

    INSERT INTO DimDate (
        DateKey, FullDateAlternateKey, DayNumberOfWeek,
        EnglishDayNameOfWeek, SpanishDayNameOfWeek, FrenchDayNameOfWeek,
        DayNumberOfMonth, DayNumberOfYear, WeekNumberOfYear,
        EnglishMonthName, SpanishMonthName, FrenchMonthName,
        MonthNumberOfYear, CalendarQuarter, CalendarYear, CalendarSemester,
        FiscalQuarter, FiscalYear, FiscalSemester, IsWeekend
    )
    VALUES (
        @DateKey, @StartDate, @DayNumberOfWeek,
        @DayNameEnglish, @DayNameSpanish, @DayNameFrench,
        DAY(@StartDate), DATEPART(DAYOFYEAR, @StartDate), DATEPART(WEEK, @StartDate),
        @MonthEnglish, @MonthSpanish, @MonthFrench,
        @MonthNumber, @CalendarQuarter, @CalendarYear, @CalendarSemester,
        @FiscalQuarter, @FiscalYear, @FiscalSemester,
        CASE WHEN @DayNameEnglish IN ('Saturday', 'Sunday') THEN 1 ELSE 0 END
    );

    SET @StartDate = DATEADD(DAY, 1, @StartDate);
END;



SELECT MIN(ProductKey) AS MinProduct,
       MAX(ProductKey) AS MaxProduct,
       COUNT(*) AS TotalProductos
FROM DimProduct;

SELECT TOP 20 ProductKey
FROM DimProduct
ORDER BY ProductKey;

