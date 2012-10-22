Lecture 1 - Relational Databases: "The relational model"
--------------------------------------------------------

What is Databases (DB)?
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. index:: What is Databases (DB)?

A DB is a set of interrelated data stored together, without presenting unnecessary redundancies, 
independently of the programs that access them.


Database Management System (DBMS)
=========================================

The Database Management System (DBMS) is a set of programs that let create and maintain a database, 
ensuring its integrity, confidentiality, and security. Therefore, it should allow:

  * To define a database: specify types, structures, and restrictions of data.
  * To build the database: save data in a/some controlled environment by the same DBMS.
  * To manipulate the database: querying, updating, and reporting.

Some of the desirable features of a Database Management System (DBMS) are:

  * Control of redundancy: Data redundancy has several negative effects 
    (duplicating work when upgrading, wasting disk space can cause data inconsistency) 
    although sometimes it is desirable for performance reasons.
  * Restriction of unauthorized access: each user has to have some access
    and authorization permissions.
  * Compliance of integrity restriction: the DBMS has to offer resources to define 
    and ensure compliance of the integrity restrictions.

The Entity-relationship model (E-R)
================================

When using a DB to manage information, you are capturing a part of the real world in a 
series of tables, records, and fields. As a result, it creates a partial model of reality. 
Before physically create these tables in the DB, it should be performed a data model.

The most extensive data model is the so called *E-R*. 
In the E-R model the starting point is a real situation from which are defined entities 
and relationships among those entities.


**Entities**

The objects that appear in real life correspond to an entity. 
For example: students, employees, airplanes, cars, accommodation, etc. 
An entity results in a table in the DB.

.. image:: ../../../sql-course/src/entidad.jpg
   :align: center

These entities are composed of several attributes, which come to be their properties. 
For example: student’s entity shall have the attributes name, Social Security Number, 
nationality, date of birth, etc.

.. image:: ../../../sql-course/src/atributo.jpg
   :align: center

The attributes are also called columns in the terminology of DB. 
Among the attributes will be one or a set of them that is not repeated; 
this attribute or set of attributes is called the primary key. In the case of the students,
it would be the Social Security Number. In any entity there is always at least one key 
that in the worst case will be formed by all of the attributes of the table. Since there 
may be several keys and we need to pick one, we will take into account these rules:

  * It is unique.
  * To have full knowledge of it. – Why each client is assigned a customer number in companies?
  * It is minimal, as it will be often used by the database manager.


Each entity will have an unlimited number of *elements*. For example, 
an element of the students’ entity will be a student itself. 
So the student Pepe will be an element, Jose will be another one. 
Each one of these elements is also called *row or tuple*  in the terminology of DB.

*Combining these three concepts we have a table structure type, the base of the DB.*


**Relations**

The entities are not isolated but are related. These relations do not 
exist in the real world that we are modeling, but they are necessary
to reflect the existing interactions between entities. The relations
can be of three types:


*Relations 1-1*: the entities that intervene in the relation are
associated one on one. (e.g. the entity MAN, the entity WOMAN and 
between then the relationship MARRIAGE).

.. image:: ../../../sql-course/src/1a1.jpg
   :align: center

*Relations 1-N*:  an occurrence of an entity it is associated with many (n) 
from another (e.g. the entity COMPANY, the entity EMPLOYEE and the relationship 
between them WORK-IN).


.. image:: ../../../sql-course/src/1aN.jpg
   :align: center

*Relations M-N*: Every occurrence, in any of the two entities in the relation, 
can be associated with many (n) of the other and vice versa (e.g. the entity 
STUDENT, the entity COMPANY and the relationship between them REGISTRATION).

.. image:: ../../../sql-course/src/MaN.jpg
   :align: center

Relational Database
~~~~~~~~~~~~~~~~~~~~~~~~~~

.. index:: Base de datos Relacionales

It allows to establish interconnections (relations) between the data (which is
stored in tables), and through those connections relate the data of both tables.

**Advantages:**
  * Database systems used by the most important commercial companies.
  * Simple model.
  * Consultations through high-level languages.
  * Efficient implementation.

**Characteristics**
  * It consists of multiple tables or relations.
  * There are not two or more tables with the same name.
  * A table is a set of records (rows or columns).
  * The relationship between parent and child table is carried out by using 
    primary and foreign keys.
  * The primary keys represent the primary/principal key of a record within 
    a table and they must fulfill with the integrity of the data.
  * The foreign keys are placed in the child table, they contain the same
    value as the primary key of the parent record; you can make relationships through them.


