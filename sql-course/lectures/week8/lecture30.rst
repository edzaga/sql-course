Lectura 30 – Mantenimiento de la Base de Datos
---------------------------------------------------------------

.. role:: sql(code)
         :language: sql
         :class: highlight

Introducción
~~~~~~~~~~~~~~

Una base de datos requiere de una mantención periódica, de lo contrario puede desarrollar problemas en una o más áreas, lo cual a largo plazo puede provocar un mal rendimiento de la aplicación, llegando incluso a perdidas de datos.

Existen actividades que el administrador del sistema gestor de bases de datos debe realizar habitualmente. En el caso de PostgreSQL, mantenimiento de los identificadores internos y de las estadísticas de planificación de las consultas, a una reindexación periódica de las tablas, y al tratamiento de los ficheros de registro.

Rutinas de mantenimiento y monitoreo
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Vacuum
===========

:sql:`VACUUM` **es el proceso que realiza una limpieza a la base de datos en PostgreSQL**. Se eliminan definitivamente tuplas marcadas para borrar y se efectúa una reorganización de datos a nivel físico.

El :sql:`VACUUM` se realiza periódicamente se para:

* **Recuperar espacio en disco perdido por datos borrados o actualizados**. En operaciones normales de PostgreSQL, las tuplas que se eliminan o quedan obsoletas por una actualización no se eliminan físicamente de su tabla, sino que permanecen hasta se ejecuta un :sql:`VACUUM`. Por lo tanto es necesario hacer  :sql:`VACUUM` periódicamente, especialmente en las tablas frecuentemente actualizadas.

* Actualizar las estadísticas de datos utilizados por el planificador de consultas SQL.

* Protegerse ante la pérdida de datos por reutilización de identificadores de transacción.

**sintaxis**

.. code-block:: sql

	VACUUM [ FULL ] [ FREEZE ] [ VERBOSE ] [ table ]
	VACUUM [ FULL ] [ FREEZE ] [ VERBOSE ] ANALYZE [ table [ (column [, ...] ) ] ]

:sql:`VACUUM` puede recibir ciertos parámetros para realizar los diferentes tipos de vaciamiento:

* :sql:`FREEZE` La opción FREEZE esta depreciada y será removida en liberaciones futuras.

* :sql:`FULL` Selecciona el vaciamiento "completo", el cual recupera más espacio, pero toma mucho más tiempo y bloquea exclusivamente la tabla.

* :sql:`VERBOSE` Imprime un reporte detallado de la actividad de vaciamiento para cada tabla.

* :sql:`ANALYZE` Actualiza las estadísticas usadas por el planeador para determinar la forma más eficiente de ejecutar una consulta.

* tabla: El nombre de una tabla específica a vaciar. Por defecto se toman todas las tablas de la base de datos actual.

* columna: El nombre de una columna específica a analizar. Por defecto se toman todas las columnas. Este comando es muy útil para automatizar vaciamientos a través de cualquier sincronizador de tareas.

Asimismo, existe la opción del Autovacuum, cuya funcionalidad es ir realizando de manera paulatina la mantención de nuestra base. Previamente y antes de activar esta funcionalidad, es recomendable leer sobre las consideraciones a tener en cuenta, para no degradar la performance de nuestro servidor.

Ejemplo:
^^^^^^^^^^^

Se ejecuta :sql:`VACUUM` sobre una base de datos existente.

.. code-block:: sql

	demo=# VACUUM;
	VACUUM

Se ejecuta :sql:`VACUUM` con parámetro FULL sobre una base de datos existente 

.. code-block:: sql

	demo=# VACUUM FULL;
	VACUUM

Se realiza :sql:`VACUUM` sobre la relación *game_score*.

.. code-block:: sql

	demo=# VACUUM game_score;
	VACUUM

En caso de que haya algún problema o acción adicional a realizar, el sistema lo indicará:

.. code-block:: sql

	demo=# VACUUM;
	WARNING: some databases have not been vacuumed in 1613770184 transactions
	HINT: Better vacuum them within 533713463 transactions, or you may have a wraparound failure.

Reindexación
=============

Para facilitas la obtención de información de una tabla se utilizan índices. El índice de una tabla permite encontrar datos rápidamente. Sin índice se debería recorrer secuencialmente toda la tabla para encontrar un registro. Es muy útil para bases de datos que posee mucha información. 

Una tabla se indexa por un campo o varios. Es importante identificar el o los datos por lo que sería útil crear un índice, aquellos campos por los cuales se realizan operaciones de búsqueda con frecuencia.

Hay distintos tipos de índice:

* **primary key:** como ya se explicó anteriormente es la clave primaria, los valores deben ser únicos y además no pueden ser nulos. 

* **index:** crea un índice común, los valores no necesariamente son únicos y aceptan valores nulos. Se le puede asignar un nombre, por defecto se coloca el nombre “key”. Pueden ser varios por tabla.

