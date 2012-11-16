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
 
Para los ejemplos de esta subsección, se usarán los valores utilizados en la lectura anterior (lectura 9).

SELECT(SELECT)-FROM-WHERE 
~~~~~~~~~~~~~~~~~~~~~~~~~ 

.. parrafo introductorio que dice q se usa la tabla de alumnos de la lectura 9 para el ejemplo 

Ejemplo 1
^^^^^^^^^

Se desea saber el promedio de un determinado alumno y su diferencia con el promedio más alto del grupo de alumnos. Podría conseguirse
averiguando el promedio más alto de grupo, y luego, en otra consulta, calcular la diferencia con el del valor del promedio del alumno
en cuestión (en este caso Doris). Esto es posible realizarlo en una sola consulta:

.. code-block:: sql
 
  SELECT sname, average, average-(SELECT max(average) FROM student ) as diferencia FROM student WHERE sname ='Doris';

cuya salida será::

  sname | average | diferencia
  ------+---------+-----------
  Doris |  45     | -25
  Doris |  70     |   0

Para distinguir a ambas Doris, se puede agregar el atributo sID a la consulta:

.. code-block:: sql
 
  SELECT sid, sname, average, average-(SELECT max(average) FROM student ) as diferencia FROM student WHERE sname ='Doris';

en cuyo caso la salida será::

  sid | sname | average | diferencia
  ----+-------+---------+-----------
   5  | Doris |  45     | -25
   7  | Doris |  70     |   0

por lo que, efectivamente se distingue que persona es la que tiene el promedio 45 y cual el 70.

.. note::   
  
   En este ejemplo se utiliza la función de SQL: MAX(atributo) ; la cual retorna el mayor 
   valor de una columna. Si se aplica en una columna de tipo string, el método de comparación 
   corresponde al valor ASCII de la primera letra. Por otro lado la función
   MIN(atributo), retorna el menor valor de una columna.




Hay que tener la precaución de retornar un sólo valor a la hora de realizar una subconsulta dentro de un SELECT. De otra forma se retornará 
un error, como se verá en el ejemplo 2.

Ejemplo 2
^^^^^^^^^

Supongamos que se tabaja bajo el contexto del ejemplo 1, pero sin utilizar la funcioón MAX, que retorna sólo un valor:

.. code-block:: sql
 
  SELECT sname, average, average-(SELECT average FROM student ) as diferencia FROM student WHERE sname ='Doris';

en cuyo caso la salida correponderá al siguiente error::
  
   ERROR: more than one row returned by a subquery used as an expression.

Ejemplo 3
^^^^^^^^^

Supongamos que se desea saber el nombre de cada alumno, su promedio,  y su diferencia respecto al promedio más bajo del curso:

.. code-block:: sql
 
  SELECT sname, average, average-(SELECT min(average) FROM student ) as diferencia FROM student;

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
 
Otro uso que se les da a las subconsultas es en a palabra reservada FROM. En el FROM de la consulta, es posible utilizar una subconsulta. De 
todos modos es recomendable agregarle un alias, pues el resultado de la subconsulta no tiene un nombre establecido.  
 
 


RECAPITULACIÓN
~~~~~~~~~~~~~~
 
Las subconsultas se utilizan cuando la consulta a realizar es demasiado compleja,
Como se ha mencionado en la lectura anterior, es posible realizar tareas de inserción, actualización y eliminación de datos en las subconsultas.

Ejemplo extra
^^^^^^^^^^^^^
Consideremos que se quiere saber el nombre, la calificación y  del estudiante con el menor promedio, además de su diferencia con el mejor promedio.
.. de la tabla student, al alumno con el menor promedio:

.. code-block:: sql
  
   SELECT sname, average, average- (SELECT max(average) FROM student) as diferencia  
   FROM student 
   WHERE average = (SELECT min(average) FROM student ); 

cuya salida es::
  
  sname  | average | diferencia
  -------+---------+-----------
  Doris  |  45     | -25
  
Supongamos que el caso de la alumna que tiene el prmedio más bajo, Doris, corresponde a un error de planilla. Se decide actualizar 
el promedio utilizando subconsultas (considerando que es la única almuna con el menor promedio):

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
alumna con promedio 100, que corresopnde a la máxima calificación:

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




Falta::
  
  buscar ejemplo d subquery en from


