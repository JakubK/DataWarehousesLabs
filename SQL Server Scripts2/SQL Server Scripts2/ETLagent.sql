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
		FIELDTERMINATOR = '|',
		ROWTERMINATOR = '\n',
		TABLOCK
	)


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

If (object_id('ETLAgentData') is not null) Drop View ETLAgentData;
GO

CREATE VIEW ETLAgentData
AS
SELECT
	[Imie i Nazwisko] = CAST(FirstName + ' ' + LastName as varchar(100)),
	d.Id AS Id_Dzial
	FROM AgentTemp aTmp JOIN DzialTemp dTmp ON aTmp.Id_Dzial = dTmp.Id
	JOIN Dzial d ON d.Nazwa = dTmp.Nazwa;
GO

MERGE Agent t USING ETLAgentData s
	ON t.[Imie i Nazwisko] = s.[Imie i Nazwisko]
	WHEN NOT MATCHED BY TARGET THEN
		INSERT ([Imie i Nazwisko], [Id_Dzial]) VALUES(s.[Imie i Nazwisko], Id_Dzial);


Drop View ETLAgentData
DROP TABLE DzialTemp
DROP TABLE AgentTemp
