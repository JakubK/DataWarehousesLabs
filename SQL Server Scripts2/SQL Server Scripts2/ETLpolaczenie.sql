USE CALLCENTER
SET LANGUAGE English

If (object_id('dbo.statTemp') is not null) DROP TABLE dbo.statTemp;
CREATE TABLE statTemp(Year int,[Month] TEXT,AgentId int ,Imie TEXT,Nazwisko TEXT,DepartmentId int,HourlyRate decimal,Bonus decimal,HourCount int,Salary decimal);
GO

BULK INSERT dbo.statTemp
	FROM 'C:\dev\HDLab\DataWarehousesLabs\DataGenerator\t0_excel.csv'
	WITH
	(
		FIRSTROW = 2,
		FIELDTERMINATOR = '|',
		ROWTERMINATOR = '\n',
		TABLOCK
	)

GO

If (object_id('vETLpolacznie') is not null) DROP VIEW vETLpolacznie;
GO
CREATE VIEW vETLpolacznie
AS
SELECT
	Id_Agent,
	Id_Produkt,
	Id_Klient,
	Id_Czas,
	Id_Data,
	Id_Rezultat,
	Id_PoPremii,
	Koszt,
	Marza,
	Zysk
FROM
	(SELECT
		Id_Agent = a.Id,
		Id_Produkt = pr.Id,
		Id_Klient = k.Id,
		Id_Czas = c.Id,
		Id_Data = d.Id,
		Id_Rezultat = r.Id,
		Id_PoPremii = pp.Id,
		Koszt = prTmp.Koszt,
		Marza = prTmp.Marza,
		Zysk = prTmp.Koszt * prTmp.Marza
	FROM RelationalDb.dbo.Polaczenie pTmp
	JOIN RelationalDb.dbo.Agent aTmp ON pTmp.FK_Agent = aTmp.Id
	JOIN Agent a ON a.[Imie i Nazwisko] = CAST(aTmp.Imie + ' ' + aTmp.Nazwisko as varchar(100))
	JOIN RelationalDb.dbo.Produkt prTmp ON pTmp.FK_Produkt = prTmp.Id
	JOIN Produkt pr ON pr.Nazwa = prTmp.Nazwa
	JOIN Klient k ON pTmp.FK_Klient = k.[Numer Telefonu]
	JOIN Czas c ON c.Godzina = DatePart(Hour, pTmp.Data_Polaczenia) AND c.Minuta = DatePart(MINUTE, pTmp.Data_Polaczenia)
	JOIN Data d ON d.Rok = DatePart(YEAR, pTmp.Data_Polaczenia) AND d.Miesiac =  DatePart(MONTH, pTmp.Data_Polaczenia) AND d.Dzien = DatePart(DAY, pTmp.Data_Polaczenia)
	JOIN Rezultat r ON r.Tresc = (CASE pTmp.Rezultat WHEN 'True' Then 'Sprzedano' ELSE 'Nie sprzedano' END)
	JOIN PoPremii pp ON pp.Tresc = 
	(CASE WHEN (
	(SELECT TOP 1 Bonus FROM statTemp 
	WHERE AgentId = aTmp.Id AND statTemp.Year = Year(pTmp.Data_Polaczenia)
	AND DatePart(MONTH, pTmp.Data_Polaczenia)  = MONTH(CAST(statTemp.Month as VARCHAR) + ' 1 2021')
	)
	> 0)
	THEN 'Po premii' ELSE 'Nie po premii' END)
	) AS x
GO



--SELECT COUNT(*) FROM vETLpolacznie
--SELECT COUNT(*) FROM RelationalDb.dbo.Polaczenie


MERGE INTO Polaczenie as t USING vETLpolacznie as s
		ON 	t.Id_Agent = s.Id_Agent
		AND t.Id_Produkt = s.Id_Produkt
		AND t.Id_Klient = s.Id_Klient
		AND t.Id_Czas = s.Id_Czas
		AND t.Id_Data = s.Id_Data
		AND t.Id_Rezultat = s.Id_Rezultat
		AND t.Id_Premia = s.Id_PoPremii
			WHEN Not Matched THEN
					INSERT  Values ( s.Koszt, s.Marza, s.Zysk, s.Id_Agent, s.Id_Produkt, s.Id_Klient, s.Id_Czas, s.Id_Data, 
									s.Id_Rezultat, s.Id_PoPremii);



DROP TABLE statTemp;
DROP VIEW vETLpolacznie;


--SELECT * FROM RelationalDb.dbo.Polaczenie pTmp
--	JOIN RelationalDb.dbo.Produkt prTmp ON pTmp.FK_Produkt = prTmp.Id
--	JOIN Produkt pr ON pr.Nazwa = prTmp.Nazwa

--SELECT COUNT(*) FROM RelationalDb.dbo.Produkt
--SELECT [Numer Telefonu] FROM Klient k INNER JOIN RelationalDb.dbo.Polaczenie pTmp ON pTmp.FK_Klient = k.[Numer Telefonu] ORDER BY 1 ASC
--SELECT [Numer Telefonu] FROM Klient k  ORDER BY 1 ASC

--SELECT FK_Klient FROM RelationalDb.dbo.Polaczenie ORDER BY 1 ASC

--USE RelationalDb
--SELECT * FROM RelationalDb.dbo.Produkt JOIN  RelationalDb.dbo.Polaczenie ON RelationalDb.dbo.Id = RelationalDb.dbo.Polaczenie.FK_Produkt

--SELECT * FROM RelationalDb.dbo.Produkt p
--INNER JOIN RelationalDb.dbo.Polaczenie pTemp ON pTemp.FK_Produkt = p.Id
--JOIN CALLCENTER.dbo.Produkt ON CALLCENTER.dbo.Produkt.Nazwa = p.Nazwa


--SELECT  p.Id_Agent, p.Id_Czas, p.Id_Data, p.Id_Klient, p.Id_PoPremii, p.Id_Produkt, p.Id_Rezultat, COUNT(*) as Wystapienia FROM vETLpolacznie p
--GROUP BY p.Id_Agent, p.Id_Czas, p.Id_Data, p.Id_Klient, p.Id_PoPremii, p.Id_Produkt, p.Id_Rezultat
--HAVING COUNT(*) > 1

--SELECT Id, COUNT(*) FROM RelationalDb.dbo.Polaczenie 
--GROUP BY Id
--HAVING COUNT(*) > 1

--SELECT * FROM vETLpolacznie
--SELECT * FROM Produkt
							--INSERT INTO Polaczenie
							--SELECT * FROM vETLpolacznie