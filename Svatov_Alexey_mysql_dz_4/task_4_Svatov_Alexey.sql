-- task_4_1

USE vk;

/*
users
media_types
media
photo_albums
communities
users_communities
photos
products
notes
likes
stickers
profiles
messages
friend_requests
 */

INSERT INTO `communities` VALUES
('1', 'voluptatem', '51'),
('2', 'quisquam', '52'),
('3', 'maxime', '53'),
('4', 'quo', '54'),
('5', 'reiciendis', '57'),
('6', 'ea', '58'),
('7', 'consequatur', '60'),
('8', 'et', '61'),
('9', 'quia', '63'),
('10', 'cumque', '65'),
('11', 'ut', '67'),
('12', 'molestiae', '68'),
('13', 'impedit', '70'),
('14', 'iure', '73'),
('15', 'laborum', '75'),
('16', 'necessitatibus', '79'),
('17', 'repellendus', '84'),
('18', 'odit', '87'),
('19', 'eum', '88'),
('20', 'sunt', '90'),
('21', 'natus', '91'),
('22', 'et', '92'),
('23', 'nobis', '93'),
('24', 'minus', '94'),
('25', 'ut', '96'),
('26', 'consectetur', '97'),
('27', 'totam', '51'),
('28', 'voluptatum', '52'),
('29', 'sunt', '53'),
('30', 'iure', '54')
;

INSERT INTO `friend_requests` VALUES
('51', '52', 'unfriended', '2000-07-21 18:21:45', '1996-03-02 16:33:53'),
('52', '53', 'requested', '1970-05-24 21:15:24', '2000-11-07 23:50:57'),
('53', '54', 'declined', '1997-01-17 23:16:27', '1989-10-16 14:49:16'),
('54', '57', 'approved', '1990-04-25 07:05:00', '1992-10-16 00:58:04'),
('57', '58', 'requested', '1976-01-09 19:20:20', '1977-11-11 12:43:42'),
('58', '60', 'approved', '1985-09-08 11:22:02', '1974-03-24 22:34:23'),
('60', '61', 'requested', '1983-03-05 20:56:49', '2018-12-08 08:03:21'),
('61', '63', 'approved', '2015-07-11 21:09:15', '2006-09-08 13:50:30'),
('63', '65', 'declined', '2000-05-06 14:53:19', '1990-02-09 06:44:49'),
('65', '67', 'unfriended', '1978-06-28 17:16:42', '1992-11-05 08:54:39'),
('67', '68', 'declined', '1981-06-10 06:20:07', '2002-12-24 03:04:31'),
('68', '70', 'declined', '1999-01-05 01:38:49', '2010-07-04 20:15:06'),
('70', '73', 'declined', '2003-11-18 06:59:24', '2001-12-15 21:50:31'),
('73', '75', 'declined', '1985-06-12 07:47:53', '2016-12-12 11:30:14'),
('75', '79', 'unfriended', '2003-08-16 06:18:58', '2012-08-16 15:57:15'),
('79', '84', 'requested', '2011-04-02 00:07:10', '1990-02-20 08:05:42'),
('84', '87', 'declined', '2010-03-02 19:40:54', '1989-09-16 04:42:54'),
('87', '88', 'declined', '2017-08-20 15:38:46', '1982-09-19 01:59:05'),
('88', '90', 'approved', '1995-06-19 12:03:38', '1987-02-13 23:24:30'),
('90', '91', 'requested', '2004-04-15 20:36:24', '1979-09-07 16:55:51'),
('91', '92', 'declined', '1989-10-26 20:11:44', '1996-10-04 14:00:01'),
('92', '93', 'approved', '1984-09-20 00:25:19', '2016-03-31 12:17:50'),
('93', '94', 'requested', '2016-09-26 02:49:19', '1991-04-15 02:19:34'),
('94', '96', 'declined', '2003-12-18 18:48:43', '1993-05-25 00:44:27'),
('96', '97', 'approved', '1999-04-14 00:52:47', '2014-04-01 07:05:07'),
('97', '51', 'declined', '2001-02-11 14:19:20', '1972-03-13 06:18:55')
;

INSERT INTO `likes` VALUES
('1', '51', '1', '2018-04-08 03:53:54'),
('2', '52', '2', '2005-01-27 00:05:36'),
('3', '53', '3', '1981-06-15 19:51:45'),
('4', '54', '4', '2011-08-24 16:50:22'),
('5', '57', '5', '2018-10-23 08:01:07'),
('6', '58', '6', '1993-08-28 03:49:29'),
('7', '60', '7', '2017-10-03 17:33:38'),
('8', '61', '8', '1992-04-18 11:51:41'),
('9', '63', '9', '1970-12-21 11:26:31'),
('10', '65', '10', '1993-04-13 09:26:03'),
('11', '67', '11', '1997-09-03 05:36:47'),
('12', '68', '12', '1980-12-26 02:28:17'),
('13', '70', '13', '2019-09-24 02:52:14'),
('14', '73', '14', '1976-05-01 19:36:58'),
('15', '75', '15', '2020-05-19 16:55:28'),
('16', '79', '16', '1988-11-26 23:32:44'),
('17', '84', '17', '1999-11-02 00:23:23'),
('18', '87', '18', '1990-07-05 09:39:34'),
('19', '88', '19', '1982-03-28 05:12:01'),
('20', '90', '20', '1987-07-26 11:49:11')
;

