USE CALLCENTER
GO

--TRUNCATE TABLE Czas;

DECLARE @HourInProcess int = 0;
DECLARE @MinuteInProcess int = 0;



WHILE @HourInProcess <= 23
BEGIN
	WHILE @MinuteInProcess <= 59
		BEGIN
			INSERT INTO Czas (Godzina, Minuta)
			VALUES (@HourInProcess, @MinuteInProcess);
			SET @MinuteInProcess = @MinuteInProcess + 1;
		END
		SET @HourInProcess = @HourInProcess + 1;
END
GO