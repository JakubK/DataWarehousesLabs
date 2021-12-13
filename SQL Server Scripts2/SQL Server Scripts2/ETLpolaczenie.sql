USE CALLCENTER

If (object_id('dbo.AgentTemp') is not null) DROP TABLE dbo.AgentTemp;
CREATE TABLE AgentTemp(Id int, FirstName varchar(100), LastName varchar(100), [Id_Dzial] int);
GO

BULK INSERT AgentTemp
	FROM 'C:\dev\HDLab\DataWarehousesLabs\DataGenerator\t0_agents.csv'
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
							Id_Produkt int, Id_Agent int, Id_Klient varchar(30));
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



If (object_id('vETLpolacznie') is not null) Drop view vETLpolacznie;
GO

CREATE VIEW vETLpolacznie
AS
SELECT
	Id_Agent,
	Id_Produkt,
	Id_Klient,
	Id_Czas,
	Id_Data,
	Id_Rezultat,
	Id_PoPremii,
	Koszt,
	Marza,
	Zysk
FROM
	(SELECT
		Id_Agent = a.Id,
		Id_Produkt pr.Id,
		Id_Klient = k.Id,
		Id_Czas c.Id,
		Id_Data d.Id,
		Id_Rezultat r.Id,
		Id_PoPremii pp.Id,
		Koszt prTmp.Cena,
		Marza prTmp.Marza,
		Zysk prTmp.Cena *  prTmp.Marza
	FROM PolaczenieTemp pTmp
	JOIN AgentTemp aTmp ON pTmp.Id_Agent = aTmp.Id
	JOIN Agent a ON a.[Imie i Nazwisko] = CAST(aTmp.FirstName + ' ' + aTmp.LastName as varchar(100))
	JOIN ProduktTemp prTmp ON pTmp.Id_Produkt = prTmp.Id
	JOIN Produkt pr ON pr.Nazwa = prTmp.Nazwa
	JOIN Klient k ON pTmp.Id_Klient = k.[Numer Telefonu]
	JOIN Czas c ON
	JOIN Data d ON 
	JOIN Rezultat r ON
	JOIN PoPremii pp ON
	)