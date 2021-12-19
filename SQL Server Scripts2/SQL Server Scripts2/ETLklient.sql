USE CALLCENTER
GO

MERGE Klient t USING RelationalDb.dbo.Klient s
	ON t.[Numer Telefonu] = s.Numer
	WHEN NOT MATCHED BY TARGET THEN
		INSERT ([Numer Telefonu]) VALUES(s.Numer)
	WHEN NOT MATCHED BY SOURCE THEN 
		UPDATE SET t.[Numer Telefonu] = NULL;