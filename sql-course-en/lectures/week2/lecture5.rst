Lecture 5 - Introduction
------------------------

.. role:: sql(code)
   :language: sql
   :class: highlight

`SQL (Structured Query Language)`_ is a type of language associated with the
management of relational databases, which allows the specification of different 
types of operations. Through the use of algebra and relational calculus, SQL 
language provides the possibility to make queries that help to retrieve information 
from databases easily.

Features
~~~~~~~~~~

.. index:: Features

Some features of this language are: 

 * Supported by all major commercial database systems.
 * Standardized - many new features over time.
 * Interactive via GUI or prompt, or embedded in programs.
 * Declarative, based on relational algebra.

Data Definition Language (DDL)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. index:: Data Definition Languaje (DDL)


`DDL (Data Definition Language)`_  is a language that allows you define a 
database (its structure or “schema”), and it also has a similar syntax to 
programming languages. 

Examples:
^^^^^^^^^^
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

`DML (Data Manipulation Language)`_ refers to commands that allow a user to manipulate 
the data of tables, that is, query tables, add rows, delete rows, and update columns. 

Examples of DML
^^^^^^^^^^^^^^^ 

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

**Meaning:**

   * :sql:`SELECT` `A_{1}, \ldots, A_{n}`: What to return
   * :sql:`FROM` `R_{1}, \ldots,R_{m}`: relations
   * :sql:`WHERE` `condition`: combine, filter

What this query seeks is to show the columns `A_{1}, \ldots, A_{n}` of the tables or relations `R_{1}, \ldots,R_{m}`, following some condition.

**Relational Algebra:**

.. math::

    \pi_{A_{1},\ldots, A_{n}} (\sigma_{condition}(R_{1} \times \ldots \times R_{m}))

SQL commands:
=============

   * :sql:`INSERT` - adds one or more records to any single table in a relational
     database.
   * :sql:`DELETE` - removes one or more records from a table. A subset may be
     defined for deletion using a condition, otherwise all records are removed.
   * :sql:`UPDATE` - changes the data of one or more records in a table. Either all
     the rows can be updated, or a subset may be chosen using a condition.

Practical Example
^^^^^^^^^^^^^^^^^^

.. index:: Practical Example

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

Firstly, we must create a ``database`` in order to start our excercises. We would call it **example**:

.. code-block:: sql

   postgres=# create database example;
   CREATE DATABASE

After creating our database, we need to *enter* to start making different operations:

.. testcase::

 postgres=# `\c example`
 psql (8.4.14)
 Now is connected to the databases «example».

Now we begin to create a table called client with ID variables that are defined as serial, 
in which as you add data it would auto-increase automatically in the database example: 

.. code-block:: sql

 example=# CREATE TABLE client (id SERIAL, name VARCHAR(50), lastname VARCHAR(50), age INTEGER, address VARCHAR(50), country VARCHAR(25));

And we would receive the following message::

 NOTICE:  CREATE TABLE creará una secuencia implícita «client_id_seq» para la columna serial «client.id»
 CREATE TABLE

To *add* data to the table **client** is performed as follows:

.. code-block:: sql

 example=# INSERT INTO client (name,lastname,age,address,country) VALUES ('John', 'Smith', 35, '7635 N La Cholla Blvd', 'EEUU');
 INSERT 0 1

*Add* more data to the **client** table

.. code-block:: sql

 example=# INSERT INTO client (name,lastname,age,address,country) VALUES ('John', 'Smith', 35, '7635 N La Cholla Blvd', 'EEUU');
 INSERT 0 1
 example=# INSERT INTO client (name,lastname,age,address,country) VALUES ('Judith', 'Ford', 20, '3901 W Ina Rd', 'Inglaterra');
 INSERT 0 1
 example=# INSERT INTO client (name,lastname,age,address,country) VALUES ('Sergio', 'Honores', 35, '1256 San Luis', 'Chile');
 INSERT 0 1
 example=# INSERT INTO client (name,lastname,age,address,country) VALUES ('Ana', 'Caprile', 25, '3456 Matta', 'Chile');
 INSERT 0 1

*Select* all the data of the **client** table

