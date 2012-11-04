Lecture 9 - Subqueries in WHERE clause
--------------------------------------
.. role:: sql(code)
   :language: sql
   :class: highlight


SELECT-FROM-WHERE(SELECT)
~~~~~~~~~~~~~~~~~~~~~~~~~

Hasta ahora se han visto las consultas del tipo SELECT-WHERE-FROM, y algunos de sus derivados, como lo son el uso de join y operadores lógicos  
**AND, OR, NOT**, que son normalmente utilizados para filtrar resultados mediante la manupulación de una serie de condiciones.

Sin embargo existe otra manera de filtrar consultas: Las **subconsultas**. Una subconsulta es una sentencia SELECT que aparece dentro de otra 
sentencia SELECT y que normalmente son utilizadas para filtrar una clausula WHERE con el conjunto de resultados de la subconsulta.

Una subconsulta tiene la misma sintaxis que una sentencia SELECT normal exceptuando que aparece encerrada entre paréntesis. 

Como es usual, se utilizará el ejemplo de la simple college admissions database (como se truduciría esto al español???)::

        College (cName, state, enrollment)
        Student (sID, sName, GPA)
        Apply (sID, cName, major, decision)

.. La idea del ejeemplo es que el estudiante "sid" postula al colegio "cname", al ramo(o mencion academica, ahi no se) "major"
   y es aceptado o no

cuyas tablas son creadas mediante:

.. code-block:: sql

 CREATE TABLE College(id serial, cName VARCHAR(20), state VARCHAR(30), enrollment INTEGER, PRIMARY KEY(id));
 CREATE TABLE Student(sID serial, sName VARCHAR(20), GPA INTEGER, PRIMARY kEY(sID));
 CREATE TABLE Apply(sID INTEGER, cName VARCHAR(20), major VARCHAR(30), decision BOOLEAN, PRIMARY kEY(sID, cName, major));


Se utilizarán 4 establecimientos educacionales:

.. code-block:: sql
        
 INSERT INTO College (cName, state, enrollment) VALUES ('Stanford','CA',15000);
 INSERT INTO College (cName, state, enrollment) VALUES ('Berkeley','CA',36000);
 INSERT INTO College (cName, state, enrollment) VALUES ('MIT','MA',10000);
 INSERT INTO College (cName, state, enrollment) VALUES ('Harvard','CM',23000);

8 estudiantes: 

.. code-block:: sql
        
 INSERT INTO Student (sName, GPA) Values ('Amy', 60);
 INSERT INTO Student (sName, GPA) Values ('Edward', 65);
 INSERT INTO Student (sName, GPA) Values ('Craig', 50);
 INSERT INTO Student (sName, GPA) Values ('Irene', 49);
 INSERT INTO Student (sName, GPA) Values ('Doris', 45);
 INSERT INTO Student (sName, GPA) Values ('Gary', 53);
 INSERT INTO Student (sName, GPA) Values ('Doris', 70);
 INSERT INTO Student (sName, GPA) Values ('Tim', 60);


y 21 postulaciones:

.. code-block:: sql

 INSERT INTO Apply (sID, cName, major, decision) VALUES (1, 'Stanford', 'science', True);
 INSERT INTO Apply (sID, cName, major, decision) VALUES (1, 'Stanford', 'engineering', False);
 INSERT INTO Apply (sID, cName, major, decision) VALUES (1, 'Berkeley', 'science', True);
 INSERT INTO Apply (sID, cName, major, decision) VALUES (1, 'Berkeley', 'engineering', False);
 INSERT INTO Apply (sID, cName, major, decision) VALUES (2, 'Berkeley', 'natural hostory', False);
 INSERT INTO Apply (sID, cName, major, decision) VALUES (3, 'MIT', 'math', True);
 INSERT INTO Apply (sID, cName, major, decision) VALUES (3, 'Harvard', 'math', False);
 INSERT INTO Apply (sID, cName, major, decision) VALUES (3, 'Harvard', 'science', False);
 INSERT INTO Apply (sID, cName, major, decision) VALUES (3, 'Harvard', 'engineering', True);
 INSERT INTO Apply (sID, cName, major, decision) VALUES (4, 'Stanford', 'marine biology', True);
 INSERT INTO Apply (sID, cName, major, decision) VALUES (4, 'Stanford', 'natural history', False);
 INSERT INTO Apply (sID, cName, major, decision) VALUES (5, 'Harvard', 'science', False);
 INSERT INTO Apply (sID, cName, major, decision) VALUES (5, 'Berkeley', 'psychology', True);
 INSERT INTO Apply (sID, cName, major, decision) VALUES (5, 'MIT', 'math', True);
 INSERT INTO Apply (sID, cName, major, decision) VALUES (6, 'MIT', 'science', False);
 INSERT INTO Apply (sID, cName, major, decision) VALUES (7, 'Stanford', 'psychology', True);
 INSERT INTO Apply (sID, cName, major, decision) VALUES (7, 'Stanford', 'science', True);
 INSERT INTO Apply (sID, cName, major, decision) VALUES (7, 'MIT', 'math', True);
 INSERT INTO Apply (sID, cName, major, decision) VALUES (7, 'MIT', 'science', True);
 INSERT INTO Apply (sID, cName, major, decision) VALUES (7, 'Harvard', 'science', False);
 INSERT INTO Apply (sID, cName, major, decision) VALUES (8, 'MIT', 'engineering', True);


