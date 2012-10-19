Lecture 5 - Introduction
-----------------------------

.. role:: sql(code)
   :language: sql
   :class: highlight

SQL (Structured Query Language) es un tipo de lenguaje vinculado con la gestión de
bases de datos de carácter relacional que permite la especificación de distintas
clases de operaciones entre éstas. Gracias a la utilización del álgebra y de
cálculos relacionales, el lenguaje SQL brinda la posibilidad de realizar consultas
que ayuden a recuperar información de las bases de datos de manera sencilla.

Characteristics
~~~~~~~~~~~~~~~~

.. index:: Características

Algunas de las características de este lenguaje son:

 * "SQL" or "sequel"
 * Supported by all major commercial database systems
 * Standardized - many new features over time
 * Interactive via GUI or prompt, or embedded in programs
 * Declarative, based on relational algebra

Data Definition Languaje (DDL)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. index:: Data Definition Languaje (DDL)


Data definition language or data description language (DDL) is a syntax similar
to a computer programming language for defining data structures, especially
database schemas.

Examples::

     Create table ...
     Drop table ... 

**Description of commands**

**Create** - To make a new database, table, index, or stored query. A CREATE
statement in SQL creates an object inside of a relational database management system
(RDBMS). The types of objects that can be created depends on which RDBMS is being
used, but most support the creation of tables, indexes, users, synonyms and
databases. Some systems (such as PostgreSQL) allow CREATE, and other DDL commands,
inside of a transaction and thus they may be rolled back.

**Drop** - To destroy an existing database, table, index, or view.
A DROP statement in SQL removes an object from a relational database management
system (RDBMS). The types of objects that can be dropped depends on which RDBMS is
being used, but most support the dropping of tables, users, and databases. Some
systems (such as PostgreSQL) allow DROP and other DDL commands to occur inside of
a transaction and thus be rolled back.

Data Manipulation Languaje (DML)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

DML son las siglas de Data Manipulation Language y se refiere a los comandos que
permiten a un usuario manipular los datos en un repositorio, es decir, añadir,
consultar, borrar o actualizar.

Examples of DML::

   `SELECT`
   `INSERT`
   `DELETE`
   `UPDATE`

**Description of commands**


**SELECT** -  returns a result set of records from one or more tables.
A SELECT statement retrieves zero or more rows from one or more database tables or
database views. In most applications, SELECT is the most commonly used Data
Manipulation Language (DML) command. As SQL is a declarative programming language,
SELECT queries specify a result set, but do not specify how to calculate it. The
database translates the query into a "query plan" which may vary between executions,
database versions and database software. This functionality is called the "query
optimizer" as it is responsible for finding the best possible execution plan for
the query, within applicable constraints.

The Basic SELECT Statement

.. code-block:: sql

 SELECT 'A_{1},\ldots,A_{n}' FROM 'R_{1}, \ldots, R_{m}' WHERE 'condition'

**Significado:**

   * :sql:`SELECT` `A_{1}, \ldots, A_{n}`: What to return
   * :sql:`FROM` `R_{1}, \ldots,R_{m}`: relations
   * :sql:`WHERE` `condition`: combine, filter

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

Other Commands
~~~~~~~~~~~~~~

indexes, constraints, views, triggers, transactions, authorization, ...


Ejemplo práctico
~~~~~~~~~~~~~~~~

.. index:: ejemplo practico

Instalamos por consola Postgresql ingresando el siguiente comando::

 sudo apt-get install postgresql postgresql-client postgresql-contrib libpq-dev

Luego para ingresar al entorno de psql escribimos en consola::

 sudo su postgres -c psql

Para crear una base de datos en este caso la llamaremos example::

 postgres=# create database example;
 CREATE DATABASE

Para ingresar a la base de datos example::

 postgres=# \c example
 psql (8.4.14)
 Ahora está conectado a la base de datos «example».

Ahora comenzamos a crear una tabla llamada cliente con las variables id que se
define como serial en que al ir agregando datos se autoincrementará automaticamente
en la base de datos example::

 example=# CREATE TABLE cliente (id SERIAL, nombre VARCHAR(50), apellido VARCHAR(50), edad INTEGER, direccion VARCHAR(50), pais VARCHAR(25));
 NOTICE:  CREATE TABLE creará una secuencia implícita «cliente_id_seq» para la columna serial «cliente.id»
 CREATE TABLE

Para ingresar datos a la tabla se realiza de la siguiente manera::

 example=# INSERT INTO cliente (nombre,apellido,edad,direccion,pais) VALUES ('John', 'Smith', 35, '7635 N La Cholla Blvd', 'EEUU');
 INSERT 0 1