.. code-block:: sql

 example=# SELECT * FROM client;
 id | name   | lastname | age  |        address        |    country
 ---+--------+----------+------+-----------------------+------------
  1 | John   | Smith    |   35 | 7635 N La Cholla Blvd | EEUU
  2 | John   | Smith    |   35 | 7635 N La Cholla Blvd | EEUU
  3 | Judith | Ford     |   20 | 3901 W Ina Rd         | Inglaterra
  4 | Sergio | Honores  |   35 | 1256 San Luis         | Chile
  5 | Ana    | Caprile  |   25 | 3456 Matta            | Chile
 (5 rows)

.. note::
 The asterisk (*) that is between :sql:`SELECT` and :sql:`FROM` means that are selected all the columns of the table.
 
If we want to select the column name with last name the query should be 

.. code-block:: sql

   SELECT name, lastname FROM client;

As we made the mistake of *adding* in the second row repeated data, but it can be *removed* as follows

.. code-block:: sql

   example=# DELETE FROM client WHERE id=2;
   DELETE 1

We check that it has been *deleted*

.. code-block:: sql

 example=# SELECT * FROM client;
 id |  name  | lastname | age  |        address        |   country
 ---+--------+----------+------+-----------------------+------------
  1 | John   | Smith    |   35 | 7635 N La Cholla Blvd | EEUU
  3 | Judith | Ford     |   20 | 3901 W Ina Rd         | Inglaterra
  4 | Sergio | Honores  |   35 | 1256 San Luis         | Chile
  5 | Ana    | Caprile  |   25 | 3456 Matta            | Chile
 (4 rows)

If you want to *update* client Sergio’s address from the **client** table 

.. code-block:: sql

 example=# UPDATE client SET address='1459 Patricio Lynch' WHERE id=4;
 UPDATE 1

You can *select* the **client** table to verify that the data has been updated.

.. code-block:: sql

 example=# SELECT * FROM client;
 id |  name  | lastname |  age |        address        |    country
 ---+--------+----------+------+-----------------------+------------
  1 | John   | Smith    |   35 | 7635 N La Cholla Blvd | EEUU
  3 | Judith | Ford     |   20 | 3901 W Ina Rd         | Inglaterra
  5 | Ana    | Caprile  |   25 | 3456 Matta            | Chile
  4 | Sergio | Honores  |   35 | 1459 Patricio Lynch   | Chile
 (4 rows)

To *delete* **client** table

.. code-block:: sql

 example=# DROP TABLE client;
 DROP TABLE

Select the **client** table to verify that is has been removed

.. code-block:: sql

 example=# SELECT * FROM client;

We will receive the following message::

 ERROR:  no existe la relación «client»
 LÍNEA 1: SELECT * FROM client;
                       ^

Foreign and primary key
~~~~~~~~~~~~~~~~~~~~~~~~

In relational databases, **primary key** is called to a field or a combination of fields
that uniquely identifies each row in a table. So it cannot exist in a table with the 
same primary key.

And the **foreign keys** are intended to establish a connection with the primary key that 
refer to the other table, creating an association between the two tables.


Practical example
^^^^^^^^^^^^^^^^^^^ 

First we will create the teachers table in which ID_teacher will be the primary key. 
It will be defined as a serial that automatically will be entering the values 1, 2, 3 
to each record. 

.. code-block:: sql

 postgres=# CREATE TABLE teachers(ID_teachers serial, name VARCHAR(30), lastname VARCHAR(30), PRIMARY KEY(ID_teachers));

We will receive the following message::

 NOTICE:  CREATE TABLE creará una secuencia implícita «teachers_ID_teachers_seq» para la columna serial «teachers.ID_teachers»
 NOTICE:  CREATE TABLE / PRIMARY KEY creará el índice implícito «teachers_pkey» para la tabla «teachers»
 CREATE TABLE

Now we will create the table of courses in which ID_courses will be the primary key of 
this table and ID_teacher will be the foreign key, which will make a connection between 
these two tables.

.. code-block:: sql

 postgres=# CREATE TABLE courses(ID_course serial, title VARCHAR(30), ID_teachers INTEGER, PRIMARY KEY(ID_course), FOREIGN KEY(ID_teachers) REFERENCES teachers(ID_teachers));

