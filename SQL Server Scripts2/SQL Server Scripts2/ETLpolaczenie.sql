USE CALLCENTER

If (object_id('dbo.AgentTemp') is not null) DROP TABLE dbo.AgentTemp;
CREATE TABLE AgentTemp(Id int, FirstName varchar(100), LastName varchar(100), [Id_Dzial] int);
GO

BULK INSERT AgentTemp
	FROM 'C:\dev\HDLab\DataWarehousesLabs\DataGenerator\t1_agents.csv'
	WITH
	(
		FIRSTROW = 2,
		FIELDTERMINATOR = '|',
		ROWTERMINATOR = '\n',
		TABLOCK
	)

If (object_id('dbo.ProduktTemp') is not null) DROP TABLE dbo.ProduktTemp;
CREATE TABLE ProduktTemp(Id int, Nazwa varchar(100), Cena decimal, Marza decimal, [Id_Producent] int);
GO

BULK INSERT ProduktTemp
	FROM 'C:\dev\HDLab\DataWarehousesLabs\DataGenerator\t0_products.csv'
	WITH
	(
		FIRSTROW = 2,
		FIELDTERMINATOR = '|',
		ROWTERMINATOR = '\n',
		TABLOCK
	)


If (object_id('dbo.PolaczenieTemp') is not null) DROP TABLE dbo.PolaczenieTemp;
CREATE TABLE PolaczenieTemp(Id int, DataPolaczenia smalldatetime, Rezultat nvarchar(5),
							Id_Produktu int, Id_Agenta int, Id_Klienta varchar(30));
GO

BULK INSERT PolaczenieTemp
	FROM 'C:\dev\HDLab\DataWarehousesLabs\DataGenerator\t0_calls.csv'
	WITH
	(
		FIRSTROW = 2,
		FIELDTERMINATOR = '|',
		ROWTERMINATOR = '\n',
		TABLOCK
	)


	
If (object_id('dbo.statTemp') is not null) DROP TABLE dbo.statTemp;
CREATE TABLE statTemp(Year int,[Month] TEXT,AgentId int ,FirstName TEXT,LastName TEXT,DepartmentId int,HourlyRate decimal,Bonus decimal,HourCount int,Salary decimal);
GO
--DECLARE @PathToFile varchar(200) = (SELECT TOP(1) PathToFile FROM TmpPaths WHERE name ='excel');
--PRINT @PathToFile;

BULK INSERT dbo.statTemp
	FROM 'C:\dev\HDLab\DataWarehousesLabs\DataGenerator\t0_excel.csv'
	WITH
	(
		FIRSTROW = 2,
		FIELDTERMINATOR = '|',
		ROWTERMINATOR = '\n',
		TABLOCK
	)

	If (object_id('dbo.KlientTemp') is not null) DROP TABLE dbo.KlientTemp;
CREATE TABLE KlientTemp([Numer Telefonu] varchar(100));
GO

BULK INSERT KlientTemp
	FROM 'C:\dev\HDLab\DataWarehousesLabs\DataGenerator\t0_clients.csv'
	WITH
	(
		FIRSTROW = 2,
		FIELDTERMINATOR = '|',
		ROWTERMINATOR = '\n',
		TABLOCK
	)