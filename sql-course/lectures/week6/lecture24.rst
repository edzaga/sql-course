Lectura 24 - Restricciones y Triggers: Triggers introducción y demostración
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

**Un Trigger es una orden que el sistema ejecuta de manera automática** como efecto secundario de alguna
modificación de la base de datos. Entonces los Triggers siguen en orden la secuencia: ``evento->condición->acción``. 
Se ejecutan mediante los comandos :sql:`INSERT`, :sql:`DELETE` y :sql:`UPDATE`. 

Para diseñar un mecanismo Trigger hay que cumplir algunos **requisitos**:

 1. **Procedimiento almacenado:** Se debe crear la base de datos y las relaciones, antes de definir el Trigger.

 2. **Especificar condiciones para ejecutar el Trigger:** Se debe definir un **evento** que causa la comprobación
    del Trigger y una **condición** que se debe cumplir para ejecutar el Trigger.

 3. **Especificar las acciones:** Se debe precisar qué acciones se van a realizar cuando se ejecute el Trigger.

La base de datos almacena Trigger como si fuesen datos normales, por lo que son persistentes y accesibles para 
todas las operaciones de la base de datos. Una vez se almacena un Trigger en la base de datos, el sistema de 
base de datos asume la responsabilidad de ejecutarlo cada vez que ocurra el evento especificado y se satisfaga
la condición correspondiente.

Algunas aplicaciones de Triggers
================================  

El Trigger es útil en una serie de situaciones diferentes. Un ejemplo es realizar una función de registro. 
Algunas acciones críticas para la integridad de una base de datos, tales como insertar, editar o eliminar 
una fila de la tabla, podrían desencadenar una inscripción en un registro que documente la acción realizada. 
El registro podrían grabar no sólo lo que se modificó, sino también cuando fue modificada y por quién.

Los Triggers también pueden ser usados para mantener una base de datos consistente. Por ejemplo si se tiene 
una relación de *Pedidos*, el pedido de un producto especifico puede activar una sentencia que cambie el 
estado de ese producto en la tabla *Inventario*, y pase de *disponible* a *reservado*. Del mismo modo, la 
eliminación de una fila en la tabla de pedidos puede activar la acción para cambia el estado del producto 
de *reservado* a *disponible*. Los Triggers ofrecen una flexibilidad aún mayor que la que se ilustra en 
los ejemplos anteriores. 

Creación de un disparo
=======================

 1. Un Trigger se crea con la sentencia :sql:`CREATE TRIGGER`. 
 2. Después de que se crea, el Trigger se encuentra a la espera de que se produzca el evento de activación. 
 3. Cuando el evento se produce desencadena una acción.  

*Forma general:*

.. code-block:: sql

	(1)CREATE TRIGGER nombreTrigger 
	(2)BEFORE|AFTER|INSTEAD OF AlgúnEvento
	     ON nombreTabla
	(3)WHEN (condición)
	(3)Action

Variables especiales 
^^^^^^^^^^^^^^^^^^^^

Existen algunas palabras reservadas, que están disponibles para ser utilizadas por Triggers. 
Algunas de estas variables especiales disponibles son las siguientes:

* :sql:`NEW`: Variable que contiene la nueva fila de la tabla para las operaciones :sql:`INSERT/UPDATE`.

* :sql:`OLD`: Variable que contiene la antigua fila de la tabla para las operaciones :sql:`UPDATE/DELETE`.

* :sql:`TG_NAME`: Variable que contiene el nombre del Trigger que está usando la función actualmente.

* :sql:`TG_RELID`: identificador de objeto de la tabla que ha activado el Trigger.

* :sql:`TG_TABLE_NAME`: nombre de la tabla que ha activado el Trigger.

Ejemplo :
^^^^^^^^^

.. note::

	El ejemplo a continuación es para explicar el funcionamiento de un Trigger, si se desea probar 
	en postgreSQL se debe crear la base de datos y la tabla Employee, más adelante se verán un ejemplo
	práctico que podrá copiarse directamente en la consola.

El siguiente Trigger se "dispara" por cambios en el atributo *salary*. El efecto de este Trigger es 
para frustrar cualquier intento de disminuir el valor de *salary* en la tabla *Employee*.

`\text{Employee}(\underline{\text{cert}},\text{name, address, salary})`

