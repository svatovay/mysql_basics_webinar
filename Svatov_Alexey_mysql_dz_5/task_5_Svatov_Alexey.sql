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