Agregar más datos a la tabla clientes::

 example=# INSERT INTO cliente (nombre,apellido,edad,direccion,pais) VALUES ('John', 'Smith', 35, '7635 N La Cholla Blvd', 'EEUU');
 INSERT 0 1
 example=# INSERT INTO cliente (nombre,apellido,edad,direccion,pais) VALUES ('Judith', 'Ford', 20, '3901 W Ina Rd', 'Inglaterra');
 INSERT 0 1
 example=# INSERT INTO cliente (nombre,apellido,edad,direccion,pais) VALUES ('Sergio', 'Honores', 35, '1256 San Luis', 'Chile');
 INSERT 0 1
 example=# INSERT INTO cliente (nombre,apellido,edad,direccion,pais) VALUES ('Ana', 'Caprile', 25, '3456 Matta', 'Chile');
 INSERT 0 1

Seleccionar todos los datos de la tabla cliente::

 example=# SELECT * FROM cliente;
 id | nombre | apellido | edad |       direccion       |    pais
 ----+--------+----------+------+-----------------------+------------
  1 | John   | Smith    |   35 | 7635 N La Cholla Blvd | EEUU
  2 | John   | Smith    |   35 | 7635 N La Cholla Blvd | EEUU
  3 | Judith | Ford     |   20 | 3901 W Ina Rd         | Inglaterra
  4 | Sergio | Honores  |   35 | 1256 San Luis         | Chile
  5 | Ana    | Caprile  |   25 | 3456 Matta            | Chile
 (5 filas)

.. note::
 El asterisco (*) que está entre el :sql:`SELECT` y el :sql:`FROM` significa que se seleccionan todas las columnas de la tabla.

Como cometimos el error de ingresar en la segunda fila datos repetidos podemos
eliminarla de esta manera::

 example=# DELETE FROM cliente WHERE id=2;
 DELETE 1

Verificamos que se haya borrado::

 example=# SELECT * FROM cliente;
 id | nombre | apellido | edad |       direccion       |    pais
 ----+--------+----------+------+-----------------------+------------
  1 | John   | Smith    |   35 | 7635 N La Cholla Blvd | EEUU
  3 | Judith | Ford     |   20 | 3901 W Ina Rd         | Inglaterra
  4 | Sergio | Honores  |   35 | 1256 San Luis         | Chile
  5 | Ana    | Caprile  |   25 | 3456 Matta            | Chile
 (4 filas)

Si se desea actualizar la dirección del cliente Sergio::

 example=# UPDATE cliente SET direccion='1459 Patricio Lynch' WHERE id=4;
 UPDATE 1

Verificamos que se haya actualizado la información::

 example=# SELECT * FROM cliente;
  id | nombre | apellido | edad |       direccion       |    pais
 ----+--------+----------+------+-----------------------+------------
  1 | John   | Smith    |   35 | 7635 N La Cholla Blvd | EEUU
  3 | Judith | Ford     |   20 | 3901 W Ina Rd         | Inglaterra
  5 | Ana    | Caprile  |   25 | 3456 Matta            | Chile
  4 | Sergio | Honores  |   35 | 1459 Patricio Lynch   | Chile
 (4 filas)

Si queremos borrar toda la tabla::

 example=# DROP TABLE cliente;
 DROP TABLE

Verificamos que se haya eliminado la tabla cliente::

 example=# SELECT * FROM cliente;
 ERROR:  no existe la relación «cliente»
 LÍNEA 1: SELECT * FROM cliente;
                       ^

Clave Primaria y Foránea
~~~~~~~~~~~~~~~~~~~~~~~~

En las bases de datos relacionales, se le llama clave primaria a un campo o a una
combinación de campos que identifica de forma única a cada fila de una tabla. Por lo
que no pueden existir dos filas en una tabla que tengan la misma clave primaria.

Y las claves foráneas tienen por objetivo establecer una conexión con la clave primaria que referencian de otra tabla, creandose una relación entre las dos tablas.

----------------
Ejemplo Práctico
----------------

Primero crearemos la tabla profesores en que ID_profesor será la clave primaria y está definido como serial que automáticamente irá ingresando los valores 1, 2,3 a cada registro.::

 postgres=# CREATE TABLE profesores(ID_profesor serial, nombre VARCHAR(30), apellido VARCHAR(30), PRIMARY KEY(ID_profesor)); 
 NOTICE:  CREATE TABLE creará una secuencia implícita «profesores_id_profesor_seq» para la columna serial «profesores.id_profesor»
 NOTICE:  CREATE TABLE / PRIMARY KEY creará el índice implícito «profesores_pkey» para la tabla «profesores»
 CREATE TABLE

Ahora vamos a crear la tabla de cursos en que ID_curso será la clave primaria de esta tabla y ID_profesor será la clave foránea, que se encargará de realizar una conexión entre estas dos tablas.::

 postgres=# CREATE TABLE cursos(ID_curso serial, titulo VARCHAR(30), ID_profesor INTEGER, PRIMARY KEY(ID_curso), FOREIGN KEY(ID_profesor) REFERENCES profesores(ID_profesor));
 NOTICE:  CREATE TABLE creará una secuencia implícita «cursos_id_curso_seq» para la columna serial «cursos.id_curso»
 NOTICE:  CREATE TABLE / PRIMARY KEY creará el índice implícito «cursos_pkey» para la tabla «cursos»
 CREATE TABLE

