USE vk;

-- task_5_1

ALTER TABLE `users` 
ADD COLUMN `created_at` DATETIME DEFAULT NULL 
AFTER `phone`;

ALTER TABLE `users` 
ADD COLUMN `updated_at` DATETIME DEFAULT NULL 
AFTER `created_at`;

UPDATE `users` SET `created_at`=NOW() WHERE ISNULL(`created_at`) 

UPDATE `users` SET `updated_at`=NOW() WHERE ISNULL(`updated_at`)

-- task_5_2 (есть решение на https://question-it.com/questions/677879/mysql-konvertirovat-dannye-varchar-v-datetime)

ALTER TABLE `users` 
ADD COLUMN `created_at_v` VARCHAR(20) DEFAULT '20.10.2017 8:10'
AFTER `updated_at`;

ALTER TABLE `users` 
ADD COLUMN `updated_at_v` VARCHAR(20) DEFAULT '20.10.2017 8:10'
AFTER `created_at_v`;

ALTER TABLE `users`
ADD COLUMN `created_at_dt` DATETIME DEFAULT NULL
AFTER `created_at_v`;

UPDATE `users` SET `created_at_dt`=STR_TO_DATE(`created_at_v`, '%d.%m.%Y %h:%i');

ALTER TABLE `users`
ADD COLUMN `updated_at_dt` DATETIME DEFAULT NULL
AFTER `updated_at_v`;

UPDATE `users` SET `updated_at_dt`=STR_TO_DATE(`updated_at_v`, '%d.%m.%Y %h:%i');

ALTER TABLE `users` 
DROP `created_at_v`, DROP `updated_at_v`; 

-- task_5_3

USE shop;

INSERT INTO `storehouses_products` VALUES
(1, NULL, NULL, 0, NULL, NULL),
(2, NULL, NULL, 1000, NULL, NULL),
(3, NULL, NULL, 1500, NULL, NULL),
(4, NULL, NULL, 1250, NULL, NULL),
(5, NULL, NULL, 0, NULL, NULL),
(6, NULL, NULL, 0, NULL, NULL),
(7, NULL, NULL, 125, NULL, NULL),
(8, NULL, NULL, 0, NULL, NULL),
(9, NULL, NULL, 0, NULL, NULL),
(10, NULL, NULL, 600, NULL, NULL),
(11, NULL, NULL, 0, NULL, NULL),
(12, NULL, NULL, 0, NULL, NULL),
(13, NULL, NULL, 0, NULL, NULL),
(14, NULL, NULL, 0, NULL, NULL),
(15, NULL, NULL, 7000, NULL, NULL),
(16, NULL, NULL, 2500, NULL, NULL),
(17, NULL, NULL, 30, NULL, NULL),
(18, NULL, NULL, 500, NULL, NULL),
(19, NULL, NULL, 0, NULL, NULL),
(20, NULL, NULL, 1, NULL, NULL)
;

SELECT `value` FROM `storehouses_products` ORDER BY `value`=0, `value`;

-- task_5_4

-- task_5_5

-- task_aggregation_1

-- task_aggregation_2

-- task_aggregation_3



