USE vk;

DROP TABLE IF EXISTS `notes`;
CREATE TABLE `notes` (
	`id` SERIAL PRIMARY KEY,
	`heading` VARCHAR(100),
	`body` TEXT,
    `created_at` DATETIME DEFAULT NOW(),
	`media_id` BIGINT unsigned NOT NULL,

	INDEX index_of_heading(heading),
    FOREIGN KEY (media_id) REFERENCES media(id)
);

DROP TABLE IF EXISTS `stickers`;
CREATE TABLE `stickers` (
	`id` SERIAL PRIMARY KEY,
	`name` VARCHAR(50),
	`author` BIGINT unsigned NOT NULL,
    `rating` INT UNSIGNED DEFAULT 0,
	`media_id` BIGINT unsigned NOT NULL,

	INDEX index_of_name(name),
	INDEX index_of_rating(rating),
    FOREIGN KEY (media_id) REFERENCES media(id),
    FOREIGN KEY (author) REFERENCES users(id)
);

DROP TABLE IF EXISTS `products`;
CREATE TABLE `products` (
	`id` SERIAL PRIMARY KEY,
	`name` VARCHAR(50),
	`price` DECIMAL(10,2),
	`photos_id` BIGINT unsigned NOT NULL,

	INDEX index_of_name(name),
    FOREIGN KEY (photos_id) REFERENCES photos(id)
);