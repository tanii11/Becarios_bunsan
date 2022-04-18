/*4.1 Obtener la lista de usuarios (name, handle, email) que están activas (enabled) y
 no tienen imagen de perfil, ordenados alfabéticamente por nombre.
 */
select name, handle, email from  users where enabled = true and image is null order by name;