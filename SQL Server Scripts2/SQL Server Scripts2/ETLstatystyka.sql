USE CALLCENTER
GO

If (object_id('dbo.statTemp') is not null) DROP TABLE dbo.statTemp;
CREATE TABLE statTemp(Year int,Month int,AgentId int ,FirstName NVARCHAR,LastName NVARCHAR,DepartmentId int,HourlyRate decimal,Bonus decimal,HourCount int,Salary decimal);
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

If (object_id('agentIds') is not null) DROP VIEW agentIds;
GO
CREATE VIEW agentIds
AS
SELECT Id, [Imie i Nazwisko] FROM dbo.Agent;
GO

MERGE StatystykaPracownicza t USING dbo.statTemp s
	ON agentIds.[Imie i Nazwisko] = dbo.statTemp.[FirstName] + ' ' + dbo.statTemp.[LastName]
	AND t.Id_Data = (SELECT Id FROM dbo.Data WHERE Rok = s.Year AND Miesiac = s.Month AND Dzien = 1)
	WHEN NOT MATCHED
		THEN
			INSERT(Id_Agenta, Id_Data, Premia, [Ilosc godzin], [Wyplata], [Stawka za godzine])
			VALUES(agentIds.Id,
			(SELECT Id FROM dbo.Data WHERE Rok = s.Year AND Miesiac = s.Month AND Dzien = 1)
			,s.Bonus,s.HourCount,s.Salary,s.HourlyRate);


drop view agentIds;
drop table dbo.statTEmp;


