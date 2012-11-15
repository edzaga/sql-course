Lecture 10 - Subqueries in FROM and SELECT
------------------------------------------
.. role:: sql(code) 
      :language: sql 
   :class: highlight 
 
 
En la lectura 9, se pudo ver como se utilizan las subconsultas en la condición **C**:: 
         
 SELECT L 
 FROM R 
 WHERE C; 
 
En esta lectura se verá como utilizarlas tanto en **L** como en **R** 

.. Agregar lo que anoté en el papel...
 
SELECT(SELECT)-FROM-WHERE 
~~~~~~~~~~~~~~~~~~~~~~~~~ 

.. parrafo introductorio que dice q se usa la tabla de alumnos de la lectura 9 para el ejemplo 

Ejemplo 1
^^^^^^^^^

Se desea saber el promedio de un determinado alumno y su diferencia con el promedio más alto del grupo de alumnos. Podría conseguirse
averiguando el promedio más alto de grupo, y luego, en otra consulta, calcular la diferencia con el del valor del promedio del alumno
en cuestión (en esta caso Tim). Esto es posible realizarlo en una sola consulta:

.. code-block:: sql
 SELECT sname, average, average-(SELECT max(average) FROM student ) as diferencia FROM student WHERE sname ='Tim';

cuya salida será::

  sname | average | diferencia
  ------+---------+-----------
   Tim  |  60     | -10
 
 
SELECT-FROM(SELECT)-WHERE 
~~~~~~~~~~~~~~~~~~~~~~~~~ 
 
Otro uso que se les da a las subconsultas es en a palabra reservada FROM. En el FROM de la consulta, es posible utilizar una subconsulta. De 
todos modos es recomendable agregarle un alias, pues el resultado de la subconsulta no tiene un nombre establecido.  
 
 
 
IDEAS:: 
  
 Buscar ejemplos más claros de los que salen en la video lectura. 
 Utilizar 2 ejemplos para subconsultas en L y 2 en R. 



