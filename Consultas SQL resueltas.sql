-- 2. Muestra los nombres de todas las películas con una clasificación por
-- edades de ‘R’.

SELECT "title" AS "Título_película", 
       "rating" AS "Clasificación"
FROM "film" AS f 
WHERE "rating" = 'R';

--3.Encuentra los nombres de los actores que tengan un “actor_id” 
-- entre 30 y 40.

SELECT CONCAT("first_name",' ',"last_name") AS "Nombre_actor",
       "actor_id" AS "Id_actor"
FROM "actor" AS a 
WHERE "actor_id" BETWEEN 30 AND 40 ; 

-- 4. Obtén las películas cuyo idioma coincide con el idioma original:

SELECT "title" AS "Título_película"
FROM "film" AS f
WHERE "language_id" = "original_language_id" ;

-- 5. Ordena las películas por duración de forma ascendente.

SELECT "title" AS "Título_película" , 
       "length" AS "Duración_película" 
FROM "film" AS f 
ORDER BY "length" ASC ;

-- 6. Encuentra el nombre y apellido de los actores que tengan 
-- ‘Allen’ en su apellido.

SELECT CONCAT("first_name",' ',"last_name") AS "Nombre_actor"
FROM "actor" AS a
WHERE "last_name" LIKE '%ALLEN%' ; 

-- 7. Encuentra la cantidad total de películas en cada clasificación 
-- de la tabla “film” y muestra la clasificación junto con el recuento.

SELECT 	"rating" AS "Clasificacion" ,
        COUNT("film_id") AS "Total_películas"
FROM "film" AS f 
GROUP BY "rating" ;

-- 8. Encuentra el título de todas las películas que son 
-- ‘PG-13’ o tienen una duración mayor a 3 horas en la tabla film.

SELECT "title" AS "Título_película", 
       "rating" as "Clasificación_película",
       "length" AS "Duración_película"
FROM "film" AS f 
WHERE "rating" = 'PG-13' 
OR "length" > 180;

-- 9. Encuentra la variabilidad de lo que costaría reemplazar las películas.   

SELECT ROUND(VARIANCE("replacement_cost"),2) AS "Variabilidad_reemplazo_películas"
FROM "film" AS f ;

-- 10. Encuentra la mayor y menor duración de una película de nuestra BBDD.  

SELECT MAX("length") AS "Mayor_duracion" ,
       MIN("length") AS "Menor_duracion"
FROM "film" AS f ;

-- 11. Encuentra lo que costó el antepenúltimo alquiler ordenado por día         

SELECT "payment_date" AS "Día_pago" ,
       "amount" AS "Cantidad" 
FROM "payment" AS p 
ORDER BY "payment_date" DESC 
OFFSET 2 
LIMIT 1 ;

-- 12. Encuentra el título de las películas en la tabla “film” 
-- que no sean ni ‘NC17’ ni ‘G’ en cuanto a su clasificación.

SELECT "title" AS "Título" , 
       "rating" AS "Clasificación" 
FROM "film" AS f
WHERE "rating" <> 'NC-17'
AND "rating" <> 'G' ;

-- 13. Encuentra el promedio de duración de las películas para cada 
--clasificación de la tabla film y muestra la clasificación junto 
-- con el promedio de duración.  

SELECT "rating" AS "Clasificación",
       AVG("length") AS "Promedio_duracion"
FROM "film" AS f 
GROUP BY "rating" ;

-- 14. Encuentra el título de todas las películas que tengan 
-- una duración mayor a 180 minutos.

SELECT "title" AS "Título_película" , 
       "length" AS "Duración"
FROM "film" AS f 
WHERE "length" > 180 ;

-- 15. ¿Cuánto dinero ha generado en total la empresa?

SELECT SUM("amount") AS "Dinero_generado" 
FROM "payment" AS p ;

-- 16. Muestra los 10 clientes con mayor valor de id.

SELECT "customer_id" AS "Id_cliente" ,
       CONCAT("first_name",' ',"last_name") AS "Nombre_cliente"
FROM "customer" AS c
ORDER BY "customer_id" DESC
LIMIT 10 ; 

-- 17. Encuentra el nombre y apellido de los actores que aparecen 
-- en la película con título ‘Egg Igby’.