INSERT INTO `media` VALUES 
('1', '1', '51', 'Ex cumque quas ipsam dolore et eius sit. Sed aperiam aut fugiat officiis distinctio. Et vel voluptatem necessitatibus.', 'rerum', 0, NULL, '1997-09-10 17:12:43', '2009-02-05 07:29:46'),
('2', '2', '52', 'Dolores vel doloribus consectetur quasi et sequi omnis. Praesentium quae magnam a. Aut molestiae rerum molestiae voluptates temporibus.', 'exercitationem', 92103, NULL, '2015-04-03 05:34:58', '1982-01-06 02:24:50'),
('3', '3', '53', 'Qui tenetur culpa ipsa iste. Sunt ullam dignissimos esse assumenda. Vitae nihil praesentium impedit et iusto. Pariatur itaque qui voluptatem consequatur nobis cum.', 'sit', 2470259, NULL, '2015-05-15 15:50:32', '1999-11-30 20:14:08'),
('4', '4', '54', 'Velit voluptas animi porro incidunt dolores dicta veniam. Voluptas exercitationem quo quae sed impedit possimus. Dicta dignissimos numquam qui consequuntur. Et dicta tempora dolorem reprehenderit beatae magnam.', 'dolor', 73141554, NULL, '1999-08-24 17:41:22', '2021-11-21 01:43:05'),
('5', '5', '57', 'Sit qui magni officia libero numquam. Repellat unde dolores laborum ea occaecati fugit consequatur.', 'consectetur', 2, NULL, '2018-05-28 23:32:01', '1981-07-22 14:17:15'),
('6', '6', '58', 'Magnam minima consectetur doloremque qui omnis vel et. Velit qui tenetur blanditiis est recusandae cupiditate labore qui. Odio nostrum repudiandae fugit optio corrupti aut eum in.', 'libero', 158391678, NULL, '2000-05-28 13:50:24', '1972-12-13 09:24:34'),
('7', '7', '60', 'Nostrum beatae voluptates accusantium et consequatur non delectus. Velit dolorem dolorem est ut delectus necessitatibus et. Omnis eos quaerat repellendus nostrum laborum facere dolorem.', 'omnis', 459469100, NULL, '2003-06-17 21:20:52', '1971-04-02 10:39:47'),
('8', '8', '61', 'Qui voluptates quam provident officiis distinctio. Sed laudantium laudantium qui. Quo dolorum vitae et delectus eaque molestiae. Sit quo natus ab aliquam.', 'omnis', 80, NULL, '2004-12-13 23:11:17', '1988-12-22 20:33:59'),
('9', '9', '63', 'Fuga temporibus natus sint ea occaecati ut ipsum. Nemo natus quo sed quos consequatur ut. Quibusdam atque qui temporibus qui eligendi. Et ut perferendis voluptates consequatur sunt alias. Atque neque culpa unde recusandae aut voluptas molestias.', 'architecto', 2165, NULL, '1973-09-08 20:50:29', '1976-12-30 14:58:08'),
('10', '10', '65', 'Voluptatibus ipsa sapiente dolorum neque. Magnam qui accusamus et aut dicta atque accusamus. Mollitia voluptatem nihil et quis quo repellendus asperiores fugit. Nulla ullam odio earum veniam quia.', 'recusandae', 0, NULL, '1972-01-26 01:55:10', '1971-09-27 08:39:08'),
('11', '11', '67', 'Eius aspernatur ut iusto. Vel rerum quod voluptas iusto qui blanditiis. Sunt quia maxime alias et maxime provident reprehenderit. Quod error praesentium est quod. Consequatur magni et consequuntur sit.', 'enim', 15, NULL, '1991-03-01 03:16:40', '1998-12-22 19:38:33'),
('12', '12', '68', 'Facere nostrum ea quidem ea eaque qui molestiae aut. Atque et ut autem.', 'cupiditate', 6378, NULL, '2021-01-17 15:57:37', '1988-07-01 14:35:03'),
('13', '13', '70', 'Aperiam est est et corrupti porro dolore. Voluptatem quidem ullam qui nemo reprehenderit consequatur. Placeat quibusdam molestias placeat atque porro. Excepturi eaque fugit sit autem ad eos delectus qui. Omnis provident repellendus commodi quas.', 'eos', 74221045, NULL, '1984-02-18 04:40:55', '2021-03-02 17:56:24'),
('14', '14', '73', 'Aut dolore voluptatem accusantium unde fugit eaque nisi velit. Hic vitae commodi voluptatem dolor at quia. Repudiandae in voluptas fuga. Cumque sit aperiam consectetur nulla quaerat deleniti.', 'aut', 19184, NULL, '1982-01-15 07:33:01', '2015-08-20 10:53:32'),
('15', '15', '75', 'Id est deserunt numquam illum alias. Animi deserunt et rem delectus quaerat. Error beatae quae eum minus.', 'quam', 9, NULL, '2018-11-04 16:23:11', '1988-12-11 15:45:52'),
('16', '16', '79', 'Est sed aut corporis rerum est distinctio error qui. Qui quasi porro non voluptas non doloribus dolor. Et recusandae non consequatur eius. Culpa facilis sed odio iure. Inventore vitae repudiandae provident dicta.', 'assumenda', 13537494, NULL, '2015-04-05 22:53:02', '1994-01-19 00:24:53'),
('17', '17', '84', 'Qui recusandae velit velit ad quidem. Voluptatem fugit enim dolores repellat voluptatibus. Eius nihil enim facilis commodi. Qui maiores odio accusamus vel ullam.', 'ut', 764006617, NULL, '1979-04-19 05:42:52', '1977-11-26 01:10:37'),
('18', '18', '87', 'Libero vel et mollitia. Laudantium omnis culpa quis. Quis provident sunt laborum exercitationem ratione et exercitationem. Distinctio voluptatem nihil qui earum est sed.', 'voluptatum', 34090, NULL, '1997-02-14 18:39:05', '2007-11-07 08:43:28'),
('19', '19', '88', 'Aut nesciunt illo non esse. Et ducimus non consectetur voluptas harum. Corrupti eum mollitia eum molestias. Qui cumque et delectus qui incidunt.', 'quos', 0, NULL, '2016-06-01 06:06:30', '1979-03-03 04:52:22'),
('20', '20', '90', 'Sed distinctio inventore consequatur id non. Quis ad sequi dolore sit doloribus. Id dolorem repellendus ad aliquid nesciunt aut repellat.', 'quod', 8823, NULL, '1980-07-16 09:12:23', '2001-06-28 22:29:47'),
('21', '1', '91', 'Minima non rerum et et ut. Quia suscipit accusantium explicabo nisi. Eius dolor quas eligendi ea ut non. Eveniet nihil ullam sunt porro rerum ducimus.', 'consequatur', 1633, NULL, '1987-12-21 20:06:24', '2014-07-06 13:20:07'),
('22', '2', '92', 'Et temporibus eveniet placeat sit provident blanditiis qui voluptate. Esse provident optio maiores ipsam. Molestiae voluptas tempora qui pariatur laudantium dicta nihil minima. Accusamus ad porro nisi molestiae hic.', 'libero', 380964927, NULL, '2013-08-13 08:14:31', '1980-05-15 09:08:37'),
('23', '3', '93', 'Animi consequatur repellendus ullam et sed impedit. Quia voluptas nobis facilis dolor magnam. Commodi quod omnis dicta occaecati aliquam.', 'quia', 12, NULL, '1994-08-06 19:49:40', '1983-07-27 05:47:21'),
('24', '4', '94', 'Quam aut molestias architecto consequatur suscipit et. Consequatur fuga dicta pariatur sapiente.', 'vel', 0, NULL, '1989-04-29 22:20:37', '1978-01-19 18:12:11'),
('25', '5', '96', 'Repellendus libero ratione id voluptatem iusto minus. Iusto amet dolorum repudiandae ad fuga nisi molestiae.', 'cum', 892878, NULL, '1977-09-06 18:05:02', '2014-05-14 22:58:50'),
('26', '6', '97', 'Perferendis et blanditiis quam earum dolores. Velit incidunt enim dignissimos veritatis tempore. Aut tempore odit sed iure beatae labore.', 'tempora', 33787309, NULL, '2006-10-11 03:08:33', '1999-05-10 09:38:14'),
('27', '7', '51', 'Ducimus sint consequatur illo delectus alias corporis. Expedita debitis saepe porro qui reiciendis suscipit omnis commodi.', 'molestiae', 215, NULL, '2014-08-22 11:32:21', '1999-02-20 04:59:52'),
('28', '8', '52', 'Quisquam perferendis impedit voluptatem a sequi doloribus molestias. Modi ex rem unde expedita aut. Corrupti dolorum odit sit aut rerum ut.', 'omnis', 0, NULL, '2006-06-19 03:37:36', '1992-05-22 21:41:31'),
('29', '9', '53', 'Velit pariatur corporis quia sed saepe laudantium quis. Quasi aspernatur vero eaque qui et ut ut. Facilis deleniti culpa voluptas.', 'quibusdam', 8, NULL, '1978-03-26 18:42:48', '2021-11-08 07:02:27'),
('30', '10', '54', 'Ratione expedita quo in quia molestiae et accusamus. Velit quis veniam rem amet. Vitae placeat quia quia commodi porro. Incidunt consequuntur est ipsum perspiciatis. Vel aliquid doloribus vel ut.', 'temporibus', 6258921, NULL, '1998-10-16 23:08:10', '1971-05-19 12:12:04')
;

