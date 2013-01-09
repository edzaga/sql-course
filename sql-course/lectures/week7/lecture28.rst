Lectura 28 - Vistas: Vistas y modificaciones automáticas
---------------------------------------------------------

.. role:: sql(code)
         :language: sql
         :class: highlight


Por lo general, las tablas son constituidas por un conjunto de definiciones y almacenan
datos físicos.

Por otra parte las vistas se encuentran en un nivel superior, es decir son constituidas
por un conjunto de definiciones, pero no almacenan datos, pues utilizan los datos que 
están almacenadas en las tablas.

Es por ello que, podemos decir que las vistas son por un conjunto de definiciones, pero no 
almacenan datos, pues utilizan los datos que están almacenadas en las tablas.


Es decir que las vistas se consideran "tablas virtuales".

Su sintaxis es:

.. code-block:: sql

 CREATE VIEW "view_name" AS "sql_instruction";

Donde:

1. **"view_name"**      : corresponde al nombre de la vista.
2. **"sql_instruction"**: corresponde a alguna instrucción SQL vista hasta ahora, es decir, operaciones de inserción y/o modificación.

Toda Base de Datos (BD), puede ser vista como un árbol de 3 niveles:

1. **La raíz**, compuesta por la parte **física** de la BD, es decir el(los) 
   disco(s) duro(s).
2. **El tronco**, compuesto por las relaciones de dentro de la BD, es decir,
   su parte **conceptual**.
3. **Las ramas**, que corresponde a la parte **lógica**, se refiere a las relaciones 
   que nacen desde las relaciones del tronco (tablas) y/o relaciones desde las ramas (otras vistas).



Realizar modificaciones en una vista no tiene mucho sentido, pues al no almacenar 
información,estos cambios simplemente se perderían. No obstante, si el objetivo de 
estos cambios corresponde a modificar la(s) tabla(s), dicha modificación adquiere sentido.

.. note::

  Por modificación se entienden operaciones de tipo INSERT, UPDATE y DELETE.

Estas modificaciones en las vistas deben ser traducidas a modificaciones que 
afecten a las tablas involucradas. Esta lectura está orientada a profundizar como se 
automatiza este proceso.

=============
Reglas
=============

Dentro del estándar de SQL, existen 4 reglas para que una "vista sea modificable", es decir
si se modifica la vista en cuestión, se modifica la relación/tabla desde donde nace la vista. 
Estas reglas son: 

1. Hacer un :sql:`SELECT`. de una tabla, no de una unión (JOIN). Además la tabla no puede ser  :sql:`DISTINCT`.
2. Si un atributo no esta en la vista, debe soportar valores  **NULL** o uno por defecto.
3. Si la vista está sobre la relación/tabla **T**, las subconsultas no pueden referirse a **T**, pero
   si a otras relaciones/tablas.
4. En una vista, no se puede usar :sql:`GROUP BY` o :sql:`AGREGGATION`.


============
Contexto
============

Supongamos que durante el primer semestre de clases, específicamente a un mes de que 
se implementara el sistema de postulación a Establecimientos Educacionales, postulan 4 
estudiantes más. Es por ello que se decide realizar una mejora utilizando vistas, debido
a sus propiedades y simplificar complejas consultas sobre tablas, ya sea seleccionando (:sql:`SELECT`.)
y/o modificando(:sql:`INSERT`, :sql:`UPDATE`, :sql:`DELETE`) datos.

Además se utilizarán criterios más estrictos, pues en la versión del sistema, se permitió la
entrada a alumnos que no tenían promedio arriba de 50: se le denominará sistema de postulación 2.0 (BETA).

Es por ello que, para esta lectura, se utilizará el sistema de Postulación de Estudiantes 
a Establecimientos Educacionales:

.. code-block:: sql

 CREATE TABLE College(cName VARCHAR(20), state VARCHAR(30),
 enrollment INTEGER, PRIMARY KEY(cName));
 CREATE TABLE Student(sID SERIAL,  sName VARCHAR(20), Average INTEGER,
 PRIMARY KEY(sID));
 CREATE TABLE   Apply(sID INTEGER, cName VARCHAR(20), major VARCHAR(30), 
 decision BOOLEAN,   PRIMARY KEY(sID, cName, major));

con los siguientes datos para la tabla **College**, **Student** y **Apply** respectivamente:

4 establecimientos:

.. code-block:: sql

 INSERT INTO College VALUES ('Stanford','CA',15000);
 INSERT INTO College VALUES ('Berkeley','CA',36000);
 INSERT INTO College VALUES ('MIT',     'MA',10000);
 INSERT INTO College VALUES ('Harvard', 'CM',23000);

.. note::
 
  Estos datos no son necesariamente reales, ni se hicieron investigaciones para corroborar
  su veracidad (estado o capacidad), pues se escapa al alcance de este curso. Sólo buscan 
  ser meras herramientas para el desarrollo de los ejemplos de esta lectura.

3 estudiantes:

.. code-block:: sql

 INSERT INTO Student (sName, Average) VALUES ('Clark',  70);
 INSERT INTO Student (sName, Average) VALUES ('Marge',  85);
 INSERT INTO Student (sName, Average) VALUES ('Homer',  50);

8 postulaciones:

