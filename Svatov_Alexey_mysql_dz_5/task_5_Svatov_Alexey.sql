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

-- task_5_2

