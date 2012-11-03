Lecture 5 - Introducción
------------------------

.. role:: sql(code)
   :language: sql
   :class: highlight

`SQL (Structured Query Language)`_ es un tipo de lenguaje vinculado con la gestión de
bases de datos de carácter relacional que permite la especificación de distintas
clases de operaciones. Gracias a la utilización del álgebra y de cálculo relacional,
el lenguaje SQL brinda la posibilidad de realizar consultas que ayuden a recuperar
información de las bases de datos de manera sencilla.

Features
~~~~~~~~~~

.. index:: Features

Algunas de las características de este lenguaje son:

 * Supported by all major commercial database systems.
 * Standardized - many new features over time.
 * Interactive via GUI or prompt, or embedded in programs.
 * Declarative, based on relational algebra.

Data Definition Language (DDL)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. index:: Data Definition Languaje (DDL)


`DDL (Data Definition Language)`_ es un lenguaje que permite definir la base de datos
(su estructura o "schemas"), tiene una sintaxis similar a los lenguajes de programación.

Examples:

.. code-block:: sql

   CREATE TABLE table_name;
   DROP TABLE table_name;
   ALTER TABLE table_name ADD id INTEGER;

**Description of commands**

 * :sql:`CREATE`:

  * To make a new database, table, index, or stored query.
  * A :sql:`CREATE` statement in SQL creates an object inside of a relational
    database management system (`RDBMS`_).
  * The types of objects that can be created depends on which RDBMS is being
    used, but most support the creation of tables, indexes, users, synonyms and
    databases.
  * Some systems (such as PostgreSQL) allow :sql:`CREATE`, and other DDL commands,
    inside of a transaction and thus they may be rolled back.

 * :sql:`DROP`:

  * To destroy an existing database, table, index, or view.
  * A :sql:`DROP` statement in SQL removes an object from a relational database
    management system (RDBMS).
  * The types of objects that can be dropped depends on which RDBMS is being used,
    but most support the dropping of tables, users, and databases.
  * Some systems (such as PostgreSQL) allow DROP and other DDL commands to occur
    inside of a transaction and thus be rolled back.

 * :sql:`ALTER`:

  * Used to modify the structure of the table, as the following cases:

    * Add a column
    * Delete a column
    * Change the name of a column
    * Change the data type for a column

Data Manipulation Languaje (DML)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

`DML (Data Manipulation Language)`_ se refiere a los comandos que permiten a un
usuario manipular los datos de las tablas, es decir, consultar tablas, añadir filas,
borrar filas y actualizar columnas.

Examples of DML

.. code-block:: sql

   SELECT field FROM table_name;
   INSERT INTO table_name(field1,...,fieldn) VALUES (data1,...,datan);
   DELETE FROM table_name WHERE condition;
   UPDATE table_name SET field = new data WHERE condition;

**Description of commands**


 * :sql:`SELECT`

  * Returns a result set of records from one or more tables.
  * A :sql:`SELECT` statement retrieves zero or more rows from one or more
    database tables or database views.
  * In most applications, :sql:`SELECT` is the most commonly used DML command.
  * As SQL is a declarative programming language, :sql:`SELECT` queries specify
    a result set, but do not specify how to calculate it.
  * The database translates the query into a "query plan" which may vary between
    executions, database versions and database software.
  * This functionality is called the "query optimizer" as it is responsible for
    finding the best possible execution plan for the query, within applicable
    constraints.

The Basic SELECT Statement

.. CMA: LaTeX no funciona dentro de código SQL

.. code-block:: sql

 SELECT A1, ..., An FROM R1, ..., Rm WHERE condition

**Significado:**

   * :sql:`SELECT` `A_{1}, \ldots, A_{n}`: What to return
   * :sql:`FROM` `R_{1}, \ldots,R_{m}`: relations
   * :sql:`WHERE` `condition`: combine, filter

Lo que busca esta consulta es mostrar las columnas `A_{1}, \ldots, A_{n}` de las tablas o relaciones `R_{1}, \ldots,R_{m}`, siguiendo alguna condición.

**Algebra relacional:**

.. math::

    \pi_{A_{1},\ldots, A_{n}} (\sigma_{condition}(R_{1} \times \ldots \times R_{m}))

Comandos SQL:

   * :sql:`INSERT` - adds one or more records to any single table in a relational
     database.
   * :sql:`DELETE` - removes one or more records from a table. A subset may be
     defined for deletion using a condition, otherwise all records are removed.
   * :sql:`UPDATE` - changes the data of one or more records in a table. Either all
     the rows can be updated, or a subset may be chosen using a condition.