Example:
========

Se tiene una base de datos que contiene dos relaciones: una denominada EMPLEADOS,
que almacena datos de los empleados de una empresa, y otra con el nombre DESPACHOS,
que almacena los datos de los despachos que tiene la empresa. Los empleados que
trabajan para una empresa pueden estar vinculados con los despachos de la empresa,
porque a cada empleado se le asigna un despacho concreto para trabajar.

.. math::

 \textbf{Tabla DESPACHOS}

   \begin{array}{|c|c|c|}
        \hline
         \textbf{edificio} & \textbf{numero} & \textbf{superficie}\\
        \hline
        \mbox{Princess} & 120  & 10\\
        \hline
	\mbox{Princess} &  121 & 12\\
        \hline
        \mbox{Princess} &  122 & 15\\
        \hline
        \mbox{Grey} & 230  & 20\\
        \hline
        \mbox{Diagonal} & 110 & 10\\
        \hline
   \end{array}

La tabla DESPACHOS posee 3 atributos (*edificio*, *número*, superficie) y 5
registros (o filas).
Esta tabla posee un conjunto de atributos cuyos valores combinados dan la
unicidad a cada fila. Se trata de los atributos edificio y número; se les llama
clave primaria compuesta.

.. math::

 \textbf{Tabla EMPLEADOS}

   \begin{array}{|c|c|c|c|c|c|}
        \hline
        \textbf{DNI} & \textbf{nombre} & \textbf{apellido} & \textbf{DNIjefe} & \textbf{edificiodesp} & \textbf{numerodesp}\\
        \hline
        40.444.255   & \mbox{Alex}     & \mbox{Karev}      & 40.783.150       & \mbox{Princess}       & 120\\
        \hline
        33.567.711   & \mbox{George}   & \mbox{O'Malley}   & 40.444.255       & \mbox{NULL}           & \mbox{NULL}\\
        \hline
        55.898.425   & \mbox{Derek}    & \mbox{Shepherd}   & 40.444.255       & \mbox{Diagonal}       & 110\\
        \hline
        77.232.144   & \mbox{Arizona}  & \mbox{Robbins}    & 40.444.255       & \mbox{Grey}           & 230\\
        \hline
   \end{array}


La tabla EMPLEADOS posee 6 atributos (*DNI*, nombre, apellido, DNIjefe,
edificiodesp, númerodesp) y 4 registros (o filas), en el segundo registro se
aprecia que George no posee despacho asignado por lo que se agrega el valor
"unknown" o "undefined" que se define como NULL.
Esta tabla posee un atributo cuyo valor es único en cada tupla que es atributo
DNI y se le llama clave primaria.

En la relación de esquema EMPLEADOS, la clave foránea formada por los
atributos {edificiodesp, númerodesp} referencia la clave primaria de la relación
DESPACHOS. De este modo, se cumple que todos los valores que no son nulos de los
atributos edificiodesp y númerodesp son valores que existen para los atributos
edificio y número de DESPACHOS. Esta clave foránea indica, para cada empleado,
el despacho donde trabaja. Además, el atributo DNIjefe es otra clave foránea que
referencia la clave primaria de la misma relación EMPLEADOS, e indica, para cada
empleado, quien es su jefe.

Ejemplo en SQL
==============
.. index:: string, text data types, str

La creación de relaciones (tablas) en SQL

.. code-block:: sql

 CREATE TABLE DESPACHOS(edificio VARCHAR(50), numero INTEGER, superficie INTEGER, PRIMARY KEY(edificio,numero));
 CREATE TABLE EMPLEADOS(DNI VARCHAR(50), nombre VARCHAR(50), apellido VARCHAR(50), DNIjefe VARCHAR(50), edificiodesp VARCHAR(50), numerodesp INTEGER, PRIMARY KEY(DNI), FOREIGN KEY(edificiodesp,numerodesp) REFERENCES DESPACHOS(edificio,numero));

Engines of Relational Databases
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. index:: Engines of Relational Databases

Nowadays there are many companies and websites that need to efficiently maintain a 
large volume of data. Many of them go for for business solutions (Oracle Database or 
IBM DB2, and others), while many others rely on free software opting for a solution 
like PostGreSQL or MySQL.

The question is very common among people who enter for the first time in the world
of free databases, what database engine should I use? MySQL or PostGreSQL? Next, 
it will be seen some details of both engines.


PostGreSQL
==========

PostGreSQL is a object-relational database management system based on the POSTGRES 
project, of the University of Berkeley. The director of this project is Professor 
Michael Stonebraker, and was sponsored by Defense Advanced Research Projects Agency (DARPA), 
the Army Research Office (ARO), the National Science Foundation (NSF), and ESL, Inc.


**A bit of history**

PostGreSQL was derived from the Postgres project. Behind its back, the project has 
more than a decade of development, being nowadays, the most advanced free system with 
difference, supporting the vast majority of the SQL transactions, concurrency control, 
and taking at their disposal several “language bindings” such as C, C++, java, Python, 
PHP, and many more.

The implementation of Postgres DBMS started in 1986, and there was no a working version until 1987. 
Version 1.0 was released in June 1989 to a few users, after which version 2.0 was released in 
June 1990 due to criticism of the system of rules, which forced its reimplementation.
Version 3.0 appeared in 1991.
 
In 1994, Andrew Yu and Jolly Chen added a SQL interpreter to this manager. Postgres95, 
as it was called, was released to the Internet as a free project (OpenSource). It was
written entirely in C, and the first version was 25% smaller than Postgres, and between
30 and 50% faster. Besides correcting some bugs, the internal engine was improved, a new 
program monitor was added, and it was compiled by using GNU Make utility and the gcc compiler.
In 1996, the developers decided to change the name to the DBMS, it was called PostGreSQL in 
order to reflect the relationship between PostGres and recent versions of SQL.

**Characteristics**

  * Implementation of SQL92/SQL99 standard.
  * BSD License.
  * For its architectural of design, scale well by increasing the number of CPUs and the amount of RAM.
  * Supports transactions and from version 7.0, foreign keys (with referential integrity checks).
  * Has better support for triggers and procedures on the server.
  * Incorporates an array data structure.
  * Includes inheritance among tables (but nor between objects, since they don’t exist), 
    so this database manager is included between the object-relational managers.
  * Implements the use of rollback’s, sub-queries, and transactions, making its function more efficient.
  * It is possible to make multiple operations simultaneously on the same table without blocking it.


MySQL
=====

MySQL is database management system of relational data, licensed under the GPL of the GNU.
Its multithreaded design allows it to support a large load in a very efficient way. MySQL 
was created for the Swedish company MySQL AB, which holds the copyright of the source code 
of the SQL server, as well as the brand.  
 
Although MySQL is free software, MySQL AB distributes a commercial version of MySQL, which 
only differs from the free version in the technical support offered, and the possibility to 
integrate a manager in proprietary software, otherwise, the GPL license would be violated.
 
**A bit of history**

MySQL emerged as an attempt to connect the manager mSQL to the MySQL AB's own tables,
using their own routines at low level. After initial tests, they saw that mSQL was not
flexible enough for what they needed, so they had to develop new features. This resulted 
in a SQL interface to their database, with a fully compatible interface to mSQL.

It is not known for sure from where its name comes from. On the one hand they say that their
libraries have carried the prefix 'my' in the last ten years. On the other hand, the daughter
of one of the developers is called My. It is unknown which of these two causes (though they
might be treated the same) have given the name to this well known database manager.


**Characteristics**

  * The best of MySQL is the speed while it is performing the operations, which makes it one of 
    the managers who offer better performance.
  * It consumes very few resources either from CPU as well as memory.
  * GPL license and also has a commercial license for those companies that want to include it in 
    their proprietary applications.
  * It provides the API’s in a large number of languages ​​(C, C + +, Java, PHP, etc).
  * Supports up to 64 indexes per table, a significant improvement over version 4.1.2.
  * Better integration with PHP.
  * Allows management of different users, as well as the permissions assigned to each of them.
  * Has support for transactions and also has a unique feature of MySQL which is to be able to 
    group transactions.
 

Selection
=========

It is essential to take into account for what will be needed. In many forums, it is associated 
to PostGreSQL to stability, databases of large size and high concurrency. Moreover, MySQL is 
associated to databases of smaller size but with higher speed of response to a query.

Each of these managers has characteristics that make them a great choice in their respective
field when choosing, as they were conceived for a particular implementation.


