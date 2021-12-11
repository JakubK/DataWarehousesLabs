--Not finished, changes in data generator needed first

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

MERGE Dzial t USING DzialTemp s
	ON t.Nazwa = s.Nazwa
	WHEN NOT MATCHED BY TARGET
		THEN INSERT (Nazwa, Kraj, Miasto) VALUES(s.Nazwa, s.Kraj, s.Miasto);

DROP TABLE DzialTemp