INSERT INTO `media_types` VALUES 
('1', 'sed', '1980-04-10 03:57:09', '1970-01-04 22:29:28'),
('2', 'aperiam', '1975-02-28 14:10:26', '2020-06-22 09:47:14'),
('3', 'pariatur', '1991-08-12 18:42:51', '1993-10-11 03:31:44'),
('4', 'magni', '1986-03-24 05:59:42', '1975-07-25 06:04:46'),
('5', 'quaerat', '1994-04-23 12:53:02', '1971-06-06 01:27:37'),
('6', 'aut', '2014-09-19 14:06:47', '1994-11-11 02:32:41'),
('7', 'suscipit', '1994-12-27 16:14:47', '1995-08-05 05:58:48'),
('8', 'deserunt', '1982-08-11 15:19:53', '2004-06-17 01:56:22'),
('9', 'nisi', '1981-05-06 22:30:02', '1999-11-27 21:48:58'),
('10', 'repellendus', '2004-06-23 23:40:16', '2019-06-18 15:53:13'),
('11', 'sed', '1972-03-21 18:47:34', '1986-02-19 12:23:26'),
('12', 'ullam', '2016-11-17 11:17:04', '1994-08-28 14:19:00'),
('13', 'vero', '1996-08-19 12:14:15', '2021-07-29 07:52:48'),
('14', 'dolores', '1988-02-07 14:14:41', '2010-06-19 16:38:37'),
('15', 'quam', '1983-04-11 14:07:21', '1986-06-10 08:24:14'),
('16', 'asperiores', '1996-04-01 18:42:03', '1982-09-24 20:25:49'),
('17', 'est', '2004-03-27 22:28:41', '2004-05-06 11:01:59'),
('18', 'tempora', '2015-03-03 04:53:59', '1979-02-02 04:37:05'),
('19', 'voluptatem', '1991-08-26 09:15:01', '2019-10-11 06:07:06'),
('20', 'quaerat', '1999-08-14 13:06:46', '1994-06-19 14:32:44')
;

