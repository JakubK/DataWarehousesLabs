INSERT INTO Producent (Id, Nazwa) VALUES(1, 'P1');

INSERT INTO Produkt (Id, Id_Producent, Nazwa) VALUES(1, 1, 'Produkt1');
INSERT INTO Produkt (Id, Id_Producent, Nazwa) VALUES(2, 1, 'Produkt2');
INSERT INTO Produkt (Id, Id_Producent, Nazwa) VALUES(3, 1, 'Produkt3');
INSERT INTO Produkt (Id, Id_Producent, Nazwa) VALUES(4, 1, 'Produkt4');

INSERT INTO PoPremii(Id, Tresc) VALUES(1, 'Po premii');
INSERT INTO PoPremii(Id, Tresc) VALUES(2, 'Nie po premii');

INSERT INTO Czas(Id, Godzina, Minuta) VALUES(1, 1, 1);
INSERT INTO Czas(Id, Godzina, Minuta) VALUES(2, 2, 2);
INSERT INTO Czas(Id, Godzina, Minuta) VALUES(3, 3, 3);
INSERT INTO Czas(Id, Godzina, Minuta) VALUES(4, 4, 4);
INSERT INTO Czas(Id, Godzina, Minuta) VALUES(5, 5, 5);
INSERT INTO Czas(Id, Godzina, Minuta) VALUES(6, 6, 6);
INSERT INTO Czas(Id, Godzina, Minuta) VALUES(7, 7, 7);
INSERT INTO Czas(Id, Godzina, Minuta) VALUES(8, 8, 8);

INSERT INTO Data(Id, Rok, Miesiac,[Nazwa Miesiaca], Dzien) VALUES
(1, 2021, 1, 'Styczeñ', 1),
(2, 2021, 2, 'Luty', 2),
(3, 2021, 3, 'Marzec', 3),
(4, 2021, 4, 'Kwiecieñ', 4);

INSERT INTO Dzial(Id, Nazwa, Kraj, Miasto) VALUES 
(1, 'Dzial A', 'Polska', 'Gdynia'),
(2, 'Dzial B', 'Imperium Lechickie', 'Gniezno'),
(3, 'Dzial C', 'Izrael', 'Jerozolima'),
(4, 'Dzial D', 'Wielka Brytania', 'Londyn'),
(5, 'Dzial E', 'Niemcy', 'Berlin');

INSERT INTO Klient(Id, [Numer Telefonu])VALUES 
(1, '123453789'),
(2, '123456749'),
(3, '123854789'),
(4, '123458389'),
(5, '123456989'),
(6, '123456729'),
(7, '113456789'),
(8, '123756789'),
(9, '123453789'),
(10, '123136789');

INSERT INTO Agent(Id, [Imie i Nazwisko], Id_Dzial) VALUES 
(1, 'Jan Kowalski', 1),
(2, 'Piotr Nowak', 1),
(3, 'Krzysztof Szewczyk', 2),
(4, 'Anna Kowalska', 2),
(5, 'Aleksandra Iksiñska', 3),
(6, 'Karolina Kowalska', 3),
(7, 'Andrzej Duda', 4),
(8, 'Marian Kowalski', 5),
(9, 'Mateusz WoŸniak', 5);

INSERT INTO Rezultat(Id, Tresc) VALUES 
(1, 'Sprzedano'),(2, 'Nie sprzedano');

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
