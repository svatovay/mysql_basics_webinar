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



-- task_8_3
USE vk;



