Lecture 30 - Database Maintenance
---------------------------------

.. role:: sql(code)
       :language: sql
       :class: highlight

Introduction
~~~~~~~~~~~~

A database requires a periodical maintenance, otherwise it can develop problems in one or more areas, which in long term can cause a drop in the application’s performance.
Some actions must be taken by the administrator of the database management system. In the case of PostgreSQL, it can go from the maintenance of internal identifiers and the statistical query planning, to the re indexing of tables and the treatment of registry files.

Monitoring and Maintenance routines
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Vacuum
======

:sql:`VACUUM` **is the process that executes a cleaning of a PostgreSQL database**. Tuples marked for elimination are deleted and a physical reorganization of the data takes place.
:sql:`VACUUM` is executed periodically to:

* **Recover lost space in the disk from eliminated or updated data** in normal PostgreSQL operation, the deleted tuples or those obsolete are not physically eliminated from the table till a :sql:`VACUUM` is executed. Because of this, a :sql:`VACUUM` command must be executed periodically,  especially in tables that are frequently updated.
* Update the statistics of the data used by the query planner used by SQL.
* Protect from the data loses product of reutilization of transaction identifiers.

**Sintaxis:**

.. code-block:: sql

           VACUUM [ FULL ] [ FREEZE ] [ VERBOSE ] [ table ]
           VACUUM [ FULL ] [ FREEZE ] [ VERBOSE ] ANALYZE [ table [ (column [, ...] ) ] ]

:sql:`VACUUM` can receive different parameters to execute different types of cleaning:

* :sql:`FREEZE` the FREEZE is obsolete and will be removed in later releases.
* :sql:`FULL` Executes a complete cleaning, which recovers more space, but takes much longer and exclusively blocks the table.
* :sql:`VERBOSE` Prints a detailed report of the cleaning activity of each table.
* :sql:`ANALYZE` Updates the statistics used by the query planner to determine the most efficient way to execute a query.
* Table: the name of the specific table to clean. By default all tables of the current database are used.
* Column: the name of the specific column to clean. By default all columns are used. This command is very useful to automate the cleaning trough any tasks synchronizer.

There also exists a Autovacuum option, which function is to incrementally make the maintenance of our database. Before activating it, it’s recommendable to read about the consideration to take in account, as to not degrade the performance of our server.

Example:
^^^^^^^^

:sql:`VACUUM` is executed over a existing database:  

.. code-block:: sql

           demo=# VACUUM;
           VACUUM

:sql:`VACUUM` is executed over a existing database with the parameter FULL:

.. code-block:: sql

           demo=# VACUUM FULL;
           VACUUM

:sql:`VACUUM` is executed over the relation *game_score*:

.. code-block:: sql

           demo=# VACUUM game_score;
           VACUUM

In case of any problem or extra action required, the system will notify:

.. code-block:: sql

           demo=# VACUUM;
           WARNING: some databases have not been vacuumed in 1613770184 transactions
           HINT: Better vacuum them within 533713463 transactions, or you may have a wraparound failure.

Re Indexation
=============

To facilitate the retrieval of information of a table, indexes are used. The index of a table allows for the fast retrieval of data. Without index, you would have to check sequentially the whole table to find a registry. It’s very useful for databases with lots of information. A table is indexed by one field or many. It’s important to identify those fields that allow for a more efficient index. Those fields are the one by which searches are executed frequently.

There are many type of index:

* **primary key:** as explained before, the values of the primary must be unique and non-null.
* **index:** a common index, the values are not necessarily unique and accepts null values. A name can be assigned, but by default the name is “key”. 

Many can be created by each table.

* **unique:** a index whose values must be unique. If we try to add a registry with a value that already exists, it’ll throw an error. It allows for null values, and many indexes of this type can be defined by each table.
* The total re indexation of a database is not a very usual task, but can substantially improve the query speed in complex queries in tables with a lot of activity.

Example:
^^^^^^^^

The following command is executed over the database used in the reading 29:

.. code-block:: sql

           demo=# reindex database demo;
           NOTICE:  table "pg_class" was reindexed
           NOTICE:  table "pg_type" was reindexed
           NOTICE:  table "pg_statistic" was reindexed
           NOTICE:  table "sql_features" was reindexed
           NOTICE:  table "sql_implementation_info" was reindexed
           NOTICE:  table "sql_languages" was reindexed
           NOTICE:  table "sql_packages" was reindexed

the reserved words  :sql:`reindex database` are used, with the parameter of the “demo” database.

Registry files
==============

It is a good practice to maintain a registry of the server activity, or at least of the errors. During the development of applications the registry of executed queries can help, but it can also degrade the performance of the database management system in databases with great activity, not being useful at all.
In the same way, is convenient to have file registry file rotation mechanisms; in other word, to periodically back up these files and start new ones, allowing for a registry history to be maintained.
PostgreSQL doesn’t provide with tools for this rotation, but most UNIX systems include a utility such as **logrotate** that executes this task following a temporal planning.

.. code-block:: sql

           VACUUM
           demo=# VACUUM VERBOSE ANALYZE;
           INFO:  analyzing "pg_catalog.pg_operator"
           INFO:  "pg_operator": scanned 13 of 13 pages, containing 704 live rows and 0       dead rows; 704 rows in sample, 704 estimated total rows
           INFO:  vacuuming "pg_catalog.pg_opfamily"
           INFO:  index "pg_opfamily_am_name_nsp_index" now contains 68 row versions in 2 pages
           DETALLE:  0 index row versions were removed.
           0 index pages have been deleted, 0 are currently reusable.
           CPU 0.00s/0.00u sec elapsed 0.00 sec.
           VACUUM

Explain
=======

This command shows the execution plan that the administrator of the PostgreSQL database management system generates from a certain query. The execution plan  shows the way in which the way in which the referenced tables will be scanned, be it plain sequential scan, index scan, etc. in the case various tables are referred, the union algorithms will be used to join the required tuples from each referred table.

**Sintaxis**

.. code-block:: sql

           EXPLAIN [ VERBOSE ] query

The option :sql:`VERBOSE` outputs the complete internal representation of an execution plan. Usually this option is useful in the error correction process Postgres.

Example 1
^^^^^^^^^

Using the same table as in reading 29:

.. code-block:: sql

           demo=# SELECT * FROM game_score;
           pname | score
           -------+-------
           UCH   |     2
           SW    |     4
           (2 rows)

To show the query plan for a simple query about a table with 2 columns, one :sql:`INT` and the other :sql:`VARCHAR` :

.. code-block:: sql

           EXPLAIN SELECT * FROM game_score;
                                      QUERY PLAN                        
           ----------------------------------------------------------
           Seq Scan on game_score  (cost=0.00..1.02 rows=2 width=7)
           (1 row)

Example 2
^^^^^^^^^

We create a table with index :sql:`INT` and 4 values are inserted:

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

:sql:`EXPLAIN` is the presentation of the estimated execution cost of the query, which is the supposition by the query planner about the time needed to execute the query (measured in capture units of disk pages). Two numbers are showed: the initial time to retrieve the first tuple, and the time to retrieve all the tuples.


