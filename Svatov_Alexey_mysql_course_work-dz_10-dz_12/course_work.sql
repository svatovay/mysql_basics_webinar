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
	media_type_id BIGINT UNSIGNED NOT NULL,
	user_id BIGINT UNSIGNED NOT NULL,
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
	avatar BIGINT UNSIGNED NOT NULL,
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
	user_id BIGINT UNSIGNED NOT NULL,
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
	media_id BIGINT UNSIGNED NOT NULL,
	course_id BIGINT UNSIGNED NOT NULL,
	
	FOREIGN KEY (media_id) REFERENCES media(id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE CASCADE ON UPDATE CASCADE
) COMMENT 'медиа курсов';


DROP TABLE IF EXISTS `groups`;
CREATE TABLE `groups` (
	id SERIAL PRIMARY KEY,
	group_name VARCHAR(20),
	course_id BIGINT UNSIGNED NOT NULL,
	teacher BIGINT UNSIGNED NOT NULL,
	created_at DATETIME DEFAULT NOW(),
	
	INDEX groups_name_idx (group_name),
	
	FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (teacher) REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE
) COMMENT 'группы';


DROP TABLE IF EXISTS `users_groups`;
CREATE TABLE users_groups (
	student BIGINT UNSIGNED NOT NULL,
	group_id BIGINT UNSIGNED NOT NULL,
	
	FOREIGN KEY (student) REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (group_id) REFERENCES `groups`(id) ON DELETE CASCADE ON UPDATE CASCADE
) COMMENT 'обучающиеся в группах';


DROP TABLE IF EXISTS `tasks`;
CREATE TABLE tasks (
	id SERIAL PRIMARY KEY,
	taskname VARCHAR(20) NOT NULL,
	specification TEXT NOT NULL,
	course_id BIGINT UNSIGNED NOT NULL,
	teacher BIGINT UNSIGNED NOT NULL,
	media_id BIGINT UNSIGNED NOT NULL,
	
	INDEX tasks_name_idx (taskname),
	
	FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (teacher) REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (media_id) REFERENCES media(id) ON DELETE CASCADE ON UPDATE CASCADE
) COMMENT 'задания';


