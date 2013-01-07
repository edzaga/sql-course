Lecture 22 - Restriciones y  triggers: Restricciones de múltiples tipos
-----------------------------------------------------------------------

.. role:: sql(code)
         :language: sql
         :class: highlight

.. contexto
Como se pudo apreciar en la lectura anterior, existen varios tipos de restricciones,
las cuales se dividen en:

1. Restricciones que no permiten valores NULL
2. Restricciones de clave primaria
3. Restricciones de atributo y tupla 
.. (lmiitados por cada implementaci+on de lenguaje sql... investigar más)
4. Restricciones generales
.. (No implementado en ninguna distribución)

==========
Contexto
==========

En esta lectura se utilizará el ejemplo del sistema de Postulación de Estudiantes a
Establecimientos Educacionales::
 
 Student(sID, sName, Average);
 College(cName, State, Enrollment);
 Apply(sID, cName, Major, Desicion);

Comencemos a ver los diversos tipos de restricciones:

========================================
Restricciones para evitar valores NULL
========================================

Como su nombre lo indica, su idea es evitar que cierto atributo contenga valores nulos.

Ejemplo 1
^^^^^^^^^
Creemos una tabla de estudiantes, en la cual no se permita tener el campo 'Average' vacio.

.. code-block:: sql
  
  CREATE TABLE Student (sID SERIAL, sName VARCHAR(50) 
  Average INT NOT NULL, PRIMARY KEY (sID) );

Y posteriormente realicemos una serie de inserciones:

.. code-block:: sql
  
  INSERT INTO Student (sName, Average) VALUES ('Amy', 60);
  INSERT INTO Student (sName, Average) VALUES ('Tim', null);
  INSERT INTO Student (sName, Average) VALUES (null, 90);

Lo cual para la segunda inserción, el siguiente error aparacerá::
 
 ERROR: null value in column "average" violates not-null constraint

Ejemplo 2
^^^^^^^^^
Si probamos utilizando comandos de actualización (**UPDATE**)

Digamos que el promedio de 'Amy' es incorrecta, pero aún no se sabe cual 
es, por lo que la persona encargada de realizar este trabajo (que no sabe la restricción que 
tiene la tabla), decide poner un valor NULL:

.. code-block:: sql

  UPDATE Student SET Average = null where sid = 1;

No obstante y para sopresa de la persona, aparece::
 
 ERROR: null value in column "average" violates not-null constraint


==================================
Restricciones de clave primaria
==================================



===================================
Restricciones de atributo y tupla
===================================



========================
Restricciones generales
========================