.. code-block:: sql

	(1) CREATE TRIGGER salaryTrigger
	(2) AFTER UPDATE OF salary ON Employee
	(3) REFERENCING
	(4) OLD ROW AS OldTuple,
	(5) NEW ROW AS NewTuple
	(6) FOR EACH ROW
	(7) WHEN (OldTuple.salary > NewTuple.salary)
	(8) UPDATE Employee
	(9) SET salary = OldTuple.salary
	(10) WHERE cert = NewTuple.cert ;

* **(1) Se crea el Trigger:** con las palabras claves :sql:`CREATE TRIGGER` y el nombre del Trigger *salaryTrigger*.

* **(2) Evento de activación:**, en este caso es la actualización del atributo *salary* de la relación *Employee*. 

* **(3) (4) y (5) Camino para la condición:** a la tupla antigua (tupla antes de la actualización) se le asigna 
  el nombre **OldTuple** y la nueva tupla (tupla después de la actualización), se asigna como NewTuple. En la 
  condición y la acción, estos nombres se pueden utilizar como si fueran variables declaradas en la cláusula 
  :sql:`FROM` de una consulta SQL.

* **(6)**, La frase :sql:`FOR EACH ROW`, expresa la exigencia de que este Trigger se ejecute una vez por cada 
  tupla actualizada. 

* **(7) Condición del Trigger:** Se dice que sólo se realiza la acción cuando el nuevo **salary** es menor 
  que el **salary** antiguo. 

* **(8) (9) y (10) Acción del Trigger** Esta acción es una instrucción SQL de actualización que tiene el 
  efecto de restaurar el *salary* a lo que era antes de la actualización. Tenga en cuenta que, en principio, 
  cada tupla de *Employee* se considera para la actualización, pero la cláusula :sql:`WHERE` de la línea (10) 
  garantiza que sólo la tupla actualizada (con el correcto *cert*) se verán afectados.


Funciones
==========

Existe una forma de separar las **acciones** y las **condiciones** de un Trigger. Esto se logra mediante el uso 
de **funciones**. Uno de los motivos de utilizar funciones es mantener la lógica lejos de la aplicación, con esto 
se consigue consistencia entre aplicaciones y reducción de funcionalidad duplicada. Además un acceso predefinido a
objetos restringidos. 

SQL es un lenguaje declarativo, pero en ocasiones se requiere de otro tipo de lenguajes. El manejo de funciones permite 
utilizar distintos de lenguajes, de manera que se puede escoger la herramienta adecuada a cada caso. Para efecto de
este curso se usará un **lenguaje imperativo**, llamado **PL/pgSQL** (Procedural Language/PostgreSQL Structured Query Language).

.. note::

	Un **Lenguaje imperativo** le ordena a la computadora cómo realizar una tarea siguiendo una serie de pasos 
        o instrucciones.
	La ejecución de estos comandos se realiza, en la mayor parte de ellos, secuencialmente, es decir, hasta que
        un comando no ha sido ejecutado no se lee el siguiente. Aunque también existen los bucles controlados que se 
	repiten hasta la ocurrencia de algún evento.

**PL/pgSQL** dispone de estructuras condicionales y repetitivas. Se pueden realizar cálculos complejos y crear nuevos tipos 
de datos de usuario. En **PL/pgSQL** se pueden crear funciones. En esta sección se verá como dichas funciones pueden ser 
ejecutadas en eventos de tipo Trigger.


Ejemplo Práctico 1:
^^^^^^^^^^^^^^^^^^^^

Se crea una base de datos y se instala el lenguaje **plpgsql**.

.. code-block:: sql

	postgres=# create database trggr2;
	CREATE DATABASE
	postgres=# \c trggr2
	psql (8.4.11)
	Ahora está conectado a la base de datos «trggr2».
	trggr2=# CREATE PROCEDURAL LANGUAGE plpgsql;
	CREATE LANGUAGE

Se crea la relación *numbers*

.. code-block:: sql

	CREATE TABLE numbers(
	  number int NOT NULL,
	  square int,
	  squareroot real,
	  PRIMARY KEY (number)
	);

Se define una función llamada ``save_data()``, que será la encargada de llenar los datos, 
al final del ejemplo se explica detalladamente su funcionamiento:

.. code-block:: sql

	CREATE OR REPLACE FUNCTION save_data() RETURNS Trigger AS $save_data$
	  DECLARE
	  BEGIN
	   
	   NEW.square := power(NEW.number,2);
	   NEW.squareroot := sqrt(NEW.number);

	   RETURN NEW;
	  END;
	$save_data$ LANGUAGE plpgsql;

