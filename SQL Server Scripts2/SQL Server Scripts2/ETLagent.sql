-- its a mess currently, a lot needs to be done

USE CALLCENTER
GO

If (object_id('dbo.DzialTemp') is not null) DROP TABLE dbo.DzialTemp;
CREATE TABLE DzialTemp(Id int, Nazwa varchar(100), Kraj varchar(100), Miasto varchar(100));
GO

BULK INSERT DzialTemp
	FROM 'C:\dev\HDLab\DataWarehousesLabs\DataGenerator\t0_departments.csv'
	WITH
	(
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		ROWTERMINATOR = '\n',
		TABLOCK
	)

If (object_id('dbo.AgentTemp') is not null) DROP TABLE dbo.AgentTemp;
CREATE TABLE AgentTemp(FirstName varchar(100), LastName varchar(100), [Id_Dzial] int);
GO

BULK INSERT AgentTemp
	FROM 'C:\dev\HDLab\DataWarehousesLabs\DataGenerator\t0_agents.csv'
	WITH
	(
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		ROWTERMINATOR = '\n',
		TABLOCK
	)


MERGE Agent t USING AgentTemp s
	ON t.[Imie i Nazwisko] = s.[Imie i Nazwisko]
	WHEN NOT MATCHED BY TARGET THEN
		INSERT ([Imie i Nazwisko], [Id_Dzial]) VALUES(s.[Imie i Nazwisko], 
		(SELECT p.Id 
		FROM Producent p JOIN ProducentTemp tmp ON p.Nazwa = tmp.Nazwa
		WHERE s.Id_Producent = tmp.Id));

DROP TABLE DzialTemp
DROP TABLE ProduktTemp