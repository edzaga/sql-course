Lectura 5 - Introducción
------------------------

.. role:: sql(code)
   :language: sql
   :class: highlight

`SQL (Lenguaje de consulta estructurado))`_ es un tipo de lenguaje vinculado con la gestión de
bases de datos de carácter relacional que permite la especificación de distintas
clases de operaciones. Gracias a la utilización del álgebra y de cálculo relacional,
el lenguaje SQL brinda la posibilidad de realizar consultas que ayuden a recuperar
información de las bases de datos de manera sencilla.

Características
~~~~~~~~~~~~~~~

.. index:: Características

Algunas de las características de este lenguaje son:

 * Compatible con todos los sistemas de bases de datos comerciales importantes.
 * Estandarizada - nuevas características en el tiempo.
 * Interactiva a través de interfaz gráfica de usuario o del sistema.
 * Declarativa, basada en álgebra relacional.

Lenguaje de descripción de datos (DDL)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. index:: Lenguaje de descripción de datos (DDL)


`DDL (Lenguaje de descripción de datos)`_ es un lenguaje que permite definir la base de datos
(su estructura o "schemas"), tiene una sintaxis similar a los lenguajes de programación.

Ejemplos:
^^^^^^^^^

.. code-block:: sql

   CREATE TABLE nombre_tabla;
   DROP TABLE nombre_tabla;
   ALTER TABLE nombre_tabla ADD id INTEGER;

**Descripción de los comandos**

 * :sql:`CREATE`:
  
  * Para crear una nueva base de datos, índice o almacenamiento de consultas.  
  * Un argumento :sql:`CREATE` en SQL crea un objeto dentro del sistema de administración 
de la base de datos relacional (`RDBMS`_).                 
  * El tipo de objetos que se pueden crear depende de qué RDBMS esta siendo utilizado, 
    pero la mayoría soporta la creación de tablas, índices, usuarios y bases de datos. 
  * Algunos sistemas (tales como **PostgreSQL**) permiten :sql:`CREATE` y otros comandos DDL,
    dentro de transacciones, y por lo tanto pueden ser revertidos 

 * :sql:`DROP`:

  * Para destruir una base de datos, tabla, índice o vista existente.
  * Un argumento :sql:`DROP` en SQL remueve un objeto dentro del sistema de administración 
de la base de datos relacional (`RDBMS`_).     
  * El tipo de objetos que se pueden eliminar depende de que RDBMS esta siendo utilizado,
    pero la mayoría soporta la eliminación de tablas, índices, usuarios y bases de datos.      
  * Algunos sistemas (tales como **PostgreSQL**) permiten :sql:`DROP` y otros comandos DDL,
    dentro de transacciones, y por lo tanto pueden ser revertidos 

 * :sql:`ALTER`:

  * Se utiliza para modificar la estructura de la tabla, como en los casos siguientes:
                                                                                     
     * Añadir una columna
     * Eliminar una columna
     * Cambiar el nombre de una columna
     * Cambiar el tipo de datos para una columna

Lenguaje de manipulación de datos (DML)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

`DML (Lenguaje de manipulación de datos)`_ se refiere a los comandos que permiten a un
usuario manipular los datos de las tablas, es decir, consultar tablas, añadir filas,
borrar filas y actualizar columnas.

Ejemplos de DML
^^^^^^^^^^^^^^^ 

.. code-block:: sql

   SELECT atributo FROM nombre_tabla;
   INSERT INTO nombre_tabla(atributo_1,...,atributo_n) VALUES (dato_1,...,dato_n);
   DELETE FROM nombre_tabla WHERE condicion;
   UPDATE nombre_tabla SET atributo = nuevo dato WHERE condicion;

**Descripción de comandos**


 * :sql:`SELECT`

  * Devuelve el resultado de un conjunto de registros de una o mas tablas.       
  * Un argumento :sql:`SELECT` devuelve cero o más filas de una o más tablas de una 
base de datos o vistas de base de datos.
  * En la mayoría de las aplicaciones :sql:`SELECT` es el comando DML mas usado.                      
  * Como SQL es un lenguaje de programación declarativo, consultas :sql:`SELECT` especifican
    el conjunto de resultado, pero no como calcularlo.
  * La base de datos traduce la consulta a un "plan de consulta", que puede variar 
    dependiendo de la ejecución, la versión de la base de datos y el software de base de datos.
  * Esta funcionalidad es llamada "optimizador de consulta", puesto que es responsable 
    de buscar el mejor plan de ejecución para la consulta, tomando en cuenta las restricciones aplicables.

