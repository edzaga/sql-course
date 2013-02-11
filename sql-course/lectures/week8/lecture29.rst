Lectura 29 - Vistas: Vistas materializadas
-------------------------------------------

.. role:: sql(code)
         :language: sql
         :class: highlight

Introducción
~~~~~~~~~~~~~~~

En las lecturas anteriores se vio la vista virtual que es el tipo usual de vista que se 
define como una consulta de la base de datos. En esta lectura se verán las **vistas materializadas**, 
que **almacena el resultado de la consulta en una tabla caché real**. Es una solución 
muy utilizada en entornos de almacenes de datos (datawarehousing), donde el acceso frecuente 
a las tablas básicas resulta demasiado costoso.


Definición
~~~~~~~~~~~~~

Una vista materializada **almacena físicamente los datos** resultantes de ejecutar la 
consulta definida en la vista. Inicialmente se almacenan los datos de las tablas base 
al ejecutar la consulta y se actualiza periódicamente a partir de las tablas originales.  
Las vistas materializadas constituyen datos redundantes, en el sentido de que su contenido 
puede deducirse de la definición de la vista y del resto del contenido de la base de datos. 

Se define una vista especificando una consulta de Vista en SQL, a través de un conjunto de
tablas existentes **(R1, R2,…Rn)**.

``Vista V= ConsultaSQL(R1, R2, …, Rn)``

De esta forma se crea en realidad una tabla física V con el esquema del resultado de la consulta. 
Puede referirse a V como si fuese una relación, ya que en realidad es una tabla almacenada en una 
base de datos.

Ventaja
=========

Poseen las mismas ventajas de visitas virtuales. La diferencia radica en que las vistas 
materializadas mejoran el rendimiento de consultas sobre la base de datos, pues  proporciona 
un acceso mucho más eficiente. Con la utilización de vistas materializadas se logra aumentar 
el rendimiento de las consultas SQL además de ser un método de optimización a nivel físico 
en modelos de datos muy complejos y/o con muchos datos.

Desventajas
==============

* Incrementa el tamaño de la base de datos

* Posible falta de sincronía, es decir, que los datos de la vista pueden estar potencialmente 
  desfasados con respecto a los datos reales. Al contener físicamente los datos de las tablas base, 
  si cambian los datos de estas tablas no se reflejarán en la vista materializada. 


Mantenimiento de las vistas
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Como se mencionó anteriormente un problema que poseen las vistas materializadas es que hay que 
mantenerlas actualizadas cuando se modifican los datos de las tablas bases que emplea la vista. 
La tarea de actualizar una vista se denomina **mantenimiento de la vista materializada**. 
También hay que tener presente que al modificar una vista debe actualizarse la(s) tabla(s) 
de origen(es), pues las vistas y las relaciones deben estar sincronizadas.

Una manera de realizar mantenimiento es utilizando :sql:`Triggers` para la inserción, la 
eliminación y la actualización de cada relación de la definición de la vista. Los :sql:`Triggers` 
deben modificar todo el contenido de la vista materializada.

Una mejor opción es editar sólo la parte modificada de la vista materializada, lo que se conoce 
como **mantenimiento incremental de la vista**. 

Los sistemas modernos de bases de datos proporcionan más soporte directo para el mantenimiento 
incremental de las vistas. Los programadores de bases de datos ya no necesitan definir :sql:`Triggers` 
para el mantenimiento de las vistas. Por el contrario, una vez que se ha declarado materializada una vista, 
el sistema de bases de datos calcula su contenido y actualiza de manera incremental el contenido 
cuando se modifican los datos subyacentes.

Creación de una vista
~~~~~~~~~~~~~~~~~~~~~~~

En algunos sistemas de gestión de bases de datos poseen las palabras reservadas :sql:`CREATE MATERIALIZED VIEW` 
que define una vista materializada a partir de una o más tablas físicas.

Forma general:

.. code-block:: sql

	CREATE MATERIALIZED VIEW viewName  
	  AS SELECT ... FROM ... WHERE ...

