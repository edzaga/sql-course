Lecture 5 - Introduction
-----------------------------

.. role:: sql(code)
   :language: sql
   :class: highlight

SQL (Structured Query Language) es un tipo de lenguaje vinculado con la gestión de bases de datos de carácter relacional que permite la especificación de distintas clases de operaciones entre éstas. Gracias a la utilización del álgebra y de cálculos relacionales, el lenguaje SQL brinda la posibilidad de realizar consultas que ayuden a recuperar información de las bases de datos de manera sencilla.

Characteristics
~~~~~~~~~~~~~~~~

 * "SQL" or "sequel"
 * Supported by all major commercial database systems
 * Standardized - many new features over time
 * Interactive via GUI or prompt, or embedded in programs
 * Declarative, based on relational algebra

Data Definition Languaje (DDL)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Data definition language or data description language (DDL) is a syntax similar to a computer programming language for defining data structures, especially database schemas.

Examples::

     'Create table ...'
     'Drop table ... '

**Description of commands**

**Create** - To make a new database, table, index, or stored query. A CREATE statement in SQL creates an object inside of a relational database management system (RDBMS). The types of objects that can be created depends on which RDBMS is being used, but most support the creation of tables, indexes, users, synonyms and databases. Some systems (such as PostgreSQL) allow CREATE, and other DDL commands, inside of a transaction and thus they may be rolled back.

**Drop** - To destroy an existing database, table, index, or view.
A DROP statement in SQL removes an object from a relational database management system (RDBMS). The types of objects that can be dropped depends on which RDBMS is being used, but most support the dropping of tables, users, and databases. Some systems (such as PostgreSQL) allow DROP and other DDL commands to occur inside of a transaction and thus be rolled back.

Data Manipulation Languaje (DML)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

DML son las siglas de Data Manipulation Language y se refiere a los comandos que permiten a un usuario manipular los datos en un repositorio, es decir, añadir, consultar, borrar o actualizar.

Examples of DML::

   'Select'
   'Insert'
   'Delete'
   'Update'

**Description of commands**


**SELECT** -  returns a result set of records from one or more tables.
A SELECT statement retrieves zero or more rows from one or more database tables or database views. In most applications, SELECT is the most commonly used Data Manipulation Language (DML) command. As SQL is a declarative programming language, SELECT queries specify a result set, but do not specify how to calculate it. The database translates the query into a "query plan" which may vary between executions, database versions and database software. This functionality is called the "query optimizer" as it is responsible for finding the best possible execution plan for the query, within applicable constraints.

The Basic SELECT Statement::

  Select `A_{1},\ldots, A_{n}` From `R_{1}, \ldots, R_{m}` Where condition

**Significado:**

   * Select `A_{1}, \ldots, A_{n}`: What to return
   * From `R_{1}, \ldots,R_{m}`: relations
   * Where `condition`: combine, filter

**Algebra relacional:**

.. math::

    \pi_{A_{1},\ldots, A_{n}} (\sigma_{condition}(R_{1} \times \ldots \times R_{m}))

   * :sql:`INSERT` - adds one or more records to any single table in a relational database.
   * :sql:`DELETE` - removes one or more records from a table. A subset may be defined for deletion using a condition, otherwise all records are removed.
   * :sql:`UPDATE` - changes the data of one or more records in a table. Either all the rows can be updated, or a subset may be chosen using a condition.

Other Commands
~~~~~~~~~~~~~~

indexes, constraints, views, triggers, transactions, authorization, ...


