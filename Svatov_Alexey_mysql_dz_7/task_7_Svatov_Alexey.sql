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



-- task_7_3



