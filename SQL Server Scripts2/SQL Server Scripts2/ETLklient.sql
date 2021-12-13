USE CALLCENTER
GO

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

MERGE Klient t USING KlientTemp s
	ON t.[Numer Telefonu] = s.[Numer Telefonu]
	WHEN NOT MATCHED BY TARGET THEN
		INSERT ([Numer Telefonu]) VALUES(s.[Numer Telefonu])
	WHEN NOT MATCHED BY SOURCE THEN 
		UPDATE SET t.[Numer Telefonu] = NULL;

DROP TABLE KlientTemp