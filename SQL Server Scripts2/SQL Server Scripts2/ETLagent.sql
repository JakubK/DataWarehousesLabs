USE CALLCENTER
GO

If (object_id('ETLAgentData') is not null) Drop View ETLAgentData;
GO

CREATE VIEW ETLAgentData
AS
SELECT
	[Imie i Nazwisko] = CAST(Imie + ' ' + Nazwisko as varchar(100)),
	d.Id AS Id_Dzial
	FROM RelationalDb.dbo.Agent aTmp JOIN RelationalDb.dbo.Dzial dTmp ON aTmp.FK_Dzial = dTmp.Id
	JOIN Dzial d ON d.Nazwa = dTmp.Nazwa;
GO

MERGE Agent t USING ETLAgentData s
	ON t.[Imie i Nazwisko] = s.[Imie i Nazwisko]
	WHEN NOT MATCHED BY TARGET THEN
		INSERT ([Imie i Nazwisko], [Id_Dzial]) VALUES(s.[Imie i Nazwisko], Id_Dzial);


Drop View ETLAgentData
