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



-- task_6_3
USE vk;



