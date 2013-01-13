Lectura 24 - Restricciones y triggers: Triggers introducción y demostración
-----------------------------------------------------------------------------

.. role:: sql(code)
         :language: sql
         :class: highlight

Triggers (disparadores)
~~~~~~~~~~~~~~~~~~~~~~~~

Durante la ejecución de una aplicación de base de datos, hay ocasiones que se requiere realizar una o más
acciones de forma automática, si se produce un evento en específico. Es decir, que la primera acción provoca
la ejecución de las siguientes acciones. Los denominados Triggers o disparadores son el mecanismo de activación, 
que posee SQL para entregar esta capacidad. 

Definición
=========== 

**Un trigger es una orden que el sistema ejecuta de manera automática** como efecto secundario de alguna
modificación de la base de datos. Entonces los tiggers siguen en orden la secuencia: ``evento->condición->acción``. 
Se ejecutan mediante los comandos :sql:`INSERT`, :sql:`DELETE` y :sql:`UPTADE`. 

Para diseñar un mecanismo trigger hay que cumplir algunos **requisitos**:

 1. **Procedimiento almacenado:** Se debe crear la base de datos y las relaciones, antes de definir el trigger.

 2. **Especificar condiciones para ejecutar el trigger:** Se debe definir un **evento** que causa la comprobación
    del trigger y una **condición** que se debe cumplir para ejecutar el trigger.

 3. **Especificar las acciones:** Se debe precisar qué acciones se van a realizar cuando se ejecute el trigger.

La base de datos almacena trigger como si fuesen datos normales, por lo que son persistentes y accesibles para 
todas las operaciones de la base de datos. Una vez se almacena un trigger en la base de datos, el sistema de 
base de datos asume la responsabilidad de ejecutarlo cada vez que ocurra el evento especificado y se satisfaga
la condición correspondiente.

Algunas aplicaciones de triggers
===============================  

El tigger es útil en una serie de situaciones diferentes. Un ejemplo es realizar una función de registro. 
Algunas acciones críticas para la integridad de una base de datos, tales como insertar, editar o eliminar 
una fila de la tabla, podrían desencadenar una inscripción en un registro que documente la acción realizada. 
El registro podrían grabar no sólo lo que se modificó, sino también cuando fue modificada y por quién.

Los triggers también pueden ser usados para mantener una base de datos consistente. Por ejemplo si se tiene 
una relación de *Pedidos*, el pedido de un producto especifico puede activar una sentencia que cambie el 
estado de ese producto en la tabla *Inventario*, y pase de *disponible* a *reservado*. Del mismo modo, la 
eliminación de una fila en la tabla de pedidos puede activar la acción para cambia el estado del producto 
de *reservado* a *disponible*. Los triggers ofrecen una flexibilidad aún mayor que la que se ilustra en 
los ejemplos anteriores. 

Creación de un disparo
=======================

 1. Un tigger se crea con la sentencia :sql:`CREATE TRIGGER`. 
 2. Después de que se crea, el tigger se encuentra a la espera de que se produzca el evento de activación. 
 3. Cuando el evento se produce desencadena una acción.  

*Forma general:*

.. code-block:: sql

	(1)CREATE trigger nombreTrigger 
	(2)BEFORE|AFTER|INSTEAD OF AlgúnEvento
	     ON nombreTabla
	(3)WHEN (condición)
	(3)Action

Ejemplo 1:
^^^^^^^^^^
.. note::

	El ejemplo a continuación es para explicar el funcionamiento de un trigger, si se desea probar 
	el postgres se debe crear la base de datos y la tabla MovieExec, más adelante se verán 2 ejemplos
	prácticos que podrán copiarse directamente en la consola.

El siguiente trigger se *dispara* por cambios en el atributo (netWorth). El efecto de este trigger es 
para frustrar cualquier intento de disminuir el valor de *netWorth* en la tabla *MovieExec*.

