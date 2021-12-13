use CALLCENTER;

DECLARE @LowerYearBound int = 1960;
DECLARE @UpperYearBound int = 2040;

DECLARE @YearInProcess int = @LowerYearBound;
DECLARE @MonthInProcess int = 1;
DECLARE @DayInProcess int = 1;

SET LANGUAGE Polish

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
GO