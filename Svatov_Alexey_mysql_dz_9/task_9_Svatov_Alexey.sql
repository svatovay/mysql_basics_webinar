-- task_9_транзакции_1

-- работа будет с базами shop и example, т.к. sample у меня содержит другие таблицы

START TRANSACTION;
INSERT INTO example.users SELECT * FROM shop.users WHERE id = 1;
DELETE FROM shop.users WHERE id = 1;
COMMIT;

-- task_9_транзакции_2

USE shop;
CREATE OR REPLACE VIEW names_prod_cat AS
SELECT name AS product_name, (SELECT name FROM catalogs WHERE id = catalog_id) AS catalog_name
FROM products;

-- task_9_транзакции_3



-- task_9_транзакции_4



-- task_9_администрирование_1



-- task_9_администрирование_2



-- task_9_хранимые процедуры_1



-- task_9_хранимые процедуры_2



-- task_9_хранимые процедуры_3