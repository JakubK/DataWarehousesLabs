USE CALLCENTER

TRUNCATE TABLE TmpPaths;

DECLARE @basePath varchar(200) = 'C:\dev\HDLab\DataWarehousesLabs\DataGenerator\';

INSERT INTO TmpPaths VALUES
('agents',@basePath + 't1_agents.csv'),
('calls',@basePath + 't1_calls.csv'),
('clients',@basePath + 't1_clients.csv'),
('departments',@basePath + 't1_departments.csv'),
('excel',@basePath + 't1_excel.csv'),
('producers',@basePath + 't1_producers.csv'),
('products',@basePath + 't1_products.csv');