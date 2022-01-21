-- Описание БД
/*
 База данных pioner-online создана в качестве курсового проекта для курса "Основы реляционных баз данных.MySQL". 
 Практическое применение - сохранение информации с портала "ПИОНЕР-ОНЛАЙН".
 
 Структура БД
 Таблицы
	 Таблица "users" - "пользователи" содержит следующие поля:
	 id - первичный ключ;
	 login - уникальный логин;
	 password_hash - хэшируемый триггером пароль;
	 email - уникальный email;
	 created_at - дата создания;
	 Индексация по login и email.
	 
	 Таблица "media_types" - "типы медиа" содержит следующие поля:
	 id - первичный ключ;
	 name - название;
	 specification  - описание;
	 Индексация по name.
	 
	 Таблица "media" - "медиа" содержит следующие поля:
	 id - первичный ключ;
	 filename - название файла;
	 media_type_id - тип медиа;
	 user_id - id пользователя;
	 created_at  - дата создания;
	 size - размер;
	 Индексация по filename;
	 Внешние ключи: media_type_id на media_types(id), user_id на users(id).
	 
	 Таблица "profiles" - "профили" содержит следующие поля:
	 user_id - id пользователя;
	 firstname - имя польователя;
	 lastname - фамилия пользователя;
	 city - город;
	 country  - страна;
	 about_profile - общая информация;
	 avatar - картинка-аватарка;
	 gender - пол;
    	 birthday - дата рождения;
    	 Индексация по firstname&lastname;
  	 Внешние ключи: media_id на media(id), user_id на users(id).
  	 
  	 Таблица "courses" - "курсы" содержит следующие поля:
  	 id - первичный ключ;
	 course_name - название курса;
	 user_id - id пользователя, создавшего курс;
	 duration - продолжительность;
	 specification - описание;
	 orientation - направленность;
	 status - состояние;
  	 Индексация по course_name;
  	 Внешние ключи: user_id на users(id);
  	 Проверки: status и orientation.
  	 
  	 Таблица "media_courses" - "медиа, используемые на курсах" содержит следующие поля:
  	 media_id - ;
  	 course_id - ;
  	 Внешние ключи: media_id на media(id), course_id на course(id);
  	 
  	 Таблица "groups" - "группы" содержит следующие поля:
  	 
  	 
  	 
  	 
  	 
  	 
  
 */
