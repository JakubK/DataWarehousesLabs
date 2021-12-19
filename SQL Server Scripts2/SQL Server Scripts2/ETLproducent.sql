USE CALLCENTER
GO

MERGE Producent t USING RelationalDb.dbo.Producent s
	ON t.Nazwa = s.Nazwa
	WHEN NOT MATCHED BY TARGET
		THEN INSERT (Nazwa) VALUES(s.Nazwa);