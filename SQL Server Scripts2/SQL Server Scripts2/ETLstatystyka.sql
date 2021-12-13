USE CALLCENTER
GO
If (object_id('dbo.statTemp') is not null) DROP TABLE dbo.statTemp;
CREATE TABLE statTemp(Year int,[Month] TEXT,AgentId int ,FirstName TEXT,LastName TEXT,DepartmentId int,HourlyRate decimal(18,2),Bonus decimal(18,2),HourCount int,Salary decimal(18,2));
GO
--DECLARE @PathToFile varchar(200) = (SELECT TOP(1) PathToFile FROM TmpPaths WHERE name ='excel');
--PRINT @PathToFile;

BULK INSERT dbo.statTemp
	FROM 'C:\dev\HDLab\DataWarehousesLabs\DataGenerator\t0_excel.csv'
	WITH
	(
		FIRSTROW = 2,
		FIELDTERMINATOR = '|',
		ROWTERMINATOR = '\n',
		TABLOCK
	)

If (object_id('agentIds') is not null) DROP VIEW agentIds;
GO
CREATE VIEW agentIds
AS
SELECT Id, [Imie i Nazwisko], Month, Year, Bonus, HourCount, Salary, HourlyRate FROM dbo.Agent
INNER JOIN dbo.statTemp ON dbo.Agent.[Imie i Nazwisko] = CAST(dbo.statTemp.[FirstName] as VARCHAR) + ' ' + CAST(dbo.statTemp.[LastName] as VARCHAR);
GO

MERGE StatystykaPracownicza t USING agentIds s
	ON t.Id_Data = (SELECT TOP 1 Id FROM dbo.Data WHERE Rok = s.Year AND Miesiac = MONTH(CAST(s.Month as VARCHAR) + ' 1 2021')  AND Dzien = 1)
	AND t.Id_Agenta = s.Id
	WHEN NOT MATCHED
		THEN
			INSERT(Id_Agenta, Id_Data, Premia, [Ilosc godzin], [Wyplata], [Stawka za godzine])
			VALUES(s.Id,
			(SELECT TOP 1 Id FROM dbo.Data WHERE Rok = s.Year AND Miesiac = MONTH(CAST(s.Month as VARCHAR) + ' 1 2021') AND Dzien = 1)
			,s.Bonus,s.HourCount,s.Salary,s.HourlyRate);

drop view agentIds;
drop table dbo.statTEmp;
