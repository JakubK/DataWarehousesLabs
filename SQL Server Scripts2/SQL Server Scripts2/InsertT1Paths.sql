USE CALLCENTER

TRUNCATE TABLE TmpPaths;

DECLARE @basePath varchar(200) = 'C:\dev\HDLab\DataWarehousesLabs\DataGenerator';

INSERT INTO TmpPaths VALUES
('agents',@basePath + 't1_agents.scv'),
('calls',@basePath + 't1_calls.scv'),
('clients',@basePath + 't1_clients.scv'),
('departments',@basePath + 't1_departments.scv'),
('excel',@basePath + 't1_excel.scv'),
('producers',@basePath + 't1_producers.scv'),
('products',@basePath + 't1_products.scv');