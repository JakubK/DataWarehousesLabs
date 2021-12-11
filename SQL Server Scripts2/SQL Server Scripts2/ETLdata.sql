DECLARE @YearInProcess int = 2020;
DECLARE @MonthInProcess int = 1;
DECLARE @DayInProcess int = 0;

DECLARE @UpperYearBound int = 2030;


WHILE @YearInProcess <= @UpperYearBound
BEGIN
	WHILE @MonthInProcess <= 12
		BEGIN
			DECLARE @tmpDate datetime = datefromparts(@YearInProcess, @MonthInProcess, 1)
			WHILE @DayInProcess <= day(eomonth (@tmpDate))
				BEGIN
					INSERT INTO Data(Rok, Miesiac, [Nazwa Miesiaca], Dzien)
					VALUES(@YearInProcess, @MonthInProcess, DateName( month , DateAdd( month , @MonthInProcess , -1 )), @DayInProcess)
					SET @DayInProcess = @DayInProcess + 1
				END
			SET @MonthInProcess = @MonthInProcess + 1
		END
	SET @YearInProcess = @YearInProcess + 1
END
GO