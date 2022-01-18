-- Создание базы и таблиц
DROP DATABASE IF EXISTS `pioner-online`;
CREATE DATABASE `pioner-online`;
USE `pioner-online`;

DROP TABLE IF EXISTS `users`;
CREATE TABLE users (
	id SERIAL PRIMARY KEY, 
    login VARCHAR(15) UNIQUE NOT NULL,
    password_hash VARCHAR(100), -- триггер на MD5
    email VARCHAR(120) UNIQUE NOT NULL,
	created_at DATETIME DEFAULT NOW(),
	
    INDEX users_login_idx (login DESC),
    INDEX users_email_idx (email DESC)
) COMMENT 'юзеры';


DROP TABLE IF EXISTS `media_types`;
CREATE TABLE media_types (
	id SERIAL PRIMARY KEY,
	name VARCHAR(20) NOT NULL,
	specification TEXT,
	
	INDEX media_types_name_idx (name)	
) COMMENT 'типы медиа';


DROP TABLE IF EXISTS `media`;
CREATE TABLE media (
	id SERIAL PRIMARY KEY,
	filename VARCHAR(100) NOT NULL,
	media_type_id BIGINT UNSIGNED NOT NULL UNIQUE,
	user_id BIGINT UNSIGNED NOT NULL UNIQUE,
	created_at DATETIME DEFAULT NOW(),
	`size` INT NOT NULL,
	
	INDEX media_filename_idx (filename),
	
	FOREIGN KEY (media_type_id) REFERENCES media_types(id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE
) COMMENT 'медиа';
	

DROP TABLE IF EXISTS `profiles`;
CREATE TABLE profiles (
	user_id BIGINT UNSIGNED NOT NULL UNIQUE,
	firstname VARCHAR(50),
	lastname VARCHAR(50),
	city VARCHAR(50),
	country VARCHAR(50),
	about_profile TINYTEXT,
	avatar BIGINT UNSIGNED NOT NULL UNIQUE,
	gender CHAR(1),
    birthday DATE,
	
    INDEX profiles_firstname_lastname_idx (firstname, lastname),
    
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (avatar) REFERENCES media(id) ON DELETE CASCADE ON UPDATE CASCADE
) COMMENT 'профили';


DROP TABLE IF EXISTS `courses`;
CREATE TABLE courses (
	id SERIAL PRIMARY KEY,
	course_name VARCHAR(255),
	user_id BIGINT UNSIGNED NOT NULL UNIQUE,
	duration SMALLINT UNSIGNED NOT NULL,
	specification TEXT,
	orientation TINYTEXT,
	status CHAR(7),
	
	INDEX courses_name_idx (course_name),
	
	FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE,
	
	CHECK (status='open' OR 
		   status='close' OR 
		   status='archive'),
	CHECK (orientation='Техническая' OR 
		   orientation='Естественнонаучная' OR 
		   orientation='Социально-гуманитарная' OR 
		   orientation='Художественная' OR 
		   orientation='Туристско-краеведческая' OR 
		   orientation='Физкультурно-спортивная')
) COMMENT 'курсы';


DROP TABLE IF EXISTS `media_courses`;
CREATE TABLE media_courses (
	media_id BIGINT UNSIGNED NOT NULL UNIQUE,
	course_id BIGINT UNSIGNED NOT NULL UNIQUE,
	
	FOREIGN KEY (media_id) REFERENCES media(id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE CASCADE ON UPDATE CASCADE
) COMMENT 'медиа курсов';


DROP TABLE IF EXISTS `groups`;
CREATE TABLE `groups` (
	id SERIAL PRIMARY KEY,
	group_name VARCHAR(20),
	course_id BIGINT UNSIGNED NOT NULL UNIQUE,
	teacher BIGINT UNSIGNED NOT NULL UNIQUE,
	created_at DATETIME DEFAULT NOW(),
	
	INDEX groups_name_idx (group_name),
	
	FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (teacher) REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE
) COMMENT 'группы';


DROP TABLE IF EXISTS `users_groups`;
CREATE TABLE users_groups (
	student BIGINT UNSIGNED NOT NULL UNIQUE,
	group_id BIGINT UNSIGNED NOT NULL UNIQUE,
	
	FOREIGN KEY (student) REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (group_id) REFERENCES `groups`(id) ON DELETE CASCADE ON UPDATE CASCADE
) COMMENT 'обучающиеся в группах';


DROP TABLE IF EXISTS `tasks`;
CREATE TABLE tasks (
	id SERIAL PRIMARY KEY,
	taskname VARCHAR(20) NOT NULL,
	specification TEXT NOT NULL,
	course_id BIGINT UNSIGNED NOT NULL UNIQUE,
	user_id BIGINT UNSIGNED NOT NULL UNIQUE, -- преподаватель
	media_id BIGINT UNSIGNED NOT NULL UNIQUE,
	
	INDEX tasks_name_idx (taskname),
	
	FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (media_id) REFERENCES media(id) ON DELETE CASCADE ON UPDATE CASCADE
) COMMENT 'задания';


DROP TABLE IF EXISTS `marks`;
CREATE TABLE marks (
	mark TINYINT NOT NULL,
	`comment` TEXT,
	task_id BIGINT UNSIGNED NOT NULL UNIQUE,
	teacher BIGINT UNSIGNED NOT NULL UNIQUE,
	student BIGINT UNSIGNED NOT NULL UNIQUE,
	
	INDEX marks_teacher_idx (teacher),
	INDEX marks_student_idx (teacher),
	
	FOREIGN KEY (teacher) REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (student) REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (task_id) REFERENCES tasks(id) ON DELETE CASCADE ON UPDATE CASCADE
) COMMENT 'оценки';
	

ALTER TABLE `courses` ALTER COLUMN status SET DEFAULT 'open';
ALTER TABLE `groups` CHANGE course_id course_id BIGINT UNSIGNED;
ALTER TABLE `groups` DROP FOREIGN KEY groups_ibfk_1; 
ALTER TABLE `groups` ADD CONSTRAINT `FK_groups_course_id` FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE SET NULL ON UPDATE CASCADE;
ALTER TABLE `courses` ADD created_at DATETIME DEFAULT NOW() AFTER orientation, ADD updated_at DATETIME DEFAULT NOW() AFTER created_at; 
	
	