INSERT INTO `messages` VALUES 
('1', '51', '51', 'Aut culpa modi quis sint aliquid dolore quidem reprehenderit. Quia exercitationem aperiam nihil ipsam voluptas nulla et. Doloribus magni excepturi non quibusdam et iusto voluptatem.', '1970-02-11 22:00:26'),
('2', '52', '52', 'Harum iste accusantium omnis voluptate quia nemo ut. Alias velit ut minus vero neque rerum.', '1980-07-24 19:49:27'),
('3', '53', '53', 'Repudiandae et quod et delectus tenetur laborum fugit. Provident nesciunt suscipit modi esse qui et qui. Alias rerum magnam aspernatur reiciendis dicta veritatis fuga omnis. Eveniet necessitatibus laborum recusandae et.', '2016-05-29 08:50:22'),
('4', '54', '54', 'Dignissimos rerum dolores molestiae nesciunt excepturi. Magni quam atque dolorem et cum dolorem voluptatem.', '1975-10-18 09:57:25'),
('5', '57', '57', 'Voluptatem et nulla exercitationem sed eaque assumenda. Totam id ut eligendi et id. Quos cumque aut odit quia asperiores adipisci. Odio in ipsa neque vel ea repellat dolor.', '1979-10-17 15:12:17'),
('6', '58', '58', 'Et quod tempora quibusdam voluptatem voluptatum et ex. Mollitia illum occaecati modi animi. Veritatis beatae et iusto in voluptatibus minus eius.', '2001-06-30 14:46:52'),
('7', '60', '60', 'Quis voluptates beatae omnis illo voluptatem quisquam ipsum quibusdam. In qui et provident.', '1980-07-26 18:19:42'),
('8', '61', '61', 'Qui perferendis earum odit consequatur. Non esse temporibus quam magni. Blanditiis odit rem laborum dolor. Rem nobis labore eaque et delectus.', '2002-08-02 05:55:01'),
('9', '63', '63', 'Sed mollitia iste ipsam est architecto. Quis possimus nam sed sunt accusantium. Aut impedit aliquam eum ducimus laudantium nulla tenetur.', '1979-02-15 13:08:25'),
('10', '65', '65', 'Minus itaque sit incidunt delectus consequatur ea id. Et quia non et nobis cum in ducimus. Quia et voluptatem illo pariatur consequatur perspiciatis. Modi commodi quos assumenda aperiam assumenda.', '2002-12-04 22:25:58'),
('11', '67', '67', 'Sunt sequi quo delectus voluptatem qui. Error voluptates dolor corporis dolorem.', '1974-06-14 13:03:01'),
('12', '68', '68', 'Sed quidem quod corrupti qui autem ratione. Quam porro provident facilis dolorum dolores repudiandae. Voluptatem voluptates nostrum et quos ea laborum.', '1992-05-19 20:21:50'),
('13', '70', '70', 'Ducimus est dolorem aliquid accusantium facilis omnis. Reiciendis voluptatem aut quo et et quod. Ipsam asperiores ea ut delectus consectetur corporis. Est minima consequatur ut quas. Earum sit tenetur sint eligendi alias.', '1992-08-28 23:08:29'),
('14', '73', '73', 'At non autem quia ut dolor dolore at. Iusto tempore velit fugit consequatur odit. Provident quia molestiae est iusto minima illum laudantium. Repellendus quia voluptas est illo libero impedit.', '1980-10-06 08:46:16'),
('15', '75', '75', 'Cumque non aliquam numquam libero rem dolorum sequi. Dolorem quo ut hic voluptatibus aut. Consequatur aut et distinctio deleniti nisi. Soluta repudiandae dolorem reiciendis voluptate est vero. Vitae saepe beatae dolores dolores earum debitis ad.', '1997-02-03 06:30:18'),
('16', '79', '79', 'Modi tempore ducimus debitis pariatur occaecati. Ex magni esse accusantium et cum.', '2016-05-27 16:00:33'),
('17', '84', '84', 'Placeat officia non harum id quam ipsam. Voluptatem quaerat dolorem repellat explicabo incidunt. Ratione aut exercitationem aut sequi et. Odio exercitationem animi explicabo ut.', '1989-02-22 00:01:00'),
('18', '87', '87', 'Mollitia nisi et eveniet qui cum perferendis. Cumque aliquid est rerum repellat illo praesentium ut veniam.', '1983-07-19 17:19:34'),
('19', '88', '88', 'Sint quia eaque laborum et. Impedit sed odit eligendi quis soluta sed itaque. Ut veniam alias maxime non et.', '1983-12-12 00:30:08'),
('20', '90', '90', 'Adipisci rem quod sint a inventore qui. Ea atque omnis explicabo distinctio temporibus. Porro facilis sunt iure voluptates. Nesciunt velit error distinctio quis alias. Quibusdam quibusdam suscipit quod.', '1993-12-14 22:33:04'),
('21', '91', '91', 'Odio sed ut commodi nobis modi quibusdam libero ducimus. Deserunt in sit id excepturi. Sed explicabo vitae itaque. Ea et qui et sunt.', '2013-10-30 19:17:39'),
('22', '92', '92', 'Omnis consequuntur voluptas nam deserunt aspernatur. Sit voluptatem quo alias delectus omnis expedita. Qui architecto pariatur qui ipsum ut soluta. Asperiores voluptas aut nisi quasi eaque quas. Et omnis nobis earum et nostrum eos.', '1985-04-16 00:20:14'),
('23', '93', '93', 'Natus nam fuga tempore quisquam aut accusantium quibusdam. Asperiores et adipisci doloremque qui veritatis autem. Cumque et harum dolor occaecati eius. Pariatur velit ab quo laudantium.', '1986-06-10 04:42:17'),
('24', '94', '94', 'Perspiciatis sed odit quis hic. Facilis id et necessitatibus nihil sint. Alias ullam atque et suscipit. Sit non qui architecto eius ut porro veniam incidunt.', '2014-02-12 15:02:24'),
('25', '96', '96', 'Voluptatem voluptas quis consequatur et earum omnis voluptas. Culpa molestiae ducimus dignissimos doloribus qui est et praesentium. Et aut autem autem incidunt iusto reiciendis quo. Consequuntur aliquam esse quod qui.', '2008-11-01 13:50:40'),
('26', '97', '97', 'Omnis veritatis veniam quasi voluptatem similique. Tempore accusantium nihil tempore dignissimos similique consectetur. Facilis praesentium eius eum est error.', '2009-02-26 10:51:53'),
('27', '51', '51', 'Veniam quasi est enim provident sunt laboriosam sunt. Provident esse voluptas dolor deserunt ducimus. Incidunt itaque ut aut minima accusantium. Laudantium asperiores consectetur adipisci reprehenderit officiis.', '1999-01-04 08:54:56'),
('28', '52', '52', 'Nam beatae ipsum quia officia totam repudiandae velit. Illo quam adipisci facere beatae suscipit velit. Quos quia ut minima soluta delectus.', '1990-06-10 04:20:16'),
('29', '53', '53', 'Consequuntur eligendi ullam iste saepe et quia. Est distinctio blanditiis quos laboriosam atque. Corporis est aliquid voluptas placeat aut. Suscipit debitis temporibus ab omnis et numquam quo.', '1985-05-17 03:19:59'),
('30', '54', '54', 'Reprehenderit dolores officia sapiente non ut molestiae. Velit ea eaque culpa tempore ipsam totam.', '1987-01-29 07:44:55'),
('31', '57', '57', 'Iure provident corporis eos consequuntur dolor excepturi. Animi eos vel quis debitis. Debitis velit distinctio id quibusdam et ipsa omnis sed.', '1976-01-26 20:15:24'),
('32', '58', '58', 'Minus sit et ea sint perspiciatis qui similique. Sunt nemo dicta magni qui voluptatum voluptas. Ipsum eveniet veniam non.', '2014-04-16 18:18:53'),
('33', '60', '60', 'Ab est tempore animi magni quidem in impedit ullam. Et eius et dolorem minima cumque. Molestiae cupiditate in maiores voluptas praesentium beatae.', '2010-01-12 11:28:17'),
('34', '61', '61', 'Ea quia eum maiores asperiores ea vel. Corporis velit qui reprehenderit ex nihil. Ut sint in esse eos officiis magnam numquam.', '2011-03-11 01:32:17'),
('35', '63', '63', 'Reprehenderit ut magnam quae et. Et voluptatem nam aperiam quia vitae est sint. Qui eum veritatis amet magni consequatur. Eligendi ea aperiam possimus sit. Beatae est magnam eum quas.', '2005-01-25 01:25:37'),
('36', '65', '65', 'Ipsum ut ab voluptates aut rem. Eveniet qui ullam unde. Dolor sunt perferendis et. Consequatur voluptates quibusdam ut.', '2014-03-28 00:41:40'),
('37', '67', '67', 'Ratione corrupti laudantium aut neque excepturi nihil quo. Dolorum quidem sed id et eos culpa consequatur. Est voluptate aperiam fuga tempore alias. Illo quia odio numquam iste cupiditate alias debitis.', '1985-08-15 02:39:15'),
('38', '68', '68', 'Qui magnam ut consequuntur totam deleniti alias et. Illum ut ut vel quaerat quia voluptates a. Qui a porro sit dolore voluptas distinctio est. Veritatis voluptate nostrum officiis deleniti quod expedita repellat. Amet facilis suscipit ut amet quam eos rerum.', '1989-01-02 23:30:26'),
('39', '70', '70', 'Quo deserunt voluptatem a sequi quia. Et aut ea accusamus debitis. Consequatur et est asperiores ipsa vero veritatis.', '1979-02-12 20:07:11'),
('40', '73', '73', 'Neque sed sequi illo aut officia cum. Quia doloribus sint qui voluptatibus maiores iusto autem. Officia et voluptas ratione quod quam consectetur distinctio et.', '2005-05-20 00:05:30'),
('41', '75', '75', 'Quasi autem voluptatem provident quam magnam. Nihil delectus ipsum omnis non. Omnis similique magni nostrum aspernatur nobis mollitia. Ut soluta sint consequatur.', '1991-02-12 13:30:07'),
('42', '79', '79', 'Possimus ipsam iste et ea et eum. Voluptatem occaecati nulla consequuntur id. Laudantium mollitia aut ut nesciunt sed vero.', '2013-05-08 03:08:23'),
('43', '84', '84', 'In iusto labore rerum earum possimus. Expedita ea fugiat qui rerum perspiciatis natus ex. Suscipit est nisi dolores consequuntur.', '1993-09-01 02:06:45'),
('44', '87', '87', 'Nobis ea sunt ea quo beatae culpa aut. Adipisci ipsum fugiat veritatis quia quisquam. Expedita quasi ducimus voluptatem incidunt voluptatem iste assumenda.', '1981-03-01 01:39:50'),
('45', '88', '88', 'Molestias dignissimos dolor iste. Incidunt provident dolore molestias omnis quidem iusto totam quae. Minima nam voluptatem corporis aspernatur commodi illo velit enim. Dolores iste nobis nihil quam inventore veniam ratione.', '2011-07-13 22:51:10'),
('46', '90', '90', 'Dolor exercitationem dignissimos beatae voluptates alias non qui. Illo in reprehenderit magnam ut optio. Perspiciatis facilis aut sit cum atque facilis. At minima perspiciatis deserunt voluptate.', '1971-11-13 02:49:08'),
('47', '91', '91', 'Doloremque molestiae amet minus aut qui vel. Aut quia aut tempore itaque omnis voluptatem magni eum. Dolore provident non totam reiciendis nobis saepe repudiandae.', '1977-08-18 17:24:01'),
('48', '92', '92', 'Officia ut eaque et eaque expedita. Dicta ducimus ipsam sed amet culpa alias perferendis libero. Aut odio nulla qui sit nobis ut. Facilis illum similique iste et quis aliquid.', '1979-07-25 18:10:44'),
('49', '93', '93', 'Et enim qui ratione laudantium. Omnis voluptas neque est facere cumque dolorem. Minima vero aut nesciunt deleniti dolorem natus. Facilis vel commodi est aut et quam aut laborum.', '1980-05-13 23:07:46'),
('50', '94', '94', 'Doloremque quo excepturi dignissimos nam alias labore. Delectus accusamus minus minus nisi architecto reiciendis id hic. Sequi eligendi aut nesciunt architecto quos sint. Dolorem facere quia voluptatem aliquam illo.', '1988-02-22 22:13:56')
;

