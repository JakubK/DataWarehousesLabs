USE master
GO

DECLARE @kill varchar(8000) = '';  
SELECT @kill = @kill + 'kill ' + CONVERT(varchar(5), session_id) + ';'  
FROM sys.dm_exec_sessions
WHERE database_id  = db_id('CALLCENTER')

EXEC(@kill);

DROP DATABASE IF EXISTS CALLCENTER;
GO

CREATE DATABASE CALLCENTER
GO

USE CALLCENTER
GO

CREATE TABLE [Czas]
(
 [Id]      int IDENTITY(1,1) PRIMARY KEY,
 [Godzina] int NOT NULL ,
 [Minuta]  int NOT NULL
);
GO

CREATE TABLE [Data]
(
 [Id]             int IDENTITY(1,1) PRIMARY KEY,
 [Rok]            int NOT NULL ,
 [Miesiac]        int NOT NULL ,
 [Nazwa Miesiaca] varchar(15) NOT NULL ,
 [Dzien]          int NOT NULL
);
GO

CREATE TABLE [Dzial]
(
 [Id]     int IDENTITY(1,1) PRIMARY KEY,
 [Nazwa]  varchar(50) NOT NULL ,
 [Kraj]   varchar(50) NOT NULL ,
 [Miasto] varchar(50) NOT NULL
);
GO

CREATE TABLE [Klient]
(
 [Id]             int IDENTITY(1,1) PRIMARY KEY,
 [Numer Telefonu] VARCHAR(30)
);
GO

CREATE TABLE [PoPremii]
(
 [Id]    int IDENTITY(1,1) PRIMARY KEY,
 [Tresc] varchar(50) NOT NULL
);
GO

CREATE TABLE [Producent]
(
 [Id]    int IDENTITY(1,1) PRIMARY KEY,
 [Nazwa] nvarchar(50) NOT NULL
);
GO

CREATE TABLE [Rezultat]
(
 [Id]    int IDENTITY(1,1) PRIMARY KEY,
 [Tresc] varchar(30) NOT NULL
);
GO

CREATE TABLE [Agent]
(
 [Id]              int IDENTITY(1,1) PRIMARY KEY,
 [Imie i Nazwisko] varchar(50) NOT NULL ,
 [Id_Dzial]        int NOT NULL ,

 CONSTRAINT [FK_15] FOREIGN KEY ([Id_Dzial])  REFERENCES [Dzial]([Id])
);
GO


CREATE TABLE [Produkt]
(
 [Id]           int IDENTITY(1,1) PRIMARY KEY,
 [Id_Producent] int NOT NULL ,
 [Nazwa]        varchar(50) NOT NULL ,

 CONSTRAINT [FK_22] FOREIGN KEY ([Id_Producent])  REFERENCES [Producent]([Id])
);
GO



CREATE TABLE [StatystykaPracownicza]
(
 [Id_Agenta]         int NOT NULL ,
 [Id_Data]           int NOT NULL ,
 [Premia]            decimal(18,2) NOT NULL ,
 [Ilosc Godzin]      int NOT NULL ,
 [Wyplata]           decimal(18,2) NOT NULL ,
 [Stawka za godzine] decimal(18,2) NOT NULL ,


 CONSTRAINT [PK_90] PRIMARY KEY CLUSTERED ([Id_Agenta], [Id_Data]),
 CONSTRAINT [FK_26] FOREIGN KEY ([Id_Agenta])  REFERENCES [Agent]([Id]),
 CONSTRAINT [FK_29] FOREIGN KEY ([Id_Data])  REFERENCES [Data]([Id])
);
GO


CREATE TABLE [Polaczenie]
(
 [Koszt]       decimal(18,2) NOT NULL ,
 [Marza]       decimal(18,2) NOT NULL ,
 [Zysk]        decimal(18,2) NOT NULL ,
 [Id_Agent]    int NOT NULL REFERENCES [Agent]([Id]),
 [Id_Produkt]  int NOT NULL REFERENCES [Produkt]([Id]) ,
 [Id_Klient]   int NOT NULL REFERENCES [Klient]([Id]),
 [Id_Czas]     int NOT NULL REFERENCES [Czas]([Id]),
 [Id_Data]     int NOT NULL REFERENCES [Data]([Id]),
 [Id_Rezultat] int NOT NULL REFERENCES [Rezultat]([Id]),
 [Id_Premia]   int NOT NULL REFERENCES [PoPremii]([Id]),


 CONSTRAINT [PK_91] PRIMARY KEY ([Id_Agent], [Id_Produkt], [Id_Klient],
 [Id_Czas], [Id_Data], [Id_Rezultat], [Id_Premia])
 --CONSTRAINT [FK_11] FOREIGN KEY ([Id_Produkt])  REFERENCES [Produkt]([Id]),
 --CONSTRAINT [FK_13] FOREIGN KEY ([Id_Klient])  REFERENCES [Klient]([Id]),
 --CONSTRAINT [FK_14] FOREIGN KEY ([Id_Agent])  REFERENCES [Agent]([Id]),
 --CONSTRAINT [FK_169] FOREIGN KEY ([Id_Rezultat])  REFERENCES [Rezultat]([Id]),
 --CONSTRAINT [FK_179] FOREIGN KEY ([Id_Premia])  REFERENCES [PoPremii]([Id]),
 --CONSTRAINT [FK_30] FOREIGN KEY ([Id_Data])  REFERENCES [Data]([Id]),
 --CONSTRAINT [FK_32] FOREIGN KEY ([Id_Czas])  REFERENCES [Czas]([Id])
);
GO
