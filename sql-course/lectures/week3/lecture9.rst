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


Ejemplo 1
^^^^^^^^^  
Como es usual, se utilizará elt ejemplo de la simple college admissions database (como se truduciría esto al español???)::

        College (cName, state, enrollment)
        Student (sID, sName, GPA, sizeHS)
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
 INSERT INTO College (cName, state, enrollment) VALUES ('Harvard','MA',23000);

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


y 21 postulaciones
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


.. queda pendiente llenar las tablas con:
   
   major en apply(science, engineering, natural history, matemathic, marine biology, phsicology) 
    
La situación que se pretende describir con estas tablas de ejemplo es la postulación de estudiantes a centros educacionales
En concreto la postulación del estudiante *sID* a la mencion académica *major* impartida en el centro educacional *cname*,
cuya aprobación, o *decision*, será "si o no".

El primer ejemplo de subconsulta corresponderá al listado de IDs y Nombres de los estudiantes que han qudado seleccionados para
estudiar ciencias en algun centro educacional.

.. code-block:: sql
   SELECT sID, sName FROM Student WHERE sID in (SELECT sID FROM Apply WHERE major = 'science');

cuya salida es::
   <agregar salida una vez llenadas las tablas>

Como se mencionó anteriormente, tanto las subconsultas como el uso de join y operadores lógicos en la clausula WHERE son formas de filtrar 
resultados, por tanto, la consulta se puede reformular como:

.. code-block:: sql
   SELECT Student.sID, sName FROM Student, Apply WHERE Student.sID = Apply.sID AND major = 'science';

.. note::
   Cuidado, en la consulta se debe especificar que el atributo *sID* corresponde al de la tabla **Student**, pues la tabla **Apply** 
   también cuenta con dicho atributo. Si no se toma en cuenta este detalle, es probable que la conulta termine en un error o resultados no
   deseados.

en cuyo caso la salida será::
   <agregar salida una vez llenadas las tablas y verificar los duplicados>

Ejemplo 2
^^^^^^^^^ 
Este ejemplo corresponderá sólo al listado de Nombres de los estudiantes que han qudado seleccionados para estudiar ciencias en algun 
centro educacional.

.. code-block:: sql
   SELECT sName FROM Student WHERE sID in (SELECT sID FROM Apply WHERE major = 'Science');




Según el libro guía:

`\text{Tabla}(\underline{\text{primaryKey}},\text{atributo,otroAtributo})`

* El nombre de la tabla va la primer letra con mayúscula, el resto con minúscula, los atributos con minúscula,salvo que sean dos palabras entonces la segunda va con mayúscula. la clave primaria va subrayada, lo puse en modo matemático todo para subrayar la PK. 
Para hablar de una `\text{Tabla}` y de un *atributo* 

* Bueno los comandosd SQL ya saben :sql:`COMANDOS SQL`, 

para resaltar algún **cocepto**

``inline`` no me gusta este no se para que puede servir si es que lo han usado ..

:math:`{\{=,\geq,>,<, \neq,\leq \}`.

.. note::
	para insertar una nota

raya horizontal:


Subtítulo sección
===================

Ejemplo o ejercicio
^^^^^^^^^^^^^^^^^^^ 



Ideas::
 Explicar que es una subconsulta de tipo "where" y que la condicion puede anidar otro select
 Poner los pasos para crear el ejemplo de la lectura (create table e insert into)
 POner un pequeño ejemplo de la subconsulta
 Explicar que la subconsulta no pone valores duplicados ante consultas similares (a menos que se use un distinct)
 Explicar que se puede usar más de una subconsulta, por ejemplo SELECT A FROM B WHERE S1 AND S2; (S es subconsulta)
 POner un ejemplo
 Subconsulta exists, not exists, any
