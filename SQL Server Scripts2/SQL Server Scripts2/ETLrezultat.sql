USE CALLCENTER
GO

IF(NOT EXISTS(SELECT 1 FROM Rezultat))
BEGIN
INSERT INTO Rezultat(Tresc) VALUES ('Sprzedano');
INSERT INTO Rezultat(Tresc) VALUES ('Nie sprzedano');
END