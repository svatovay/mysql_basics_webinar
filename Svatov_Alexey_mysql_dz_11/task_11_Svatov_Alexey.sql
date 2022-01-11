-- task_11_1
USE shop;

DROP TABLE IF EXISTS logs;
CREATE TABLE logs (
  datetime_insert DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'время и дата создания записи',
  table_name VARCHAR(255) COMMENT 'Название таблицы',
  table_id BIGINT UNSIGNED COMMENT 'id записи в логируемой таблице',
  name VARCHAR(255) COMMENT 'поле name в логируемой таблице'
  ) ENGINE=Archive;

 
DELIMITER //
CREATE TRIGGER tr_catalogs_log AFTER INSERT ON shop.catalogs
FOR EACH ROW
 BEGIN
  SET @table_name = 'catalogs';
  SET @table_id = NEW.id;
  SET @name = NEW.name;
  INSERT INTO shop.logs (table_name, table_id, name) VALUES (@table_name, @table_id, @name);
 END//
DELIMITER ;

DELIMITER //
CREATE TRIGGER tr_users_log AFTER INSERT ON shop.users
FOR EACH ROW
 BEGIN
  SET @table_name = 'users';
  SET @table_id = NEW.id;
  SET @name = NEW.name;
  INSERT INTO shop.logs (table_name, table_id, name) VALUES (@table_name, @table_id, @name);
 END//
DELIMITER ;

DELIMITER //
CREATE TRIGGER tr_products_log AFTER INSERT ON shop.products
FOR EACH ROW
 BEGIN
  SET @table_name = 'products';
  SET @table_id = NEW.id;
  SET @name = NEW.name;
  INSERT INTO shop.logs (table_name, table_id, name) VALUES (@table_name, @table_id, @name);
 END//
DELIMITER ;

-- task_11_2