INSERT INTO `notes` VALUES 
('1', NULL, 'Voluptatibus minima velit totam eum distinctio eligendi. Repudiandae et officia omnis vel sint. Mollitia nihil voluptatem distinctio quibusdam amet. Aliquam aut qui ipsa sint ut doloribus. Consequuntur soluta rem et repellendus quidem adipisci.', '1993-03-24 18:42:43', '1'),
('2', NULL, 'Distinctio et dicta ut nisi sed. Repellendus eaque distinctio dolor aut est quisquam. Mollitia similique ipsam cumque dolores atque temporibus. Temporibus ea mollitia illo molestiae ea quia maxime.', '2012-01-07 03:19:13', '2'),
('3', NULL, 'Id officia fugiat accusantium in autem. Et voluptatem in molestiae pariatur et odit rerum. Maxime modi accusamus voluptate error nostrum.', '1979-08-04 23:25:54', '3'),
('4', NULL, 'Cum modi nihil in. Totam vel sit maiores officiis reprehenderit veritatis. Voluptatem vitae nostrum unde soluta et earum. Cupiditate culpa sed laudantium hic magnam voluptatum.', '1987-01-10 09:31:31', '4'),
('5', NULL, 'Velit dicta numquam autem iure. Laudantium magnam eos nemo iusto totam. Suscipit consectetur enim odio cum autem eos aut. Voluptas et sint aut aut non vel.', '2005-02-07 16:33:30', '5'),
('6', NULL, 'Nisi dignissimos exercitationem nobis corporis sit. Temporibus labore dolores voluptatem doloremque. Dicta voluptatem quod ut consequuntur aut amet libero. Dicta aut ut dolore ut.', '1997-04-08 00:35:13', '6'),
('7', NULL, 'Et quos delectus dignissimos ut repudiandae possimus. Debitis minima doloribus sapiente aliquid id alias. Ipsa rerum enim enim aperiam qui et. Aut perferendis officiis quia dolorem architecto consequatur assumenda.', '1990-04-05 05:16:50', '7'),
('8', NULL, 'Earum totam dolorem doloribus quia dolor voluptas. Sit rem culpa numquam ipsum. Soluta ut quos id corrupti sint.', '2017-02-03 01:34:19', '8'),
('9', NULL, 'Velit libero saepe expedita corporis et harum. Unde ea nobis unde libero eaque minima. Voluptate quidem dolorem et omnis commodi harum assumenda.', '1997-09-02 13:08:09', '9'),
('10', NULL, 'Quasi possimus aliquid cumque mollitia quaerat accusamus iure. Est earum delectus reprehenderit recusandae optio illo. Vel cupiditate nostrum incidunt molestiae. Sed neque velit dolor magni vitae fugiat.', '2008-07-27 04:39:08', '10'),
('11', NULL, 'Rem occaecati deserunt eaque ut assumenda ut minus. Culpa sed eos corrupti voluptatem aut sapiente veniam. Sed qui doloremque perspiciatis repudiandae ea. Suscipit nostrum magni labore cumque ut.', '1980-06-12 09:54:47', '11'),
('12', NULL, 'Modi qui repellat alias. Sunt non reprehenderit corrupti magni quia. Inventore animi nihil sit suscipit rerum harum incidunt. Corrupti beatae numquam voluptas excepturi cumque sunt sed.', '1981-03-03 00:28:44', '12'),
('13', NULL, 'Odio necessitatibus amet quisquam blanditiis ipsum voluptates et. Iste tenetur dolores repellendus ea dolorem. Iusto vel veniam placeat corporis natus.', '1978-06-06 19:39:03', '13'),
('14', NULL, 'Similique sed porro et aut et. Explicabo eveniet quia qui aliquid molestias sunt eum. Tempore repudiandae voluptatem porro.', '1997-03-22 10:38:39', '14'),
('15', NULL, 'Corporis asperiores aliquam et modi impedit sit. Rerum molestias deleniti et. Dolorem aliquam quo omnis vero. Fugiat deserunt sit a sapiente rerum. Eos quisquam saepe distinctio et ad aut nisi quis.', '1980-04-01 02:36:26', '15'),
('16', NULL, 'Est blanditiis iusto alias error facilis. Aliquid aspernatur rerum qui in. Sed est dolor ut ut asperiores quod officia. Temporibus aut hic deserunt quam deleniti est.', '2012-12-17 05:45:42', '16'),
('17', NULL, 'Et atque consequatur aliquam optio debitis qui saepe est. Doloribus excepturi atque doloribus voluptas voluptatem. Nam qui officia et non accusantium veniam et. Repellat sed consequatur commodi animi minima et.', '2019-06-05 04:16:20', '17'),
('18', NULL, 'Eos porro molestiae quam reprehenderit. Aut rerum voluptatem omnis laudantium. Sunt sed porro ut deleniti.', '2019-09-04 08:23:02', '18'),
('19', NULL, 'Sapiente nobis pariatur nostrum rem mollitia qui. Velit tempora ab quia sequi dolorum natus est rerum. Nesciunt quod asperiores ipsum ipsum soluta eum.', '1974-08-22 07:04:35', '19'),
('20', NULL, 'Vitae et aliquid consequuntur est soluta voluptates omnis blanditiis. Rem qui et ut ducimus sit quia et. Vero voluptatem facere ut accusantium deleniti. Eligendi incidunt veritatis animi quisquam rerum.', '2003-10-03 02:51:41', '20'),
('21', NULL, 'Iste excepturi ad perferendis odit. In id voluptatem voluptatem voluptas fugiat dignissimos. Non et laudantium dolores sed aut ducimus. Impedit voluptatum eos provident modi veritatis et.', '1979-09-28 13:12:33', '21'),
('22', NULL, 'Hic commodi nesciunt et et ducimus modi ipsa. In quasi et enim aliquam et et. Id praesentium occaecati totam quas asperiores dicta quo.', '1983-03-07 08:27:54', '22'),
('23', NULL, 'Sapiente aut iure quis. Molestiae velit nesciunt saepe at exercitationem. Iure placeat et enim eveniet sed voluptatibus repellendus. Quasi qui doloribus ea eos quos distinctio autem. Quae dolor minus eius voluptas sit magnam rerum.', '1986-01-30 03:02:23', '23'),
('24', NULL, 'Quis odio alias ut natus est iure dicta. Fugiat vero nihil id assumenda provident ab natus.', '2018-06-18 01:50:06', '24'),
('25', NULL, 'Praesentium maiores fugit est distinctio. Sint aliquid eos consequatur quidem. Ex reprehenderit quia voluptatum laudantium dolore et voluptatibus. Non laboriosam dolores corrupti quibusdam.', '2005-11-05 22:29:40', '25'),
('26', NULL, 'Eos explicabo alias aliquam odio voluptas molestiae. Maxime culpa tempore voluptates magni qui totam.', '1982-02-04 03:35:05', '26'),
('27', NULL, 'Possimus beatae praesentium expedita. Assumenda est soluta id odit blanditiis eligendi et.', '2020-11-20 18:23:08', '27'),
('28', NULL, 'Numquam quisquam ea totam veniam. Sit molestias voluptatem officiis labore eligendi. Quo a ut consequatur et inventore et temporibus vel.', '1999-01-06 18:16:34', '28'),
('29', NULL, 'Optio ab tempore atque sapiente. Occaecati atque cum porro omnis sint. Commodi deserunt iusto et laborum ea.', '2021-07-22 14:12:52', '29'),
('30', NULL, 'Sit blanditiis repudiandae rem aperiam aut. Eum sint voluptas ea sequi iusto nisi voluptatem vero.', '2005-03-08 17:27:54', '30')
;

