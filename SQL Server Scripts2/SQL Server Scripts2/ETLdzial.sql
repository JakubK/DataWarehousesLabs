USE CALLCENTER
GO

MERGE Dzial t USING RelationalDb.dbo.Dzial s
	ON t.Nazwa = s.Nazwa
	WHEN NOT MATCHED BY TARGET
		THEN INSERT (Nazwa, Kraj, Miasto) VALUES (s.Nazwa, s.Kraj, s.Miasto);
