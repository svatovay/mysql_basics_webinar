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

-- task_9_администрирование_1

CREATE USER 'shop_read'@'localhost' IDENTIFIED WITH sha256_password BY 'Password1!';
GRANT SELECT ON shop.* TO 'shop_read'@'localhost';
CREATE USER 'shop'@'localhost' IDENTIFIED WITH sha256_password BY 'Password2?';
GRANT ALL ON shop.* TO 'shop'@'localhost';
SELECT User, Host FROM mysql.user;

-- task_9_хранимые процедуры_1

DROP FUNCTION IF EXISTS hello;
DELIMITER //
CREATE FUNCTION hello()
RETURNS TEXT DETERMINISTIC
BEGIN
 DECLARE hour_now TINYINT;
 DECLARE datetime_now TIMESTAMP;
 DECLARE answer VARCHAR(255);
 SET datetime_now = TIMESTAMP(NOW());
 SET hour_now = EXTRACT(hour FROM datetime_now);
 CASE 
  WHEN hour_now > 6 AND hour_now < 12 
   THEN SET answer = 'Доброе утро';
  WHEN hour_now  >= 12 AND hour_now < 18 
   THEN SET answer = 'Добрый день';
  WHEN hour_now >= 18
   THEN SET answer = 'Добрый вечер';
  WHEN hour_now >= 0 AND hour_now < 6 
   THEN SET answer = 'Доброй ночи';
  ELSE SET answer = 'ERROR';
 END CASE;
 RETURN answer;
END//
DELIMITER ;

SELECT hello();

-- task_9_хранимые процедуры_2

DROP TRIGGER IF EXISTS products_not_null;
DELIMITER //
CREATE TRIGGER products_not_null BEFORE INSERT ON products FOR EACH ROW
 BEGIN
 DECLARE new_name VARCHAR(255);
 DECLARE new_description VARCHAR(255);
 SET @new_name = NEW.name;
 SET @new_description = NEW.description;
  IF (ISNULL(@new_name) AND ISNULL(@new_description)) THEN
   KILL QUERY CONNECTION_ID();
  END IF;
 END//
DELIMITER ;
