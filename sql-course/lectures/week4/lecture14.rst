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

En esta lectura se verá en profundidad, aquellas operaciones que permiten modificar datos, es decir,
INSERT, UPDATE y DELETE.


INSERT
~~~~~~

Para insertar datos, existen al menos dos formas. Una se ha visto desde las primeras lecturas (INSERT INTO):

.. code-block:: sql

   INSERT INTO table VALUES (atributo1, atributo2 ...);

Es decir que se insertará en la tabla "table", los valores correspondientes a los atributos de la tabla
**table**. Para poder utilizar esta forma, es necesario que la cantidad de valores asociados a los
atributos, sea igual a la cantidad de atributos de la tabla **table**, y que estén en el mismo orden
respecto a los tipos de datos y los datos que se quieran insertar. El ejemplo 1 aclarará posibles dudas:


Contexto
^^^^^^^^

Utilicemos la tabla "student", que ya se ha utilizado en lecturas anteriores::

 Student (sID, sName, Average)

y creemos una nueva tabla llamada **Student_new**, con una estructura similar, pero vacía:

.. code-block:: sql

 CREATE TABLE Student_new (sID serial, sName VARCHAR(20), Average INTEGER,  PRIMARY kEY(sID));

Es decir, cuenta con 3 atributos, los cuales son: el identificador o *sID* de carácter entero y serial,
lo cual significa que si no se especifica un valor, tomará un valor entero; el nombre o *sName*  que
corresponde a una cadena de caracteres, y el promedio o *Average*, es decir un número entero.


Ejemplo 1
^^^^^^^^^
Supongamos que planilla de estudiantes albergada en la tabla **Student** ya fue enviada y no se puede
modificar, es por ello que se necesita crear una nueva planilla (otra tabla student), y agregar a los
nuevos alumnos postulantes.

Por lo tanto es posible agregar un estudiante mediante:

.. code-block:: sql

  INSERT INTO Student_new VALUES (1,'Betty', 78);

cuya salida, después de ejecutar el :

.. code-block:: sql

 SELECT * student;

es ::

   sid | sname  | average
   ----+--------+---------
    1  | Betty  |  78


Al utilizar el atributo *sID* como serial, es posible omitir el valor de este atributo a la hora de
insertar un nuevo estudiante:

.. code-block:: sql

  INSERT INTO Student_new (sName, Average) VALUES ('Wilma', 81);

Pero, esto resulta en el siguiente error::

  ERROR: duplicate key value violates unique constraint "student2_pkey"
  DETAIL: Key(sid)=(1) already exists.

Esto se debe a que *sID* es clave primaria, y serial tiene su propio contador, que parte de 1 (el cual
no está ligado necesariamente a los valores de las diversas filas que puedan existir en la tabla). Hasta
este punto, sólo se pueden seguir añadiendo alumnos agregado de forma explícita todos y cada uno de los
atributos de la tabla, sin poder prescindir en este caso de *sID* y su carcaterística de ser serial, pues
la tupla atributo-valor (sID)=(1) está bloqueada.

.. note::

  Es posible eliminar directamente la fila que corresponde a 'Betty', pero ese paso se reserva a la
  subsección  de DELETE, presentada más adelante en esta lectura


Ejemplo 2
^^^^^^^^^

Es posible modificar la inserción de 'Betty' para que sea similar a la de 'Wilma'.

.. note::

  A continuación se usará el comando SQL DROP TABLE, que permite eliminar una tabla entera.

.. code-block:: sql

  DROP TABLE Student_new;
  CREATE TABLE Student_new(sID serial, sName VARCHAR(20), Average INTEGER,  PRIMARY kEY(sID));
  INSERT INTO Student_new (sName, Average) VALUES ('Betty', 78);
  INSERT INTO Student_new (sName, Average) VALUES ('Wilma', 81);

Como  se ha modificado la consulta de 'Betty', se utiliza el contador propio del atributo serial, por
lo que no hay conflictos.

Si se selecciona toda la información de la tabla:

.. code-block:: sql

  SELECT * FROM Student_new;

la salida es::

   sid | sname  | average
   ----+--------+---------
    1  | Betty  |  78
    2  | Wilma  |  81



.. La otra forma de realizar inserciones de datos es mediante el uso de SELECT. Sin embargo, y aunque esta
 forma no es tan directa como la anterior, puede ser de gran utilidad.

.. agregar la idea del video

UPDATE
~~~~~~

Es posible modificar o "actualizar" datos a través del comando UPDATE, cuya sintaxis es:

.. code-block:: sql

  UPDATE table SET Attr = Expression  WHERE Condition;

Es decir que se actualiza, de la tabla **table**, el atributo *Attr* (el valor anterior, por el
valor "Expression"), bajo una cierta condición "Condition"

.. note::

   Es importante destacar que la condición puede variar, puede ser de carácter sumamente complejo,
   una sub-consulta, una sentencia que involucre otras tablas. "Expression" también puede ser un valor
   que involucre otras tablas, no necesariamente corresponde a un valor de comparación directa.
   Se aplica lo mismo para la condición.

Es necesario destacar que, si bien se puede actualizar un atributo, también se pueden actualizar
varios a la vez:

.. code-block:: sql

  UPDATE table
  SET Attr1 = Expression1, Attr2 = Expression2,..., AttrN = ExpressionN
  WHERE Condition;