Ejemplo práctico
~~~~~~~~~~~~~~~~

.. index:: ejemplo practico

.. note::

   To perform this excercise, you must use the Virtual Machine of the course
   or install **Postgresql** in your computer.

   If you have a Linux system, you can download the source from ...
   Another possibility is to use the package manager of your OS

   * For Debian/Ubuntu users you can perform the following command as a root::

      sudo apt-get install postgresql postgresql-client postgresql-contrib libpq-dev

   * For Red Hat/Scientific Linux/Fedora/CentOS users::

      yum -y install postgresql postgresql-libs postgresql-contrib postgresql-server postgresql-docs

   After the installation process, you need to enter into the **psql environment**

   * For Debian/Ubuntu users you can perform the following command as a root::

      sudo su postgres -c psql

   * For Red Hat/Scientific Linux/Fedora/CentOS users

    * Start the service. I should say OK if everything is correct
      ::

        service postgresql start

    * We change the user's password Postgres
      ::

        passwd postgres

    * Now start Postgres (enter password from above)
      ::

        su postgres

    * We started the service
      ::

        /etc/init.d/postgresql start

    * You should see a prompt "bash-4.1 $", now we enter Postgres
      ::

        psql

Primero que todo debemos *crear* una base de datos
para comenzar nuestros ejercicios.
La llamaremos **example**:

.. code-block:: sql

   postgres=# create database example;
   CREATE DATABASE

Luego de haber creado nuestra base de datos, necesitamos *ingresar*
para comenzar a realizar distintas operaciones:

.. testcase::

 postgres=# `\c example`
 psql (8.4.14)
 Ahora está conectado a la base de datos «example».

Ahora comenzamos a *crear una tabla* llamada **cliente** con las variables id que se
define como serial en que al ir agregando datos se autoincrementará automaticamente
en la base de datos example:

.. code-block:: sql

 example=# CREATE TABLE cliente (id SERIAL, nombre VARCHAR(50), apellido VARCHAR(50), edad INTEGER, direccion VARCHAR(50), pais VARCHAR(25));

Y recibiremos el siguiente mensaje::

 NOTICE:  CREATE TABLE creará una secuencia implícita «cliente_id_seq» para la columna serial «cliente.id»
 CREATE TABLE

Para *agregar* datos a la tabla **cliente** se realiza de la siguiente manera:

.. code-block:: sql

 example=# INSERT INTO cliente (nombre,apellido,edad,direccion,pais) VALUES ('John', 'Smith', 35, '7635 N La Cholla Blvd', 'EEUU');
 INSERT 0 1

*Agregar* más datos a la tabla **cliente**

.. code-block:: sql

 example=# INSERT INTO cliente (nombre,apellido,edad,direccion,pais) VALUES ('John', 'Smith', 35, '7635 N La Cholla Blvd', 'EEUU');
 INSERT 0 1
 example=# INSERT INTO cliente (nombre,apellido,edad,direccion,pais) VALUES ('Judith', 'Ford', 20, '3901 W Ina Rd', 'Inglaterra');
 INSERT 0 1
 example=# INSERT INTO cliente (nombre,apellido,edad,direccion,pais) VALUES ('Sergio', 'Honores', 35, '1256 San Luis', 'Chile');
 INSERT 0 1
 example=# INSERT INTO cliente (nombre,apellido,edad,direccion,pais) VALUES ('Ana', 'Caprile', 25, '3456 Matta', 'Chile');
 INSERT 0 1

*Seleccionar* todos los datos de la tabla **cliente**

.. code-block:: sql

 example=# SELECT * FROM cliente;
 id | nombre | apellido | edad |       direccion       |    pais
 ---+--------+----------+------+-----------------------+------------
  1 | John   | Smith    |   35 | 7635 N La Cholla Blvd | EEUU
  2 | John   | Smith    |   35 | 7635 N La Cholla Blvd | EEUU
  3 | Judith | Ford     |   20 | 3901 W Ina Rd         | Inglaterra
  4 | Sergio | Honores  |   35 | 1256 San Luis         | Chile
  5 | Ana    | Caprile  |   25 | 3456 Matta            | Chile
 (5 filas)

.. note::
 El asterisco (*) que está entre el :sql:`SELECT` y el :sql:`FROM` significa que se seleccionan todas las columnas de la tabla.

Si deseamos seleccionar la columna nombre con apellido la consulta deberia ser

.. code-block:: sql

   SELECT nombre, apellido FROM cliente;

Como cometimos el error de *agregar* en la segunda fila datos repetidos, pero se puede *eliminar* de la siguiente manera

.. code-block:: sql

   example=# DELETE FROM cliente WHERE id=2;
   DELETE 1

Verificamos que se haya *eliminado*

.. code-block:: sql

 example=# SELECT * FROM cliente;
 id | nombre | apellido | edad |       direccion       |    pais
 ---+--------+----------+------+-----------------------+------------
  1 | John   | Smith    |   35 | 7635 N La Cholla Blvd | EEUU
  3 | Judith | Ford     |   20 | 3901 W Ina Rd         | Inglaterra
  4 | Sergio | Honores  |   35 | 1256 San Luis         | Chile
  5 | Ana    | Caprile  |   25 | 3456 Matta            | Chile
 (4 filas)

Si se desea *actualizar* la dirección del cliente Sergio de la tabla **cliente**

.. code-block:: sql

 example=# UPDATE cliente SET direccion='1459 Patricio Lynch' WHERE id=4;
 UPDATE 1

Se puede *seleccionar* la tabla **cliente** para verificar que se haya actualizado la información

.. code-block:: sql

 example=# SELECT * FROM cliente;
 id | nombre | apellido | edad |       direccion       |    pais
 ---+--------+----------+------+-----------------------+------------
  1 | John   | Smith    |   35 | 7635 N La Cholla Blvd | EEUU
  3 | Judith | Ford     |   20 | 3901 W Ina Rd         | Inglaterra
  5 | Ana    | Caprile  |   25 | 3456 Matta            | Chile
  4 | Sergio | Honores  |   35 | 1459 Patricio Lynch   | Chile
 (4 filas)

Para *borrar* la tabla **cliente**

.. code-block:: sql

 example=# DROP TABLE cliente;
 DROP TABLE

Seleccionamos la tabla **cliente**, para verificar que se haya eliminado

.. code-block:: sql

 example=# SELECT * FROM cliente;

Recibiremos el siguiente mensaje::

 ERROR:  no existe la relación «cliente»
 LÍNEA 1: SELECT * FROM cliente;
                       ^

Clave Primaria y Foránea
~~~~~~~~~~~~~~~~~~~~~~~~

En las bases de datos relacionales, se le llama **clave primaria** a un campo o a una
combinación de campos que identifica de forma única a cada fila de una tabla. Por lo
que no pueden existir dos filas en una tabla que tengan la misma clave primaria.

Y las **claves foráneas** tienen por objetivo establecer una conexión con la clave
primaria que referencian de otra tabla, creandose una asociación entre las dos tablas.

----------------
Ejemplo Práctico
----------------

Primero crearemos la tabla profesores en que ID_profesor será la clave primaria y está
definido como serial que automáticamente irá ingresando los valores 1, 2, 3 a cada registro.

.. code-block:: sql

 postgres=# CREATE TABLE profesores(ID_profesor serial, nombre VARCHAR(30), apellido VARCHAR(30), PRIMARY KEY(ID_profesor));

Recibiremos el siguiente mensaje::

 NOTICE:  CREATE TABLE creará una secuencia implícita «profesores_id_profesor_seq» para la columna serial «profesores.id_profesor»
 NOTICE:  CREATE TABLE / PRIMARY KEY creará el índice implícito «profesores_pkey» para la tabla «profesores»
 CREATE TABLE

Ahora vamos a crear la tabla de cursos en que ID_curso será la clave primaria de esta
tabla y ID_profesor será la clave foránea, que se encargará de realizar una conexión
entre estas dos tablas.

.. code-block:: sql

 postgres=# CREATE TABLE cursos(ID_curso serial, titulo VARCHAR(30), ID_profesor INTEGER, PRIMARY KEY(ID_curso), FOREIGN KEY(ID_profesor) REFERENCES profesores(ID_profesor));

Recibiremos el siguiente mensaje::

 NOTICE:  CREATE TABLE creará una secuencia implícita «cursos_id_curso_seq» para la columna serial «cursos.id_curso»
 NOTICE:  CREATE TABLE / PRIMARY KEY creará el índice implícito «cursos_pkey» para la tabla «cursos»
 CREATE TABLE