SELECT CONCAT("first_name",' ',"last_name") AS "Nombre_actores"
FROM "actor" AS a 
INNER JOIN "film_actor" AS fa 
ON a."actor_id" = fa."actor_id" 
INNER JOIN "film" AS f
ON fa."film_id" = f."film_id"
WHERE "title" = 'EGG IGBY' ;

-- 18. Selecciona todos los nombres de las películas únicos

SELECT DISTINCT "title" AS "Títulos_películas"
FROM "film" AS f ;

-- 19. Encuentra el título de las películas que son comedias
-- y tienen una duración mayor a 180 minutos en la tabla “film”.

SELECT "title" AS "Título_película"
FROM "film" AS f 
INNER JOIN "film_category" AS fc 
ON f."film_id" = fc."film_id" 
INNER JOIN "category" AS c 
ON fc."category_id" = c."category_id" 
WHERE c."name" = 'Comedy'
AND f."length" > 180;

-- 20. Encuentra las categorías de películas que tienen un promedio 
-- de duración superior a 110 minutos y muestra el nombre de la 
-- categoría junto con el promedio de duración.

SELECT c."name" AS "Categoría_película" , 
       AVG("length") AS "Duración_promedio"
FROM "film" AS f
INNER JOIN "film_category" AS fc 
ON f."film_id" = fc."film_id" 
INNER JOIN "category" AS c 
ON fc."category_id" = c."category_id" 
GROUP BY c."name" 
HAVING AVG(f."length") > 110 ;

-- 21. ¿Cuál es la media de duración del alquiler de las películas?

SELECT ROUND(AVG("rental_rate"), 2) AS "Media_alquiler"
FROM "film" AS f ;

-- 22. Crea una columna con el nombre y apellidos de todos los actores y actrices.

SELECT CONCAT("first_name",' ', "last_name")  AS "Nombre_actores"
FROM "actor" AS a ;

-- 23. Números de alquiler por día, ordenados por cantidad de alquiler de
-- forma descendente.

SELECT "rental_date" AS "Alquiler_día",
       COUNT("rental_date") AS "total_alquileres"
FROM "rental" AS r 
GROUP BY "rental_date"
ORDER BY "total_alquileres" DESC ;

-- 24. Encuentra las películas con una duración superior al promedio.

SELECT "title" AS "Título_película",
       "length" AS "Duración" 
FROM "film" AS f 
WHERE "length" > (
		  SELECT AVG("length")
	          FROM "film" AS f2) ; 

-- 25. Averigua el número de alquileres registrados por mes.

SELECT COUNT(*) AS "Total_alquileres" , 
       EXTRACT (MONTH FROM "rental_date") AS "Mes" ,
       EXTRACT (YEAR FROM "rental_date") AS "Año" 	
FROM "rental" AS r 
GROUP BY "Mes" , "Año"
ORDER BY "Mes" , "Año" ;

-- 26.Encuentra el promedio, la desviación estándar y varianza
-- del total pagado.

SELECT ROUND(AVG("amount"),2) AS "Promedio_pagado" ,  
       ROUND(STDDEV("amount"),2) AS "Desviación_estándar_pagado" , 	
       ROUND(VARIANCE("amount"),2) AS "Varianza_pagado"
FROM "payment" AS p ;

-- 27. ¿Qué películas se alquilan por encima del precio medio?

SELECT "title" AS "Título_pelicula",
       "rental_rate" AS "Tarifa_alquiler"
FROM "film" AS f 
WHERE "rental_rate" > (SELECT AVG("rental_rate") 
		       FROM "film" AS f2 ) ;

-- 28. Muestra el id de los actores que hayan participado 
-- en más de 40 películas.

SELECT "actor_id" AS "Id_Actor"
FROM "film_actor" AS fa 
GROUP BY "actor_id"
HAVING  COUNT("film_id") > 40 ;

-- 29. Obtener todas las películas y, si están disponibles en 
-- el inventario, mostrar la cantidad disponible.

SELECT f."film_id" AS "Id_película",
       f."title" AS "Título_película",
       COUNT(i."inventory_id") AS "Películas_disponibles"
FROM "film" AS f 
INNER JOIN "inventory" AS i 
ON f."film_id" = i."film_id" 
LEFT JOIN "rental" AS r 
ON i."inventory_id" = r."inventory_id" 
AND r."return_date" IS NULL
WHERE r."rental_id" IS NULL
GROUP BY f."film_id" , f."title"
ORDER BY f."film_id" ;

-- 30. Obtener los actores y el número de películas en las que ha actuado.

SELECT CONCAT(a."first_name",' ', a."last_name") AS "Nombre_actor", 
       COUNT(fa."film_id") AS "Total_películas"
FROM "actor" a
INNER JOIN "film_actor" AS fa 
ON a."actor_id" = fa."actor_id"
GROUP BY a."first_name", a."last_name" ;

-- 31. Obtener todas las películas y mostrar los actores que han 
-- actuado en ellas, incluso si algunas películas no tienen actores asociados.

SELECT f."title" AS "Título_película" ,
       CONCAT(a."first_name", ' ', a."last_name") AS "Nombre_actor"
FROM "film" AS f 
INNER JOIN "film_actor" AS fa 
ON f."film_id" = fa."film_id" 
INNER JOIN "actor" AS a 
ON fa."actor_id" = a."actor_id"
GROUP BY f."title" , a."first_name" , a."last_name"
ORDER BY "title" ASC ;

-- 32.Obtener todos los actores y mostrar las películas en las 
-- que han actuado, incluso si algunos actores no han actuado en
-- ninguna película. 

SELECT CONCAT(a."first_name",' ', a."last_name") AS "Nombre_actores",
       f."title" AS "Título_película"
FROM "actor" AS a 
LEFT JOIN "film_actor" AS fa 
ON a."actor_id" = fa."actor_id" 
LEFT JOIN "film" AS f 
ON fa."film_id" = f."film_id" ;

-- 33. Obtener todas las películas que tenemos y todos los registros de alquiler. 

SELECT r."rental_id" AS "Id_alquiler" ,
       f."title" AS "Título_película" , 
       r."rental_date" AS "Día_alquiler", 
       r."customer_id" AS "Id_cliente"
FROM "film" AS f 
LEFT JOIN "inventory" AS i 
ON f."film_id" = i."film_id" 
LEFT JOIN "rental" AS r 
ON i."inventory_id" = r."inventory_id" ;

-- 34.Encuentra los 5 clientes que más dinero se hayan gastado con nosotros.

SELECT CONCAT(c."first_name", ' ', c."last_name") AS "Nombre_cliente" ,  
       SUM(p."amount") AS "Total_gastado"
FROM "payment" AS p 
INNER JOIN "customer" AS c 
ON p."customer_id" = c."customer_id" 
GROUP BY c."first_name" , c."last_name" 
ORDER BY "Total_gastado" DESC 
LIMIT 5;

-- 35. Selecciona todos los actores cuyo primer nombre es 'Johnny'.

SELECT "first_name" AS "Primer_nombre" 
FROM "actor" AS a 
WHERE "first_name" = 'JOHNNY' ;

-- 36. Renombra la columna “first_name” como Nombre y “last_name” como 
-- Apellido.

SELECT "first_name" AS "Nombre" , 
       "last_name" AS "Apellido"
FROM "actor" AS a ;

-- 37. Encuentra el ID del actor más bajo y más alto en la tabla actor.

SELECT MAX("actor_id") AS "Id_más_alto" ,
       MIN("actor_id") AS "Id_más_bajo"
FROM "actor" AS a ;

-- 38. Cuenta cuántos actores hay en la tabla “actor”

SELECT COUNT("actor_id") AS "Total_actores"
FROM "actor" AS a ;

-- 39. Selecciona todos los actores y ordénalos por apellido en orden
ascendente.

SELECT CONCAT("first_name",' ',"last_name") AS "Nombre_actor"
FROM "actor" AS a 
ORDER BY "last_name" ASC ;

-- 40. Selecciona las primeras 5 películas de la tabla “film”.

SELECT "film_id" AS "Id_pelicula",
       "title" AS "Titulo"
FROM "film" AS f 
ORDER BY "film_id" ASC
LIMIT 5;

-- 41. Agrupa los actores por su nombre y cuenta cuántos actores tienen el mismo nombre. ¿Cuál es el nombre más repetido?

SELECT "first_name" AS "Nombre_actores",
       COUNT("first_name") AS "Total_actores"
