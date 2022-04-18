/*4.5 En base a las asignaciones vigentes en marzo y considerando que cada día laborable 
 * (lun-vie) es de 8 hrs, calcular el total de horas trabajadas durante marzo por todos los usuarios.*/

select (count(name)* 8 * (select count(days) from generate_series(DATE '2022-03-01', DATE '2022-03-31', '1 DAY'::INTERVAL) DAYS 
where extract('ISODOW' from days)<6))as Horas_Totales_Trabajadas_Marzo from users ;
