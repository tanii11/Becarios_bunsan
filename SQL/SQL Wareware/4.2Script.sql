/*4.2 Obtener la lista de usuarios (name, handle) que están activos, 
 saben elixir al menos en un nivel competent y además saben aws en cualquier nivel. 
 (Los niveles de competencia son, en orden: novice, advanced_beginner, competent, proficient, expert)*/

select users.name, users.handle  from user_skills a inner join users 
on a.user_id = users.id where users.enabled = true and (a.level in ('competent', 'proficient', 'expert') 
and a.skill_id =1) and a.user_id = (select b.user_id from user_skills b where b.skill_id  = 13 
and b.user_id = a.user_id );