.. code-block:: sql

 INSERT INTO Apply VALUES (1, 'Stanford', 'science'         , True);
 INSERT INTO Apply VALUES (1, 'Berkeley', 'science'         , False;
 INSERT INTO Apply VALUES (2, 'Harvard' , 'science'         , False;
 INSERT INTO Apply VALUES (2, 'MIT'     , 'engineering'     , True);
 INSERT INTO Apply VALUES (2, 'Berkeley', 'science'         , True);
 INSERT INTO Apply VALUES (3, 'MIT'     , 'science'         , True);
 INSERT INTO Apply VALUES (3, 'Harvard' , 'engineering'     , True);
 INSERT INTO Apply VALUES (3, 'Harvard' , 'natural history' , True);


.. note::
 
  Estos datos no son necesariamente reales, ni se hicieron investigaciones para corroborar
  su veracidad (mención académica), pues se escapa al alcance de este curso. 
  Sólo buscan  ser meras herramientas para el desarrollo de los ejemplos de esta lectura.



===========================================
Modificación automática de vistas y tablas
===========================================

.. De acuerdo a la serie de reglas que se explicaron anteriormente
Supongamos que deseamos seleccionar a los Estudiantes que postularon y fueron aceptados en
en Ciencias, en cualquier Establecimiento Educacional, pero utilizando vistas:

.. code-block:: sql
 
 CREATE VIEW scAccepted as 
 SELECT sid, sname FROM Apply 
 WHERE major='science' and decision = true;

Esta vista cuenta con las 4 restricciones impuestas por el estándar SQL para que 
sea considerada como "vista modificable":

1. Se selecionan datos solamente de la tabla **Apply**.
2. Los atributos de dicha tabla no contienen alguna restricción de tipo **NOT NULL**.
3. No hay subconsultas que se refieran a la tabla **Apply**.
4. No se utiliza :sql:`GROUP BY` o :sql:`AGREGGATION`.


Si se seleccionan los datos de la vista:
 
.. code-block:: sql

 SELECT * FROM scAccepted;
 
su salida es:: 
 
 sid | cname
 ----+----------
   1 | Stanford
   2 | Berkeley
   3 | MIT

Ejemplo 1
^^^^^^^^^
Supongamos que se desea eliminar de la vista al estudiante con *sID* = 3  (Homer), pues
realizó trampa en esta prueba. La idea es eliminarlo de la vista y a la vez, de la tabla
Apply, para no tener que realizar 2 operaciones:

.. code-block:: sql

 DELETE FROM scAccepted WHERE sid = 3;

No obstante::
 
 ERROR: you cannot delete from view "scaccepted"
 HINT: You need a unconditional ON DELETE DO INSTEAD rule or 
 INSTEAD OF DELETE trigger.

Pues MySQL es el único sistema, en relación a PostgreSQL o SQLite que permite un 
manejo de datos de este tipo. Estos últimos permiten la modificación en base a 
reglas y/o :sql:`triggers` solamente.

.. warning::
 
 Si bien el motor de Base de Datos utilizado para este curso, no soporta el tópico de
 esta lectura, se verán casos y consejos para utilizarlos en sistemas que funcionen.
 De todos modos, los ejemplos se construyen utilizando PostgreSQL.


Ejemplo 2
^^^^^^^^^
Supongamos que deseamos crear una vista que contenga a los Estudiantes que postularon
a Ciencias o Ingeniería. 

.. code-block:: sql

 CREATE VIEW sceng as
 SELECT sid, cname, major  FROM Apply
 WHERE major = 'science' or major = 'engineering';

Verificando a través de una selección:

.. code-block:: sql 

 SELECT * FROM sceng;
 
la salida es::

  sid | cname    | major
  ----+----------+-------------
   1  | Stanford | science
   1  | Berkeley | science
   2  | Harvard  | science
   2  | MIT      | engineering
   2  | Berkeley | science
   3  | MIT      | science
   3  | Harvard  | engineering



Si deseamos agregar una fila, digamos:

.. code-block:: sql
 
 INSERT INTO sceng VALUES (1, 'MIT', 'science');

No hay problemas, pues cuenta con las 4 reglas de "vistas modificables". 
El ejemplo funciona en MySQL y en la teoría.


Ejemplo 3
^^^^^^^^^
Supongamos que deseamos agregar una fila a la vista **scAccepted**, 

.. code-block:: sql 

 INSERT INTO scAccepted VALUES (2, 'MIT');

Si bien podría pensarse que, como la vista contiene valores determinados para el
atributo *major* y *decision*, bastaría con agregar sólo los restantes, es decir
*sID* y *cName*. Al momento de seleccionar todos los datos de la vista, no se verá 
esta nueva fila, debido a que:

1. El hecho de que la vista cuente con valores de **selección** no quiere decir que ellos
   sean de **inserción**.
2. Al no tener los atributos *major* y *decision* con valores 'science' y 'true' respectivamente
   no pasan el filtro de la vista.

Sin embargo en la tabla (**Apply** en este caso), la nueva fila se agrega. Pero claro,
no tiene sentido, pues los campos *major* y *decision* son **NULL**.

 
Ejemplo 4
^^^^^^^^^
En los sistemas que se permite el cambio automático, es posible evitar  inconsistencias 
como la que se generó en el ejemplo 3, agregando al final de la vista:

.. code-block:: sql 
  
 CREATE VIEW scAccepted2 as 
 SELECT sid, sname FROM Apply 
 WHERE major='science' and decision = true;
 WITH CHECK OPTION;

No obstante esta opción no está implementada en PostgreSQL, por lo 
que el siguiente error aparece al ejecutar la consulta que está arriba::
 
 ERROR: WITH CHECK OPTION is not implemented.
 

=============
Conclusiones
=============

1. Los cambios automáticos sólo se pueden realizar a "tablas modificables", es decir que
   cumplan con las 4 reglas.
2. PostgreSQL **no soporta este tipo de modificación**, sólo la permite a través
   de reglas y/o :sql:`triggers`. SQLite tampoco la soporta. MySQL si.