PostgreSQL retorna:

.. code-block:: sql

	CREATE FUNCTION

Ahora ya se puede definir el Trigger que llamará a la función ``save_data()`` automáticamente, 
cada vez que se inserte o actualice un dato.

.. code-block:: sql

	CREATE TRIGGER save_data BEFORE INSERT OR UPDATE 
	    ON numbers FOR EACH ROW 
	    EXECUTE PROCEDURE save_data();

PostgreSQL retorna:

.. code-block:: sql

	CREATE TRIGGER

Para ver cómo funciona el Trigger se insertan los números 4, 9 y 6.

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
	(3 rows)

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
	(3 rows)

Como se puede apreciar, solo se ha insertado o actualizado el valor number pero al hacerlo automáticamente 
se llenaron los valores para los atributos *square* y *squareroot*. Esto es debido a que el Trigger estaba 
definido para activarse al realizar un :sql:`INSERT` o :sql:`UPDATE`. Por cada uno de estos comandos el Trigger 
ordenó la ejecución de la función ``save_data()``, una vez por cada fila involucrada. Es decir cuando realizamos el 
primer :sql:`INSERT` (number = 4), el Trigger ``save_data`` llama a la función ``save_data()`` una vez. 

* El valor de la variable ``NEW`` al empezar a ejecutarse ``save_data()`` es: ``number=4, square=NULL, squareroot=NULL``. 
  La tabla *numbers* aún está vacía. 

* A continuación se calcula el cuadrado y la raíz cuadrada de 4, estos valores se asignan a ``NEW.square`` 
  y ``NEW.squareroot`` respectivamente. Ahora la variable NEW contiene ``number=4, square=16, squareroot=2``. 

 Para calcular el cuadrado de un número se utiliza la instrucción :sql:`power`, que recibe como parámetros el 
 número que se ingrese y el número al cual se eleva. Para calcular la raíz cuadrara de un número se utiliza 
 la instrucción :sql:`sqrt` que recibe como parámetro el nuevo número.

* Con la sentencia :sql:`RETURN NEW`, se retorna la fila :sql:`RECORD` almacenada en la variable :sql:`NEW`, 
  el sistema almacena entonces :sql:`NEW` en la tabla *numbers*.


Ejemplo Práctico 2:
^^^^^^^^^^^^^^^^^^^^^

Para este ejemplo se utiliza la misma relación **numbers** creada anteriormente, con los valores ya insertados. 
La función **protect_data** es usada para proteger datos en una tabla. No se permitirá el borrado de 
filas, pues retorna ``NULL`` que, como se vio en lecturas anteriores, es la inexistencia de valor.

.. code-block:: sql

	 CREATE OR REPLACE FUNCTION protect_data() RETURNS Trigger AS $Tprotect$
	  DECLARE
	  BEGIN
	   RETURN NULL;
	  END;
	$Tprotect$ LANGUAGE plpgsql;

El siguiente Trigger llamado **Tprotect** se activa antes de realizar una eliminación de datos de la 
tabla *numbers*, la acción que realiza es llamar a la función ``protect_data``.

.. code-block:: sql

	CREATE Trigger Tprotect BEFORE DELETE 
	    ON numbers FOR EACH ROW 
	    EXECUTE PROCEDURE protect_data();

Se intenta eliminar todos los datos de la tabla *numbers* con la siguiente sentencia:

.. code-block:: sql

	trggr2=# DELETE FROM numbers;
	DELETE 0

Sin embargo no es posible borrar datos pues el Trigger acciona la función ``protect_data``, y ningún dato es eliminado.

.. code-block:: sql

	trggr2=# SELECT * FROM numbers;
		 number | square | squareroot 
		--------+--------+------------
		      4 |     16 |          2
		      9 |     81 |          3
		      7 |     49 |    2.64575
		(3 rows)

Ejemplo Práctico 3:
^^^^^^^^^^^^^^^^^^^^^

Nuevamente se utiliza la relación *numbers*, las *funciones* y los *Triggers* ya creados.

La función que se verá a continuación busca evitar errores al calcular la raíz cuadrada de un número negativo. 
Observe que ocurre al intentar insertar el valor -4:

.. code-block:: sql

	trggr2=# INSERT INTO numbers (number) VALUES (-4);
	ERROR:  cannot take square root of a negative number
	CONTEXTO:  PL/pgSQL function "save_data" line 5 at assignment

