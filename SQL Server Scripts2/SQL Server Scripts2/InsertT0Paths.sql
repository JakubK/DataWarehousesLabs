USE CALLCENTER

TRUNCATE TABLE TmpPaths;

DECLARE @basePath varchar(200) = 'C:\dev\HDLab\DataWarehousesLabs\DataGenerator\';

INSERT INTO TmpPaths VALUES
('agents',@basePath + 't0_agents.csv'),
('calls',@basePath + 't0_calls.csv'),
('clients',@basePath + 't0_clients.csv'),
('departments',@basePath + 't0_departments.csv'),
('excel',@basePath + 't0_excel.csv'),
('producers',@basePath + 't0_producers.csv'),
('products',@basePath + 't0_products.csv');