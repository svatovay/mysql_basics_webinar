
-- task_6_1
USE vk;

SELECT 
(SELECT firstname FROM users WHERE id = from_user_id) AS fisrtname,
(SELECT lastname FROM users WHERE id = from_user_id) AS lastname,
COUNT(id) as cnt_msg
FROM messages
  WHERE (from_user_id = 1 AND 
  	to_user_id IN (
  		SELECT initiator_user_id FROM friend_requests WHERE (target_user_id = 1) AND status='approved'
  		union
  		SELECT target_user_id FROM friend_requests WHERE (initiator_user_id = 1) AND status='approved'))
  OR (to_user_id = 1 AND 
  	from_user_id IN (
  		SELECT initiator_user_id FROM friend_requests WHERE (target_user_id = 1) AND status='approved'
  		union
  		SELECT target_user_id FROM friend_requests WHERE (initiator_user_id = 1) AND status='approved'))
GROUP BY from_user_id
ORDER BY cnt_msg DESC LIMIT 1; -- вывод пользователя с максимальным количеством сообщений нашему пользователю

-- task_6_2
USE vk;

-- first variant
SELECT user_id,
(SELECT firstname FROM users WHERE id = user_id) AS fisrtname,
(SELECT lastname FROM users WHERE id = user_id) AS lastname,
(SELECT TIMESTAMPDIFF(YEAR, birthday, NOW()) FROM profiles WHERE profiles.user_id = likes.user_id) AS age,
COUNT(id) AS cnt_likes
FROM likes 
WHERE user_id IN (SELECT user_id FROM profiles WHERE TIMESTAMPDIFF(YEAR, birthday, NOW()) < 10)
GROUP BY id;

-- second variant
SELECT COUNT(id) AS cnt_likes from likes WHERE user_id IN (SELECT user_id FROM profiles WHERE TIMESTAMPDIFF(YEAR, birthday, NOW()) < 10);

-- task_6_3
USE vk;




