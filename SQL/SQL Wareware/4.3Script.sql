/*4.3 Obtener la lista de los 10 usuarios activos (name, handle) 
que son los que tienen menos skills registrados, ordenados de menor a mayor. Ejemplo: 
name, handle, email, count_skills
Agustín Ramos, @MachinesAreUs, agustin@bunsan.io, 1
Amir Orbe, @AmirOrbe, amir.orbe@bunsan.io, 2
Juan Galicia, @ga_c, juan.galicia@bunsan.io, 4*/

select users.name, users.handle, users.email, count(skill_id)as count_skills  from user_skills inner join 
users on user_skills.user_id = users.id  group by users.name, users.handle, users.email  
order by count_skills, users.name limit 10;