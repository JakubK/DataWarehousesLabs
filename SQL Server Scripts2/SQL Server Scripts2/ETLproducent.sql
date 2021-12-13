USE CALLCENTER
GO

If (object_id('dbo.ProducentTemp') is not null) DROP TABLE dbo.ProducentTemp;
CREATE TABLE ProducentTemp(Id int, Nazwa varchar(100));
GO

BULK INSERT ProducentTemp
	FROM 'C:\dev\HDLab\DataWarehousesLabs\DataGenerator\t0_producers.csv'
	WITH
	(
		FIRSTROW = 2,
		FIELDTERMINATOR = '|',
		ROWTERMINATOR = '\n',
		TABLOCK
	)

MERGE Producent t USING ProducentTemp s
	ON t.Nazwa = s.Nazwa
	WHEN NOT MATCHED BY TARGET
		THEN INSERT (Nazwa) VALUES(s.Nazwa);

DROP TABLE ProducentTemp