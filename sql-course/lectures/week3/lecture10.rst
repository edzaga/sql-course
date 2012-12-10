Lecture 10 - Subqueries in FROM and SELECT
------------------------------------------
.. role:: sql(code) 
      :language: sql 
   :class: highlight 
 
 
En la lectura 9, se pudo ver cómo se utilizan las subconsultas en la condición **C**:: 
         
 SELECT L 
 FROM R 
 WHERE C; 
 
En esta lectura se verá como utilizarlas tanto en **L** como en **R** 

.. Agregar lo que anoté en el papel...
 
Para los ejemplos de esta subsección, se usarán los valores utilizados en la lectura anterior (lectura 9).

SELECT(SELECT)-FROM-WHERE 
~~~~~~~~~~~~~~~~~~~~~~~~~ 

.. parrafo introductorio que dice q se usa la tabla de alumnos de la lectura 9 para el ejemplo 
Es posible utilizar una subconsulta como una columna dentro de la selección.

Ejemplo 1
^^^^^^^^^

Supongamos que se terminó el periodo de postulaciones y desea obtener una lista de  los estudiantes y cuantas veces fueron aceptados.

.. code-block:: sql

   SELECT sid, sname, 
   (SELECT COUNT (*) FROM apply A WHERE A.sid = S.sid and A.decision = 't')
   as acepted
   FROM student S
   ORDER BY acepted DESC;

cuya salida será::

   sid | sname  | acepted
   ----+--------+--------
    7  | Doris  |  4     
    5  | Doris  |  2     
    1  | Amy    |  2     
    4  | Irene  |  1     
    3  | Craig  |  1    
    8  | Tim    |  1   
    6  | Gary   |  0    
    2  | Edward |  0     

 

Ejemplo 2
^^^^^^^^^

Se desea saber el promedio de un determinado alumno y su diferencia con el promedio más alto del grupo de alumnos. Podría conseguirse
averiguando el promedio más alto de grupo, y luego, en otra consulta, calcular la diferencia con el del valor del promedio del alumno
en cuestión (en este caso Doris). Esto es posible realizarlo en una sola consulta:

.. code-block:: sql
 
  SELECT sname, average, average-(SELECT max(average) FROM student )
  as diferencia
  FROM student
  WHERE sname ='Doris';

cuya salida será::

  sname | average | diferencia
  ------+---------+-----------
  Doris |  45     | -25
  Doris |  70     |   0

Para distinguir a ambas Doris, se puede agregar el atributo sID a la consulta:

.. code-block:: sql
 
  SELECT sid, sname, average, average-(SELECT max(average) FROM student )
  as diferencia
  FROM student
  WHERE sname ='Doris';

en cuyo caso la salida será::

  sid | sname | average | diferencia
  ----+-------+---------+-----------
   5  | Doris |  45     | -25
   7  | Doris |  70     |   0

por lo que, efectivamente se distingue cual persona es la que tiene el promedio 45 y cual el 70.

.. note::   
  
   En este ejemplo se utiliza la función de SQL: MAX(atributo) ; la cual retorna el mayor 
   valor de una columna. Si se aplica en una columna de tipo string, el método de comparación 
   corresponde al valor ASCII de la primera letra. Por otro lado la función
   MIN(atributo), retorna el menor valor de una columna.




Hay que tener la precaución de retornar un sólo valor a la hora de realizar una subconsulta dentro de un SELECT. De otra forma se retornará 
un error, como se ve en el ejemplo 3.

Ejemplo 3
^^^^^^^^^

Supongamos que se trabaja bajo el contexto del ejemplo 2, pero sin utilizar la función MAX, que retorna sólo un valor:

.. code-block:: sql
 
  SELECT sname, average, average-(SELECT average FROM student )
  as diferencia
  FROM student
  WHERE sname ='Doris';

en cuyo caso la salida corresponderá al siguiente error::
  
   ERROR: more than one row returned by a subquery used as an expression.

Ejemplo 4
^^^^^^^^^

Supongamos que se desea saber el nombre de cada alumno, su promedio,  y su diferencia respecto al promedio más bajo del curso:

.. code-block:: sql
 
  SELECT sname, average, average-(SELECT min(average) FROM student ) as diferencia
  FROM student;

en cuyo caso la salida será::
  
   sname  | average | diferencia
   -------+---------+-----------
   Amy    |  60     |  15
   Edward |  65     |  20 
   Craig  |  50     |   5
   Irene  |  49     |   4
   Doris  |  45     |   0
   Gary   |  53     |   8
   Doris  |  70     |  25
   Tim    |  60     |  15
  

 
