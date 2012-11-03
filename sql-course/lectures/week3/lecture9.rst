Lecture 9 - Subqueries in WHERE clause
--------------------------------------

.. role:: sql(code)
   :language: sql
   :class: highlight

.. Parrafo introdutorio sin titulo
Hasta ahora se han visto las consultas del tipo SELECT-WHERE-FROM, y algunos de sus derivados, ya sea utilizando operadores
lógicos (AND, OR, NOT) 

SELECT-FROM-WHERE(SELECT)
~~~~~~~~~~~~~~~~~~~~~~~~~

Como es usual, se utilizará el ejemplo de la simple college admissions database (como se truduciría esto al español???)::

        College (cName, state, enrollment)
        Student (sID, sName, GPA, sizeHS)
        Apply (sID, cName, major, decision)

.. La idea del ejeemplo es que el estudiante "sid" postula al colegio "cname", al ramo(o mencion academica, ahi no se) "major"
   y es aceptado o no

cuyas tablas son creadas mediante:

.. code-block:: sql

 CREATE TABLE College(id serial, cName VARCHAR(20), state VARCHAR(30), enrollment VARCHAR(40), PRIMARY KEY(id));
 CREATE TABLE Student(sID serial, sName VARCHAR(20), GPA INTEGER, sizeHS VARCHAR(40), PRIMARY kEY(sID));
 CREATE TABLE Apply(sID serial, cName VARCHAR(20), major VARCHAR(30), decision VARCHAR(40), PRIMARY kEY(sID, cName));

Se utilizarán 4 Establecimientos educacionales, 7 estudiantes y 12 postulaciones, los cuales serán:

.. code-block:: sql
 INSERT INTO

La situación que pretende describir estas tablas de ejemplo es la postulación de estudiantes a centros educacionales
En concreto la postulación del estudiante **sID** a la mencion académica **major** impartida en el centro educacional **cname**,
cuya aprovación, o **decision**, será "si o no".

Según el libro guía:

`\text{Tabla}(\underline{\text{primaryKey}},\text{atributo,otroAtributo})`

* El nombre de la tabla va la primer letra con mayúscula, el resto con minúscula, los atributos con minúscula,salvo que sean dos palabras entonces la segunda va con mayúscula. la clave primaria va subrayada, lo puse en modo matemático todo para subrayar la PK. 
Para hablar de una `\text{Tabla}` y de un *atributo* 

* Bueno los comandos SQL ya saben :sql:`COMANDOS SQL`, 

para resaltar algún **cocepto**

``inline`` no me gusta este no se para que puede servir si es que lo han usado ..

:math:`{\{=,\geq,>,<, \neq,\leq \}`.

.. note::
	para insertar una nota

raya horizontal:

n del estudiante sID

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



Según el libro guía:

`\text{Tabla}(\underline{\text{primaryKey}},\text{atributo,otroAtributo})`

* El nombre de la tabla va la primer letra con mayúscula, el resto con minúscula, los atributos con minúscula,salvo que sean dos palabras entonces la segunda va con mayúscula. la clave primaria va subrayada, lo puse en modo matemático todo para subrayar la PK. 
Para hablar de una `\text{Tabla}` y de un *atributo* 

* Bueno los comandos SQL ya saben :sql:`COMANDOS SQL`, 

para resaltar algún **cocepto**

``inline`` no me gusta este no se para que puede servir si es que lo han usado ..

:math:`{\{=,\geq,>,<, \neq,\leq \}`.

.. note::
	para insertar una nota

raya horizontal:


