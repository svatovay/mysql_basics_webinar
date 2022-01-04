-- task_7_1

USE `shop`

INSERT INTO `orders` (user_id) VALUES
  (1),
  (1),
  (1),
  (3),
  (6),
  (6),
  (1),
  (2),
  (1),
  (1),
  (3),
  (1),
  (5),
  (1);

SELECT users.name, COUNT(user_id) AS cnt_orders
FROM `users` JOIN `orders` ON users.id = orders.user_id 
GROUP BY user_id 

-- task_7_2

USE shop

SELECT products.name AS pr_name, products.description, products.price, products.created_at, products.updated_at, catalogs.name AS ct_name
FROM `products` LEFT JOIN `catalogs` ON products.catalog_id = catalogs.id;

-- task_7_3 Так и не смог придумать, как с помощью JOIN решить эту задачу

USE `sample`

CREATE TABLE flights (
  id SERIAL PRIMARY KEY,
  `from` VARCHAR(255) COMMENT 'откуда',
  `to` VARCHAR(255)) COMMENT 'куда';

 CREATE TABLE cities (
  `label` VARCHAR(255) UNIQUE COMMENT 'en название',
  `name` VARCHAR(255)) COMMENT 'ru название';
 
 INSERT INTO flights (`from`, `to`) VALUES
  ('moscow', 'omsk'),
  ('novgorod', 'kazan'),
  ('irkutsk', 'moscow'),
  ('omsk', 'irkutsk'),
  ('moscow', 'kazan');
 
  INSERT INTO cities VALUES
  ('moscow', 'Москва'),
  ('irkutsk', 'Иркутск'),
  ('novgorod', 'Новгород'),
  ('kazan', 'Казань'),
  ('omsk', 'Омск');


