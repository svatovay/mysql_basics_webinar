/*
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

*/


-- Создание базы и таблиц
DROP TABLE IF EXISTS `pioner-online`;
CREATE DATABASE `pioner-online`;
USE pioner-online;

DROP TABLE IF EXISTS `users`;
CREATE TABLE users (
	id SERIAL PRIMARY KEY, 
    login VARCHAR(15) UNIQUE,
    password_hash VARCHAR(100) -- триггер на MD5,
    email VARCHAR(120) UNIQUE,
	created_at DATETIME DEFAULT NOW(),
	
    INDEX users_login_idx (login DESC),
    INDEX users_email_idx (email DESC)
) COMMENT 'юзеры';


DROP TABLE IF EXISTS `profiles`;
CREATE TABLE profiles (
	user_id BIGINT UNSIGNED NOT NULL UNIQUE,
	firstname VARCHAR(50),
	secondname VARCHAR(50),
	city VARCHAR(50),
	country VARCHAR(50),
	about_profile TINYTEXT,
	avatar BIGINT UNSIGNED NOT NULL UNIQUE,
	gender CHAR(1),
    birthday DATE,
	
    INDEX profiles_firstname_lastname_idx (firstname, lastname),
    
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (avatar) REFERENCES media(id)
) COMMENT 'профили';










