

CREATE TABLE [Czas]
(
 [Id]      int IDENTITY(1,1) PRIMARY KEY,
 [Godzina] int NOT NULL ,
 [Minuta]  int NOT NULL ,
);
GO

CREATE TABLE [Data]
(
 [Id]             int NOT NULL ,
 [Rok]            int NOT NULL ,
 [Miesiac]        int NOT NULL ,
 [Nazwa Miesiaca] varchar(15) NOT NULL ,
 [Dzien]          int NOT NULL ,


 CONSTRAINT [PK_145] PRIMARY KEY CLUSTERED ([Id] ASC)
);
GO

CREATE TABLE [Dzial]
(
 [Id]     int NOT NULL ,
 [Nazwa]  varchar(50) NOT NULL ,
 [Kraj]   varchar(50) NOT NULL ,
 [Miasto] varchar(50) NOT NULL ,


 CONSTRAINT [PK_56] PRIMARY KEY CLUSTERED ([Id] ASC)
);
GO

CREATE TABLE [Klient]
(
 [Id]             int NOT NULL ,
 [Numer Telefonu] nvarchar(50) NOT NULL ,


 CONSTRAINT [PK_65] PRIMARY KEY CLUSTERED ([Id] ASC)
);
GO

CREATE TABLE [PoPremii]
(
 [Id]    int NOT NULL ,
 [Tresc] varchar(50) NOT NULL ,


 CONSTRAINT [PK_176] PRIMARY KEY CLUSTERED ([Id] ASC)
);
GO

CREATE TABLE [Producent]
(
 [Id]    int NOT NULL ,
 [Nazwa] nvarchar(50) NOT NULL ,


 CONSTRAINT [PK_60] PRIMARY KEY CLUSTERED ([Id] ASC)
);
GO

CREATE TABLE [Rezultat]
(
 [Tresc] varchar(30) NOT NULL ,
 [Id]    int NOT NULL ,


 CONSTRAINT [PK_159] PRIMARY KEY CLUSTERED ([Id] ASC)
);
GO

CREATE TABLE [Agent]
(
 [Id]              int NOT NULL ,
 [Imie i Nazwisko] varchar(50) NOT NULL ,
 [Id_Dzial]        int NOT NULL ,


 CONSTRAINT [PK_39] PRIMARY KEY CLUSTERED ([Id] ASC),
 CONSTRAINT [FK_15] FOREIGN KEY ([Id_Dzial])  REFERENCES [Dzial]([Id])
);
GO


CREATE TABLE [Produkt]
(
 [Id_Producent] int NOT NULL ,
 [Nazwa]        varchar(50) NOT NULL ,
 [Id]           int NOT NULL ,


 CONSTRAINT [PK_87] PRIMARY KEY CLUSTERED ([Id] ASC),
 CONSTRAINT [FK_22] FOREIGN KEY ([Id_Producent])  REFERENCES [Producent]([Id])
);
GO



CREATE TABLE [StatystykaPracownicza]
(
 [Id_Agenta]         int NOT NULL ,
 [Id_Data]           int NOT NULL ,
 [Premia]            decimal(18,0) NOT NULL ,
 [Ilosc Godzin]      int NOT NULL ,
 [Wyplata]           decimal(18,0) NOT NULL ,
 [Stawka za godzine] decimal(18,0) NOT NULL ,


 CONSTRAINT [PK_90] PRIMARY KEY CLUSTERED ([Id_Agenta] ASC, [Id_Data] ASC),
 CONSTRAINT [FK_26] FOREIGN KEY ([Id_Agenta])  REFERENCES [Agent]([Id]),
 CONSTRAINT [FK_29] FOREIGN KEY ([Id_Data])  REFERENCES [Data]([Id])
);
GO


CREATE TABLE [Polaczenie]
(
 [Koszt]       decimal(18,0) NOT NULL ,
 [Marza]       decimal(18,0) NOT NULL ,
 [Zysk]        decimal(18,0) NOT NULL ,
 [Id_Agent]    int NOT NULL ,
 [Id_Produkt]  int NOT NULL ,
 [Id_Klient]   int NOT NULL ,
 [Id_Czas]     int NOT NULL ,
 [Id_Data]     int NOT NULL ,
 [Id_Rezultat] int NOT NULL ,
 [Id_Premia]   int NOT NULL ,


 CONSTRAINT [PK_91] PRIMARY KEY CLUSTERED ([Id_Agent] ASC, [Id_Produkt] ASC, [Id_Klient] ASC, [Id_Czas] ASC, [Id_Data] ASC, [Id_Rezultat] ASC, [Id_Premia] ASC),
 CONSTRAINT [FK_11] FOREIGN KEY ([Id_Produkt])  REFERENCES [Produkt]([Id]),
 CONSTRAINT [FK_13] FOREIGN KEY ([Id_Klient])  REFERENCES [Klient]([Id]),
 CONSTRAINT [FK_14] FOREIGN KEY ([Id_Agent])  REFERENCES [Agent]([Id]),
 CONSTRAINT [FK_169] FOREIGN KEY ([Id_Rezultat])  REFERENCES [Rezultat]([Id]),
 CONSTRAINT [FK_179] FOREIGN KEY ([Id_Premia])  REFERENCES [PoPremii]([Id]),
 CONSTRAINT [FK_30] FOREIGN KEY ([Id_Data])  REFERENCES [Data]([Id]),
 CONSTRAINT [FK_32] FOREIGN KEY ([Id_Czas])  REFERENCES [Czas]([Id])
);
GO
