USE CALLCENTER
GO

MERGE Produkt t USING RelationalDb.dbo.Produkt s
	ON t.Nazwa = s.Nazwa
	WHEN NOT MATCHED BY TARGET THEN
		INSERT (Nazwa, Id_Producent) VALUES(s.Nazwa, 
		(SELECT p.Id 
		FROM Producent p JOIN RelationalDb.dbo.Producent tmp ON p.Nazwa = tmp.Nazwa
		WHERE s.FK_Producent = tmp.Id));