Se *insertarán* algunos datos para poder realizar una *selección* y poder visualizar el funcionamiento de la clave primaria y foránea

.. code-block:: sql

 postgres=# INSERT INTO profesores(nombre, apellido) VALUES('Alfred','JOHNSON');
 INSERT 0 1
 postgres=# INSERT INTO profesores(nombre, apellido) VALUES('Alisson','DAVIS');
 INSERT 0 1
 postgres=# INSERT INTO profesores(nombre, apellido) VALUES('Bob','MILLER');
 INSERT 0 1
 postgres=# INSERT INTO profesores(nombre, apellido) VALUES('Betty','WILSON');
 INSERT 0 1
 postgres=# INSERT INTO profesores(nombre, apellido) VALUES('Christin','JONES');
 INSERT 0 1
 postgres=# INSERT INTO profesores(nombre, apellido) VALUES('Edison','SMITH');
 INSERT 0 1

Quedando la tabla de la siguiente manera si seleccionamos todas las columnas.

.. code-block:: sql

 postgres=# SELECT * FROM profesores;
  id_profesor |  nombre  | apellido
 -------------+----------+----------
            1 | Alfred   | JOHNSON
            2 | Alisson  | DAVIS
            3 | Bob      | MILLER
            4 | Betty    | WILSON
            5 | Christin | JONES
            6 | Edison   | SMITH
 (6 filas)

.. note::

 Como se puede ver en la tabla de **profesores**, el "id_profesor" que lo definimos como tipo de dato serial se autoincremento automáticamente sin necesidad de ingresarlo nosotros, además se definió como una clave primaria.

Ahora insertamos los datos de la tabla **cursos**.

.. code-block:: sql

 postgres=# INSERT INTO cursos(titulo, ID_profesor) VALUES('Base de datos',2);
 INSERT 0 1
 postgres=# INSERT INTO cursos(titulo, ID_profesor) VALUES('Estructura de datos',5);
 INSERT 0 1
 postgres=# INSERT INTO cursos(titulo, ID_profesor) VALUES('Arquitectura de computadores',1);
 INSERT 0 1
 postgres=# INSERT INTO cursos(titulo, ID_profesor) VALUES('Recuperacion de informacion',3);
 INSERT 0 1
 postgres=# INSERT INTO cursos(titulo, ID_profesor) VALUES('Teoria de sistemas',4);
 INSERT 0 1
 postgres=# INSERT INTO cursos(titulo, ID_profesor) VALUES('Sistemas de informacion',6);
 INSERT 0 1

Quedando la tabla de siguiente manera.

.. code-block:: sql

 postgres=# SELECT * FROM cursos;
  id_curso |            titulo            | id_profesor
 ----------+------------------------------+-------------
         1 | Base de datos                |           2
         2 | Estructura de datos          |           5
         3 | Arquitectura de computadores |           1
         4 | Recuperacion de informacion  |           3
         5 | Teoria de sistemas           |           4
         6 | Sistemas de informacion      |           6
 (6 filas)

.. note::

 Un profesor puede tener asignado más de un curso, no existe restricción.

Ahora queremos tener solo una tabla con el "nombre", "apellido" del profesor y el "titulo" de la asignatura que dicta. Para esto realizamos una *selección* de la siguiente manera:

.. code-block:: sql

 postgres=# SELECT nombre, apellido, titulo FROM profesores, cursos WHERE profesores.id_profesor=cursos.id_profesor;
   nombre  | apellido |            titulo
 ----------+----------+------------------------------
  Alisson  | DAVIS    | Base de datos
  Christin | JONES    | Estructura de datos
  Alfred   | JOHNSON  | Arquitectura de computadores
  Bob      | MILLER   | Recuperacion de informacion
  Betty    | WILSON   | Teoria de sistemas
  Edison   | SMITH    | Sistemas de informacion
 (6 filas)

Aquí es donde tiene la importancia la clave primaria y foránea, puesto que en la condición podemos realizar una igualdad entre los "id_profesor" de la tabla **profesores** y **cursos**.

.. _`SQL (Structured Query Language)`: http://en.wikipedia.org/wiki/SQL
.. _`DDL (Data Definition Language)`: http://en.wikipedia.org/wiki/Data_Definition_Language
.. _`RDBMS`: http://en.wikipedia.org/wiki/Relational_database#Relational_database_management_systems
.. _`DML (Data Manipulation Language)`: http://en.wikipedia.org/wiki/Data_manipulation_language