La situación que se pretende describir con estas tablas de ejemplo es la postulación de estudiantes a centros educacionales
En concreto la postulación del estudiante *sID* a la mencion académica *major* impartida en el centro educacional *cName*,
cuya aprobación, o *decision*, será "True o False".


Ejemplo 1
^^^^^^^^^  
El primer ejemplo de subconsulta corresponderá al listado de IDs y Nombres de los estudiantes que han postulado para
estudiar "science" en algun centro educacional.

.. code-block:: sql

 SELECT sID, sName FROM Student WHERE sID in (SELECT sID FROM Apply WHERE major = 'science');

cuya salida es::
   
  sid | sname
  ----+-------
   6  | Gary
   1  | Amy
   3  | Craig
   7  | Doris
   5  | Doris

  (5 rows)

.. note::
   
  Notese que en el ejemplo existen dos personas distintas llamadas Doris.


Como se mencionó anteriormente, tanto las subconsultas como el uso de join y operadores lógicos en la clausula WHERE son formas de filtrar 
resultados, por tanto, la consulta se puede reformular como:

.. code-block:: sql
  
 SELECT Student.sID, sName FROM Student, Apply WHERE Student.sID = Apply.sID AND major = 'science';

.. note::
  
   Cuidado, en la consulta se debe especificar que el atributo *sID* corresponde al de la tabla **Student**, pues la tabla **Apply** 
   también cuenta con dicho atributo. Si no se toma en cuenta este detalle, es probable que la conulta termine en un error o resultados no
   deseados.

en cuyo caso la salida será::
 
  sid | sname
  ----+-------
   1  | Amy
   1  | Amy
   3  | Craig
   6  | Gary
   7  | Doris
   7  | Doris
   7  | Doris  
   5  | Doris
  
  (8 rows)

Las 3 filas "extra" se deben, a que al utilizar join y operadores lógicos, se toman en cuenta todos los resultados, por ejemplo Amy postuló en 
dos ocasiones a science. Al utilizar la subconsulta, se eliminan estos resultados duplicados, haciendo la consulta más fiel a la realidad
pues se pregunta por aquellos estudiantes que han postulado a "science", no cuntas veces postuló cada uno. No obstante si se agrega la
clausula **distinct**, se obtiene la misma respuesta que al utilizar una subconsulta. Es decir que para la consulta:

.. code-block:: sql
  
 SELECT DISTINCT Student.sID, sName FROM Student, Apply WHERE Student.sID = Apply.sID AND major = 'science';

su salida será::
           
  sid | sname
  ----+-------
   6  | Gary
   1  | Amy
   3  | Craig
   7  | Doris
   5  | Doris

  (5 rows)


Ejemplo 2
^^^^^^^^^ 
Este ejemplo corresponderá sólo al listado de Nombres de los estudiantes que han qudado seleccionados para estudiar ciencias en algun 
centro educacional.

.. code-block:: sql
  
  SELECT sName FROM Student WHERE sID in (SELECT sID FROM Apply WHERE major = 'Science');

cuya salida es::

   sname
   -------
   Gary
   Amy
   Craig
   Doris
   Doris

   (5 rows)

.. note::
  
 Notese que ambas Doris no corresponden a un duplicado, ya que el atributo *sID* de una es 5 y de la otra es 7.

Y se obtienen los mismos 5 estudiantes. De forma análoga al ejemplo anterior, se realizará el equivalente a la subconsulta utilizando join 
y operadores lógicos:

.. code-block:: sql
  
 SELECT sName FROM Student, Apply WHERE Student.sID = Apply.sID AND major = 'science';

cuya salida es::
 
  sname
  -------
  Amy
  Amy
  Craig
  Gary
  Doris
  Doris
  Doris  
  Doris
  
  (8 rows)


