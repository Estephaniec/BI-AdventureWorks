-- Revisar la última fecha de venta por internet
USE AdventureWorks2022;
GO

SELECT 
    MAX(CAST(OrderDate AS date)) AS UltimaFechaInternet
FROM Sales.SalesOrderHeader
WHERE OnlineOrderFlag = 1;
--UltimaFechaInternet 2014-10-08

-- 100 órdenes por internet que se usan como base
SELECT TOP (100) *
INTO #BaseOrdenesInternet
FROM Sales.SalesOrderHeader
WHERE OnlineOrderFlag = 1
ORDER BY OrderDate;

--generar las nuevas 100 órdenes con fechas posteriores a 2014-06-30.
DECLARE @UltimaFecha date = '2014-06-30';

INSERT INTO Sales.SalesOrderHeader (
    RevisionNumber,
    OrderDate,
    DueDate,
    ShipDate,
    Status,
    OnlineOrderFlag,
    PurchaseOrderNumber,
    AccountNumber,
    CustomerID,
    ShipToAddressID,
    BillToAddressID,
    ShipMethodID,
    CreditCardID,
    CreditCardApprovalCode,
    SubTotal,
    TaxAmt,
    Freight,
    Comment,
    rowguid,
    ModifiedDate
)
SELECT
    RevisionNumber,
    DATEADD(day, ROW_NUMBER() OVER(ORDER BY (SELECT NULL)), @UltimaFecha),
    DATEADD(day, 5, DATEADD(day, ROW_NUMBER() OVER(ORDER BY (SELECT NULL)), @UltimaFecha)),
    DATEADD(day, 2, DATEADD(day, ROW_NUMBER() OVER(ORDER BY (SELECT NULL)), @UltimaFecha)),
    Status,
    1,
    PurchaseOrderNumber,
    AccountNumber,
    CustomerID,
    ShipToAddressID,
    BillToAddressID,
    ShipMethodID,
    CreditCardID,
    CreditCardApprovalCode,
    SubTotal,
    TaxAmt,
    Freight,
    Comment,
    NEWID(),
    SYSDATETIME()
FROM #BaseOrdenesInternet;

--saber qué SalesOrderID nuevos corresponden a cada orden base.
-- Crear tabla para guardar el mapeo
IF OBJECT_ID('tempdb..#MapeoOrdenes') IS NOT NULL DROP TABLE #MapeoOrdenes;

CREATE TABLE #MapeoOrdenes (
    OldSalesOrderID int,
    NewSalesOrderID int
);

;WITH Base AS (
    SELECT 
        h.SalesOrderID,
        ROW_NUMBER() OVER (ORDER BY h.OrderDate, h.SalesOrderID) AS rn
    FROM #BaseOrdenesInternet h
),
Nuevas AS (
    SELECT 
        h.SalesOrderID,
        ROW_NUMBER() OVER (ORDER BY h.OrderDate, h.SalesOrderID) AS rn
    FROM Sales.SalesOrderHeader h
    WHERE h.OrderDate > '2014-06-30'  -- solo las nuevas
)
INSERT INTO #MapeoOrdenes (OldSalesOrderID, NewSalesOrderID)
SELECT 
    b.SalesOrderID,
    n.SalesOrderID
FROM Base b
JOIN Nuevas n ON b.rn = n.rn;

-- inserción en details
INSERT INTO Sales.SalesOrderDetail (
    SalesOrderID,
    CarrierTrackingNumber,
    OrderQty,
    ProductID,
    SpecialOfferID,
    UnitPrice,
    UnitPriceDiscount,
    rowguid,
    ModifiedDate
)
SELECT
    m.NewSalesOrderID,
    d.CarrierTrackingNumber,
    d.OrderQty,
    d.ProductID,
    d.SpecialOfferID,
    d.UnitPrice,
    d.UnitPriceDiscount,
    NEWID(),
    SYSDATETIME()
FROM Sales.SalesOrderDetail d
JOIN #MapeoOrdenes m
    ON d.SalesOrderID = m.OldSalesOrderID;

-- verificar inserciones
SELECT 
    COUNT(*) AS TotalOrdenesNuevas,
    MIN(OrderDate) AS PrimeraFechaNueva,
    MAX(OrderDate) AS UltimaFechaNueva
FROM Sales.SalesOrderHeader
WHERE OrderDate > '2014-06-30';

--En DW
USE AdventureWorksDW2022;

-- dimensión fecha
DECLARE @StartDate DATE = '2010-01-01';
DECLARE @EndDate   DATE = '2030-12-31';

;WITH Dates AS (
    SELECT @StartDate AS [Date]
    UNION ALL
    SELECT DATEADD(DAY, 1, [Date])
    FROM Dates
    WHERE [Date] < @EndDate
)
INSERT INTO DimDate (FullDateAlternateKey, CalendarYear, CalendarMonth, DayNumberOfMonth)
SELECT 
    [Date],
    YEAR([Date]),
    MONTH([Date]),
    DAY([Date])
FROM Dates
OPTION (MAXRECURSION 0);


-- verificar fechas en DW

SELECT 
    MIN(FullDateAlternateKey) AS PrimeraFechaDimDate,
    MAX(FullDateAlternateKey) AS UltimaFechaDimDate
FROM DimDate;
--UltimaFechaDimDate 2014-12-31

--identificar qué necesita FactInternetSales para poder hacer los Lookups en SSIS.
EXEC sp_help 'FactInternetSales';

--obtener de AdventureWorks2022 todos los datos que se van a transformar hacia FactInternetSales.
SELECT
    h.SalesOrderID,
    d.SalesOrderDetailID AS SalesOrderLineNumber,
    h.OrderDate,
    h.DueDate,
    h.ShipDate,
    d.ProductID,
    h.CustomerID,
    p.TerritoryID,
    d.OrderQty,
    d.UnitPrice,
    d.UnitPriceDiscount,
    h.SubTotal,
    h.TaxAmt,
    h.Freight
FROM Sales.SalesOrderHeader h
JOIN Sales.SalesOrderDetail d
    ON h.SalesOrderID = d.SalesOrderID
JOIN Sales.Customer c
    ON h.CustomerID = c.CustomerID
LEFT JOIN Sales.SalesTerritory p
    ON c.TerritoryID = p.TerritoryID
WHERE h.OnlineOrderFlag = 1;
--OLE DB Source del Data Flow en SSIS.

-- ver tipos para derived column
EXEC sp_help 'dimDate';
USE AdventureWorksDW2022;
EXEC sp_help 'sales.salesOrderHeader';
EXEC sp_help 'factInternetSales';

select * from FactInternetSales
--antes del ETL
SELECT COUNT(*) AS TotalAntes  --TotalAntes: 60398
FROM FactInternetSales;

--DESPUÉS
SELECT COUNT(*) AS TotalDespues
FROM FactInternetSales;


SELECT *
FROM Sales.SalesOrderDetail  --OrderDate: 2014-10-09 00:00:00.000
ORDER BY OrderDate DESC;

SELECT *
FROM FactInternetSales  -- OrderDateKey: 2014-01-28
ORDER BY OrderDateKey DESC;

SELECT 
    COLUMN_NAME, 
    DATA_TYPE, 
    CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'DimProduct'
  AND COLUMN_NAME = 'ProductAlternateKey';

SELECT *
FROM FactInternetSales
WHERE ModifiedDate >= '2025-11-27'
ORDER BY ModifiedDate DESC;


SELECT *
FROM DimProduct;
