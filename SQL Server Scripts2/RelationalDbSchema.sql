USE master;
DECLARE @kill varchar(8000) = '';  
SELECT @kill = @kill + 'kill ' + CONVERT(varchar(5), session_id) + ';'  
FROM sys.dm_exec_sessions
WHERE database_id  = db_id('RelationalDb')

EXEC(@kill);

DROP DATABASE IF EXISTS RelationalDb;

CREATE DATABASE RelationalDb;
USE RelationalDb;

CREATE TABLE Dzial (
	Id INT  PRIMARY KEY,
	Nazwa VARCHAR(100) NOT NULL,
	Kraj VARCHAR(100) NOT NULL,
	Miasto VARCHAR(100) NOT NULL,
	MaxLiczbaPracownikow INT NOT NULL
);



CREATE TABLE Klient (
	Numer VARCHAR(30) PRIMARY KEY,
	IloscZakupionychProduktow INT NOT NULL
);


CREATE TABLE Producent (
	Id INT PRIMARY KEY,
	Nazwa VARCHAR(60) NOT NULL,
);


CREATE TABLE Agent (
	Id INT PRIMARY KEY,
	Imie VARCHAR(30) NOT NULL,
	Nazwisko VARCHAR(30) NOT NULL,
	FK_Dzial INT NOT NULL,
	FOREIGN KEY(FK_Dzial) REFERENCES Dzial(Id)
);

CREATE TABLE Produkt (
	Id INT PRIMARY KEY,
	Nazwa VARCHAR(30) NOT NULL,
	Koszt DECIMAL(17,2) NOT NULL,
	Marza DECIMAL(17,2) NOT NULL,
	FK_Producent INT NOT NULL,
	FOREIGN KEY(FK_Producent) REFERENCES Producent(Id)
);

CREATE TABLE Polaczenie (
	Id INT  PRIMARY KEY,
	Data_Polaczenia DATETIME NOT NULL,
	Rezultat BIT NOT NULL,
	FK_Produkt INT NOT NULL,
	FK_Agent INT NOT NULL,
	FK_Klient VARCHAR(30) NOT NULL,
	FOREIGN KEY(FK_Produkt) REFERENCES Produkt(Id),
	FOREIGN KEY(FK_Agent) REFERENCES Agent(Id),
	FOREIGN KEY(FK_Klient) REFERENCES Klient(Numer)
);