Ejemplo 3
^^^^^^^^^^

Bajo el contexto del ejemplo 2, supongamos que la nota de 'Wilma' corresponde a un 91 en lugar de 81.
Se desea corregir este error de tipéo, a través del comando UPDATE. Es necesario recordar que dependiendo de
la cantidad de atributos de la tabla, es posible realizar de muchas formas la actualización:

.. code-block:: sql

   UPDATE Student_new
   SET Average = 91
   WHERE sName = 'Wilma';

o

.. code-block:: sql

   UPDATE Student_new
   SET Average = 91
   WHERE Average = 81;

Ambos casos no son erróneos, pues realizan el cambio pedido. No obstante, *es necesario ganar la costumbre
de trabajar con atributos que sean únicos, es decir la clave primaria* ; compuesta por un atributo o la
combinación de algunos de ellos (en este caso el atributo *sID*). La razón corresponde a que en caso
de haber más de una Wilma se cambiaría el promedio de ambas, lo mismo para el caso de que varias personas
cuenten con un promedio igual a 81. Por lo tanto la consulta ideal corresponde a

.. code-block:: sql

   UPDATE Student_new
   SET Average = 91
   WHERE sID = 2;



DELETE
~~~~~~

Es posible eliminar filas de información, que cumplan una determinada condición. Esto
es especialmente útil en casos donde se desee borrar filas específicas en lugar de tener que borrar
toda una tabla.

La sintaxis del comando DELETE es:

.. code-block:: sql

  DELETE FROM table WHERE Condition;

Es decir que de la tabla **table**, se elimina el(los) valor(es) que cumpla(n) con la condición "Condition".

.. note::

   Es importante destacar que la condición puede variar, puede ser de carácter sumamente complejo,
   una sub-consulta, una sentencia que involucre otras tablas.


Ejemplo 4
^^^^^^^^^

Si nos situamos temporalmente al final del ejemplo 1, con el error::

  ERROR: duplicate key value violates unique constraint "student2_pkey"
  DETAIL: Key(sid)=(1) already exists.

Al querer insertar a 'Wilma', es posible eliminar la fila correspondiente a 'Betty' y volver insertar
ambas como se hizo en el ejemplo 2, sin la necesidad de borrar la tabla, crearla y agregar todo de nuevo:

.. code-block:: sql

  DELETE FROM Student_new WHERE sID = 1;

Lo cual permite eliminar la fila correspondiente a 'Betty' y dejar la tabla vacía. Posteriormente
es posible comenzar a llenarla de nuevo mediante las últimas 2 consultas del ejemplo 2, es decir:

.. code-block:: sql

  INSERT INTO Student_new (sName, Average) VALUES ('Betty', 78);
  INSERT INTO Student_new (sName, Average) VALUES ('Wilma', 81);

Ejemplo 5
^^^^^^^^^

Supongamos que 'Wilma' se enoja por el error de tipéo y desea salir del proceso de postulación. Es
por ello que debe ser eliminada de la nueva planilla de estudiantes:

.. code-block:: sql

  DELETE FROM Student_new WHERE sID = 1;

RECAPITULACIÓN
~~~~~~~~~~~~~~

A continuación se expondrá un ejemplo que implique el uso de todos los comandos aprendidos en esta
lectura.

Ejemplo extra
^^^^^^^^^^^^^
Tomando en cuenta el ejemplo 5, supongamos que 'Betty' pasa a la etapa de postulaciones
y decide hacerlo en 2 Establecimientos educacionales. Postula a ciencias e ingeniería  en Stanford
y a Historia Natural en Berkeley, es aceptada en todo lo que ha postulado. La tabla **Apply** igual
que la tabla **Student**: ya se había enviado sin posibilidad de modificar,  Es por ello que se crea
la tabla **Apply_new**, cpn las mismas características que **Apply**:


.. code-block:: sql

   CREATE TABLE   Apply_new(sID INTEGER, cName VARCHAR(20), major VARCHAR(30),
   decision BOOLEAN,   PRIMARY kEY(sID, cName, major));


  INSERT INTO Apply_new (sID, cName, major, decision) VALUES (1, 'Stanford',
  'science'        , True);
  INSERT INTO Apply_new (sID, cName, major, decision) VALUES (1, 'Stanford',
  'engineering'    , True);
  INSERT INTO Apply_new (sID, cName, major, decision) VALUES (1, 'Berkeley',
  'natural history'    , True);

Supongamos ahora que hubo un error en la gestión de papeles respecto a la postulación a ingeniería:
Básicamente 'Wilma' no quedó aceptada  en dicha mención, por lo tanto se debe modificar

.. code-block:: sql

  UPDATE Apply SET decision = false
  WHERE sid = 13 and cname = 'Stanford' and major = 'engineering';

Lo que resulta en el cambio en la tabla.

Supongamos ahora que 'Wilma', por suerte,  es una persona distraída y debido a sus enormes
ganas de entrar a ciencias no se percata del error. El responsable de error, por temor a poner en
juego su reputación, decide eliminar el registro de la postulación, en lo que considera un plan maestro,
pues la tabla **Apply_new** no cuenta con un contador serial que pudiese causar algún conflicto.

.. code-block:: sql

 DELETE FROM Apply
 WHERE sid = 1 and name = 'Stanford' and major = 'engineering';

Falta agregar salida de las consultas (las verifiqué en todo caso)