INSERT INTO `photo_albums` VALUES 
('1', 'nihil', '51'),
('2', 'ea', '52'),
('3', 'minima', '53'),
('4', 'modi', '54'),
('5', 'rerum', '57'),
('6', 'consequuntur', '58'),
('7', 'nobis', '60'),
('8', 'velit', '61'),
('9', 'corrupti', '63'),
('10', 'molestiae', '65'),
('11', 'dolor', '67'),
('12', 'et', '68'),
('13', 'facere', '70'),
('14', 'vel', '73'),
('15', 'sequi', '75'),
('16', 'eveniet', '79'),
('17', 'sed', '84'),
('18', 'et', '87'),
('19', 'tempora', '88'),
('20', 'quae', '90')
;

INSERT INTO `photos` VALUES
('1', '1', '1'),
('2', '2', '2'),
('3', '3', '3'),
('4', '4', '4'),
('5', '5', '5'),
('6', '6', '6'),
('7', '7', '7'),
('8', '8', '8'),
('9', '9', '9'),
('10', '10', '10'),
('11', '11', '11'),
('12', '12', '12'),
('13', '13', '13'),
('14', '14', '14'),
('15', '15', '15'),
('16', '16', '16'),
('17', '17', '17'),
('18', '18', '18'),
('19', '19', '19'),
('20', '20', '20')
;

