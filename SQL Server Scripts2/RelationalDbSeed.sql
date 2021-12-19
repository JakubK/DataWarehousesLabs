USE RelationalDb;

BULK INSERT Dzial
	FROM 'C:\dev\HDLab\DataWarehousesLabs\DataGenerator\t0_departments.csv'
	WITH
	(
		FIRSTROW = 2,
		FIELDTERMINATOR = '|',
		ROWTERMINATOR = '\n',
		TABLOCK
	)


BULK INSERT Klient
	FROM 'C:\dev\HDLab\DataWarehousesLabs\DataGenerator\t0_clients.csv'
	WITH
	(
		FIRSTROW = 2,
		FIELDTERMINATOR = '|',
		ROWTERMINATOR = '\n',
		TABLOCK
	)

BULK INSERT Producent
	FROM 'C:\dev\HDLab\DataWarehousesLabs\DataGenerator\t0_producers.csv'
	WITH
	(
		FIRSTROW = 2,
		FIELDTERMINATOR = '|',
		ROWTERMINATOR = '\n',
		TABLOCK
	)

BULK INSERT Agent
	FROM 'C:\dev\HDLab\DataWarehousesLabs\DataGenerator\t0_agents.csv'
	WITH
	(
		FIRSTROW = 2,
		FIELDTERMINATOR = '|',
		ROWTERMINATOR = '\n',
		TABLOCK
	)

BULK INSERT Produkt
	FROM 'C:\dev\HDLab\DataWarehousesLabs\DataGenerator\t0_products.csv'
	WITH
	(
		FIRSTROW = 2,
		FIELDTERMINATOR = '|',
		ROWTERMINATOR = '\n',
		TABLOCK
	)

BULK INSERT Polaczenie
	FROM 'C:\dev\HDLab\DataWarehousesLabs\DataGenerator\t0_calls.csv'
	WITH
	(
		FIRSTROW = 2,
		FIELDTERMINATOR = '|',
		ROWTERMINATOR = '\n',
		TABLOCK
	)