SELECT-FROM(SELECT)-WHERE 
~~~~~~~~~~~~~~~~~~~~~~~~~ 
 
Otro uso que se les da a las subconsultas es en la palabra reservada FROM. En el FROM de la consulta, es posible utilizar una
subconsulta. De todos modos es necesario agregarle un alias, pues el resultado de la subconsulta no tiene un nombre establecido.  
En caso de no hacerlo, aparece el siguiente error::
 
 ERROR: subquery in FROM must have an alias
 HINT: For example, FROM (SELECT ...) [AS] foo.

Como ya se ha mencionado, en la sección del FROM, se listan las tablas desde donde se sacarán los datos para crear las relaciones. Por lo tanto
la subconsulta de este estilo corresponde a crear una nueva tabla desde donde  se podrán extraer datos.

Ejemplo 5
^^^^^^^^^
Para demostrar el funcionamiento de la subconsulta dentro del FROM, supongamos que se desea extraer el id y nombre de cada
alumno dentro de la tabla student:

.. code-block:: sql

 SELECT sid, sname FROM student;

cuya salida es::
 
 sid | sname  
 ----+--------
  1  | Amy    
  2  | Edward 
  3  | Craig 
  4  | Irene
  5  | Doris
  6  | Gary 
  7  | Doris
  8  | Tim   

Lo cual es equivalente a la consulta:

.. code-block:: sql

 SELECT sid, sname FROM (SELECT * FROM student) as example;

cuya salida es::
 
 sid | sname  
 ----+--------
  1  | Amy    
  2  | Edward 
  3  | Craig 
  4  | Irene
  5  | Doris
  6  | Gary 
  7  | Doris
  8  | Tim   

Es decir son equivalentes, pues el alias "example", contiene toda la información de la tabla student.

.. Ejemplo 6
.. ^^^^^^^^^


RECAPITULACIÓN
~~~~~~~~~~~~~~
 
Las subconsultas se utilizan cuando la consulta a realizar es demasiado compleja,
Como se ha mencionado en la lectura anterior, es posible realizar tareas de inserción, actualización y eliminación de datos en las subconsultas.

Ejemplo extra
^^^^^^^^^^^^^

.. note::
 
  A continuación se verán ejemplos de subconsultas en actualización y eliminación de datos. Su sintaxis y 
  propiedades  se explicarán en la lectura 14 (semana 4). Ahora se exponen para dejar en claro que las subconsultas
  se pueden utilizar en cualquiera de las 4 operaciones básicas.

Consideremos que se quiere saber el nombre y la calificación del estudiante con el menor promedio, además de su diferencia con el mejor promedio.

.. de la tabla student, al alumno con el menor promedio:

.. code-block:: sql
  
   SELECT sname, average, average- (SELECT max(average) FROM student) as diferencia  
   FROM student 
   WHERE average = (SELECT min(average) FROM student ); 

cuya salida es::
  
  sname  | average | diferencia
  -------+---------+-----------
  Doris  |  45     | -25
  
Supongamos que el caso de la alumna que tiene el promedio más bajo, Doris, corresponde a un error de planilla. Se decide actualizar 
el promedio utilizando subconsultas (considerando que es la única alumna con el menor promedio):

.. code-block:: sql

  UPDATE student SET average = 100
  WHERE average = (SELECT min(average) FROM student);

en cuyo caso, y tras realizar un :sql:´SELECT * FROM student´, la salida es::
 
   sid | sname  | average  
   ----+--------+---------
    1  | Amy    |  60
    2  | Edward |  65    
    3  | Craig  |  50  
    4  | Irene  |  49
    6  | Gary   |  53
    7  | Doris  |  70   
    8  | Tim    |  60 
    5  | Doris  |  100    

Sin embargo, se descubre que Doris de id = 5, hizo trampa. Ella se metió de forma remota y sin permiso al servidor de datos donde se
encontraban las planillas de notas, y procedió a alterar aquellas que aportaban en su promedio. Como castigo se opta por
eliminarla del proceso de postulación. El encargado realiza la acción a través de subconsultas, considerando que Doris es la única 
alumna con promedio 100, que corresponde a la máxima calificación:

.. code-block:: sql

  DELETE FROM student where average = (SELECT max(average) FROM student);

Cuya salida tras realizar el SELECT * de rigor, es::

   sid | sname  | average  
   ----+--------+---------
    1  | Amy    |  60
    2  | Edward |  65    
    3  | Craig  |  50  
    4  | Irene  |  49
    6  | Gary   |  53
    7  | Doris  |  70   
    8  | Tim    |  60 