La consola arroja un error en la función ``save_data``, pues no puede calcular la raíz de un número negativo.

La función **invalid_root** ocupa la sentencia ``IF`` para validar que el número sea mayor a 0. 
La construcción ``IF`` sirve para ejecutar código sólo si una condición es cierta, dicha condición debe 
ser una expresión booleana. La sentencia ``IF`` tiene la forma: **si (condición es cierta) entonces realizar sentencia**, 
si la condición no se cumple la línea o líneas se saltan y no son ejecutadas, se evalúan entonces sucesivamente 
las condiciones ``ELSIF``, que son una condición alternativa al ``IF``, en este caso se especifica que el 
nuevo número sea mayor o igual a 0.

Al ingresar a la sentencia ``IF`` se ejecuta la misma acción de la función ``protect_data``, es decir retorna ``NULL``
y no realiza ninguna acción sobre *numbers*. Si es mayor o igual a 0 se ejecuta la sentencia que está al
interior de la instrucción ``ELSIF``, esta sentencia es la misma que emplea la función ``sabe_data``, esto es, 
calcular el cuadrado y la raíz.

.. code-block:: sql

	CREATE OR REPLACE FUNCTION invalid_root() RETURNS Trigger AS $invalid_root$
	DECLARE
	BEGIN
		IF (NEW.number < 0) THEN
			RETURN NULL;
		ELSIF (NEW.number >= 0) THEN
		   NEW.square := power(NEW.number,2);
		   NEW.squareroot := sqrt(NEW.number);
		   RETURN NEW;
		END IF;

	END;
	$invalid_root$ LANGUAGE plpgsql;

Luego de tener la función se define el Trigger que detona la función. El Trigger ``invalid_root`` se 
activa cuando se realiza una inserción o actualización de datos en *numbers*.

.. code-block:: sql

	CREATE TRIGGER invalid_root BEFORE INSERT OR UPDATE
	ON numbers FOR EACH ROW
	EXECUTE PROCEDURE invalid_root();

Ahora se vuelve a probar la inserción de un número negativo:

.. code-block:: sql

	trggr2=# INSERT INTO numbers (number) VALUES (-4);
	INSERT 0 0

Esta vez no arroja error pues ingresa al ``IF`` que restringe valores negativos, 
y simplemente no inserta el valor.

Y si se intenta ingresar un numero positivo, se consigue sin problemas: 

.. code-block:: sql

	trggr2=# INSERT INTO numbers (number) VALUES (5);INSERT 0 1
	trggr2=# SELECT * FROM numbers;
	 number | square | squareroot 
	--------+--------+------------
	      4 |     16 |          2
	      9 |     81 |          3
	      7 |     49 |    2.64575
	      5 |     25 |    2.23607
	(4 filas)

Para borrar un Trigger y una función primero se elimina el Trigger:

.. code-block:: sql

	trggr2=# DROP Trigger invalid_root ON numbers;
	DROP Trigger

Y luego se puede eliminar la función:

.. code-block:: sql

	trggr2=# DROP FUNCTION invalid_root();
	DROP FUNCTION

Cuándo no deben usarse los Triggers
=====================================

Existen algunos casos que pueden ser manejados de mejor forma con otras técnicas:

* **Realizar resúmenes de datos:** Muchos sistemas de bases de datos actuales soportan las vistas 
  materializadas, que proporcionan una forma mucho más sencilla de mantener **los datos de resumen**. 

* **Respaldo de las bases de datos:** Anteriormente los diseñadores de sistemas,  usaban Triggers con 
  la inserción, eliminación o actualización de las relaciones para registrar los cambios. Un proceso 
  separado copiaba los cambios al respaldo de la base de datos, y el sistema ejecutaba los cambios 
  sobre la réplica. Sin embargo, los sistemas de bases de datos modernos proporcionan características 
  incorporadas para el respaldo de bases de datos, haciendo innecesarios a los Triggers para la réplica 
  en la mayoría de los casos. 

Los Triggers se deberían escribir con sumo cuidado, dado que un error de un Trigger detectado en tiempo de 
ejecución causa el fallo de la instrucción de inserción, borrado o actualización que inició el Trigger. 
En el peor de los casos esto podría dar lugar a una cadena infinita de Triggers. Generalmente, los sistemas 
de bases de datos limitan la longitud de las cadenas de Triggers.
