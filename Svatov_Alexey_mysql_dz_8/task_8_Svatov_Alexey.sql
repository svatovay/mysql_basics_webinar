-- task_8_1
USE vk;

SELECT
 (SELECT CONCAT (u.firstname,' ', u.lastname) FROM users u WHERE id = from_user_id) AS fullname,
 COUNT(*) AS cnt_of_messages 
  FROM messages m
    JOIN friend_requests fr ON 
    	(fr.initiator_user_id = m.from_user_id AND fr.target_user_id =1)
    	OR 
    	(fr.target_user_id = m.from_user_id AND fr.initiator_user_id =1) 
  WHERE fr.status = 'approved' AND m.to_user_id =1
GROUP BY m.from_user_id
ORDER BY cnt_of_messages DESC;

 
-- task_8_2
USE vk;

SELECT
 (SELECT CONCAT (u.firstname,' ', u.lastname) FROM users u WHERE id = l.user_id) AS fullname,
 COUNT(id) AS cnt_likes
  FROM likes l
   JOIN profiles p ON
        l.user_id = p.user_id 
  WHERE TIMESTAMPDIFF(YEAR, p.birthday, NOW()) < 11
GROUP BY id;

-- task_8_3
USE vk;

SELECT
 p.gender,
 COUNT(id) AS cnt_likes
  FROM likes l
   JOIN profiles p ON l.user_id = p.user_id
GROUP BY p.gender;