Sin embargo en esta lectura se utilizará otro método para tratar las vistas materializada. Primero se crea 
la tabla *matviews*  para guardar la información de una vista materializada.

.. code-block:: sql

	CREATE TABLE matviews (
	  mv_name NAME NOT NULL PRIMARY KEY
	  , v_name NAME NOT NULL
	  , last_refresh TIMESTAMP WITH TIME ZONE
	);

Donde:

* *mv_name*: es el nombre de la vista materializada representada por esta fila.

* *v_Name*: es el nombre de la vista que se basa la vista materializada.

* *last_refresh*: La hora de la última actualización de la vista materializada.

Ahora se crea una función *create_matview* escrita en PL/pgSQL. Dicha función inserta una 
fila en la tabla *matviews* y crea la vista materializada. Recibe el nombre de la vista materializada, 
y el nombre de la vista que se basa. Tenga en cuenta que se debe crear la vista virtual en la que 
se basa, más adelante se explica cómo se crea y utiliza esta vista.
Esta función ve si una vista materializada con el nombre que recibe ya está creada. Si es así, 
se produce una excepción. De lo contrario, se crea una nueva tabla con la vista, e inserta una 
fila en la tabla *matviews*.

.. code-block:: sql

	CREATE OR REPLACE FUNCTION create_matview(NAME, NAME)
	RETURNS VOID
	SECURITY DEFINER
	LANGUAGE plpgsql AS '
	DECLARE
	    matview ALIAS FOR $1;
	    view_name ALIAS FOR $2;
	    entry matviews%ROWTYPE;
	BEGIN
	    SELECT * INTO entry FROM matviews WHERE mv_name = matview;

	    IF FOUND THEN
		RAISE EXCEPTION ''Materialized view ''''%'''' already exists.'',
		  matview;
	    END IF;

	    EXECUTE ''REVOKE ALL ON '' || view_name || '' FROM PUBLIC''; 

	    EXECUTE ''GRANT SELECT ON '' || view_name || '' TO PUBLIC'';

	    EXECUTE ''CREATE TABLE '' || matview || '' AS SELECT * FROM '' || view_name;

	    EXECUTE ''REVOKE ALL ON '' || matview || '' FROM PUBLIC'';

	    EXECUTE ''GRANT SELECT ON '' || matview || '' TO PUBLIC'';

	    INSERT INTO matviews (mv_name, v_name, last_refresh)
	      VALUES (matview, view_name, CURRENT_TIMESTAMP); 
	    
	    RETURN;
	END
	';

La función *drop_matview* elimina la vista materializada y la entrada de *matviews* , Dejando la vista virtual sola.

.. code-block:: sql

	CREATE OR REPLACE FUNCTION drop_matview(NAME) RETURNS VOID
	SECURITY DEFINER
	LANGUAGE plpgsql AS '
	DECLARE
	    matview ALIAS FOR $1;
	    entry matviews%ROWTYPE;
	BEGIN

	    SELECT * INTO entry FROM matviews WHERE mv_name = matview;

	    IF NOT FOUND THEN
		RAISE EXCEPTION ''Materialized view % does not exist.'', matview;
	    END IF;

	    EXECUTE ''DROP TABLE '' || matview;
	    DELETE FROM matviews WHERE mv_name=matview;

	    RETURN;
	END
	';


La función *refresh_matview* actualiza las vistas materializadas de manera que los datos 
no se convierten en obsoletos. Esta función sólo necesita el nombre de la *matview*. 
Se utiliza un algoritmo que elimina todas las filas y vuelve a colocarlas en la vista.

.. code-block:: sql

	CREATE OR REPLACE FUNCTION refresh_matview(name) RETURNS VOID
	SECURITY DEFINER
	LANGUAGE plpgsql AS '
	DECLARE 
	    matview ALIAS FOR $1;
	    entry matviews%ROWTYPE;
	BEGIN

	    SELECT * INTO entry FROM matviews WHERE mv_name = matview;

	    IF NOT FOUND THEN
		RAISE EXCEPTION ''Materialized view % does not exist.'', matview;
	    END IF;

	    EXECUTE ''DELETE FROM '' || matview;
	    EXECUTE ''INSERT INTO '' || matview
		|| '' SELECT * FROM '' || entry.v_name;

	    UPDATE matviews
		SET last_refresh=CURRENT_TIMESTAMP
		WHERE mv_name=matview;

	    RETURN;
	END
	';

