use CALLCENTER;

DECLARE @LowerYearBound int = 2008;
DECLARE @UpperYearBound int = 2025;

DECLARE @YearInProcess int = @LowerYearBound;
DECLARE @MonthInProcess int = 1;
DECLARE @DayInProcess int = 1;

SET LANGUAGE Polish

IF(NOT EXISTS(SELECT 1 FROM Data))
BEGIN
WHILE @YearInProcess <= @UpperYearBound
	BEGIN
		PRINT @YearInProcess;
		WHILE @MonthInProcess <= 12
			BEGIN
				DECLARE @tmpDate datetime = datefromparts(@YearInProcess, @MonthInProcess, 1)
				WHILE @DayInProcess <= day(eomonth (@tmpDate))
					BEGIN
						INSERT INTO Data(Rok, Miesiac, [Nazwa Miesiaca], Dzien)
						VALUES(@YearInProcess, @MonthInProcess, DateName( month , DateAdd( month , @MonthInProcess , -1 )), @DayInProcess);

						SET @DayInProcess = @DayInProcess + 1;
					END

			SET @MonthInProcess = @MonthInProcess + 1;
			SET @DayInProcess = 1;
			END

		SET @MonthInProcess = 1;
		SET @YearInProcess = @YearInProcess + 1;
	END
END