FROM "actor" AS a 
GROUP BY "first_name" 
HAVING COUNT("first_name") > 1
ORDER BY "Total_actores" DESC ;
-- Los nombres que más se repiten son Penelope, Kenneth y Julia.
-- He obviado los nombres que no se repiten con having.

-- 42. Encuentra todos los alquileres y los nombres de los clientes que los
-- realizaron.

SELECT CONCAT("first_name",' ',"last_name") AS "Nombre_clientes",
       "rental_id" AS "Id_alquiler"
FROM "customer" AS c 
INNER JOIN "rental" AS r 
ON c."customer_id" = r."customer_id" ;

-- 43. Muestra todos los clientes y sus alquileres si existen, 
-- incluyendo aquellos que no tienen alquileres.

SELECT CONCAT("first_name",' ',"last_name") AS "Nombre_cliente",
       "rental_id" AS "Id_alquiler"
FROM "customer" AS c
LEFT JOIN "rental" AS r 
ON c."customer_id" = r."customer_id" 
ORDER BY c."customer_id" , r."rental_id" ;

-- 44. Realiza un CROSS JOIN entre las tablas film y category. ¿Aporta valor
--  esta consulta? ¿Por qué? Deja después de la consulta la contestación.

SELECT *
FROM "film" AS f 
CROSS JOIN "category" AS c ;

-- Esta consulta no nos aporta valor, ya que al hacer el producto cartesiano de las dos tablas,
-- no hay ninguna condición que relacione las dos tablas.

-- 45. Encuentra los actores que han participado en películas de la 
-- categoría 'Action'.

SELECT CONCAT("first_name",' ',"last_name") AS "Nombre_actor", 	
       c."name" AS "Categoría"
FROM "actor" AS a 
INNER JOIN "film_actor" AS fa 
ON a."actor_id" = fa."actor_id" 
INNER JOIN "film" AS f 
ON fa."film_id" = f."film_id" 
INNER JOIN "film_category" AS fc 
ON f."film_id" = fc."film_id" 
INNER JOIN "category" AS c 
ON fc."category_id" = c."category_id" 
WHERE c."name" = 'Action';

-- 46. Encuentra todos los actores que no han participado en películas.

SELECT CONCAT("first_name",' ',"last_name") AS "Nombre_actor",
       fa."film_id" AS "Id_film"
FROM "actor" AS a 
INNER JOIN "film_actor" AS fa 
ON a."actor_id" = fa."actor_id" 	
WHERE fa."film_id" = NULL  ;

-- 47. Selecciona el nombre de los actores y la cantidad de películas 
-- en las que han participado.

SELECT CONCAT(a."first_name",' ',a."last_name") AS "Nombre_Actor"  ,
       COUNT("film_id") AS "Total_películas"
FROM "actor" AS a 
INNER JOIN "film_actor" AS fa 
ON a."actor_id" = fa."actor_id"
GROUP BY CONCAT("first_name",' ',"last_name")  ;	

-- 48. Crea una vista llamada “actor_num_peliculas” que muestre los 
-- nombres de los actores y el número de películas en las que han participado.

CREATE VIEW "actor_num_peliculas" AS
SELECT CONCAT("first_name",' ',"last_name") AS "Nombre_actores" , 
       COUNT(fa."film_id") AS "Número_películas" 
FROM "actor" AS a 
INNER JOIN "film_actor" AS fa 
ON a."actor_id" = fa."actor_id" 
GROUP BY a."first_name" , "last_name" ;

-- 49. Calcula el número total de alquileres realizados por cada cliente.

SELECT r."customer_id" AS "Id_cliente",
       COUNT(r."rental_id") AS "Total_alquileres", 
       CONCAT(c."first_name",' ',c."last_name") AS "Nombre_cliente"
FROM "rental" AS r 
INNER JOIN "customer" AS c 
ON r."customer_id" = c."customer_id" 
GROUP BY r."customer_id" , CONCAT(c."first_name",' ',c."last_name") ;

-- 50. Calcula la duración total de las películas en la categoría 'Action'.

SELECT c."name" AS "Categoría_película" , 
       SUM("length") AS "Duración_película"