Instrucción SELECT básica

.. code-block:: sql

 SELECT A1, ..., An FROM R1, ..., Rm WHERE condición

**Significado:**

   * :sql:`SELECT` `A_{1}, \ldots, A_{n}`: Atributos que retorna
   * :sql:`FROM` `R_{1}, \ldots,R_{m}`: relaciones o tablas
   * :sql:`WHERE` `condición`: combinar, filtrar

Lo que busca esta consulta es mostrar las columnas `A_{1}, \ldots, A_{n}` de las tablas o relaciones `R_{1}, \ldots,R_{m}`, siguiendo alguna condición.

**Álgebra relacional:**

.. math::

    \pi_{A_{1},\ldots, A_{n}} (\sigma_{condición}(R_{1} \times \ldots \times R_{m}))

Comandos SQL:
=============

   * :sql:`INSERT` - agrega uno o más registros a una tabla de una base de datos relacional.
   * :sql:`DELETE` - elimina uno o más registros de una tabla. Un subconjunto de datos
puede ser eliminado si existe una condición, de lo contrario todos los registros serán eliminados.
   * :sql:`UPDATE` - cambia los datos de uno o más registros de una tabla. Una fila o 
un subconjunto de filas puede ser actualizadas utilizando una condición.

Ejemplo práctico
~~~~~~~~~~~~~~~~

.. index:: ejemplo practico

.. note::

   Para realizar estos ejercicios, debe utilizar **Postgresql** mediante la conexión
   ssh o también puede instalarlo en su computador.

   Si tiene un sistema Linux puede utilizar el gestor de paquetes del sistema operativo.

   * Para usuarios que utilicen Debian / Ubuntu pueden ejecutar el siguiente comando como root::

      sudo apt-get install postgresql postgresql-client postgresql-contrib libpq-dev

   * Para usuarios que utilicen Red Hat/Scientific Linux/Fedora/CentOS ::

      yum -y install postgresql postgresql-libs postgresql-contrib postgresql-server postgresql-docs

   Después que finalice el proceso de instalación, es necesario ingresar al entorno ** psql **

   * Para usuarios que utilicen Debian / Ubuntu pueden ejecutar el siguiente comando como root ::

      sudo su postgres -c psql

   * Para usuarios que utilicen Red Hat/Scientific Linux/Fedora/CentOS

    * Iniciar el servicio. Debería decir OK si todo esta correcto
      ::

        service postgresql start

    * Cambiamos la contraseña del usuario **Postgresql**
      ::

        passwd postgres

    * Ejecutar **Postgresql** (ingresar la contraseña que cambiamos anteriormente)
      ::

        su postgres

    * Comenzamos el servicio
      ::

        /etc/init.d/postgresql start

    * Debe aparecer el mensaje "bash-4.1 $", ahora ingresamos a **Postgresql** ingresando
      ::

        psql

Primero que todo debemos *crear* una base de datos
para comenzar nuestros ejercicios.
La llamaremos **example**:

.. code-block:: sql

   postgres=# create database example;
   CREATE DATABASE

Luego de haber creado nuestra base de datos, necesitamos *ingresar* a ella 
para comenzar a realizar las distintas operaciones:

.. testcase::

 postgres=# `\c example`
 psql (8.4.14)
 Ahora está conectado a la base de datos «example».

Ahora comenzamos a *crear una tabla* llamada **cliente** con las variables id que se
define como serial en que al ir agregando datos se autoincrementará automáticamente
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
 (5 rows)

.. note::
 El asterisco (*) que está entre el :sql:`SELECT` y el :sql:`FROM` significa que se seleccionan todas las columnas de la tabla.

Si deseamos seleccionar la columna nombre con apellido la consulta debería ser

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
 (4 rows)

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
 (4 rows)

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
primaria que referencia de otra tabla, creándose una asociación entre las dos tablas.

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
 (6 rows)

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
 (6 rows)

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
 (6 rows)

Aquí es donde tiene la importancia la clave primaria y foránea, puesto que en la condición podemos realizar una igualdad entre los "id_profesor" de la tabla **profesores** y **cursos**.

.. _`SQL (Structured Query Language)`: http://en.wikipedia.org/wiki/SQL
.. _`DDL (Data Definition Language)`: http://en.wikipedia.org/wiki/Data_Definition_Language
.. _`RDBMS`: http://en.wikipedia.org/wiki/Relational_database#Relational_database_management_systems
.. _`DML (Data Manipulation Language)`: http://en.wikipedia.org/wiki/Data_manipulation_language
