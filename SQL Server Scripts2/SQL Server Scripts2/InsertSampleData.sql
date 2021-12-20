INSERT INTO Producent (Nazwa) VALUES('P1');

INSERT INTO Produkt (Id_Producent, Nazwa) VALUES(1, 'Produkt1');
INSERT INTO Produkt (Id_Producent, Nazwa) VALUES(1, 'Produkt2');
INSERT INTO Produkt (Id_Producent, Nazwa) VALUES(1, 'Produkt3');
INSERT INTO Produkt (Id_Producent, Nazwa) VALUES(1, 'Produkt4');

INSERT INTO PoPremii(Tresc) VALUES('Po premii');
INSERT INTO PoPremii(Tresc) VALUES('Nie po premii');

INSERT INTO Czas(Godzina, Minuta) VALUES(1, 1);
INSERT INTO Czas(Godzina, Minuta) VALUES(2, 2);
INSERT INTO Czas(Godzina, Minuta) VALUES(3, 3);
INSERT INTO Czas(Godzina, Minuta) VALUES(4, 4);
INSERT INTO Czas(Godzina, Minuta) VALUES(5, 5);
INSERT INTO Czas(Godzina, Minuta) VALUES(6, 6);
INSERT INTO Czas(Godzina, Minuta) VALUES(7, 7);
INSERT INTO Czas(Godzina, Minuta) VALUES(8, 8);

INSERT INTO Data(Rok, Miesiac,[Nazwa Miesiaca], Dzien) VALUES
(2021, 1, 'Styczeñ', 1),
(2021, 2, 'Luty', 2),
(2021, 3, 'Marzec', 3),
(2021, 4, 'Kwiecieñ', 4);

INSERT INTO Dzial(Nazwa, Kraj, Miasto) VALUES 
('Dzial A', 'Polska', 'Gdynia'),
('Dzial B', 'Imperium Lechickie', 'Gniezno'),
('Dzial C', 'Izrael', 'Jerozolima'),
('Dzial D', 'Wielka Brytania', 'Londyn'),
('Dzial E', 'Niemcy', 'Berlin');

INSERT INTO Klient([Numer Telefonu])VALUES 
('123453789'),
('123456749'),
('123854789'),
('123458389'),
('123456989'),
('123456729'),
('113456789'),
('123756789'),
('123453789'),
('123136789');

INSERT INTO Agent([Imie i Nazwisko], Id_Dzial) VALUES 
('Jan Kowalski', 1),
('Piotr Nowak', 1),
('Krzysztof Szewczyk', 2),
('Anna Kowalska', 2),
('Aleksandra Iksiñska', 3),
('Karolina Kowalska', 3),
('Andrzej Duda', 4),
('Marian Kowalski', 5),
('Mateusz WoŸniak', 5);

INSERT INTO Rezultat(Tresc) VALUES 
('Sprzedano'),(Nie sprzedano');

INSERT INTO Polaczenie(Id_Agent, Id_Czas, Id_Data, Id_Klient, Id_Premia,
						Id_Produkt, Id_Rezultat, Koszt, Marza, Zysk) VALUES
(1, 1, 4, 1, 2, 1, 1, 10, 0.2, 2),
(2, 1, 4, 1, 1, 3, 2, 20, 0.1, 2),
(1, 2, 1, 4, 2, 1, 1, 30, 0.3, 9),
(4, 1, 2, 1, 1, 4, 2, 10, 0.1, 1),
(2, 1, 3, 2, 1, 1, 2, 40, 0.4, 16),
(1, 3, 1, 1, 2, 1, 2, 50, 0.5, 25),
(3, 1, 4, 1, 2, 2, 2, 100, 0.1, 10),
(1, 3, 1, 3, 1, 1, 1, 10, 0.05, 0.5);

INSERT INTO StatystykaPracownicza(Id_Agenta,Id_Data,Premia,[Ilosc Godzin], Wyplata, [Stawka za godzine]) VALUES
(1, 1, 200, 200, 1200, 6),
(1, 2, 0, 100, 600, 6),
(1, 3, 0, 50, 300, 6),
(2, 1, 0, 20, 120, 6),
(2, 2, 120, 50, 300, 6),
(2, 3, 50, 80, 480, 6),
(3, 1, 0, 90, 540, 6),
(3, 2, 10, 130, 1200, 6),
(3, 3, 0, 140, 840, 6),
(4, 1, 0, 100, 600, 6),
(4, 2, 0, 10, 60, 6),
(4, 3, 0, 50, 300, 6),
(5, 1, 0, 10, 60,6);