We will receive the following message::

 NOTICE:  CREATE TABLE creará una secuencia implícita «courses_ID_course_seq» para la columna serial «courses.ID_course»
 NOTICE:  CREATE TABLE / PRIMARY KEY creará el índice implícito «courses_pkey» para la tabla «courses»
 CREATE TABLE

Some data will be *inserted* in order to make a *selection* and to visualize the functioning of the primary and foreign key.

.. code-block:: sql

 postgres=# INSERT INTO teachers(name, lastname) VALUES('Alfred','JOHNSON');
 INSERT 0 1
 postgres=# INSERT INTO teachers(name, lastname) VALUES('Alisson','DAVIS');
 INSERT 0 1
 postgres=# INSERT INTO teachers(name, lastname) VALUES('Bob','MILLER');
 INSERT 0 1
 postgres=# INSERT INTO teachers(name, lastname) VALUES('Betty','WILSON');
 INSERT 0 1
 postgres=# INSERT INTO teachers(name, lastname) VALUES('Christin','JONES');
 INSERT 0 1
 postgres=# INSERT INTO teachers(name, lastname) VALUES('Edison','SMITH');
 INSERT 0 1

If we select all columns, the table will remain as follows.

.. code-block:: sql

 postgres=# SELECT * FROM teachers;
  ID_teachers |   name   | lastname
 -------------+----------+----------
            1 | Alfred   | JOHNSON
            2 | Alisson  | DAVIS
            3 | Bob      | MILLER
            4 | Betty    | WILSON
            5 | Christin | JONES
            6 | Edison   | SMITH
 (6 rows)

.. note::
 As you can see in the **teachers** table, the “ID_teacher” wich we define as a type of serial data, automatically incremented without having the necessity to enter it by ourselves, and it is also defined as a primary key. 
  
Now we insert the data of the **courses** table.

.. code-block:: sql

 postgres=# INSERT INTO courses(title, ID_teachers) VALUES('Database',2);
 INSERT 0 1
 postgres=# INSERT INTO courses(title, ID_teachers) VALUES('Data structure ',5);
 INSERT 0 1
 postgres=# INSERT INTO courses(title, ID_teachers) VALUES('Computers architecture ',1);
 INSERT 0 1
 postgres=# INSERT INTO courses(title, ID_teachers) VALUES('Information retrieval',3);
 INSERT 0 1
 postgres=# INSERT INTO courses(title, ID_teachers) VALUES('Systems of theory',4);
 INSERT 0 1
 postgres=# INSERT INTO courses(title, ID_teachers) VALUES('Systems of information',6);
 INSERT 0 1

The resulting table would look as follows:

.. code-block:: sql

 postgres=# SELECT * FROM courses;


  ID_course|            title            | ID_teachers
 ----------+-----------------------------+-------------
         1 | Database                    |           2
         2 | Data structure              |           5
         3 | Computers architecture      |           1
         4 | Information retrieval       |           3
         5 | Systems of theory           |           4
         6 | Systems of information      |           6
 (6 rows)

.. note::

 A teacher may have assigned more than one course, there is no restriction.

Now we want to have just one table with the "name", "last name" of the teacher and the 
"title" of the course that he/she dictates. For that we made a selection of the following:

.. code-block:: sql

 postgres=# SELECT name, lastname, title 
 FROM teachers, courses 
 WHERE teachers.ID_teachers=courses.ID_teachers;

   name    | lastname |            title
 ----------+----------+---------------------------
  Alisson  | DAVIS    | Database
  Christin | JONES    | Data structure 
  Alfred   | JOHNSON  | Computers architecture 
  Bob      | MILLER   | Information retrieval
  Betty    | WILSON   | Systems of theory
  Edison   | SMITH    | Systems of information
 (6 rows)

This is where you see the importance of having the primary and foreign key, since in the condition 
we can make equality between the “ID_teacher” of the **teachers** and **courses** table.

.. _`SQL (Structured Query Language)`: http://en.wikipedia.org/wiki/SQL
.. _`DDL (Data Definition Language)`: http://en.wikipedia.org/wiki/Data_Definition_Language
.. _`RDBMS`: http://en.wikipedia.org/wiki/Relational_database#Relational_database_management_systems
.. _`DML (Data Manipulation Language)`: http://en.wikipedia.org/wiki/Data_manipulation_language