Por tanto, y al igual que el ejemplo anterior, se utilizará **distinct**, es decir:

.. code-block:: sql
  
 SELECT DISTINCT sName FROM Student, Apply WHERE Student.sID = Apply.sID AND major = 'science';

cuya salida es::
 
  sname
  -------
  Amy
  Craig
  Doris
  Gary

  (4 rows)

Pero solo hay 4 estudiantes. Esto se debe a que en ejemplo anterior, se utilizó tanto el *sID* como el *sName*, como ambas Doris cuentan con un 
*sID* diferente, no se tomaba en cuenta como duplicado, pero en esta consulta, al solo contar con *sName*, ambas Doris se toman como 2 instancias
de la misma y se elimina una. 

La única forma de obtener el "número correcto de duplicados" es utilizando subconsultas


IN AND NOT IN
=============

IN y NOT IN permiten realizar filtros de forma más específica, necesarios para responder preguntas como la del ejemplo 3

Ejemplo 3
^^^^^^^^^ 
En el siguiente ejemplo se quiere saber el *sID* y el *sName* de aquellos estudiantes que postularon a science, pero no a engineering:

.. code-block:: sql
   
  SELECT sID, sName FROM Student WHERE 
  sID in (SELECT sID FROM Apply WHERE major = 'science') 
  and sID not in (SELECT sID FROM Apply WHERE major = 'engineering');

cuya salida corresponde precisamente a::
  
  sid  | sname
  -----+-------
   5   | Doris
   6   | Gary
   7   | Doris

  (3 rows)

.. note:: 

   Es posible corroborar el resultado ejecutando :sql:´SELECT * FROM Apply;´ y verificar manualmente.

La consulta realizada en este ejemplo es posible realizarla de otra manera:

.. code-block:: sql
   
  SELECT sID, sName FROM Student WHERE 
  sID in (SELECT sID FROM Apply WHERE major = 'science') 
  and not sID in (SELECT sID FROM Apply WHERE major = 'engineering');

cuya salida es equivalente a la anterior.


EXISTS AND NOT EXISTS
=====================

EXISTS es una función SQL que devuelve veradero cuando una subconsulta retorna al menos una fila.

Ejemplo 4
^^^^^^^^^ 
En este ejemplo se busca el nommbre de todos los establecimientos educacionales que comparten estado. Si se ejecuta:

.. code-block:: sql
 
 SELECT cName, state FROM College;

cuya salida es::
 
 cname    | state  
 ---------+-------
 Stanford | CA
 Berkeley | CA
 MIT      | MA
 Harvard  | CM
 
 (4 rows)

el resultado esperado debiese contener el par  **Stanford** - **Berkeley**

La consulta que pretende resolver esta pregunta es:

.. code-block:: sql
 
 SELECT cName, state FROM College C1 WHERE exists (SELECT * FROM College C2 WHERE C2.state = C1.state);

.. note::
  
 Lo que realiza esta consulta es verificar que por cada resultado obtenido en C1, lo compara con todos los resultados en C2.

cuya salida es::
 
 cname    | state  
 ---------+-------
 Stanford | CA
 Berkeley | CA
 MIT      | MA
 Harvard  | CM

 (4 rows)

Esto pasa debido a que C1 y C2 pueden ser el mismo establecimiento. Por ende, es necesario dejar en claro que C1 y C2 son diferentes. 

.. code-block:: sql
 
 SELECT cName, state FROM College C1 WHERE exists (SELECT * FROM College C2 WHERE C2.state = C1.state and C1.cName <> C2.cName);

en cuyo caso la salida corresponde a la correcta, es decir::
 
 cname    | state  
 ---------+-------
 Stanford | CA
 Berkeley | CA

 (2 rows)


Es posible realizar computos matemáticos (valor más alto, valor más bajo)  utilizando subconsultas:

Ejemplo 5
^^^^^^^^^ 
Se busca el establecimiento con mayor cantidad de alumnos. 
La consulta que se realizará corresponde a buscar todos los establecimientos donde no exista otro establecimiento que su cantidad de alumnos sea
mayor que la primera.

.. code-block:: sql
 
 SELECT cName, state FROM College C1 WHERE exists (SELECT * FROM College C2 WHERE C2.enrollment > C1.enrollment);

Donde el resultado corresponde a Berkeley.

.. note::
 
 De forma analoga es posible calcular el establecimiento con menor cantidad de alumnos, cambiando el signo matemático **>** por **<**

ANY
===

Ejemplo 6
^^^^^^^^^ 






Falta explicar y poner 1 ejeplos de c/u::
  
 any

