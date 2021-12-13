USE CALLCENTER

CREATE TABLE TmpPaths
(
	Name varchar (100) PRIMARY KEY,
	Path varchar (200)
)

DECLARE @basePath varchar(200) = 'C:\dev\HDLab\DataWarehousesLabs\DataGenerator';

INSERT INTO TmpPaths VALUES
('agents',@basePath + 't0_agents.scv'),
('calls',@basePath + 't0_calls.scv'),
('clients',@basePath + 't0_clients.scv'),
('departments',@basePath + 't0_departments.scv'),
('excel',@basePath + 't0_excel.scv'),
('producers',@basePath + 't0_producers.scv'),
('products',@basePath + 't0_products.scv'),
('t1_agents',@basePath + 't1_agents.scv'),
('t1_calls',@basePath + 't1_calls.scv'),
('t1_clients',@basePath + 't1_clients.scv'),
('t1_departments',@basePath + 't1_departments.scv'),
('t1_excel',@basePath + 't1_excel.scv'),
('t1_producers',@basePath + 't1_producers.scv'),
('t1_products',@basePath + 't1_products.scv');