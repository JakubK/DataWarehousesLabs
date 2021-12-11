USE CALLCENTER
GO

If (object_id('dbo.ProduktTemp') is not null) DROP TABLE dbo.ProduktTemp;
CREATE TABLE ProduktTemp(Id int, Nazwa varchar(100));
GO

BULK INSERT ProduktTemp
	FROM 'C:\dev\HDLab\DataWarehousesLabs\DataGenerator\t0_products.csv'
	WITH
	(
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		ROWTERMINATOR = '\n',
		TABLOCK
	)

MERGE Producent t USING ProduktTemp s
	ON t.Nazwa = s.Nazwa
	WHEN NOT MATCHED BY TARGET
		THEN INSERT (Nazwa) VALUES(s.Nazwa);

DROP TABLE ProduktTemp