FROM "film" AS f 
INNER JOIN "film_category" AS fc 
ON f."film_id" = fc."film_id" 
INNER JOIN "category" AS c 
ON fc."category_id" = c."category_id" 
WHERE c."name" = 'Action'
GROUP BY c."name" ;

-- 52. Crea una tabla temporal llamada “cliente_rentas_temporal” 
-- para almacenar el total de alquileres por cliente.

CREATE TEMP TABLE "cliente_rentas_temporal" AS
SELECT "customer_id" ,
       COUNT("rental_id") 
FROM "rental" AS r 
GROUP BY "customer_id" ;

-- 52. Crea una tabla temporal llamada “peliculas_alquiladas que 
-- almacene las películas que han sido alquiladas al menos 10 veces. 

CREATE TEMP TABLE "Películas_alquiladas" AS 
SELECT f."title" AS "Título_pelicula" ,
       COUNT(r."rental_id") AS "Veces_alquilada"
FROM "film" AS f 
INNER JOIN "inventory" AS i 
ON f."film_id" = i."film_id" 
INNER JOIN "rental" AS r 
ON i."inventory_id" = r."rental_id"
GROUP BY f."film_id"
HAVING COUNT(r."rental_id") >= 10 ;

-- 53. Encuentra el título de las películas que han sido alquiladas por 
-- el cliente con el nombre ‘Tammy Sanders y que aún no se han devuelto.
--  Ordena los resultados alfabéticamente por título de película.

SELECT f."title" AS "Título_película"
FROM "film" AS f 
INNER JOIN "inventory" AS i 
ON f."film_id" = i."film_id"  
INNER JOIN "rental" AS r 
ON i."inventory_id" = r."inventory_id"
INNER JOIN "customer" AS c 
ON r."customer_id" = c."customer_id"
WHERE c."first_name" = 'TAMMY' AND c."last_name" = 'SANDERS'
AND r."return_date" IS NULL 
ORDER BY f."title" ASC ;

-- 54. Encuentra los nombres de los actores que han actuado en al menos
--  una película que pertenece a la categoría ‘Sci-Fi. 
-- Ordena los resultados alfabéticamente por apellido.

SELECT CONCAT("first_name",' ',"last_name") AS "Nombre_actor",
       c."name" AS "Categoría"
FROM "actor" AS a 
INNER JOIN "film_actor" AS fa 
ON a."actor_id" = fa."actor_id" 
INNER JOIN "film" AS f 
ON fa."film_id" = f."film_id" 
INNER JOIN "film_category" AS fc 
ON f."film_id" = fc."film_id" 
INNER JOIN "category" AS c 
ON fc."category_id" = c."category_id" 
WHERE c."name" = 'Sci-Fi'
ORDER BY "last_name" ASC ;

-- 55. Encuentra el nombre y apellido de los actores que han actuado en 
-- películas que se alquilaron después de que la película ‘Spartacus Cheaper
-- se alquilara por primera vez. Ordena los resultados alfabéticamente
-- por apellido.

SELECT CONCAT(a."first_name",' ',a."last_name") AS "Nombre_actor"
FROM "actor" AS a 
INNER JOIN "film_actor" AS fa 
ON a."actor_id" = fa."actor_id" 
INNER JOIN "film" AS f 
ON fa."film_id" = f."film_id" 
INNER JOIN "inventory" AS i 
ON f."film_id" = i."film_id" 
INNER JOIN "rental" AS r 
ON i."inventory_id" = r."inventory_id" 
WHERE r."rental_date" > (
	SELECT r2."rental_date"
	FROM "film" AS f2
	INNER JOIN "inventory" AS i2
	ON f2."film_id" = i2."film_id"
	INNER JOIN "rental" AS r2
	ON i2."inventory_id" = r2."inventory_id"
	WHERE f2."title" = 'SPARTACUS CHEAPER'
	ORDER BY r2."rental_date"
	LIMIT 1)
GROUP BY a."first_name" , a."last_name" 
ORDER BY a."last_name" ASC ;

-- 56. Encuentra el nombre y apellido de los actores que no han actuado 
-- en ninguna película de la categoría ‘Music’.