MovieExec(name, address, cert# , netWorth)

.. code-block:: sql

	(1) CREATE TRIGGER NetWorthTrigger
	(2) AFTER UPDATE OF netWorth ON MovieExec
	(3) REFERENCING
	(4) OLD ROW AS OldTuple,
	(5) NEW ROW AS NewTuple
	(6) FOR EACH ROW
	(7) WHEN (OldTuple.netWorth > NewTuple.netWorth)
	(8) UPDATE MovieExec
	(9) SET netWorth = OldTuple.netWorth
	(10) WHERE cert# = NewTuple.cert# ;

* **(1) Se crea el trigger:** con las palabras clave CREATE TRIGGER y el nombre del trigger *NetWorthTrigger*.

* **(2) Evento de activación:**, en este caso es la actualización del atributo *netWorth* de la relación *MovieExec*. 

* **(3) (4) y (5) Camino para la condición:** a la tupla antigua (tupla antes de la actualización) se le asigna 
  el nombre **OldTuple** y la nueva tupla (tupla después de la actualización), se asigna como NewTuple. En la 
  condición y la acción, estos nombres se pueden utilizar como si fueran variables declaradas en la cláusula 
  :sql:`FROM` de una consulta SQL.

* **(6)**, La frase :sql:`FOR EACH ROW`, expresa la exigencia de que este trigger se ejecute una vez por cada 
  tupla actualizada. 

* **(7) Condición del trigger:** Se dice que sólo se realiza la acción cuando el nuevo **netWorth** es menor 
  que el **netWorth** antiguo. 

* **(8) (9) y (10) Acción del trigger** Esta acción es una instrucción SQL de actualización que tiene el 
  efecto de restaurar el *netWorth* a lo que era antes de la actualización. Tenga en cuenta que, en principio, 
  cada tupla de *MovieExec* se considera para la actualización, pero la cláusula :sql:`WHERE` de la línea (10) 
  garantiza que sólo la tupla actualizada (el uno con el correcto # cert) se verán afectados.

Variables especiales 
=====================

Existen algunas palabras reservadas, que están disponibles para ser utilizadas por triggers. 
Algunas de estas variables especiales disponibles son las siguientes:

* :sql:`NEW`: Variable que contiene la nueva fila de la tabla para las operaciones :sql:`INSERT/UPDATE`.

* :sql:`OLD`: Variable que contiene la antigua fila de la tabla para las operaciones :sql:`UPDATE/DELETE`.

* :sql:`TG_NAME`: Variable que contiene el nombre del trigger que está usando la función actualmente.

* :sql:`TG_RELID`: identificador de objeto de la tabla que ha activado el trigger.

* :sql:`TG_TABLE_NAME`: nombre de la tabla que ha activado el trigger.

Ejemplo Práctico:
^^^^^^^^^^^^^^^^^

Se crea una base de datos y se instala el lenguaje **plpgsql**, un lenguaje imperativo que 
permite el uso de funciones.

.. code-block:: sql

	postgres=# create database trggr2;
	CREATE DATABASE
	postgres=# \c trggr2
	psql (8.4.11)
	Ahora está conectado a la base de datos «trggr2».
	trggr2=# CREATE PROCEDURAL LANGUAGE plpgsql;
	CREATE LANGUAGE

Se crea la relación **numbers**

.. code-block:: sql

	CREATE TABLE numbers(
	  number int NOT NULL,
	  square int,
	  squareroot real,
	  PRIMARY KEY (number)
	);

Se define una función llamada **save_data()**, que será la encargada de llenar los datos, 
al final del ejemplo se explica detalladamente su funcionamiento:

.. code-block:: sql

	CREATE OR REPLACE FUNCTION save_data() RETURNS TRIGGER AS $save_data$
	  DECLARE
	  BEGIN
	   
	   NEW.square := power(NEW.number,2);
	   NEW.squareroot := sqrt(NEW.number);

	   RETURN NEW;
	  END;
	$save_data$ LANGUAGE plpgsql;

Postgres retorna:

.. code-block:: sql

	CREATE FUNCTION

Ahora ya se puede definir el trigger que llamará a la función save_data() automáticamente, 
cada vez que se inserte o actualice un dato.

.. code-block:: sql

	CREATE TRIGGER save_data BEFORE INSERT OR UPDATE 
	    ON numbers FOR EACH ROW 
	    EXECUTE PROCEDURE save_data();

Postgres retorna:

.. code-block:: sql

	CREATE TRIGGER

Para ver cómo funciona el trigger se insertan los números 4, 9 y 6.

.. code-block:: sql

	trggr2=# INSERT INTO numbers (number) VALUES (4),(9),(6);
	INSERT 0 3

Y se realiza un select para ver los datos almacenados.

.. code-block:: sql

	trggr2=#  SELECT * FROM numbers;

	 number | square | squareroot 
	--------+--------+------------
	      4 |     16 |          2
	      9 |     81 |          3
	      6 |     36 |    2.44949
	(3 filas)

También se puede actualizar 

.. code-block:: sql

	trggr2=# UPDATE numbers SET number = 7 WHERE number = 6;
	UPDATE 1
	trggr2=# SELECT * FROM numbers;
	 number | square | squareroot 
	--------+--------+------------
	      4 |     16 |          2
	      9 |     81 |          3
	      7 |     49 |    2.64575
	(3 filas)

Como se puede apreciar, solo se ha insertado o actualizado el valor number pero al hacerlo automáticamente 
se llenaron los valores para los atributos *square* y *squareroot*. Esto es debido a que el tigger estaba 
definido para activarse al realizar un :sql:`INSERT` o :sql:`UPDATE`. Por cada uno de estos comandos el trigger 
ordenó la ejecución de la función save_data(), una vez por cada fila involucrada. Es decir cuando realizamos el 
primer :sql:`INSERT` (number = 4), el trigger save_data llama a la función save_data() una vez. 

* El valor de la variable NEW al empezar a ejecutarse save_data() es: ``number=4, square=NULL, squareroot=NULL``. 
  La tabla numbers aún está vacía. 

* A continuación se calcula el cuadrado y la raíz cuadrada de 4, estos valores se asignan a ``NEW. square`` 
  y ``NEW. squareroot`` respectivamente. Ahora la variable NEW contiene ``number=4, square=16, squareroot=2``. 

 Para calcular el cuadrado de un número se utiliza la instrucción :sql:`power`, que recibe como parámetros el 
 número que se ingrese y el número al cual se eleva. Para calcular la raíz cuadrara de un número se utiliza 
 la instrucción :sql:`sqrt` que recibe como parámetro el nuevo número.

* Con la sentencia RETURN NEW, se retorna la fila RECORD almacenada en la variable NEW, el sistema almacena 
  entonces NEW en la tabla numbers.

Cuándo no deben usarse los triggers
=====================================

Existen algunos casos que pueden ser manejados de mejor forma con otras técnicas:

* **Realizar resúmenes de datos:** Muchos sistemas de bases de datos actuales soportan las vistas 
  materializadas, que proporcionan una forma mucho más sencilla de mantener **los datos de resumen**. 

* **Respaldo de las bases de datos:** Anteriormente los diseñadores de sistemas,  usaban triggers con 
  la inserción, eliminación o actualización de las relaciones para registrar los cambios. Un proceso 
  separado copiaba los cambios al respaldo de la base de datos, y el sistema ejecutaba los cambios 
  sobre la réplica. Sin embargo, los sistemas de bases de datos modernos proporcionan características 
  incorporadas para el respaldo de bases de datos, haciendo innecesarios a los triggers para la réplica 
  en la mayoría de los casos. 

Los triggers se deberían escribir con sumo cuidado, dado que un error de un trigger detectado en tiempo de 
ejecución causa el fallo de la instrucción de inserción, borrado o actualización que inició el trigger. 
En el peor de los casos esto podría dar lugar a una cadena infinita de triggers. Generalmente, los sistemas 
de bases de datos limitan la longitud de las cadenas de triggers.