Ejemplo
^^^^^^^^

Para este ejemplo se utilizarán las funciones mostradas anteriormente, primero se instala el lenguaje plpgsql:

.. code-block:: sql

	viewm=# CREATE PROCEDURAL LANGUAGE plpgsql;
	CREATE LANGUAGE
 
Con el lenguaje ya instalado se crea la relación *matviews* y se agregar las funciones 
*create_matview*, *drop_matview* y *refresh_matview* a la base de datos.

Se crea la relación *game_score*, también se crea la vista virtual *player_total_score_v*

.. code-block:: sql

	CREATE TABLE game_score (
	  pname VARCHAR(255) NOT NULL,
	  score INTEGER NOT NULL);

	CREATE VIEW player_total_score_v AS
	 SELECT pname, sum(score) AS total_score
	 FROM game_score GROUP BY pname;

Dado que muchos de los equipos juegan todos los días, y correr la vista es un poco caro, 
se decide implementar una vista materializada en *player_total_score_v* . Para ello se crea 
la vista invocando la función *create_matview* pasándole por parámetros el nombre de la 
vista materializada *player_total_score_mv* y el nombre de la vista virtual *player_total_score_v*.

.. code-block:: sql

	viewm=# SELECT create_matview('player_total_score_mv', 'player_total_score_v');

	create_matview 
	----------------
	 
	(1 row)

Al ejecutar un select sobre la vista se observa que está creada y vacía:

.. code-block:: sql

	viewm=# SELECT * from player_total_score_mv;
	 pname | total_score 
	-------+-------------
	(0 row)

Los datos de la vista se almacena en la relación *matviews*

.. code-block:: sql

	 SELECT * from matviews;
		mv_name        |        v_name        |         last_refresh         
	-----------------------+----------------------+------------------------------
	 player_total_score_mv | player_total_score_v | 2013-02-11 10:54:56.08571-03
	(1 row)


Se insertan valores en la relación *game_score*:

.. code-block:: sql

	viewm=# INSERT INTO game_score ( pname, score)  VALUES ('UCH',2), ('SW',4);
	INSERT 0 2

Al ejecutar un :sql:`SELECT` se observa que la vista se mantiene vacía:

.. code-block:: sql

	viewm=# SELECT * from player_total_score_mv;
	 pname | total_score 
	-------+-------------
	(0 row)

Para actualizar la vista materializada se debe ocupar la función *refresh_matview*:

.. code-block:: sql

	viewm=# SELECT refresh_matview('player_total_score_mv');
	 refresh_matview 
	-----------------
	 
	(1 row)

Esta vez al volver a seleccionar la vista aparecen los valores insertados en la relación *game_score*

.. code-block:: sql

	viewm=# SELECT * from player_total_score_mv;
	 pname | total_score 
	-------+-------------
	 SW    |           4
	 UCH   |           2
	(2 rows)

Para eliminar la vista se usa la función *drop_matview*:

.. code-block:: sql

	viewm=# SELECT drop_matview('player_total_score_mv');
	 drop_matview 
	--------------
	 
	(1 row)

Al hacer un :sql:`SELECT` a la vista materializada, aparece un error pues ya no existe.

.. code-block:: sql

	viewm2=# SELECT * from player_total_score_mv;
	ERROR:  relation "player_total_score_mv" does not exist
	LÍNEA 1: SELECT * from player_total_score_mv;

Se revisa la relación *matviews* y aquí también se eliminó la vista materializada: 

.. code-block:: sql
	viewm=# SELECT * from matviews;
	 mv_name | v_name | last_refresh 
	---------+--------+--------------
	(0 row)

