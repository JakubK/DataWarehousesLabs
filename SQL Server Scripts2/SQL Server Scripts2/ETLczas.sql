USE CALLCENTER
GO

DECLARE @HourInProcess int = 0;
DECLARE @MinuteInProcess int = 0;


IF(NOT EXISTS(SELECT 1 FROM Czas))
BEGIN
  WHILE @HourInProcess <= 23
	BEGIN
		WHILE @MinuteInProcess <= 59
			BEGIN
				INSERT INTO Czas (Godzina, Minuta)
				VALUES (@HourInProcess, @MinuteInProcess);
				SET @MinuteInProcess = @MinuteInProcess + 1;
			END

		SET @MinuteInProcess = 0;
		SET @HourInProcess = @HourInProcess + 1;
	END
END;


