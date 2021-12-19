USE CALLCENTER
GO


IF(NOT EXISTS(SELECT 1 FROM PoPremii))
BEGIN
INSERT INTO PoPremii(Tresc) VALUES ('Po premii');
INSERT INTO PoPremii(Tresc) VALUES ('Nie po premii');
END