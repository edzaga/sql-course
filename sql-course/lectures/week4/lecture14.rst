Lecture 14 - SQL: Data modifications statements
------------------------------------------------
.. role:: sql(code) 
         :language: sql 
   :class: highlight 
 

Como ya se ha dicho en algunas de las lecturas anteriores, existen 4 operaciones básicas relacionadas con
la manipulación de datos en una tabla SQL::
        
     Selección     -> SELECT
     Inserción     -> INSERT
     Actualización -> UPDATE
     Eliminación   -> DELETE

En esta lectura se verá en profundidad, aquellas operaciones que permiten modificar datos, es decir, INSERT, UPDATE y DELETE.


INSERT
~~~~~~

Para insertar datos, existen al menos dos formas. Una se ha visto desde las primeras lecturas (INSERT INTO):

.. code-block:: sql

   INSERT INTO table VALUES (atributo1, atributo2 ...);

Es decir que se insertará en la tabla "table", los valores correspondientes a los atributos de la tabla "table". Para poder utilizar
esta forma, es necesario que la cantidad de valores asociados a los atributos, sea igual a la cantidad de atributos de la tabla "table", 
y que esten en el mismo orden de tipo de datos. El ejemplo 1 aclarará posibles dudas:

Ejemplo 1
^^^^^^^^^
Utilicemos la tabla "student", que ya se ha utilizado en lecturas anteriores::

 Student (sID, sName, Average)
 
y creemos una nueva tabla llamada Student2, con una estructura similar, pero vacia:

.. code-block:: sql
 
 CREATE TABLE Student2(sID serial, sName VARCHAR(20), Average INTEGER);

Es decir, cuenta con 3 atributos, los cuales son sID de carácter entero y serial, lo cual significa que si no se especifica un
valor, tomará un valor entero ; el nombre que crresponde a un string  y el promedio, es decir un número entero. 

Supongamos que planilla de estudiantes albergada en la tabla **Student** ya fue enviada y no se puede modificar, es por ello que
se necesita crear una nueva planilla (otra tabla student), y agregar a los nuevos alumnos postulantes.

Por lo tanto es posible agregar un estudiante mediante:

.. code-block:: sql

  INSERT INTO Student2 VALUES (1,'Betty', 78);

cuya salida, despues de ejecutar el :SQL:´select * student;´ de rigor es ::
 
   sid | sname  | average  
   ----+--------+---------
    1  | Betty  |  78


UPDATE
~~~~~~



DELETE
~~~~~~