INSERT INTO `products` VALUES 
('1', 'dolorem', '4912.53', '1'),
('2', 'soluta', '1652.36', '2'),
('3', 'temporibus', '99999999.99', '3'),
('4', 'ullam', '9036623.12', '4'),
('5', 'atque', '4000651.98', '5'),
('6', 'delectus', '6651942.74', '6'),
('7', 'architecto', '6895.89', '7'),
('8', 'aut', '6.04', '8'),
('9', 'et', '0.00', '9'),
('10', 'ipsa', '0.00', '10'),
('11', 'eius', '3769.67', '11'),
('12', 'pariatur', '81468.57', '12'),
('13', 'expedita', '28199305.59', '13'),
('14', 'ad', '458583.00', '14'),
('15', 'non', '467.51', '15'),
('16', 'repudiandae', '804957.58', '16'),
('17', 'eveniet', '1704414.53', '17'),
('18', 'architecto', '162794.79', '18'),
('19', 'occaecati', '53690187.09', '19'),
('20', 'nobis', '40.03', '20')
;

INSERT INTO `profiles` VALUES 
('51', NULL, '2006-08-06', '1', '1993-10-11 20:45:55', NULL),
('52', NULL, '2005-07-21', '2', '1971-06-14 08:28:28', NULL),
('53', NULL, '1987-05-05', '3', '2013-12-10 18:39:50', NULL),
('54', NULL, '2018-10-06', '4', '2011-10-15 13:10:25', NULL),
('57', NULL, '1971-10-26', '5', '2009-09-11 21:08:51', NULL),
('58', NULL, '1986-01-08', '6', '2001-01-15 19:19:07', NULL),
('60', NULL, '2012-05-19', '7', '2018-11-07 23:56:06', NULL),
('61', NULL, '2013-05-21', '8', '2011-03-14 13:49:58', NULL),
('63', NULL, '2000-02-12', '9', '2000-02-15 10:37:25', NULL),
('65', NULL, '1986-07-16', '10', '2016-11-10 17:30:35', NULL),
('67', NULL, '1992-05-24', '11', '1995-07-30 17:43:56', NULL),
('68', NULL, '1996-02-07', '12', '1992-03-20 23:42:02', NULL),
('70', NULL, '1970-07-08', '13', '2014-12-09 21:02:08', NULL),
('73', NULL, '2009-07-03', '14', '1983-05-12 12:57:25', NULL),
('75', NULL, '1998-07-21', '15', '2006-03-14 07:47:03', NULL),
('79', NULL, '2015-07-02', '16', '1984-11-01 22:38:35', NULL),
('84', NULL, '1972-04-15', '17', '2009-09-29 12:23:51', NULL),
('87', NULL, '1976-05-10', '18', '1978-08-28 16:16:23', NULL),
('88', NULL, '1977-08-16', '19', '1985-07-14 10:39:24', NULL),
('90', NULL, '2019-05-26', '20', '1986-08-05 16:09:31', NULL),
('91', NULL, '2010-10-03', '1', '2021-04-10 20:52:15', NULL),
('92', NULL, '1991-02-11', '2', '2000-01-11 10:36:24', NULL),
('93', NULL, '1984-08-15', '3', '2012-12-15 12:45:18', NULL),
('94', NULL, '2006-09-01', '4', '2013-01-16 20:30:09', NULL),
('96', NULL, '1982-12-24', '5', '1995-08-24 18:48:06', NULL),
('97', NULL, '1979-07-12', '6', '2018-05-23 09:02:39', NULL)
;

INSERT INTO `stickers` VALUES 
('1', 'itaque', '51', 418815835, '1'),
('2', 'quod', '52', 2, '2'),
('3', 'quasi', '53', 0, '3'),
('4', 'enim', '54', 995, '4'),
('5', 'harum', '57', 269477895, '5'),
('6', 'labore', '58', 23728, '6'),
('7', 'aut', '60', 92037, '7'),
('8', 'sunt', '61', 55734180, '8'),
('9', 'et', '63', 16, '9'),
('10', 'id', '65', 0, '10'),
('11', 'hic', '67', 197654453, '11'),
('12', 'magnam', '68', 24255, '12'),
('13', 'aut', '70', 522750325, '13'),
('14', 'omnis', '73', 4265902, '14'),
('15', 'sit', '75', 80809, '15'),
('16', 'aut', '79', 68, '16'),
('17', 'voluptas', '84', 848, '17'),
('18', 'nostrum', '87', 6, '18'),
('19', 'aut', '88', 22930664, '19'),
('20', 'in', '90', 0, '20'),
('21', 'quia', '91', 0, '21'),
('22', 'voluptas', '92', 3, '22'),
('23', 'voluptatibus', '93', 5, '23'),
('24', 'aut', '94', 847, '24'),
('25', 'eius', '96', 1901, '25'),
('26', 'repudiandae', '97', 649427680, '26'),
('27', 'impedit', '51', 0, '27'),
('28', 'maxime', '52', 87374244, '28'),
('29', 'voluptatem', '53', 8364008, '29'),
('30', 'dolorem', '54', 289354918, '30')
;

INSERT INTO `users` VALUES
('51', 'Jeffery', 'Renner', 'filomena.rice@example.com', 'fdd5d986a1e5c839e8835465eae8c482f524b5aa', '1'),
('52', 'Emmanuelle', 'Pouros', 'klarkin@example.com', '996806f36708c219049cfbb3a03542c2d291fdd5', '424562'),
('53', 'Sydni', 'Abernathy', 'abbigail.leannon@example.org', '590072d105ceb5a66eedb5a25f774af85ceae52f', '262'),
('54', 'Delmer', 'Schumm', 'little.akeem@example.org', '49108c757be756e075d30e10f89e110e6b386b25', '0'),
('57', 'Madalyn', 'Muller', 'clyde.dach@example.org', '7974c19dd9d64ea4afb739949bf2314676f3bfce', '194839'),
('58', 'Marilie', 'Dare', 'ardella91@example.com', '627e10e57b5095652d8bacf6d9ebdeb2bc8f1708', '824'),
('60', 'Camila', 'Boyer', 'rachelle96@example.com', '7817e5075a50322f0ffbffb33ce8fb4c15b40a35', '36838'),
('61', 'Lloyd', 'Runolfsdottir', 'mitchel03@example.org', 'e35bc77b2fe8ca4d2c45a3e144d1faeeb1457356', '893'),
('63', 'Justus', 'Dibbert', 'hveum@example.org', '69d446c8a0a411bc59a338bfe8c399600bfef588', '5010803700'),
('65', 'Maverick', 'Schroeder', 'danny99@example.net', '9fe2938900f6a1e630b7ed4e7557a6df3290c181', '857'),
('67', 'Kim', 'Erdman', 'bins.talon@example.com', '5f6e9d7f59b36f75efb406711a19eb4e95542526', '650838'),
('68', 'Moriah', 'Hickle', 'watsica.parker@example.net', 'ce0e624f76d6d950f9958ef1fdc3c14c8c9c8a9b', '205'),
('70', 'Lola', 'Stracke', 'maymie28@example.org', '46f058a258db87d3daab444e8ac9a5e4c19c532a', '952409'),
('73', 'Nicole', 'Quigley', 'vnicolas@example.net', '1f01209bbf06681f7fb90879eb8a38f0e20c2c00', '563756'),
('75', 'Julianne', 'Nolan', 'hyman34@example.net', 'd933409453bd2749099cbd8d82fa5fe0d1af4e1d', '57'),
('79', 'Rubie', 'Beatty', 'alycia68@example.org', '720c52f80aa2f25ba8a4809ce1df6f6c89d1a2e8', '296'),
('84', 'Ivah', 'Upton', 'ellis76@example.net', '95037b2e072351d2607d9aa0921f8d6a566dae97', '384'),
('87', 'Maud', 'Stamm', 'noemi.legros@example.org', '707f917febd3dac59c5cfa094db5a63eaa37e18e', '483'),
('88', 'Shakira', 'Kertzmann', 'nienow.dejah@example.org', 'be274d71bcabf55d66dcecacabce61fa8aef9a31', '999'),
('90', 'Anika', 'Anderson', 'lucinda.schmidt@example.org', '5e78358ddf4ef8f841f7cef229ea23a0c5a4842a', '901'),
('91', 'Ladarius', 'Reilly', 'ghuels@example.com', 'dbf8fbb714e13c48e0196aeccfb6e688299ebb33', '18049'),
('92', 'Tony', 'Mohr', 'gharvey@example.org', '65282d603e921d8f692ee24cc54372e352bca57c', '10'),
('93', 'Velda', 'Heathcote', 'hope.o\'reilly@example.org', '6ac81722ee231dc0672c0cd07fe8f819e7a6f2d6', '14'),
('94', 'Sydni', 'Hyatt', 'brendon.rippin@example.net', 'f8304954a1345c4ab869238fab4c73819d799567', '941'),
('96', 'Eliseo', 'Romaguera', 'mike56@example.com', '18712224a702765569cd594deb07a95f9a70a04d', '3082987955'),
('97', 'Hellen', 'Hills', 'ffahey@example.net', '024abb8c2a7c6ad793d2faba7c1c096c7b69bc3c', '738294')
;

INSERT INTO `users_communities` VALUES 
('51', '1'),
('51', '27'),
('52', '2'),
('52', '28'),
('53', '3'),
('53', '29'),
('54', '4'),
('54', '30'),
('57', '5'),
('58', '6'),
('60', '7'),
('61', '8'),
('63', '9'),
('65', '10'),
('67', '11'),
('68', '12'),
('70', '13'),
('73', '14'),
('75', '15'),
('79', '16'),
('84', '17'),
('87', '18'),
('88', '19'),
('90', '20'),
('91', '21'),
('92', '22'),
('93', '23'),
('94', '24'),
('96', '25'),
('97', '26')
;


-- task_4_2

SELECT DISTINCT firstname FROM users ORDER BY firstname;

-- task_4_3

ALTER TABLE `profiles` 
ADD COLUMN `is_active` BOOL DEFAULT TRUE 
AFTER birthday;

UPDATE `profiles` SET `is_active`=FALSE WHERE FLOOR((TO_DAYS(NOW()) - TO_DAYS(birthday))/365.25) < 18

-- task_4_4

DELETE FROM `messages` WHERE `created_at` > NOW()
