USE CALLCENTER

TRUNCATE TABLE TmpPaths;

DECLARE @basePath varchar(200) = 'C:\dev\HDLab\DataWarehousesLabs\DataGenerator';

INSERT INTO TmpPaths VALUES
('agents',@basePath + 't0_agents.scv'),
('calls',@basePath + 't0_calls.scv'),
('clients',@basePath + 't0_clients.scv'),
('departments',@basePath + 't0_departments.scv'),
('excel',@basePath + 't0_excel.scv'),
('producers',@basePath + 't0_producers.scv'),
('products',@basePath + 't0_products.scv');