* **unique:** crea un índice para los cuales los valores deben ser únicos y diferentes, aparece un mensaje de error si intentamos agregar un registro con un valor ya existente. Permite valores nulos y pueden definirse varios por tabla. 

La reindexación completa de la base de datos no es una tarea muy habitual, pero puede mejorar sustancialmente la velocidad de las consultas complejas en tablas con mucha actividad.

Ejemplo:
^^^^^^^^

Se ejecuta el comando sobre la base de datos utilizada en la lectura 29:

.. code-block:: sql

	demo=# reindex database demo;
	NOTICE:  table "pg_class" was reindexed
	NOTICE:  table "pg_type" was reindexed
	NOTICE:  table "pg_statistic" was reindexed
	NOTICE:  table "sql_features" was reindexed
	NOTICE:  table "sql_implementation_info" was reindexed
	NOTICE:  table "sql_languages" was reindexed
	NOTICE:  table "sql_packages" was reindexed

Se utiliza las palabras reservadas :sql:`reindex database` agregando el nombre de la base de datos “demo”.

Ficheros de registro
=====================

Una buena práctica es mantener archivos de registro de la actividad del servidor, al menos de los errores que origina. Durante el desarrollo de aplicaciones se puede disponer de un registro de las consultas efectuadas, aunque disminuye el rendimiento del gestor en bases de datos de mucha actividad, y puede no ser de mucha utilidad.

De igual modo es conveniente disponer de mecanismos de rotación de los ficheros de registro; es decir, que periódicamente se mantenga un respaldo de estos ficheros y se empiecen unos nuevos, lo que permite tener un historial. 

PostgreSQL no proporciona directamente utilidades para realizar esta rotación, pero en la mayoría de sistemas Unix vienen incluidas utilidades como **logrotate** que realizan esta tarea a partir de una planificación temporal.

.. code-block:: sql

	VACUUM
	demo=# VACUUM VERBOSE ANALYZE;
	INFO:  analyzing "pg_catalog.pg_operator"
	INFO:  "pg_operator": scanned 13 of 13 pages, containing 704 live rows and 0 dead rows; 704 rows in sample, 704 estimated total rows
	INFO:  vacuuming "pg_catalog.pg_opfamily"
	INFO:  index "pg_opfamily_am_name_nsp_index" now contains 68 row versions in 2 pages
	DETALLE:  0 index row versions were removed.
	0 index pages have been deleted, 0 are currently reusable.
	CPU 0.00s/0.00u sec elapsed 0.00 sec.
	VACUUM

Explain
=============

Este comando muestra el plan de ejecución que el administrador del sistema gestor de bases de datos Postgres genera para una consulta dada. El plan de ejecución muestra la manera en que serán escaneadas las tablas referenciadas; ya sea escaneo secuencial plano, escaneo por índice, etc. En el caso que se referencian varias tablas, los algoritmos de unión que serán utilizados para agrupar las tuplas requeridas de cada tabla de entrada.

**Sintaxis**

.. code-block:: sql

	EXPLAIN [ VERBOSE ] consulta

La opción :sql:`VERBOSE` emite la representación interna completa del plan. Usualmente esta opción es útil para la corrección de errores de Postgres.

Ejemplo 1. 
^^^^^^^^^^^^^^^

Se emplea la misma tabla utilizada en la lectura 29:

.. code-block:: sql

	demo=# SELECT * FROM game_score;
	pname | score 
	-------+-------
	 UCH   |     2
	 SW    |     4
	(2 rows)

Para mostrar un plan de consulta para una consulta simple sobre una tabla con dos columnas una del tipo :sql:`INT` y la otra :sql:`VARCHAR` :

.. code-block:: sql

	EXPLAIN SELECT * FROM game_score;
		                QUERY PLAN                        
	----------------------------------------------------------
	 Seq Scan on game_score  (cost=0.00..1.02 rows=2 width=7)
	(1 row)

Ejemplo 2. 
^^^^^^^^^^^^^^^

Se crea una tabla con un índice :sql:`INT` y se insertan 4 valores:

.. code-block:: sql

	demo=# CREATE TABLE score (num int);
	CREATE TABLE
	demo=# INSERT INTO score VALUES(1),(2),(5),(4);
	INSERT 0 4

.. code-block:: sql

	EXPLAIN SELECT * FROM foo WHERE num = 4;
		             QUERY PLAN                      
	-----------------------------------------------------
	 Seq Scan on foo  (cost=0.00..40.00 rows=12 width=4)
	   Filter: (num = 4)
	(2 rows)

   
:sql:`EXPLAIN` es la presentación del costo estimado de ejecución de la consulta, que es la suposición del planificador sobre el tiempo que tomará correr la consulta (medido en unidades de captura de páginas de disco). Se Muestra dos números: el tiempo inicial que toma devolverse la primer tupla, y el tiempo total para devolver todas las tuplas. 

