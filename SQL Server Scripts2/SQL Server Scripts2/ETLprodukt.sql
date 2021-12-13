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


MERGE Produkt t USING ProduktTemp s
	ON t.Nazwa = s.Nazwa
	WHEN NOT MATCHED BY TARGET THEN
		INSERT (Nazwa, Id_Producent) VALUES(s.Nazwa, 
		(SELECT p.Id 
		FROM Producent p JOIN ProducentTemp tmp ON p.Nazwa = tmp.Nazwa
		WHERE s.Id_Producent = tmp.Id));


DROP TABLE ProduktTemp