SELECT CONCAT("first_name",' ',"last_name") AS "Nombre_actor"
FROM "actor" AS a
WHERE a."actor_id" NOT IN (
    SELECT DISTINCT fa."actor_id"
    FROM "film_actor" AS fa
    INNER JOIN "film_category" AS fc 
    ON fa."film_id" = fc."film_id"
    INNER JOIN "category" AS c 
    ON fc."category_id" = c."category_id"
    WHERE c."name" = 'Music'
);

-- 57. Encuentra el título de todas las películas que fueron alquiladas
-- por más de 8 días.

SELECT f."title" AS "Título_película"
FROM "film" f
INNER JOIN "inventory" AS i 
ON f."film_id" = i."film_id"
INNER JOIN "rental" AS r 
ON i."inventory_id" = r."inventory_id"
WHERE r."return_date" > r."rental_date" + INTERVAL '8 days'
GROUP BY f."title"
ORDER BY f."title" ;

-- 58. Encuentra el título de todas las películas que son de la misma 
-- categoría que ‘Animation’.

SELECT "title" AS "Título_película"
FROM "film" AS f
INNER JOIN "film_category" AS fc 
ON f."film_id" = fc."film_id" 
INNER JOIN "category" AS c 
ON fc."category_id" = c."category_id" 
WHERE c."name" = 'Animation' ;

-- 59. Encuentra los nombres de las películas que tienen la misma 
-- duración que la película con el título ‘Dancing Fever’. Ordena los resultados alfabéticamente por título de película

SELECT "title" AS "Título_película"
FROM "film" AS f 
WHERE "length" = (
	          SELECT "length" 
                  FROM "film" AS f2 
   	          WHERE "title" = 'DANCING FEVER'
   	          ) 
ORDER BY "title" ASC ;

-- 60. Encuentra los nombres de los clientes que han alquilado al menos 
-- 7 películas distintas. Ordena los resultados alfabéticamente por apellido.

SELECT CONCAT(c."first_name",' ' , c."last_name") AS "Nombre_cliente"
FROM "customer" AS c 
INNER JOIN "rental" AS r 
ON c."customer_id" = r."customer_id"
INNER JOIN "inventory" AS i 
ON r."inventory_id" = i."inventory_id" 
INNER JOIN "film" AS f 
ON i."film_id" = f."film_id"
GROUP BY c."customer_id", c."first_name" , c."last_name" 
HAVING COUNT(DISTINCT f."film_id") >= 7 ;

-- 61. Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres.

SELECT c."name" AS "Categoría_pelicula" , 
       COUNT(r."rental_id") AS "Total_alquiladas"
FROM "category" AS c 
INNER JOIN "film_category" AS fc 
ON c."category_id" = fc."category_id" 
INNER JOIN "film" AS f 
ON fc."film_id" = f."film_id" 
INNER JOIN "inventory" AS i 
ON f."film_id" = i."film_id" 
INNER JOIN "rental" AS r 
ON i."inventory_id" = r."inventory_id" 
GROUP BY c."category_id" ;

-- 62. Encuentra el número de películas por categoría estrenadas en 2006.

SELECT c."name" AS "Categoría_película", 
       COUNT(f."film_id") AS "Total_películas"
FROM "category" AS c
INNER JOIN "film_category" AS fc 
ON c."category_id" = fc."category_id"
INNER JOIN "film" AS f 
ON fc."film_id" = f."film_id"
WHERE f."release_year" = 2006
GROUP BY c."name" ;

-- 63. Obtén todas las combinaciones posibles de trabajadores 
-- con las tiendas que tenemos.

SELECT CONCAT(s."first_name",' ',s."last_name") AS "Nombre_epleado" ,
       s2."store_id" AS "Id_tienda"
FROM "staff" AS s 
CROSS JOIN "store" AS s2 ;

-- 64. Encuentra la cantidad total de películas alquiladas por cada cliente y
-- muestra el ID del cliente, su nombre y apellido junto con la cantidad de
-- películas alquiladas.

SELECT c."customer_id" AS "Id_cliente" , 
       CONCAT("first_name",' ', "last_name") AS "Nombre_cliente",
       COUNT(r."rental_id") AS "Total_alquiladas" 
FROM "customer" AS c 
LEFT JOIN "rental" AS r 
ON c."customer_id" = r."customer_id" 
GROUP BY c."customer_id" , c."first_name" , c."last_name" ;