DROP TABLE IF EXISTS `marks`;
CREATE TABLE marks (
	mark TINYINT NOT NULL,
	`comment` TEXT,
	task_id BIGINT UNSIGNED NOT NULL,
	teacher BIGINT UNSIGNED NOT NULL,
	student BIGINT UNSIGNED NOT NULL,
	
	INDEX marks_teacher_idx (teacher),
	INDEX marks_student_idx (student),
	
	FOREIGN KEY (teacher) REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (student) REFERENCES users(id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (task_id) REFERENCES tasks(id) ON DELETE CASCADE ON UPDATE CASCADE
) COMMENT 'оценки';


ALTER TABLE `courses` ALTER COLUMN status SET DEFAULT 'open';
ALTER TABLE `groups` CHANGE course_id course_id BIGINT UNSIGNED;
ALTER TABLE `groups` DROP FOREIGN KEY groups_ibfk_1; 
ALTER TABLE `groups` ADD CONSTRAINT `FK_groups_course_id` FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE SET NULL ON UPDATE CASCADE;
ALTER TABLE `courses` ADD created_at DATETIME DEFAULT NOW() AFTER orientation, ADD updated_at DATETIME DEFAULT NOW() AFTER created_at; 
	
-- вставка данных
-- 1
INSERT INTO `users` VALUES 
(1,'totam','59acbb2186cca59381777de82131bb290f57e61f','berniece02@example.net','2018-04-12 13:37:54'),
(2,'non','d0bdc5c8da7a70547aa3a6bbf33b18549591489b','erdman.kyle@example.org','2018-12-24 09:07:36'),
(3,'aut','b550038b654d0ec16495168ac43a89726a6c72ed','smitham.harvey@example.com','2010-05-09 20:23:38'),
(4,'architecto','717c640cc2bf03a88578f32a49ad82b8c06eea05','tgoyette@example.org','1971-04-06 06:19:20'),
(5,'ratione','47c42d1150a91cbb5f4f57dc99449b8644895767','toney73@example.net','2017-11-06 12:34:16'),
(6,'sunt','b8f6e282cdbf07200ae0d7c5a1fe132ca6fe3d4c','johns.ethyl@example.net','2015-09-26 09:29:53'),
(7,'blanditiis','3c0f1cf24aae3237f1e863cdfbab27d9db504ff6','anderson.elinore@example.com','2008-06-01 08:52:54'),
(8,'perspiciatis','a0151378a90ada8cc560c54bbd777935fafb13e4','vfritsch@example.net','2017-06-08 01:36:07'),
(9,'fuga','9bcf60d58b42271ff142265a3751998195201a03','gaylord.nathanial@example.net','2003-11-30 01:10:55'),
(10,'eum','cb16e7c4fef90ad97797ccf542134c0727c6e354','elaina.grady@example.net','1988-07-05 23:42:28'),
(11,'animi','61247f9fa8440a06ee264e6169d653e0520cdabf','elias.macejkovic@example.com','1999-07-23 20:07:26'),
(12,'sint','0306329958febba4ba080295211f37378234cd1a','akemmer@example.org','1985-01-28 05:34:14'),
(13,'fugiat','f04dfe64460e6750e02d87256190d64d4c9c6f5b','von.winona@example.com','1975-11-03 00:57:44'),
(14,'illum','60f848cdc39c28620bcbf6a6cf71ca900f2610b6','tsanford@example.net','2001-04-05 09:42:16'),
(15,'ipsa','9b15af97f09be184694ed112e192fb7a4e59b10e','monserrate03@example.net','1989-06-21 16:14:32'),
(16,'dolore','8ad223f9979fd1678bc782c55daf02ad01005ea6','batz.elaina@example.net','2002-07-17 03:52:43'),
(17,'excepturi','d2a8616378cf908f97219d1e80074cb8118af2d5','dhaley@example.net','1977-08-10 04:45:50'),
(18,'velit','7ec9cdc641aeaaf42cfc0576e3f3b8f47531b54e','hrohan@example.net','2015-12-11 16:52:37'),
(19,'aspernatur','c55abb2c0e8d7e1b4cb884bf1fd091aa5a7d7aad','kenton.torp@example.net','1979-04-22 19:04:44'),
(20,'minima','22940a017283a527e61f94a2cd9cdf563ef69afe','bridget.mertz@example.com','2009-06-21 16:19:34'),
(21,'et','9c3354461baab1bd6bde212ee3d35eaf60b40ffc','maudie17@example.net','1971-04-04 17:58:20'),
(22,'ducimus','6993c82f81ba55304860029db138f2ee0965964e','lleannon@example.net','1976-01-16 03:29:10'),
(23,'sit','5ac77ccea6db2944ba35dfb32cc152fb9f01c2a0','noelia96@example.com','2008-12-29 16:25:48'),
(24,'est','5b900ec8ae18628a38002afbe0a9a7e7b1e0b732','jesse.schulist@example.org','1999-07-23 03:02:52'),
(25,'saepe','09264488e18c031eff1131deb14cd461aefbe4dc','oharvey@example.com','2018-06-12 22:03:36'),
(26,'voluptatem','9fffbdf43f66f44b0c6d1108f27e3ad7b8b1ffba','dino46@example.com','2021-01-14 08:54:06'),
(27,'ut','95e63d1746a666300382066b6a5a667723c5f0c5','devan29@example.org','2015-11-02 22:54:04'),
(28,'id','6864af6a8df6015068cf090f1aa907299816ef45','gust.goldner@example.net','1970-10-22 22:52:11'),
(29,'corrupti','c047116e71af16996e9d0066e44e4d048496d8ec','moore.abe@example.org','2018-05-28 10:44:06'),
(30,'expedita','26c43c303edf8942d94e746c2ade016f937c7da1','ephraim.wintheiser@example.net','2007-03-19 20:55:44'),
(31,'consequatur','d053370e16168872e2504ed3a044539b0bf0a312','kuhlman.barry@example.org','2011-06-08 14:37:14'),
(32,'delectus','3826f044978d11718c10c86828bc1e83705a9386','thomas.dubuque@example.org','1986-07-03 21:09:55'),
(33,'vel','5d0de8e11b0eebabdb55336fc1968a649bd2cbe6','lbatz@example.org','2007-06-20 14:14:31'),
(34,'similique','40a5d38c24772cd477e7c03436961a95527ddad9','mose.mills@example.com','2012-10-30 09:17:51'),
(35,'numquam','ef2db8d312d04110651874c27d306548cf137541','ho\'hara@example.org','2005-08-21 20:47:32'),
(36,'sed','a5804a2a6e42fb39d8b98e0a265426d45360a1ab','tthompson@example.org','1999-11-23 00:40:43'),
(37,'exercitationem','f4334408f8d3a5e9b0a0f7095dcd8032b440e22a','kstehr@example.net','1992-09-24 23:10:41'),
(38,'qui','18be3bd0245798364eb74dae071ee95021b58984','nebert@example.org','2012-09-10 15:19:39'),
(39,'autem','96da4ac9483ed2d82540e3e38f80ca9279b3b94b','salma.robel@example.org','1981-05-11 05:43:06'),
(40,'fugit','908cd5cfd31c08f6db490635f3b1ec633f6b00db','zella.windler@example.com','1992-10-29 10:59:15'),
(41,'molestiae','7409529acd6e30690452eb2046e300a13a916712','johathan33@example.net','2009-12-26 09:54:33'),
(42,'iure','b8466874d5f7a36a968b44acecaf9db981c7291a','kpurdy@example.org','1977-08-22 00:01:59'),
(43,'in','faf73916aa6f0724f2056e841fe465c4638f9799','wnikolaus@example.org','2007-01-05 21:36:04'),
(44,'veritatis','d44163d06c65f82f385a511cf6b5f786b46348a1','yblanda@example.net','1974-09-08 09:12:42'),
(45,'corporis','35fbc670132f9772e552ceefb75e14f8d93e2a49','margaret.kilback@example.com','1982-02-26 23:48:39'),
(46,'neque','ed493fec6d211df5220cf30007197405aa1d333a','cremin.lea@example.net','1982-02-26 09:50:41'),
(47,'accusamus','fd9bf87bc79589b3210e0c5698b35787e3396625','tmann@example.org','2007-04-30 18:09:24'),
(48,'debitis','e53c23615a8059657bc57c627d208ba7c9d461d6','adolf.hackett@example.com','2006-10-01 21:56:00'),
(49,'voluptates','bcfd52b43bad980a280f3efae85463352b669308','lulu12@example.com','1976-06-14 03:09:20'),
(50,'ipsum','ec534e869f7b5a1256eff579ea48806fad8a5f6b','ztorphy@example.net','1979-09-03 02:51:32'),
(51,'recusandae','ecb7edfe053662be5e19f78b8fae1734c0fc24a8','rgrimes@example.net','2020-07-12 10:19:37'),
(52,'voluptatum','39acad66be7c8f072875d168e6f2a14bccf29c74','sallie16@example.org','1984-12-21 02:03:31'),
(53,'beatae','63181d72db2d52a577d18f85f6c338dfcf78dd0c','ygrimes@example.net','2000-07-23 08:06:24'),
(54,'quis','e4dfdeb07fd9cfbeb134c538570edf4e6bd45169','hartmann.lucienne@example.com','2014-10-01 16:22:51'),
(55,'deleniti','8541cbcc86316803e5270b5e6e68d92e6b81153b','stroman.mario@example.com','1983-09-15 04:01:29'),
(56,'vitae','4a1bcdd49372eb250c7f4ecadff1b2d5706e3fd0','addie.dicki@example.net','1995-04-28 16:18:22'),
(57,'error','361489cf4b0352b2f3e3f8710532b2ba0eeb59f2','billie.ward@example.net','1989-07-19 21:49:02'),
(58,'distinctio','021fe50e59c7a21d8c2b898d7e7d3f933ee12454','muller.shad@example.net','2007-06-14 10:26:44'),
(59,'consequuntur','809ff91a641ce4f7f1d198bfaac5bd6e99e4a492','damon27@example.org','1973-08-10 17:31:05'),
(60,'incidunt','68ff2caad953c30aff0ba4ce222346b132ff55f1','vbayer@example.net','1990-01-22 20:12:45'),
(61,'perferendis','6ee9fa10bedd6c0a3dc2cf4ce263cee437eaaa41','nelle.schimmel@example.org','2007-05-03 03:15:57'),
(62,'consectetur','28604de151245319fd831b0a2db670687fcccec9','fermin.lesch@example.com','1976-01-05 08:15:52'),
(63,'quidem','0ae145f06846d765852b516a993420ceb4c1fd4c','cboehm@example.org','1999-01-19 22:15:02'),
(64,'nostrum','8678bc9f1906a37455c7c56a361c5f8b022ec812','ortiz.sid@example.org','2021-08-12 10:27:57'),
(65,'quia','985cdcb07aa6895b09a83aaaaaedcb4f3a69dc5b','jane73@example.com','1999-10-30 01:08:17'),
(66,'occaecati','30919af7be80b81f501f2b1c532a49f1250a9625','hessel.minerva@example.org','2017-07-10 05:09:11'),
(67,'quisquam','63e6eeb7dd9e2f693704a9dbc8a08fdde2d78747','lhudson@example.org','2001-02-01 06:35:52'),
(68,'aliquam','affc43efb1dca262256c8d9209a98585dae8d6e8','lang.boris@example.net','1982-01-13 12:14:46'),
(69,'inventore','5f78fffa7c4ced1518bebbcdac929535bf9c8c05','wilfrid17@example.com','1981-12-23 02:58:34'),
(70,'harum','4d862a699b76fbb63260077d312867a951f98e01','kbogan@example.com','2014-06-02 01:48:47'),
(71,'dolores','0fdc6416bd916277ac86f75bc63695166b89634a','okuneva.myra@example.org','1989-07-18 08:06:22'),
(72,'magni','f24a0565add3811b87d786c3c39e917a5eadb470','ogrant@example.com','1991-02-03 01:06:18'),
(73,'nihil','4be14bc16af7c18ab68097c3a754dff883e7e8cb','kuhn.rodolfo@example.net','2009-09-29 02:32:25'),
(74,'dolorum','806736df727cdd48eacd06fc791aa172a75d98d0','cortez.farrell@example.org','1996-05-15 22:30:40'),
(75,'repudiandae','2cb04303c6252d41c966d062990f5feab6e037f9','ufunk@example.org','1998-07-24 22:04:04'),
(76,'ipsam','bb325969ba81357fbe97221b7c6a7340b385e11b','erdman.martine@example.org','1988-07-05 13:08:04'),
(77,'tempore','baee6fff913813085f48343d00fd0693922a375b','zbernhard@example.org','1985-09-05 15:34:09'),
(78,'sapiente','15152fe6d5ba0170213ca5d40c10a097cc2e3667','murphy.glennie@example.org','2019-05-19 18:06:16'),
(79,'eveniet','7d7ac27362b2d171bb19f49d3b2830fd96710997','bednar.elias@example.org','2009-04-22 19:16:10'),
(80,'ad','da83b997a37ded283242c07286af6ac54ccdca9f','leopold37@example.com','2005-07-04 13:40:56'),
(81,'cum','d8d05d048b9197eac44045b3477e2e962ea38aa8','modesto07@example.com','2002-03-10 22:39:13'),
(82,'quae','311f29fbe10de809b37de8a7c5961ae58ec14c5a','qbraun@example.org','1976-06-24 09:54:16'),
(83,'repellat','fb0c5e3a6d290c47e0e0825eec26ae8f0e5e39b2','liana.hills@example.net','2015-06-13 10:56:21'),
(84,'eaque','f6b616a252ac4ab43c68f72b9b8309278c8b08ea','savannah.willms@example.com','2002-12-10 16:24:41'),
(85,'assumenda','62553a0cc079cacfed3da19ea0c89a4fb078e168','cassidy72@example.com','1998-11-12 15:13:45'),
(86,'rem','f9d287b7782761e00eedf54b8947d8c5d808aa9a','xhand@example.com','1983-11-22 00:03:26'),
(87,'dolorem','c58941a320fe7e0895d139d1e404ac6adb0b1259','gkunze@example.org','1982-03-27 06:31:34'),
(88,'enim','25b708dd1cd45b78680f70ace9dd49b7a891ef5d','jacquelyn.robel@example.net','2003-02-03 17:08:36'),
(89,'asperiores','88f445e42dd8a0acf2b4e00f3ef88f4a14ef8d60','ihaag@example.net','2018-05-22 02:21:50'),
(90,'dicta','5e156bf04db23f35cd34b6a1a070b00f62c0fa4d','nikko.weimann@example.com','1973-12-26 17:57:19'),
(91,'officia','fb5f40b6f4612c20b54418e928c9635cbbf569c2','carmine.stamm@example.org','2020-05-29 06:19:46'),
(92,'porro','ef03c0dc0e7989d26e72c437e62d893dadd75a11','isabell51@example.net','2017-05-10 02:00:53'),
(93,'aliquid','5a3071ed1f7dfd5f2b673a8aee2d72081683b180','sfay@example.org','2020-11-10 11:14:16'),
(94,'cumque','2f1815f8f82fdfb4edfeb271eda4474d0f7b4778','luther60@example.org','1989-03-29 21:29:27'),
(95,'vero','c9c84ce6d3f8957ea93375062e1ef578d02ea0cb','ally.adams@example.com','1992-01-30 14:12:47'),
(96,'magnam','30647b0795f230d04bb7826ece0e4deabac0d754','tblock@example.org','1986-05-17 16:51:11'),
(97,'unde','96525f31130bb162fa8252974e93ed0396a65b17','nbailey@example.com','2014-02-08 04:59:42'),
(98,'nobis','76348c90ad5caa15bfca6ca256e433af31692d1f','crooks.geoffrey@example.net','1996-05-31 20:12:05'),
(99,'esse','a01fb47a93344abe05d5ce3405a2f763901f5de5','janiya69@example.net','1977-10-09 03:28:43'),
(100,'optio','a577c79871e662cd51db047237862ce517ef5b1b','verla.kub@example.net','1986-09-17 02:56:29');


-- 2
INSERT INTO `media_types` VALUES 
(1,'voluptatibus','Delectus nihil voluptas enim officia. Quis placeat magni rerum error voluptatem architecto. Molestiae hic labore dicta quae et. Nemo vel repudiandae nostrum vel illum repudiandae.'),
(2,'iure','Ut unde eius dignissimos et. Totam blanditiis provident modi qui sit quia enim. Quidem sit qui impedit tempore et.'),
(3,'itaque','Perspiciatis ipsum vel nemo ut sit nobis nam. Recusandae consequatur quia nobis. Ut molestiae in fugiat eveniet totam consequuntur. Eveniet cumque ipsam corporis ratione adipisci sunt tempore.'),
(4,'voluptas','Dignissimos aliquid accusamus nesciunt ut laboriosam neque provident. Voluptatem enim at nihil aliquid fugiat. Assumenda est minima aliquam accusantium non et.'),
(5,'porro','Quia sed sed fugiat et earum natus. Molestiae inventore commodi perferendis fugiat aut quisquam possimus. Dicta hic similique ut possimus et repudiandae.'),
(6,'est','Laudantium optio laudantium consequatur iusto. Quidem ut sed sit asperiores. Quasi omnis hic voluptatem alias corporis eius. Sit nihil occaecati voluptas ad.'),
(7,'sit','Minus est sit placeat voluptas iusto. Voluptatem ut nesciunt adipisci quasi inventore. Amet labore earum accusantium cum dolorem eos sapiente eos.'),
(8,'ut','Voluptatem maxime aut repellendus corporis. Et velit qui voluptate consequuntur ullam dolores et quia. Dolor at quia ex qui aliquam voluptas commodi.'),
(9,'dolore','Sunt aut est minus voluptatem neque veritatis. Molestias omnis illo aut et praesentium ratione. Voluptate beatae animi corrupti id.'),
(10,'molestiae','Velit sequi soluta nemo a. Et ullam et aperiam inventore vitae. Voluptatem dicta delectus et eveniet placeat. Quam est qui et inventore quis. Et dolor voluptatem ut a aut.'),
(11,'delectus','Vero ea enim debitis est repudiandae nobis. Vel error animi quia tempora. Nobis et est ipsa placeat deserunt error quas. Repudiandae dolores nihil quia quae voluptatum. Iusto et est quae excepturi est id iste.'),
(12,'et','Id unde nihil dicta repellat id vitae consequatur. Illum qui perspiciatis qui non assumenda corporis fuga modi. Architecto soluta nulla nobis ea. Iusto non sunt velit et quia.'),
(13,'dolor','Dignissimos facere voluptatibus sed est rerum laborum sapiente consequuntur. Ea qui incidunt eius iste quas animi magnam. Eum natus quaerat adipisci ut rerum tempora error. Excepturi vel dolore vel esse similique placeat. Quae est qui unde aut quas qui et qui.'),
(14,'aliquid','Ut officiis voluptates debitis asperiores ut. Fugiat dolores culpa sint suscipit. Voluptatem odio repudiandae nulla modi.'),
(15,'iusto','Id enim distinctio consequatur exercitationem est corporis. Deleniti architecto et vel quia iure qui pariatur. Autem id quibusdam porro non.'),
(16,'magnam','Alias odit modi quia ea minus aperiam. Voluptas tenetur dolor qui iure eligendi. Reprehenderit vero reiciendis quasi ea.'),
(17,'quibusdam','Qui ab provident deleniti magnam voluptas sequi est. Non omnis perspiciatis omnis excepturi voluptatum. Saepe non provident architecto quisquam.'),
(18,'earum','Dignissimos ullam reprehenderit quos et. Quis impedit sit sed. Sunt molestiae fugiat unde aut voluptates porro. Omnis eaque culpa accusamus animi iure doloremque similique.'),
(19,'eos','Numquam blanditiis officiis ut quas. Molestias hic modi deleniti doloremque aut fuga dolorum. Qui repellendus numquam nisi eum.'),
(20,'perspiciatis','Qui iure quaerat voluptates. Eveniet illum vel vitae sint eius. Est omnis ut repudiandae doloremque reprehenderit ex ipsam natus. Est quia distinctio deleniti.');


-- 3
INSERT INTO `media` VALUES 
(1,'quos',1,1,'2017-09-10 10:38:27',81445),
(2,'aliquid',2,2,'1976-04-10 06:17:45',38869121),
(3,'ex',3,3,'2021-04-02 22:59:26',6598),
(4,'culpa',4,4,'1981-06-16 11:24:22',1229),
(5,'blanditiis',5,5,'2013-07-17 10:02:26',62),
(6,'quia',6,6,'2000-04-22 19:59:23',373404),
(7,'ipsa',7,7,'2005-05-16 12:14:55',0),
(8,'ipsa',8,8,'2020-06-28 14:21:05',0),
(9,'porro',9,9,'1976-04-07 09:11:43',0),
(10,'dicta',10,10,'1984-04-21 18:57:56',24193856),
(11,'expedita',11,11,'2011-08-10 19:45:09',0),
(12,'consequatur',12,12,'2011-03-01 21:34:47',0),
(13,'reiciendis',13,13,'1976-06-29 01:00:34',7),
(14,'impedit',14,14,'1985-02-20 11:57:37',0),
(15,'in',15,15,'2013-06-30 10:52:57',2147062),
(16,'et',16,16,'1990-03-20 22:55:43',71),
(17,'est',17,17,'1972-03-15 12:57:11',472),
(18,'recusandae',18,18,'2018-05-05 05:36:06',383847),
(19,'praesentium',19,19,'2014-02-02 09:54:39',638057),
(20,'ex',20,20,'2008-06-16 09:35:52',0),
(21,'itaque',1,21,'1999-08-25 20:45:17',709),
(22,'mollitia',2,22,'1995-11-13 02:25:50',7996550),
(23,'repellendus',3,23,'2012-03-04 19:42:24',94),
(24,'magnam',4,24,'2021-10-22 15:38:00',1215644),
(25,'sequi',5,25,'2019-12-06 04:38:03',18138428),
(26,'id',6,26,'2002-06-28 22:48:41',591147),
(27,'veniam',7,27,'1982-09-03 00:10:50',6),
(28,'eos',8,28,'2015-01-10 14:36:04',5119),
(29,'illum',9,29,'1992-11-28 08:02:43',63221),
(30,'quam',10,30,'1985-12-22 11:34:26',3),
(31,'et',11,31,'2020-02-18 12:20:59',88255),
(32,'ad',12,32,'1990-01-02 05:42:03',4),
(33,'porro',13,33,'1972-01-25 06:05:27',783012),
(34,'ipsam',14,34,'1981-10-07 20:51:00',0),
(35,'fuga',15,35,'2009-03-21 21:17:26',976),
(36,'quis',16,36,'1988-01-07 19:31:54',81),
(37,'nisi',17,37,'1987-01-23 05:41:54',121858),
(38,'omnis',18,38,'1991-08-04 19:58:05',9060384),
(39,'quasi',19,39,'2011-07-13 23:38:56',73),
(40,'eius',20,40,'1994-04-08 06:44:58',57),
(41,'quos',1,41,'2005-02-06 06:41:23',62299),
(42,'quo',2,42,'1984-12-08 03:35:28',371957674),
(43,'fugit',3,43,'2017-05-25 01:42:21',66397),
(44,'veniam',4,44,'1971-11-16 01:17:47',3921),
(45,'recusandae',5,45,'2021-10-18 16:46:59',925),
(46,'ut',6,46,'1999-11-25 19:20:30',934),
(47,'occaecati',7,47,'1987-12-05 10:46:25',1503238),
(48,'aut',8,48,'2016-05-01 07:54:13',0),
(49,'non',9,49,'1971-06-19 11:19:10',44449254),
(50,'magni',10,50,'2009-11-17 02:24:43',625242370),
(51,'cumque',11,51,'1992-06-01 16:29:27',246),
(52,'veritatis',12,52,'2020-08-13 17:33:53',19627576),
(53,'voluptas',13,53,'2010-11-19 18:54:49',43217351),
(54,'vero',14,54,'1973-05-26 17:50:14',29114902),
(55,'qui',15,55,'1995-03-09 10:14:24',1987),
(56,'velit',16,56,'2018-10-26 09:39:00',3832339),
(57,'sunt',17,57,'2001-09-08 09:02:34',13963050),
(58,'cupiditate',18,58,'1978-09-05 04:06:28',390754),
(59,'odit',19,59,'1986-11-07 02:00:44',3),
(60,'aut',20,60,'2012-12-02 04:46:02',436296),
(61,'magni',1,61,'1990-08-29 19:24:08',682),
(62,'dicta',2,62,'1991-08-11 11:05:39',43639),
(63,'harum',3,63,'1995-08-21 23:22:02',664980911),
(64,'quod',4,64,'2007-11-21 22:24:24',17427652),
(65,'ullam',5,65,'2005-04-05 23:09:18',523375),
(66,'voluptatem',6,66,'1991-07-30 17:16:29',0),
(67,'ullam',7,67,'1986-01-04 10:09:30',483),
(68,'consequatur',8,68,'1995-02-01 05:11:45',433685394),
(69,'qui',9,69,'1986-03-05 23:30:36',4571422),
(70,'eius',10,70,'2012-03-12 09:15:26',186650232),
(71,'quis',11,71,'1996-04-14 18:25:39',36),
(72,'autem',12,72,'1978-09-26 07:24:02',0),
(73,'vel',13,73,'1997-08-10 12:13:21',0),
(74,'rem',14,74,'2008-11-13 06:45:50',0),
(75,'omnis',15,75,'1980-08-07 15:46:01',0),
(76,'sunt',16,76,'1976-03-01 02:54:16',53119),
(77,'excepturi',17,77,'2003-10-16 07:29:20',12),
(78,'eos',18,78,'1995-12-10 07:45:51',262),
(79,'itaque',19,79,'2005-10-06 09:21:03',79111929),
(80,'cumque',20,80,'2005-04-09 14:24:00',1866),
(81,'et',1,81,'1994-05-21 18:56:14',1692023),
(82,'quis',2,82,'1979-03-08 15:12:27',0),
(83,'laudantium',3,83,'1971-05-27 06:04:33',442),
(84,'non',4,84,'2017-12-02 12:39:30',847201451),
(85,'minima',5,85,'1973-10-01 06:58:03',27),
(86,'sit',6,86,'2017-02-03 03:39:02',89053),
(87,'sed',7,87,'1990-07-30 18:12:55',0),
(88,'nisi',8,88,'1972-08-04 19:05:15',740),
(89,'laborum',9,89,'1987-05-15 22:37:07',50),
(90,'sunt',10,90,'1971-02-17 01:49:39',562332175),
(91,'sed',11,91,'2002-01-27 17:33:25',6904),
(92,'assumenda',12,92,'1999-01-13 19:09:36',6807582),
(93,'necessitatibus',13,93,'2017-10-27 05:09:15',0),
(94,'facilis',14,94,'1972-05-11 02:03:10',4354576),
(95,'aut',15,95,'2002-06-20 15:48:07',323816920),
(96,'qui',16,96,'2021-12-03 17:56:28',34338346),
(97,'quod',17,97,'2020-12-07 19:07:58',83),
(98,'qui',18,98,'2016-03-20 03:12:36',84729069),
(99,'exercitationem',19,99,'1982-09-05 01:33:40',38391429),
(100,'sunt',20,100,'2009-05-15 04:59:09',0),
(101,'itaque',1,1,'2007-04-09 12:49:54',4),
(102,'aut',2,2,'1982-10-01 17:44:50',6863569),
(103,'itaque',3,3,'1996-08-19 21:54:38',802602415),
(104,'beatae',4,4,'1988-03-11 21:28:31',8351),
(105,'in',5,5,'1985-01-24 14:45:29',70),
(106,'libero',6,6,'1978-08-17 11:17:19',76),
(107,'quia',7,7,'2000-03-25 14:00:56',7968),
(108,'placeat',8,8,'1987-10-23 17:30:27',232652),
(109,'dolor',9,9,'1986-10-01 14:25:52',5),
(110,'quos',10,10,'1986-10-28 12:10:08',50605484),
(111,'numquam',11,11,'2014-02-21 17:04:05',989461),
(112,'architecto',12,12,'2005-08-20 14:00:30',57733983),
(113,'corporis',13,13,'1984-05-30 08:55:42',0),
(114,'perferendis',14,14,'2019-05-02 10:52:53',4509),
(115,'nisi',15,15,'2015-08-11 13:33:44',0),
(116,'enim',16,16,'1997-03-19 08:29:24',602532786),
(117,'autem',17,17,'2007-08-29 02:10:24',3354),
(118,'nostrum',18,18,'1976-09-01 01:04:26',1),
(119,'sit',19,19,'2012-10-14 20:40:31',51235),
(120,'ipsum',20,20,'2018-03-25 22:37:51',459042),
(121,'neque',1,21,'1972-12-26 03:50:02',7711),
(122,'eos',2,22,'1984-04-16 19:29:37',901),
(123,'beatae',3,23,'2003-06-28 02:57:05',5093633),
(124,'temporibus',4,24,'1973-10-01 13:43:03',8288664),
(125,'ea',5,25,'2017-06-15 04:22:17',6),
(126,'quia',6,26,'1979-01-27 14:50:38',40291),
(127,'laudantium',7,27,'1989-11-06 00:49:49',324089),
(128,'quidem',8,28,'1981-07-27 12:29:50',629),
(129,'consectetur',9,29,'1993-09-12 08:52:26',0),
(130,'dolorum',10,30,'1996-06-14 20:32:36',87),
(131,'et',11,31,'2004-11-09 13:28:28',905),
(132,'quia',12,32,'1973-03-16 15:34:20',4946902),
(133,'laborum',13,33,'1998-03-09 05:24:42',891),
(134,'nam',14,34,'2012-04-01 19:10:15',5349528),
(135,'rerum',15,35,'1974-03-04 12:27:37',64),
(136,'quia',16,36,'1980-08-20 05:00:23',14734),
(137,'rerum',17,37,'1989-10-28 04:29:26',1299),
(138,'est',18,38,'2016-01-21 06:45:25',806),
(139,'nulla',19,39,'2011-08-05 23:36:11',4487),
(140,'architecto',20,40,'2002-08-10 23:25:40',78086),
(141,'velit',1,41,'2021-11-19 02:36:50',7821868),
(142,'qui',2,42,'2007-11-06 17:32:24',9257),
(143,'officiis',3,43,'2019-12-27 02:47:07',39780671),
(144,'reprehenderit',4,44,'2015-07-22 18:00:25',7),
(145,'mollitia',5,45,'2019-12-20 08:41:14',941666650),
(146,'delectus',6,46,'2014-07-23 22:41:28',324372202),
(147,'provident',7,47,'1972-08-25 13:40:50',533461),
(148,'nam',8,48,'1985-05-09 21:39:47',809),
(149,'iusto',9,49,'2013-05-04 11:05:52',3),
(150,'sunt',10,50,'1982-11-10 18:28:59',7);


-- 4
INSERT INTO `profiles` VALUES 
(1,'Leanna','Littel','Bergstromchester','16901','Provident itaque quam cupiditate velit commodi nisi aut cupiditate. Amet ut sed illo omnis. Harum maxime dolore iste error magnam veritatis sequi. Velit repellendus et facere commodi error omnis non quisquam.',1,NULL,'1970-05-03'),
(2,'Elias','Walker','Lake Jarred','405739714','Id ipsa ipsa ut ut omnis quia. Quibusdam commodi ipsa in sapiente fuga dolores. Qui esse officiis id animi et adipisci.',2,NULL,'1973-05-07'),
(3,'Flossie','Collier','Harberstad','2','Incidunt debitis et id. Voluptatum expedita et est vel laudantium. Fuga quia voluptates esse dolores odio eligendi.',3,NULL,'2016-07-30'),
(4,'Margaret','Torphy','Haneville','1780757','Repellendus eum soluta magni voluptatibus ab magni. Nihil dolorem repellendus rerum amet ullam eius ut. Aperiam maxime magni velit eveniet autem.',4,NULL,'1976-11-23'),
(5,'Steve','Collins','Port Amiebury','7060624','Neque esse voluptas facilis esse ipsa aspernatur enim. Perspiciatis facilis libero recusandae recusandae. Et quia aut rerum consequatur.',5,NULL,'1979-04-15'),
(6,'Santos','Moore','South Nestorbury','204192582','Aliquid ut tempora occaecati accusamus aspernatur quidem ipsum at. Impedit sint ratione voluptate suscipit veniam maiores. Beatae est dolor omnis vero rerum dolor. Consequatur et sint cupiditate.',6,NULL,'1988-06-16'),
(7,'Robert','Koepp','Sipeschester','','Eum fugiat sit ea. Deserunt quos fugit sed autem quisquam dolorum magni. Sunt commodi quae assumenda omnis quo deleniti et eum. Debitis quibusdam soluta et in.',7,NULL,'2015-07-09'),
(8,'Elouise','Hilll','East Taureanborough','485161643','Asperiores minus officia commodi officia. Pariatur aliquam distinctio omnis ipsum tempora officiis rem. Exercitationem officiis a asperiores voluptate. Aut vel quaerat sed consectetur quia animi non sed. Eum sit maxime incidunt ut.',8,NULL,'2020-07-02'),
(9,'Abigayle','Powlowski','Terryton','42','Cumque iure officia dolorem ipsum id. Esse autem voluptas voluptatem atque esse aut cum et. Accusamus expedita error molestiae est iure hic ut saepe. A velit veritatis sunt sint.',9,NULL,'1990-07-31'),
(10,'Jaren','Kozey','New Alekchester','752510','Qui iusto dolorem est praesentium eos libero vero. Laborum omnis officia iste consequuntur. Sunt ut quas occaecati. Doloremque distinctio nam dolorum dolor.',10,NULL,'1983-01-22'),
(11,'Alexandrea','Beer','Nikolasberg','34','Nulla sit omnis sunt. Culpa iure molestiae omnis accusantium velit. Accusantium quam commodi similique aut architecto et. Vero consequatur nobis modi debitis qui.',11,NULL,'2017-11-07'),
(12,'Vincenzo','Jakubowski','South Evansview','91545571','Sunt officiis rerum aut tempora. Pariatur ad non quo. Vero vel modi impedit qui sunt cupiditate ea.',12,NULL,'1996-07-02'),
(13,'Stone','Klocko','Port Genoveva','78','Est est qui eos perspiciatis totam possimus aspernatur. Quia alias consectetur qui corporis ratione corrupti. Est quam quis enim quia consequuntur sint. Itaque molestiae ut enim excepturi nobis sit aspernatur. Odio porro accusantium praesentium ut.',13,NULL,'1999-06-14'),
(14,'Marguerite','Sporer','North Kellytown','71228922','Rem voluptate et laborum saepe. Et accusamus consequatur rerum velit magni omnis laudantium. Officia ipsum molestias repellendus. Explicabo provident sint et nostrum laborum quae.',14,NULL,'2015-07-03'),
(15,'Brenda','Gutkowski','Lake Blair','7679923','Odit ex quam provident ducimus. Nulla non voluptatem nesciunt expedita recusandae ipsam. Quisquam porro iste laboriosam et porro occaecati natus excepturi. Debitis qui ad accusamus qui quis eum aut.',15,NULL,'2007-12-10'),
(16,'Marcia','Armstrong','Sanfordberg','88','Aut porro optio tempore aut voluptas a at. Recusandae aut praesentium blanditiis quis est. Totam impedit iste commodi iure et veritatis.',16,NULL,'1995-01-06'),
(17,'Katrina','Lehner','Baumbachhaven','923826711','Soluta beatae libero velit explicabo voluptatem omnis. Maiores sint vel dolores natus sit inventore. Numquam eos quo assumenda nemo iusto corrupti. Commodi necessitatibus voluptas ut et nisi molestiae.',17,NULL,'1991-06-06'),
(18,'Wilmer','Davis','Jackelinemouth','','Aspernatur reprehenderit aut quibusdam voluptas et aut enim doloremque. Aut labore nisi commodi laudantium odit. Et aut explicabo quo enim. Iure animi voluptate ratione est atque perspiciatis.',18,NULL,'1976-06-15'),
(19,'Michale','Weissnat','Lilianaborough','798397','Doloremque hic provident sed inventore commodi voluptatem. Voluptates aliquam vel maiores sunt. Sed cum rerum consequuntur sunt eum nisi ut perspiciatis. Deleniti dolore tenetur error aut.',19,NULL,'2009-08-02'),
(20,'Erin','Haley','West Tillmanstad','318880','Ut id autem numquam eligendi eaque blanditiis non. Autem voluptas beatae in molestiae sunt eum. Occaecati maiores est molestiae illo facere. Aut debitis est aut et.',20,NULL,'2020-01-10'),
(21,'Lauriane','Baumbach','Runolfssonbury','','Officia quod necessitatibus explicabo id itaque enim totam. Et magni explicabo nesciunt ratione. Consequatur dicta veritatis fugiat est deserunt labore voluptatem. Excepturi itaque aliquam placeat qui. Aliquam fuga est commodi rerum est expedita non.',21,NULL,'2018-12-13'),
(22,'Eli','Wisoky','New Antone','310465','Maiores doloribus possimus placeat voluptatum quis vero voluptatem. Ut dolor et sit est veniam velit officia. Eum quis non minus qui voluptatibus. Dolorem velit eius tenetur quis non veniam.',22,NULL,'1985-08-12'),
(23,'April','Baumbach','Lake Billieborough','837226','Consequuntur et suscipit quia. Error aliquid voluptas sed iste tenetur nam ipsa libero.',23,NULL,'1988-12-23'),
(24,'Margret','Leannon','Beckerhaven','201593295','At consectetur ab minima voluptatibus dolore. Corrupti dicta velit ratione voluptate voluptas velit. Perspiciatis eum aut corrupti.',24,NULL,'2012-12-24'),
(25,'Narciso','Schmidt','East Rozella','141377901','Blanditiis dolorem ut dignissimos molestiae iste. Voluptatem voluptas officia natus impedit necessitatibus. Ut ut in laborum numquam voluptatem laborum non.',25,NULL,'1997-07-26'),
(26,'Bulah','Mitchell','Gutmannstad','46','Quos commodi ducimus voluptatem et sit dignissimos. Ut laborum quaerat et voluptatem consequuntur dolores. Quia cum dignissimos modi fuga praesentium quia optio.',26,NULL,'2019-08-23'),
(27,'Adam','Mills','Horacioton','64329','Ex qui et nesciunt quidem voluptatem in quo. Odit est perferendis fugiat culpa distinctio quod. Praesentium recusandae fugiat ut quo. Animi nobis nulla doloribus sed similique.',27,NULL,'2000-10-23'),
(28,'Keon','Krajcik','Flaviostad','5','Voluptatem omnis vitae animi laudantium qui debitis iusto. Repellendus quisquam unde consequatur optio est.',28,NULL,'1986-02-25'),
(29,'Hildegard','Kulas','East Zackary','430580','Eligendi eos saepe temporibus laboriosam. Ipsa placeat sed quo sit numquam est esse officiis. Molestiae doloremque molestiae et ipsum quasi.',29,NULL,'2000-09-29'),
(30,'Autumn','Ebert','South Eviebury','2218','Quaerat repellat dolor voluptatibus. Consectetur dolore dolor nihil quia fugit dolor. Quo et fuga eos ea consequatur molestiae sint.',30,NULL,'2019-04-11'),
(31,'Ashtyn','Ebert','Cierraville','','Temporibus alias eligendi aspernatur quae. Et enim eligendi molestias quos atque laborum quisquam. Consectetur perferendis vitae amet maxime quia ratione ipsam.',31,NULL,'1990-07-26'),
(32,'Sonia','Orn','Kendalltown','844575465','Facilis sed rerum ut corporis voluptate. Ut repudiandae placeat assumenda praesentium. Consequatur eius et minus tempora tempora ipsum.',32,NULL,'1979-05-15'),
(33,'Pansy','Padberg','South Stuart','6560509','Expedita maiores aperiam aliquam et iste molestiae. Veniam perspiciatis enim dolores amet dicta porro ducimus. Sit qui velit eum asperiores tempore molestiae nihil. Aut blanditiis qui eligendi non autem ipsa aut.',33,NULL,'2002-01-30'),
(34,'Hyman','Cassin','Jenniferberg','','Voluptas consequatur in rerum vel facilis autem magni. Fuga unde ipsum sunt perferendis et esse. Est eum sit sed dolor cupiditate magni quae.',34,NULL,'2010-03-29'),
(35,'Imogene','Parker','Toybury','163559','Voluptate consequatur ut necessitatibus consequatur et sunt et vel. Dolorum quia excepturi natus minus et eligendi rerum. Dolorem consequatur corporis ut fugiat corrupti maxime. Soluta aut laborum ducimus.',35,NULL,'1977-07-29'),
(36,'Joanne','Schmitt','Armaniton','4','Quos eveniet ea et aut exercitationem nostrum. Minima aperiam natus reiciendis saepe praesentium. Magni velit quis doloribus dolorum est.',36,NULL,'2007-07-08'),
(37,'Maximillian','Hessel','West Ruthville','68265','Officiis earum reiciendis pariatur autem nisi saepe est molestiae. Est facere neque quisquam inventore adipisci tempora et non. Deserunt ipsam minus dolore aliquam veritatis nesciunt modi. Qui est voluptatem aut voluptatem possimus odit.',37,NULL,'1984-06-04'),
(38,'Priscilla','King','Silastown','46584035','Nam consectetur vitae ea molestias non dolores. Dicta blanditiis voluptate repellendus sapiente qui rem quaerat. In quasi iste debitis saepe. Ipsam et aut veniam fugit.',38,NULL,'1984-04-07'),
(39,'Curt','Bernhard','South Roslyn','8','Id necessitatibus aut amet dolore. Voluptatibus vel nesciunt molestiae cumque. Neque est qui ipsam nihil eum blanditiis culpa odio. Ipsa sit impedit quaerat quam at consequuntur nam. Sed qui omnis maxime velit velit earum sint pariatur.',39,NULL,'2005-11-13'),
(40,'Alexie','Kirlin','Wintheiserfurt','765028','Iste dicta est reiciendis id et blanditiis sint. Nisi a voluptates incidunt quis inventore voluptas nobis. Minima odit nemo cupiditate non. Illo sit voluptas sed assumenda.',40,NULL,'2019-10-01'),
(41,'Aryanna','Bins','East Nedrahaven','216636','Quas soluta aut occaecati aspernatur libero. Qui possimus ut id eum. Sit sit vel alias animi aspernatur ea tempore dolorum. Illo recusandae dolorem dolores neque fuga.',41,NULL,'2013-06-07'),
(42,'Rashad','Schroeder','East Skylar','37053725','Ut animi vero quod ipsum sunt quisquam. Reprehenderit error velit fuga commodi natus qui.',42,NULL,'2016-11-05'),
(43,'Garry','Kerluke','Aliyahhaven','5640','Dolores non et facilis laudantium voluptatum id. Consequatur error et voluptatum impedit molestiae. Sit amet quis aspernatur voluptas nemo veniam accusamus. Et commodi quis quia quos ex.',43,NULL,'1984-02-25'),
(44,'Elisha','Hansen','West Wilber','','Dolor optio qui ut. Vitae ab sed iusto beatae omnis. Et dolorem qui fugiat recusandae cumque. Eaque iste dolore aliquid.',44,NULL,'1970-01-27'),
(45,'Ivy','Boyer','Rudolphville','20','Animi cupiditate nobis magni neque reiciendis. Architecto et optio omnis quod earum. Blanditiis molestias iure aut nobis autem. Vitae nobis aliquam voluptatem est in. Neque saepe itaque nostrum molestiae.',45,NULL,'1980-07-11'),
(46,'Rodolfo','Ernser','East Corine','16961','Commodi voluptates itaque nihil sed. Minus laboriosam laborum voluptatum ducimus maxime sit quae. Sapiente veritatis quia suscipit voluptates. Ea vel sit consectetur quia nisi sed.',46,NULL,'1987-09-19'),
(47,'Blake','Purdy','Spencerberg','36700','Dolor ut omnis doloribus dignissimos molestiae. Voluptatem qui tenetur in sunt vero rerum. Beatae officiis qui qui saepe vitae earum.',47,NULL,'1984-05-20'),
(48,'Victor','Bergstrom','New Judah','17884456','Et in provident occaecati voluptatem sunt est dignissimos. Cupiditate eos laboriosam omnis sapiente. Voluptatum accusantium labore mollitia vero.',48,NULL,'1990-09-21'),
(49,'Kamren','Smitham','East Ayana','','Autem fugit quia occaecati eius sit debitis ratione. Debitis dolorem aliquid placeat voluptatem. Nobis accusantium perferendis vel pariatur.',49,NULL,'2014-01-19'),
(50,'Yasmeen','Kessler','East Shannyfort','930','A in non quia quis omnis pariatur. Eum quia et et dolor. Quod quia et libero ut. Illo veritatis fugit aut aliquid est officia dicta iste.',50,NULL,'1989-10-16'),
(51,'Maeve','Johnson','New Lester','516','Et nesciunt nesciunt veniam fuga blanditiis incidunt. Eveniet voluptates similique totam dolorum. Iste ea vel sunt dolorem et maxime.',51,NULL,'2018-12-07'),
(52,'Micaela','Beatty','New Stefanbury','34184159','Temporibus officiis dolores nobis. Excepturi dolorem est laudantium est soluta qui esse illum. Recusandae sit ad nisi modi unde.',52,NULL,'1974-06-03'),
(53,'Immanuel','Yundt','Gleasonfurt','120598451','Eum quia reprehenderit eos. Dolorum in illo ratione accusantium. Facere debitis deserunt est qui fugiat recusandae iure ipsum. Dolor sint quis beatae assumenda deleniti excepturi vel. Expedita doloremque sed iure quis error qui perferendis.',53,NULL,'1979-02-10'),
(54,'Fannie','Pfannerstill','East Miltonland','27','Inventore dolorem minima enim facere. In iusto consequatur sunt quia. Molestiae incidunt expedita deserunt nobis nostrum sunt harum.',54,NULL,'2004-06-11'),
(55,'Hailie','Streich','Eusebiomouth','398272','Dolore delectus quia qui quos ab perferendis similique. Sequi dolorem porro consequatur ea est et. Vero pariatur quasi tempora quia nulla. Et magni quam provident omnis.',55,NULL,'1970-11-21'),
(56,'Darryl','Willms','North Mablehaven','48593886','Iste maxime occaecati dolores est temporibus dolores maxime. Et rerum ea possimus provident. Cupiditate voluptas accusantium occaecati libero perspiciatis sed.',56,NULL,'2004-01-07'),
(57,'Lilly','Hahn','Calistaside','99528980','Incidunt velit quasi pariatur vero vero qui dolorem. Recusandae possimus aut reprehenderit aliquam. Voluptatem quae molestiae et.',57,NULL,'1981-05-03'),
(58,'Jacky','Oberbrunner','New Sarinatown','2466833','Mollitia est id reiciendis deserunt libero. Aut fugit itaque alias ducimus minima non. Tempore ab error et temporibus vel.',58,NULL,'1972-07-05'),
(59,'Sincere','Hilpert','Lake Juliana','60669','Autem voluptas placeat facere provident consequatur et consequatur. Atque molestiae laboriosam molestiae et distinctio.',59,NULL,'1979-10-19'),
(60,'Minerva','Von','Rosaliamouth','8','Fugiat ipsum corrupti hic occaecati. Et sed odio in cupiditate maxime.',60,NULL,'2009-07-10'),
(61,'Else','Tremblay','South Alexandroshire','4856','Non amet quas eum totam suscipit. Aut commodi dolorum quod quos non quisquam veniam. Voluptatibus doloremque consequatur eveniet asperiores. Et culpa vero quasi. Quia quia tempora at qui totam aut harum.',61,NULL,'1987-05-27'),
(62,'Keely','Herman','West Darren','2286901','Aut voluptatem aut dolorem magnam eius est molestiae repellendus. Totam omnis iusto et. Minima sint dolorum officia sed.',62,NULL,'2017-03-16'),
(63,'Kyleigh','Kuhic','New Unaborough','64','Odio et est eaque omnis. Qui nihil iusto sed cumque at aspernatur.',63,NULL,'2019-09-23'),
(64,'Velva','Hartmann','West Josemouth','','Labore est aut voluptatum minus architecto et. Assumenda fugiat illo tempora sit sequi et dolorem. Necessitatibus odio officiis porro harum omnis perferendis.',64,NULL,'2013-01-12'),
(65,'Monserrate','Steuber','North Lambert','','Voluptas rerum omnis facere totam exercitationem officiis id. Dolor similique voluptatibus et eveniet aliquam. Ad ratione asperiores at nihil dolorem. Sint non temporibus molestias assumenda et non.',65,NULL,'1989-07-23'),
(66,'Mary','Hessel','Sylviamouth','257','Sunt dignissimos nostrum maxime aspernatur. Aliquam et enim labore recusandae perferendis sed. Voluptatibus nesciunt possimus eligendi laudantium. Libero praesentium iure fuga minima nihil officiis omnis.',66,NULL,'2005-11-21'),
(67,'Ollie','Runolfsdottir','Greenholtchester','37','Dolor est officia soluta ut ab est. Quas quis modi eos labore quae. Culpa minus ipsa excepturi ab possimus sit. Id possimus et omnis dolores eum est similique.',67,NULL,'1980-04-25'),
(68,'Tyra','Moore','Schultzland','123','Ad voluptate ut fuga voluptatum delectus. Praesentium sed magnam praesentium eligendi. Numquam esse voluptatem qui molestias omnis aliquam quia quia.',68,NULL,'1986-07-02'),
(69,'Westley','Gleason','South Jayne','583','Sed maxime ut placeat officiis dolorum. Voluptate saepe neque quos nisi autem. Non ipsa tempore repellendus sit. Ut autem quisquam vero culpa exercitationem et.',69,NULL,'2000-03-05'),
(70,'Lindsey','Casper','Goldnerfurt','','Minus molestias eum ad eveniet eaque. Iure enim fuga provident illo et. Reiciendis id sint et.',70,NULL,'1989-03-20'),
(71,'Damian','Cartwright','South Webster','351625','Pariatur accusantium adipisci expedita dignissimos accusantium non quae. Aut eos omnis quis voluptatem ducimus quos perferendis. Aliquam accusantium voluptate ut dolor iure. Corporis omnis sunt est in inventore.',71,NULL,'2008-08-04'),
(72,'Noelia','Crona','South Lauryn','66743','Minus eligendi et impedit aut magnam tempore ut. Reprehenderit rerum eos unde asperiores. Temporibus quia quo sapiente est. Eaque vel dicta iure asperiores amet laborum.',72,NULL,'2017-06-22'),
(73,'Brandt','Mitchell','Dawnborough','1','Vel rerum sed et quia totam. Necessitatibus eligendi in impedit explicabo ratione quasi est. Esse minima sunt autem incidunt eligendi sit dolore rerum. Provident numquam consequuntur aut aut repellat quidem.',73,NULL,'2001-01-03'),
(74,'Chelsey','Heller','North Deannafort','','Quaerat non omnis voluptatem ducimus. Voluptatum natus dolorum harum ut dicta. Possimus quidem delectus id reprehenderit.',74,NULL,'2004-10-10'),
(75,'Cathy','Thompson','Patview','3','Aspernatur voluptas quod distinctio eum aliquid et harum. Reiciendis optio ipsum ea ratione ratione. Voluptatum non delectus nesciunt debitis voluptate libero. Est aperiam porro illum eveniet non. Consequatur similique odit eveniet reprehenderit modi dese',75,NULL,'1977-05-29'),
(76,'Rene','Dicki','Cyrilshire','939781','Explicabo ut id aliquid dolorum id vel id. Voluptas architecto accusantium omnis nisi placeat aliquid ex. Quam ex animi quis illo corporis ea.',76,NULL,'1974-07-03'),
(77,'Zack','Marquardt','Handmouth','59','Sunt dolores odio quia aliquam fuga. Aut officiis officia in sed. Nesciunt deserunt quidem qui saepe error voluptatem eos.',77,NULL,'2021-10-20'),
(78,'Jerry','West','Littlechester','','Sapiente dolorem rem corrupti corrupti debitis quas. Voluptatum est at magni aliquam. Consequuntur quia quibusdam ea modi placeat incidunt. Sed quaerat ullam necessitatibus praesentium non.',78,NULL,'1976-07-16'),
(79,'Troy','Schumm','Harmonport','3724','Autem et cumque eum explicabo quo. Vel ex non sunt ut reprehenderit iusto. Velit doloribus veniam dicta.',79,NULL,'2010-02-05'),
(80,'Unique','White','South Devenborough','13447656','Quisquam et numquam ut ea. Consequatur ipsam veritatis inventore exercitationem enim. Autem omnis et dolor et. Laudantium id voluptatibus et minus dolores fugiat incidunt.',80,NULL,'2008-08-08'),
(81,'Lorine','Gutmann','Berryport','8308261','Nostrum voluptas pariatur aut quia facere. Porro ipsam non qui et excepturi. Deserunt delectus ut ratione minus suscipit et et. Cumque tempora illo enim assumenda ut omnis ipsam sed. Quia sed quis veritatis repellendus impedit.',81,NULL,'1971-10-05'),
(82,'Delphine','Swaniawski','Lucianoberg','86093582','Eum aut natus voluptas. Ab ut voluptas nihil quaerat ratione odit eaque. Fuga repellat nesciunt laudantium qui assumenda adipisci voluptate.',82,NULL,'1999-11-07'),
(83,'Brielle','Ullrich','Cormierfort','','Eum rerum sed ut est quam atque velit. Consequatur officiis nihil ut excepturi et. Blanditiis vero beatae sit odio. Quibusdam odit pariatur ullam qui quis quia ratione.',83,NULL,'1970-10-02'),
(84,'Haylee','Frami','Predovicmouth','','Eligendi libero tempore sit temporibus enim voluptatem. Tempora quisquam nobis nobis sequi aspernatur eveniet eum. Quo fuga adipisci atque. Voluptatum voluptates aperiam modi quod ut autem in explicabo.',84,NULL,'1993-07-30'),
(85,'Kenya','Mayert','West Freeman','4','Illum ad repudiandae vel nulla veniam. Vitae vero error aperiam facere. Commodi eveniet impedit aspernatur repellendus. Expedita quaerat odit ipsam facilis et.',85,NULL,'1985-07-07'),
(86,'Adrianna','Kuphal','Creminburgh','','Sed esse molestias rerum dolorem. Veritatis et enim recusandae aut sit nostrum. Consequatur vitae sit ducimus quaerat commodi numquam iure. Necessitatibus ut ut voluptatem culpa quibusdam voluptatibus qui. Ipsam debitis labore magnam beatae earum qui repe',86,NULL,'1987-09-04'),
(87,'Julia','Hansen','South Luciusbury','','In animi ipsum perspiciatis doloribus. Voluptas adipisci consequatur labore voluptatem perspiciatis eaque ratione. Placeat aut ex et non est aut voluptatem.',87,NULL,'1979-04-23'),
(88,'Ibrahim','Mueller','Hillsstad','','Recusandae in non iure vel et rerum aperiam. Modi rerum et fugiat cumque sit. Repellat fugit ea cupiditate non ea.',88,NULL,'2018-04-11'),
(89,'Renee','Marvin','Lake Margotburgh','4020','Earum quo ut rem voluptatem. Dolor velit et eveniet. Velit animi consequatur dolor earum voluptates velit vel. Distinctio quia omnis veritatis est aut.',89,NULL,'1989-01-18'),
(90,'Edyth','Schultz','Keelingtown','3','Cumque eveniet tenetur minus impedit non error nulla. Est sint nemo voluptatibus fugiat quisquam error nihil. Molestiae sit quod suscipit quas neque est. Sint quis perferendis culpa veritatis harum tempora qui dolore.',90,NULL,'2006-07-25'),
(91,'Josephine','West','Humbertostad','3336','Repellat porro ullam laborum nihil nihil fugit non. Occaecati est dolorem id iste. Incidunt quo molestiae qui dolor accusantium.',91,NULL,'1998-03-25'),
(92,'Darren','Renner','Lake Codyburgh','6','Sed est nemo omnis dolor at commodi nemo. Sapiente ut ducimus qui voluptas. Animi consectetur qui quam. Ipsam et est quos.',92,NULL,'2002-07-14'),
(93,'Jerald','Abbott','Harrisfurt','479','Provident rerum est aliquid repudiandae autem quidem sit itaque. Consequatur facilis aut maxime pariatur saepe autem. Quod fugiat corporis doloremque similique veritatis vel. Et laudantium voluptate provident accusantium.',93,NULL,'1996-01-18'),
(94,'Jaylen','Jacobi','Koelpinside','32702925','Accusantium qui eius nesciunt molestias. Est enim reiciendis repellendus illum quo. Omnis sit ut culpa dicta illum.',94,NULL,'1996-12-27'),
(95,'Jadyn','Tromp','Graysonburgh','1','Modi et consequuntur mollitia cumque dolorem. Et cum corporis voluptatem reiciendis. Et error eos dolore. Expedita nisi odio hic rerum quos. Nisi iure nulla repellat eum illo voluptates.',95,NULL,'1990-06-06'),
(96,'Kellen','Boyle','Bertaton','7','Facere in ab facere dolorum voluptatem. Perferendis sit ut veritatis saepe. Nesciunt quia magni modi vel ratione id aut. Magnam rerum voluptates ullam deserunt distinctio necessitatibus corrupti reprehenderit.',96,NULL,'2003-03-20'),
(97,'Michaela','Jacobs','Port Vincenzoside','1107650','Aut et velit error optio dolorem. Quam ea facilis est natus dignissimos. Maiores minus unde minima unde aspernatur.',97,NULL,'2010-07-19'),
(98,'Jadyn','Greenfelder','West Rachael','4086078','Aliquam dolore ipsam et. Quo quia possimus et necessitatibus tempore laborum. Officia hic sit repudiandae quaerat optio dicta non voluptatum. Et rem iure sit nostrum eligendi omnis.',98,NULL,'2010-04-12'),
(99,'Maybell','Littel','Schulistfurt','597803','Hic nemo nulla est quae. Ipsam ut voluptates dolores a. Cumque dicta rem et provident tenetur voluptatem excepturi aut. Repudiandae voluptatem iusto voluptatem enim.',99,NULL,'2004-02-28'),
(100,'Thalia','Kunde','Rempelview','','Consectetur enim aut asperiores. Consequatur officiis eaque consequatur quas. Repellat aut quis vero. Quis quia vitae pariatur vel soluta.',100,NULL,'1985-03-31');


-- 5
INSERT INTO `courses` VALUES 
(1,'dolores',1,2,'Sint quis amet enim a. Accusamus id sint vel quia quam vero. Doloremque minima doloremque dolorum aut et nemo ducimus. Ab voluptatem excepturi in et voluptas eos nihil.','Техническая','1974-04-11 05:23:48','1990-03-29 16:00:38','open'),
(2,'quasi',2,8,'Voluptatem voluptas amet optio. Sunt non fugiat non ea quia et. Omnis voluptatum quo velit totam. Et corporis ea in saepe mollitia aspernatur.','Естественнонаучная','1976-07-21 02:21:14','1993-01-09 01:36:01','open'),
(3,'ut',3,8,'Pariatur modi veniam laudantium nobis amet ut quia ipsa. Saepe reprehenderit et doloribus ea non voluptatem officia. Perspiciatis dolores perspiciatis illo corrupti omnis numquam.','Техническая','2019-10-10 08:29:18','2008-12-16 17:19:10','open'),
(4,'eius',4,6,'Vero officia unde natus mollitia molestias assumenda. Dignissimos voluptatem in incidunt mollitia atque ad maxime. Architecto et qui voluptatibus dolor exercitationem laborum.','Естественнонаучная','1972-07-05 03:57:43','1980-06-21 19:25:16','open'),
(5,'earum',5,6,'Exercitationem a perspiciatis accusantium vel. Distinctio ullam eius nihil veniam eius tempore autem eos.','Техническая','2017-12-31 21:45:34','2001-11-27 20:37:09','open'),
(6,'totam',6,1,'Incidunt unde est iure sint consectetur et facere. Rerum ut dolorum omnis omnis. Aut quae deserunt quis voluptatibus sed. Doloribus illum quo sint vitae.','Естественнонаучная','2015-10-27 16:32:38','2019-02-23 17:36:39','open'),
(7,'ipsa',7,8,'Laboriosam quia provident sunt aspernatur consequuntur ut. Error quod vel tenetur quas est. Quis aperiam illum asperiores. Qui veritatis eligendi occaecati sit quidem ut.','Техническая','2011-11-29 08:45:03','2005-03-26 08:08:21','open'),
(8,'vero',8,1,'Dolor a explicabo repudiandae non quis adipisci. Impedit quia veniam optio vel. Eos mollitia reiciendis qui et neque aperiam. Repellat facilis illum suscipit debitis quia quo.','Естественнонаучная','1979-09-24 13:22:18','1994-10-07 12:01:44','open'),
(9,'consectetur',9,4,'Et saepe in nihil tenetur odio. Voluptatem consequatur et inventore quidem sint quis et. Accusantium aliquid voluptatem mollitia laudantium qui.','Техническая','2003-02-19 03:36:23','1998-06-13 05:24:13','open'),
(10,'adipisci',10,3,'Consequatur vitae et provident repellendus doloribus deserunt dicta corporis. Quaerat veritatis et eligendi aut vel expedita totam. Vero aut distinctio consectetur voluptatibus quis nesciunt distinctio.','Естественнонаучная','1984-02-18 10:29:13','2002-12-05 19:30:29','close'),
(11,'laborum',11,6,'Vel ea id a culpa voluptatum qui voluptatem. Sit nemo repudiandae magnam ipsam accusantium eligendi. At est accusantium qui ut. Voluptatem aperiam quidem velit dolorem pariatur qui sit autem.','Социально-гуманитарная','2021-01-20 00:30:26','2009-04-06 16:01:26','close'),
(12,'eveniet',12,7,'Maiores hic et vitae asperiores. Nulla odit in reiciendis accusantium neque at et. Ut porro similique nostrum est ipsam. Sit possimus veritatis soluta rerum et tenetur rem odit.','Художественная','2018-07-18 01:55:59','1987-12-29 12:31:36','close'),
(13,'sapiente',13,4,'Saepe illo totam sequi natus qui vero natus. Ratione nesciunt nihil et similique commodi atque. Accusantium maiores repudiandae quo voluptatem.','Социально-гуманитарная','1984-02-27 23:49:41','2005-01-03 17:43:21','archive'),
(14,'esse',14,7,'Id dolor similique consequatur minima. Molestias necessitatibus consequatur et sunt. Itaque explicabo laudantium beatae.','Художественная','1976-07-28 04:14:34','1984-05-02 22:20:54','close'),
(15,'ipsa',15,8,'Veritatis ea dolorem dolor. Magnam est omnis corrupti tempore quia officia. Ipsa nobis quia laboriosam recusandae rerum illum ipsam. Quod quas tempore optio blanditiis eius.','Социально-гуманитарная','1979-03-22 21:19:16','1996-06-26 12:21:03','open'),
(16,'cupiditate',15,6,'Sequi temporibus libero at. Rem dolorum delectus omnis est qui. Est fugit optio non velit. Architecto et vero non ut ducimus in.','Художественная','2005-12-28 11:14:09','1991-06-05 16:05:47','open'),
(17,'ducimus',8,8,'Eos aut quis id. Dolorem vitae quo cumque voluptatem et impedit tempora. Minima adipisci et repellat animi voluptas cumque. Occaecati voluptatum sed aperiam ut vel suscipit.','Социально-гуманитарная','2013-09-12 13:25:04','2006-01-22 12:43:55','open'),
(18,'quibusdam',9,4,'Dolores similique tempore est temporibus at. Rem et molestiae nisi sit. In ipsam modi dolorum eligendi consequatur ratione. Facilis et dolorem sint aliquid.','Художественная','1981-06-06 02:01:36','1996-12-07 01:10:24','open'),
(19,'optio',10,4,'Dolorem quibusdam neque et architecto. Autem suscipit quia dolor. Molestiae praesentium est qui et id voluptatem ut. Consectetur tempore praesentium possimus et mollitia. Voluptatem voluptas harum esse reiciendis sit.','Социально-гуманитарная','1988-12-08 04:20:27','1973-08-11 13:21:13','archive'),
(20,'corporis',2,9,'Molestiae veniam quibusdam molestias pariatur ratione voluptatem. Dolorum perferendis officia ullam libero voluptatem eaque voluptatem. Eum nulla illum libero qui omnis voluptas et.','Художественная','1971-12-20 10:32:56','2010-09-24 07:42:06','archive'),
(21,'fugit',3,2,'A minus temporibus laudantium qui quidem. Voluptas sed consequatur sequi tenetur. Culpa quas asperiores dicta voluptatem ipsum autem reiciendis.','Туристско-краеведческая','1997-06-24 06:29:11','1995-01-02 20:19:57','open'),
(22,'ut',4,7,'Eligendi aperiam doloribus sunt ea in non asperiores. Cumque illo laboriosam culpa ea rerum ullam nihil. Eaque tempore ex est vel.','Физкультурно-спортивная','2021-12-06 21:55:43','2009-01-26 02:54:02','open'),
(23,'architecto',5,1,'Provident necessitatibus sed fugiat illum. Ipsum aliquid voluptatem consequuntur. Aut et sed saepe est sapiente incidunt quaerat repudiandae. Tempora ut sunt aspernatur mollitia.','Туристско-краеведческая','1971-10-30 17:31:55','1994-01-17 20:48:25','open'),
(24,'illo',6,9,'Suscipit ipsum minima delectus consequuntur. Inventore aliquid necessitatibus distinctio et est et.','Физкультурно-спортивная','1992-11-16 17:58:16','2020-12-10 09:43:43','open'),
(25,'quia',7,4,'Totam asperiores voluptatem et magnam dignissimos. Dolores dolor dolores dolor unde saepe. Sed dolorem soluta eum incidunt commodi consequuntur hic. Laudantium consequatur ex iste et.','Туристско-краеведческая','2021-06-07 17:16:18','2018-06-26 14:26:21','close'),
(26,'sed',8,4,'Sed praesentium vero facere et rerum voluptatem et dolor. Atque architecto incidunt repellendus quia. Tempora occaecati laborum eum corrupti quia itaque.','Физкультурно-спортивная','2011-02-21 08:01:35','1997-05-03 09:58:04','open'),
(27,'perspiciatis',9,4,'Qui asperiores libero quidem eum dolores est. Dolores nulla voluptatibus quia omnis vel doloremque. Quis repudiandae non inventore voluptatem debitis. Consequatur voluptatem recusandae rem dolorem est.','Туристско-краеведческая','2012-01-29 03:23:25','2019-07-10 02:17:34','open'),
(28,'illo',1,5,'Voluptatem quas qui dolores id quidem dolores voluptatem. Perferendis voluptatibus non voluptates omnis. Reprehenderit voluptates sed rerum consectetur. Quae et non odio nemo quis ratione.','Физкультурно-спортивная','1989-11-04 16:44:51','2005-11-24 01:20:45','open'),
(29,'sequi',2,9,'Omnis numquam quam alias adipisci aut a. Suscipit aut porro ipsam architecto labore eius ut. Quaerat eum autem veritatis laudantium doloribus distinctio dignissimos quis. Nihil sit et excepturi voluptas atque in quia recusandae.','Туристско-краеведческая','2018-08-12 15:02:17','2015-12-24 17:11:01','open'),
(30,'laudantium',3,5,'Officia molestiae cumque eos voluptatum cumque voluptatem dolor inventore. Sed ea quae minus inventore architecto sunt. Repudiandae dolore quibusdam qui harum reiciendis consequuntur ipsum.','Физкультурно-спортивная','1977-03-30 18:22:42','2014-12-18 00:41:50','open');


-- 6
INSERT INTO `media_courses` VALUES 
(1,1),
(2,2),
(3,3),
(4,4),
(5,5),
(6,6),
(7,7),
(8,8),
(9,9),
(10,10),
(11,11),
(12,12),
(13,13),
(14,14),
(15,15),
(16,16),
(17,17),
(18,18),
(19,19),
(20,20),
(21,21),
(22,22),
(23,23),
(24,24),
(25,25),
(26,26),
(27,27),
(28,28),
(29,29),
(30,30),
(31,1),
(32,2),
(33,3),
(34,4),
(35,5),
(36,6),
(37,7),
(38,8),
(39,9),
(40,10),
(41,11),
(42,12),
(43,13),
(44,14),
(45,15),
(46,16),
(47,17),
(48,18),
(49,19),
(50,20),
(51,21),
(52,22),
(53,23),
(54,24),
(55,25),
(56,26),
(57,27),
(58,28),
(59,29),
(60,30);


-- 7
INSERT INTO `groups` VALUES 
(1,'consequatur',1,1,'2004-10-30 14:26:40'),
(2,'sed',2,2,'1977-09-24 02:58:22'),
(3,'vero',3,3,'1983-05-27 12:04:52'),
(4,'asperiores',4,4,'1986-01-02 23:55:35'),
(5,'quibusdam',5,5,'2002-11-05 03:10:59'),
(6,'aut',6,6,'1996-12-17 14:54:39'),
(7,'quod',7,7,'1988-11-02 23:25:27'),
(8,'molestiae',8,8,'1975-11-01 11:05:59'),
(9,'vel',9,9,'1976-04-13 09:36:48'),
(10,'voluptas',10,10,'2003-06-17 08:19:53'),
(11,'error',11,11,'2006-11-20 15:10:12'),
(12,'totam',12,12,'1993-09-07 15:10:05'),
(13,'enim',13,13,'1975-04-04 08:24:29'),
(14,'recusandae',14,14,'2005-10-05 16:48:48'),
(15,'nobis',15,15,'1999-03-29 21:29:51');


-- 8
INSERT INTO `users_groups` VALUES 
(81,1),
(82,2),
(83,3),
(84,4),
(85,5),
(86,6),
(87,7),
(88,8),
(89,9),
(90,10),
(91,11),
(92,12),
(93,13),
(94,14),
(95,15),
(16,1),
(17,2),
(18,3),
(19,4),
(20,5),
(21,6),
(22,7),
(23,8),
(24,9),
(25,10),
(26,11),
(27,12),
(28,13),
(29,14),
(30,15),
(31,1),
(32,2),
(33,3),
(34,4),
(35,5),
(36,6),
(37,7),
(38,8),
(39,9),
(40,10),
(41,11),
(42,12),
(43,13),
(44,14),
(45,15),
(46,1),
(47,2),
(48,3),
(49,4),
(50,5),
(51,6),
(52,7),
(53,8),
(54,9),
(55,10),
(56,11),
(57,12),
(58,13),
(59,14),
(60,15),
(61,1),
(62,2),
(63,3),
(64,4),
(65,5),
(66,6),
(67,7),
(68,8),
(69,9),
(70,10),
(71,11),
(72,12),
(73,13),
(74,14),
(75,15),
(76,1),
(77,2),
(78,3),
(79,4),
(80,5);


-- 9
INSERT INTO `tasks` VALUES 
(1,'Impedit dicta quod r','Consequatur culpa sapiente et voluptatem ex quod quam. Ratione sed quos est in.',1,1,1),
(2,'Optio dolor incidunt','Reiciendis et atque commodi molestias. Porro iste consectetur a et cum dolor. Voluptatem doloribus ipsam qui aperiam ex eos.',2,2,2),
(3,'Id autem facilis est','Ex distinctio vitae ut impedit temporibus. Voluptate reprehenderit qui eos voluptas. Et amet iusto quae.',3,3,3),
(4,'Voluptate pariatur a','Animi atque voluptatibus consectetur omnis molestiae tempore est. Molestiae rerum molestiae at velit. Perspiciatis soluta ut nulla voluptas suscipit.',4,4,4),
(5,'Excepturi sed non of','Qui ducimus id ea alias voluptas et. Voluptas autem qui praesentium et magni laboriosam consequatur. Esse ut qui eum alias et qui voluptatem.',5,5,5),
(6,'Dolore ea delectus e','Earum incidunt omnis rerum deserunt sint ea non. Et veniam id unde quos voluptas ab. Sapiente repudiandae inventore neque sed.',6,6,6),
(7,'Consequatur nobis si','Recusandae voluptatibus qui sint rerum. Ab esse placeat saepe vel libero veritatis. Iste aut maxime voluptatem.',7,7,7),
(8,'Eum aut sit inventor','Dolor et aut qui praesentium totam. Fugit adipisci officia eum temporibus. Autem nulla et qui accusamus soluta sint. Quis quis laudantium laborum soluta cum.',8,8,8),
(9,'Corrupti quidem dolo','Quia impedit et fugiat. Tempora cum vel ducimus sed. Dolorem nihil eum dolores asperiores sunt.',9,9,9),
(10,'Odio deserunt aut qu','Quae dolore magni veritatis voluptatem eaque. Explicabo nihil cum reiciendis enim ea aliquid corporis qui. Eveniet voluptates at omnis eos dolor voluptatibus soluta pariatur.',10,10,10),
(11,'Et a nihil molestiae','Dolore corporis velit explicabo eos quo. Dolor saepe repellendus saepe suscipit cupiditate. Ab exercitationem sed eos pariatur consequatur.',11,11,11),
(12,'Dolorem nostrum aut ','Voluptatem enim explicabo aliquid quod non. Cupiditate porro nemo quia in. Asperiores nihil itaque nihil nemo ipsum repellat.',12,12,12),
(13,'Sunt ducimus sit vit','Id aut voluptas aut ipsa. Consequatur dolor dicta repellendus hic dolorem. Quae illo minima quam numquam quia.',13,13,13),
(14,'Earum eos ipsum numq','Similique omnis qui quidem ex quis ratione et. Numquam beatae deserunt perspiciatis ut. Voluptates laborum quod accusantium.',14,14,14),
(15,'Quam illo quia sunt ','Qui culpa repellat voluptatem maiores tempore. Esse libero rem soluta. Ducimus quia voluptatem aliquam nam. Qui atque aut doloribus sunt quo. Corporis corporis aliquid aliquid.',15,15,15),
(16,'Praesentium aut beat','Dolorem ut provident est qui quidem at unde. Quo voluptates non quisquam ut aut qui. Dolor voluptatem perspiciatis corporis.',16,7,16),
(17,'Et vel aperiam et de','Sit ut modi magni velit ut odio. Minima aut et blanditiis magnam necessitatibus sunt sed. Odit esse asperiores atque dolorum qui rerum autem.',17,8,17),
(18,'Sint sunt nemo repel','Nam rerum corporis dicta voluptas occaecati et esse. Omnis illum et ex. Omnis cum cumque mollitia consequatur.',18,9,18),
(19,'Et qui et et incidun','Nobis unde sunt recusandae eius. Ipsa at ullam ab hic quia. Itaque eveniet ut et accusantium omnis et placeat.',19,10,19),
(20,'Ut aliquam et consec','Molestiae soluta harum molestias ad molestias. Molestiae ab consequatur in. Voluptatem eos quia perferendis deserunt. Alias rem dolores inventore qui.',20,2,20),
(21,'Reiciendis nemo quae','Tempora quia consequatur voluptas quae tempore id quia. Dolor et est sit aspernatur consectetur. Quod dolores nam quia necessitatibus inventore rerum aperiam.',21,3,21),
(22,'Beatae laudantium re','Tenetur sunt nulla velit quia. Delectus voluptatem atque quis. Rem in commodi autem ut repellendus earum.',22,4,22),
(23,'Tempora qui expedita','Voluptatibus doloremque distinctio sed sunt et quia quia. Rem labore vel quo et deserunt. Incidunt dolores at iste enim corrupti vel molestias. Numquam accusantium rem vitae vitae.',23,5,23),
(24,'Saepe est ut officia','Facilis quis deleniti nihil dignissimos praesentium alias aut. Itaque labore provident esse nostrum architecto numquam. Dolores dicta quia id dolorum dolorem. Et vero sunt qui eius libero nesciunt.',24,6,24),
(25,'Consectetur placeat ','Ipsum est facere quia saepe velit quas veritatis molestiae. Beatae iure voluptatem quisquam expedita non voluptatem quis. Velit eos qui veritatis qui. Repudiandae consequatur enim rerum iusto itaque nobis assumenda.',25,7,25),
(26,'Aut tenetur accusant','Corrupti nesciunt sit pariatur tempora consequuntur. Ratione corrupti labore rerum qui non.',26,8,26),
(27,'Aut voluptatem quo d','Accusamus et assumenda voluptatibus nam. Dolore vitae dolor velit dignissimos quasi quia. Ea eum dignissimos asperiores velit harum dicta est nam. Iure quas eos odit expedita sit eveniet dolore.',27,9,27),
(28,'Qui voluptatem et co','Ut soluta ea maxime assumenda. Doloribus consequatur voluptatem culpa. Sed dignissimos quasi quo ullam et. Delectus et consequuntur sit in possimus inventore.',28,10,28),
(29,'Praesentium aut offi','Voluptatem qui voluptatem sit voluptates qui vero non sunt. Sit nostrum et magnam laboriosam delectus dolores. Et modi corporis et illo doloremque. Necessitatibus corrupti id eos tempora.',29,11,29),
(30,'Amet perferendis dig','Illum ipsa dolorem eos accusamus et. Amet numquam molestias consectetur quam cupiditate repellendus. Iure vitae ab omnis doloremque numquam.',30,12,30),
(31,'Modi omnis commodi p','Quisquam et sapiente assumenda itaque nihil rem eum. Qui ut aliquam sint consequatur earum dolores. Exercitationem est sunt perspiciatis velit ducimus dolor.',1,13,31),
(32,'Voluptatem commodi e','Esse enim aspernatur debitis modi aliquid nam fugiat. Quia vel ipsum inventore est quaerat. Exercitationem ipsum vel est illum eligendi dolorum corrupti iure. Quibusdam doloremque sit natus et vel voluptas sunt.',2,14,32),
(33,'Et non velit aut mol','Placeat consectetur aut quasi magnam perspiciatis aut cupiditate id. Inventore numquam dolor non. Perspiciatis eveniet sint delectus laborum aut voluptatibus. Iste debitis quasi sed.',3,15,33),
(34,'Quas magni totam exe','Illum dignissimos perspiciatis et qui deleniti. Autem et aut occaecati consequatur veniam illum consequuntur.',4,7,34),
(35,'Perspiciatis tempore','Aut id eveniet illo. Debitis non nam labore eaque ex. Aut odio quis neque autem nam blanditiis ut.',5,8,35),
(36,'Sint et provident ut','Eius aut voluptas consequatur. Quisquam cumque possimus in explicabo dolor est debitis sed. Nisi repellendus qui id.',6,9,36),
(37,'Ducimus molestiae eu','Officia dolore quaerat consequatur adipisci. Repellendus asperiores cum id id ut. Ullam quis voluptatem nostrum culpa. In corrupti eaque veritatis.',7,10,37),
(38,'Excepturi nihil mole','Tenetur nostrum harum et consequatur. Aliquam sed autem vitae nesciunt voluptates qui fugit. Sint vero hic fugiat consequatur eum.',8,11,38),
(39,'Quasi veritatis est ','Perferendis illum possimus magnam porro quas. Sed eos nemo sunt aliquid doloremque necessitatibus. Porro enim non blanditiis consequuntur.',9,12,39),
(40,'Qui pariatur exercit','Aut eveniet tenetur dolores laborum repudiandae ut aliquam voluptatem. Nostrum maxime voluptas animi. Tempore iusto autem laboriosam inventore sit illum.',10,4,40),
(41,'Officiis qui dicta i','Quae quibusdam aut commodi fuga expedita ut inventore. Deserunt modi rerum non. Unde facere molestias ipsam earum laborum.',11,15,41),
(42,'Facere ullam qui in ','Voluptate officia vel et ut ut. Mollitia est inventore voluptatum. Laborum maiores veritatis qui error amet nisi voluptas.',12,6,42),
(43,'Porro maiores corrup','Voluptas commodi non iusto magnam vel maxime. Nesciunt consectetur aperiam ut qui dolorum et maxime. Nisi qui ipsam delectus est. Praesentium odio laborum ut.',13,7,43),
(44,'Blanditiis odit eum ','Odit sapiente maxime eos voluptate. Illo aut dolores eum mollitia vero fugit. Praesentium tempore omnis ut in quo iusto in.',14,8,44),
(45,'Sed odio expedita fu','Sunt eveniet inventore cupiditate dolor aut expedita. Voluptatem in ex eum recusandae.',15,9,45),
(46,'Iste excepturi cum m','Et est id fugiat fugiat sint nihil. Dolor reprehenderit consequatur eos illum. Molestias blanditiis id consequatur numquam nostrum quia.',16,10,46),
(47,'Sunt voluptatem aut ','Recusandae aperiam fuga dolor eaque unde a eveniet libero. Nesciunt provident ut quo ratione consectetur illum aliquid. Quidem sunt delectus qui non et. Officiis animi deserunt sit.',17,11,47),
(48,'Et voluptatem omnis ','Reiciendis aspernatur harum est pariatur ut soluta. Asperiores iure rerum ipsam sed impedit aperiam. Sit fugiat voluptatibus ut aut ea cum praesentium. Sint consequatur porro quis iusto qui tempora et.',18,12,48),
(49,'Sint molestiae aut l','Debitis non aspernatur veritatis est. Officia perspiciatis error soluta excepturi placeat. Qui sint iure minima doloremque cum debitis.',19,13,49),
(50,'Id exercitationem ma','Corporis pariatur voluptatem consequuntur adipisci. Incidunt culpa velit aliquid minus commodi est. Odit similique nulla fuga qui aperiam temporibus.',20,5,50),
(51,'Quam nisi porro ab v','Ipsum numquam eum laudantium ea ut similique. Iusto fuga nihil maxime deserunt minus. Saepe facere veniam maxime in.',21,15,51),
(52,'Aut praesentium rem ','Laboriosam facilis temporibus accusantium eos aperiam nesciunt. Autem esse minima alias debitis in et. Odio fugiat aperiam saepe dolores eveniet. Eum qui corporis et quis rem quasi.',22,7,52),
(53,'Quo molestias optio ','Sit aliquam id ullam deserunt possimus. Quae consectetur recusandae consequatur pariatur fugit veniam. Molestiae blanditiis ipsam autem distinctio esse molestiae.',23,8,53),
(54,'Sint vel vel est ad ','Nesciunt praesentium facere quibusdam sed. Est voluptatibus similique et. Suscipit similique deserunt voluptas autem vel. Nihil ipsam nobis quam porro quas sapiente.',24,9,54),
(55,'Numquam consequatur ','Voluptatibus et quae aut in ab. Quasi voluptatem delectus voluptas non aliquam. Assumenda sit et repellendus quis expedita distinctio. Ipsam rem quibusdam molestiae alias debitis et voluptas.',25,10,55),
(56,'Esse quia omnis libe','Esse corporis recusandae aut et vel dolor sed. Velit asperiores quia sequi consectetur. Corrupti dignissimos rem qui ut.',26,11,56),
(57,'Deleniti aliquid mol','Asperiores voluptatibus molestias dolor. Dignissimos ut voluptatem id harum officiis veniam. Maiores voluptatem non dolores libero corrupti. Dolorem laudantium repellendus velit explicabo itaque.',27,12,57),
(58,'Dolor molestiae aper','Rerum ut velit sit accusantium qui reiciendis quod ad. Architecto dolorem dolorum expedita a quam. Nemo ratione exercitationem autem dolorum quaerat laborum. Cupiditate accusantium qui quam amet.',28,13,58),
(59,'Sit qui quos error e','Fugiat nostrum totam ipsum dolorum maiores non sequi. Occaecati laboriosam nulla beatae totam voluptatibus voluptatem. Architecto et et non natus commodi nihil aut.',29,14,59),
(60,'Aut ut sit maxime a.','Sequi ut error dolor fugiat est ut veritatis eos. Iste doloribus dicta consequatur sit cupiditate delectus sequi eligendi. Optio occaecati nisi corporis autem. Et dolor qui veritatis quia reiciendis maxime.',30,6,60),
(61,'Deleniti velit dolor','Voluptatem accusantium ad voluptatem molestiae. Dolore nisi suscipit aut nostrum aperiam et.',1,1,61),
(62,'Sed ut in est est et','Expedita consequatur facilis et nesciunt ullam natus ad. Eius dignissimos debitis rerum sit. Exercitationem officiis facilis autem nostrum.',2,8,62),
(63,'Quibusdam modi repud','Aspernatur ea facere cupiditate est recusandae. Unde dicta numquam illum sed quis aut. Labore et amet aut qui itaque.',3,6,63),
(64,'Consequatur iusto cu','Et sit aliquam quisquam laborum voluptatum sint. Temporibus quasi sed voluptates nemo. Perferendis aspernatur ipsa quia. Nihil laboriosam ratione voluptatum mollitia molestiae.',4,10,64),
(65,'Ullam quo ipsam ipsa','Nesciunt maxime error similique sit eius non. Nam quia autem et a atque. Qui dolor atque non qui.',5,11,65),
(66,'Corrupti mollitia vo','Unde non consequuntur voluptatem architecto ipsa soluta. Blanditiis quibusdam voluptatem aut itaque voluptas ut. Corporis quasi non similique consequatur.',6,6,66),
(67,'Debitis fugit at qui','Soluta rem praesentium corrupti voluptas. Modi explicabo illum neque est voluptas. Est amet quam et maxime illo. Est unde amet aperiam hic.',7,7,67),
(68,'Qui vel vel ut error','Voluptatem ut iusto qui dolorem impedit ut sit. Quidem et laboriosam voluptatibus assumenda. Necessitatibus iste iste aspernatur est et. Qui vel officia voluptas cum necessitatibus natus dolor.',8,8,68),
(69,'Eum pariatur qui qui','Fugit quia est in accusantium iure necessitatibus totam. Velit incidunt consequatur eveniet cumque at quo. Pariatur rerum quia error enim exercitationem consequuntur. Distinctio unde perspiciatis sit veniam id.',9,9,69),
(70,'Nobis voluptas enim ','Earum quas aut et. Consequatur rem laudantium aperiam laboriosam. Quas dicta dolore et eaque earum sed est.',10,7,70),
(71,'Illo mollitia sint a','Repellendus iusto quo necessitatibus nihil sed. Magni perferendis expedita eos vel et eum. Itaque a reprehenderit voluptatibus eos. Eligendi reiciendis ratione deleniti eius iste aut molestiae.',11,1,71),
(72,'Autem ratione suscip','Necessitatibus sed consectetur neque voluptates velit. Atque voluptas est et ut repellendus. Voluptas voluptatem sequi iusto quos. Ex consequatur quasi officia officiis nam.',12,2,72),
(73,'Ipsam quos recusanda','Vitae nemo occaecati pariatur autem. Sapiente delectus quae aut quo omnis nulla recusandae. Similique fugiat et voluptas minus. Minus minima odit voluptatibus voluptates.',13,3,73),
(74,'Cumque aut ut archit','Aspernatur dolor voluptatem id perferendis. Odio voluptatem consequuntur rerum ab accusamus. Quaerat et est suscipit quia aspernatur voluptas quod.',14,4,74),
(75,'Enim et harum volupt','Exercitationem blanditiis excepturi doloremque accusamus voluptatibus esse deleniti numquam. Ut in ipsa et sed et provident.',15,5,75),
(76,'Ut beatae dicta unde','Consectetur voluptatem illo nemo consectetur. Expedita assumenda sed recusandae laudantium.',16,6,76),
(77,'Dolorum nesciunt aut','Blanditiis natus et quod. Omnis molestias accusantium nam. Neque est nostrum eum quis officiis. Eveniet rerum ad eaque similique.',17,7,77),
(78,'Facilis atque labore','Quia unde ex labore dolores est nemo. Eum enim consequatur ratione molestiae voluptatem soluta omnis. Soluta molestiae ullam cum incidunt quidem sint sed distinctio. Numquam quibusdam cum esse fuga voluptate.',18,7,78),
(79,'Sunt veritatis simil','Saepe aut minima vitae a omnis et qui. Quos ut culpa voluptatem non quia. Perspiciatis nostrum et nihil illo et blanditiis molestiae corrupti.',19,9,79),
(80,'Autem numquam quos m','Tenetur voluptas a ullam eius labore non. Molestiae ipsa rem quia delectus et nihil est id. Cupiditate sed ut expedita distinctio est odit sequi. Qui vitae sed ab voluptates. Ut molestias ratione harum quod eveniet.',20,8,80),
(81,'Quam asperiores quis','Velit praesentium sint laboriosam ipsam dolorem. Velit nam perspiciatis dicta modi repudiandae fuga nam. Laudantium aliquid quam consequatur at. Praesentium reiciendis architecto fuga aliquam praesentium praesentium quis laboriosam.',21,1,81),
(82,'Maxime ut voluptas f','Corporis est hic enim aliquam et quibusdam. Neque repellendus in voluptatem minus blanditiis. Non aspernatur asperiores a blanditiis laboriosam error aut. Velit eaque voluptatem soluta iste blanditiis sed.',22,2,82),
(83,'Sed suscipit eligend','Similique explicabo et voluptatibus velit numquam cupiditate et. Et ut nihil laborum in. Explicabo magni et et dolores.',23,3,83),
(84,'Sequi dolores qui it','Suscipit et corrupti quae itaque autem voluptatem inventore. Debitis culpa vero adipisci officia.',24,8,84),
(85,'Velit aliquid a volu','Commodi et omnis quia laudantium. Reprehenderit sequi illum quia unde mollitia fuga cumque. Officia in et minus et quo sint eos. Amet odio deleniti velit illo ipsum dignissimos.',25,5,85),
(86,'Assumenda voluptas v','Omnis blanditiis aut omnis accusamus consectetur est. Maiores esse temporibus eos eum consequatur.',26,6,86),
(87,'Sed asperiores dolor','Accusamus aliquid cumque quas praesentium cupiditate illo necessitatibus. Quo molestias dicta et sit atque dolores eum. Laudantium voluptatum voluptatem enim accusamus vel ut corrupti. Harum repudiandae in deleniti nam.',27,8,87),
(88,'Reiciendis provident','Voluptates quisquam consequatur veritatis mollitia officia aut. Tenetur neque inventore itaque error quo et. In nihil ut suscipit quis a qui.',28,8,88),
(89,'Eum dolor laboriosam','Quam error facilis illum necessitatibus omnis cupiditate. Perspiciatis ducimus non totam ipsam et in. Labore sed natus aliquam consequatur error sit. Pariatur consequatur ea expedita sed itaque est minus.',29,9,89),
(90,'Quis consequatur nat','Dolor ad rerum consequatur hic ea praesentium necessitatibus. Laboriosam fuga iste quaerat nesciunt incidunt ipsum. Nulla voluptatem ut maiores quo. Sed enim excepturi sunt accusantium non placeat. Vel nesciunt dolorem consequatur odio et minus quas.',30,9,90);


-- 10
INSERT INTO `marks` VALUES 
(2,'Velit fuga nihil molestias velit corporis sed.',1,1,19),
(5,'Fuga vero eum odit laudantium occaecati cupiditate quia.',2,2,21),
(5,'Quod est eligendi earum odit qui.',3,3,32),
(2,'Vel maiores numquam iusto et qui qui iste.',4,4,43),
(5,'Consectetur asperiores omnis ipsum iure quo ipsam cupiditate.',5,5,54),
(1,'Repellendus deserunt alias sed sunt.',6,6,65),
(1,'Doloribus qui tempora laudantium ut porro ratione.',7,7,76),
(4,'Ratione nulla omnis sed dicta labore.',8,8,87),
(5,'Voluptatem sed sit optio ex eius ipsum eaque.',9,9,90),
(3,'Ut vitae corporis et debitis rerum.',10,10,18),
(5,'Culpa harum quae asperiores animi.',11,11,17),
(5,'Dolorem tenetur rerum consequuntur.',12,12,16),
(2,'Labore eum velit quas laborum sit qui.',13,13,91),
(5,'Ipsam officia eum ipsam eum.',14,14,92),
(1,'Quo architecto dolor fuga veritatis in rerum eveniet.',15,15,93),
(2,'Quas totam aut voluptatibus distinctio.',16,7,16),
(5,'Cumque aliquid iure est et ducimus itaque aut.',17,7,17),
(3,'Architecto commodi eveniet delectus reiciendis.',18,8,18),
(1,'Distinctio a sunt natus quia praesentium.',19,9,19),
(5,'Velit iusto explicabo tempore molestiae ullam non est est.',20,2,20),
(5,'Officia distinctio dolorem numquam asperiores praesentium.',21,3,21),
(4,'Debitis soluta ipsam delectus architecto et odit dolorem nihil.',22,4,22),
(5,'Nobis cumque est dolor nobis optio laudantium.',23,3,23),
(2,'Consequatur non tempora accusamus occaecati et voluptatem.',24,4,24),
(5,'Consequatur vel eum et qui distinctio fugit architecto molestias.',25,5,25),
(5,'Debitis quisquam libero ipsam asperiores alias ut.',26,8,26),
(3,'Corrupti labore alias accusamus libero rerum quia consequatur.',27,7,27),
(3,'Odit autem ut qui temporibus omnis voluptatem aut.',28,8,28),
(5,'Non voluptatum aliquam est dignissimos atque deserunt.',29,9,29),
(2,'Voluptates adipisci iste libero blanditiis esse aspernatur.',30,10,30),
(1,'Perferendis voluptas aut porro est velit ea ut voluptas.',31,11,31),
(5,'Expedita ipsum assumenda omnis voluptatem reiciendis.',32,12,32),
(5,'Quisquam voluptate qui autem.',33,13,33),
(3,'Placeat qui sed laborum ut eum aspernatur rerum.',34,14,34),
(5,'Voluptates laborum dolores exercitationem voluptate vel et voluptatibus.',35,15,35),
(4,'Et molestiae esse est aut sed.',36,9,36),
(2,'Id dolorem quibusdam pariatur quia eum aut nesciunt corrupti.',37,10,37),
(5,'Nemo occaecati minus modi et.',38,11,38),
(5,'Iusto reprehenderit delectus aut aut odio.',39,12,39),
(5,'Perspiciatis qui in consequatur deserunt placeat deleniti.',40,4,40),
(3,'Nostrum hic aut eos.',41,4,41),
(1,'Eveniet nihil et ut praesentium culpa.',42,2,42),
(5,'Doloremque odio voluptatem omnis corporis.',43,3,43),
(5,'Et qui dolores qui quasi.',44,4,44),
(5,'Maiores molestiae qui in dolorem.',45,5,45),
(5,'Temporibus maiores est illo.',46,6,46),
(1,'Porro distinctio doloremque ducimus accusamus maiores maiores maiores.',47,7,47),
(5,'Officia laudantium quia eveniet nulla similique.',48,4,48),
(2,'Quis excepturi sed dolorem laborum.',49,9,49),
(5,'Natus cumque velit velit.',50,5,50),
(3,'Dolor est omnis eaque consequatur iusto illum harum magnam.',51,11,51),
(4,'Id ea ut qui odit id error.',52,12,52),
(2,'Est eos repellendus nisi corrupti recusandae delectus praesentium rerum.',53,13,53),
(5,'Aut aliquam omnis voluptatem commodi esse.',54,14,54),
(5,'Nisi magnam error inventore.',55,15,55),
(5,'Numquam est a placeat sed eum vero nihil sed.',56,15,56),
(5,'Quia eum nihil non veniam sit incidunt id.',57,7,57),
(2,'Error cum mollitia dolores nobis.',58,8,58),
(5,'Reiciendis quam voluptates non maiores ut perspiciatis.',59,9,59),
(2,'Nisi fugiat consectetur facilis iusto ducimus repellat reiciendis.',60,6,60),
(4,'Earum reprehenderit molestias itaque voluptatibus in in.',61,1,61),
(5,'Architecto eos aperiam in ad molestiae.',62,2,62),
(5,'Corrupti exercitationem voluptas ullam et dolores minima non.',63,3,63),
(5,'Consequatur voluptatem odio esse aliquam dolorem delectus sed.',64,4,64),
(4,'Atque totam id amet quam vel corrupti.',65,5,65),
(5,'Voluptatibus dolore natus fugit illo et.',66,6,66),
(5,'Eos molestias numquam sint dolore quidem odio.',67,7,67),
(5,'Qui impedit cupiditate a modi debitis asperiores sit beatae.',68,8,68),
(5,'Non saepe voluptatem voluptatibus porro autem.',69,9,69),
(3,'Aut occaecati aliquam ad aut at praesentium corrupti.',70,7,70);


UPDATE profiles SET gender='f';
UPDATE profiles SET gender='m' WHERE (user_id%3=0) OR (user_id%5=0);
INSERT INTO `users` VALUES (888,'TEST','00000000','berniece03@example.net','2018-04-12 13:37:54');

-- хранимые процедуры/триггеры

DELIMITER //
CREATE TRIGGER tr_password_hash_insert BEFORE INSERT ON `pioner-online`.users
    FOR EACH ROW 
    BEGIN
		SET NEW.password_hash = MD5(NEW.password_hash);	
    END//​
DELIMITER ;


DELIMITER //
CREATE TRIGGER tr_password_hash_update BEFORE UPDATE ON `pioner-online`.users
    FOR EACH ROW 
    BEGIN
		SET NEW.password_hash = MD5(NEW.password_hash);	
    END//​
DELIMITER ;


DROP PROCEDURE IF EXISTS CHECK_ACTUAL_COURSE;
DELIMITER //
CREATE PROCEDURE CHECK_ACTUAL_COURSE (key_date DATE)
	BEGIN
		DECLARE i INT;
		DECLARE course_updated_at DATE;
		SET i = (SELECT MAX(id) FROM courses);
		WHILE i > 0 DO
			SET course_updated_at = (SELECT updated_at FROM courses WHERE id = i);
			IF (course_updated_at < key_date) THEN 
				UPDATE courses SET status='archive' WHERE id=i;
			END IF;
			SET i = i-1;
		END WHILE;
	END//
DELIMITER ;

-- функции

DROP FUNCTION IF EXISTS `transfer`
DELIMITER //
CREATE FUNCTION `transfer` (student_id INT, new_group INT)
RETURNS VARCHAR(50) DETERMINISTIC
	BEGIN
		DECLARE `result` VARCHAR(50);
		IF (SELECT group_id FROM users_groups WHERE student = student_id) = new_group THEN
		SET `result` = 'Студент уже в этой группе';
		ELSE 
		UPDATE users_groups SET group_id=new_group WHERE student=student_id;
		SET `result` = CONCAT('Студент переведён в группу', ' ', new_group);
		END IF;
		RETURN (`result`);
	END//
DELIMITER ;

SELECT transfer(81, 3);

-- представления

CREATE OR REPLACE VIEW `teachers` AS
	SELECT profiles.user_id, firstname, lastname, courses.course_name 
	FROM profiles JOIN courses 
	ON profiles.user_id = courses.user_id 
	ORDER BY firstname;


CREATE OR REPLACE VIEW `top_10_students` AS
	SELECT CONCAT(firstname,' ', lastname) AS student, 
		   AVG(marks.mark) AS avg_mark 
	FROM profiles JOIN marks 
	ON profiles.user_id = marks.student 
	GROUP BY student 
	ORDER BY avg_mark DESC 
	LIMIT 10;


CREATE OR REPLACE VIEW `count_student_group` AS 
	SELECT group_name,
		   COUNT(group_id) AS count_student
	FROM `groups` JOIN users_groups
	ON `groups`.id = users_groups.group_id
	GROUP BY group_name
	ORDER BY group_name;

-- скрипты характерных выборок

-- подборка групп на открытых курсах
SELECT g.group_name AS 'Название группы',
	   c.course_name AS 'Название курса'
FROM `groups` g JOIN courses c
ON g.course_id = c.id
WHERE c.status = 'open';

-- количество проверенных ДЗ
SELECT taskname AS 'Название задания',
	   (SELECT COUNT(mark) FROM marks m WHERE m.task_id = tasks.id) AS 'Количество проверенных заданий'
FROM tasks
ORDER BY taskname;

-- количество курсов у каждого педагога
SELECT DISTINCT CONCAT(t.firstname,' ', t.lastname) AS teacher,
	   (SELECT COUNT(c.user_id) FROM courses c WHERE c.user_id = t.user_id) AS 'Количество курсов'
FROM teachers t
ORDER BY teacher;

-- задания по каждому курсу
SELECT c.course_name,
	   (SELECT DISTINCT CONCAT(t.firstname,' ', t.lastname) FROM teachers t WHERE t.user_id = c.user_id) AS teacher,
		ts.taskname
FROM courses c
RIGHT JOIN tasks ts
ON c.id = ts.course_id
ORDER BY c.course_name;

	   






