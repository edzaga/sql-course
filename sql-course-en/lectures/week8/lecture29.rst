Lecture 29 - Views: Materialized views
--------------------------------------

.. role:: sql(code)
       :language: sql
       :class: highlight

Introduction
~~~~~~~~~~~~

In previous readings we explained the virtual view, which is a view defined as a query to the database. In this reading, we’ll see **Materialized views**, that **store the result of the query in a real cache table**. It’s a very common solution used in data warehousing environments, where frequent access to the basic tables is too expensive.

Definition
~~~~~~~~~~

A Materialized view **stores physically the data** from the query defined by the view. Initially the data is stored from the base tables when the query is executed, and is then updated periodically from the base tables. The materialized views are redundant data, in the sense that its contents can be deduced from the definition of the view and the contents of the rest of the database.
The view is defined by specifying a view query in SQL, through a set of existing tables **(R1, R2,…Rn)**.

``View V= QuerySQL(R1, R2, …, Rn)``

In this way we create a physical table V with the contents of the result of the query. We can refer to V as if it were a relationship, because in reality it is a table with data stored in the database.

Advantages
==========

The possess the same advantages of virtual view, with the difference that the materialized views improve the performance of queries in the database, as it provides a much more efficient access to the data. With the use of this type of views we achieve a improvement in the performance of SQL queries, while also providing a physical level optimizing method in complex and/or vast data models.

Disadvantages
==============

* Increases the size of the database.
* Allows for asynchrony, in other words, some of the data from the view can be potentially outdated with respect to the base tables. As it contains a real table, when the base table changes, the view is not immediately updated.

View Maintenance
~~~~~~~~~~~~~~~~

As mentioned before, a problem with this type of view is that they must be updated every time the base tables are modified. The task of updating the view is called **Maintenance of the Materialized View**. It must be also be noted, that when the view is modified, the base table must be updated as well, as view and base table must be always in sync.
A way to do this maintenance is using :sql:`Triggers` for the insertion, elimination and edition of each relation of the view. The sql:`Triggers` must modify all the contend of the materialized view.
A better option is to edit only the modified section of the materialized view. This is known as **Incremental Maintenance of the View**
Modern database systems provide a more direct support for the incremental maintenance of the views. Database programmers no longer need to define :sql:`Triggers`  for the maintenance. By the contrary, once the materialized view is declared, the database system calculates its contents and updates incrementally the content when the base data is modified.

Creating a Materialized View
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Some database management systems have the words :sql:`CREATE MATERIALIZED VIEW` reserved in order to allow the definition of a view from one or more physical tables.

General  Form:

.. code-block:: sql

           CREATE MATERIALIZED VIEW viewName  
            AS SELECT ... FROM ... WHERE ...

However, this reading will use another method to work with materialized views. First the table *matviews* must be created to store the information from the view.

.. code-block:: sql

           CREATE TABLE matviews (
            mv_name NAME NOT NULL PRIMARY KEY
            , v_name NAME NOT NULL
            , last_refresh TIMESTAMP WITH TIME ZONE
           );

Where:

* *mv_name*: is the name of the materialized view represented by this row.

* *v_Name*: is the name of the view in which the materialized view is based.

* *last_refresh*: the time of the last update of the materialized view.

Now we create a function *create_matview* written in PL/pgSQL. This function inserts a row in the *matviews* table and creates the materialized view. It receives the name of the materialized view, and the name of the base view. Have in mind you must have already created the base virtual view. Later will be explained how this view is created and used.
This function checks if a view with the same name already exists. If it does, it throws an exception. If it doesn’t, it creates a new table with the view and inserts a row in the table *matviews*.

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

the function *drop_matview* deletes the materialized view and its entry in the *matviews*, leaving the virtual view alone.

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

The function *refresh_matview* updates the materialized views so the data doesn’t become obsolete. This function only needs the name of the *matview* table. It uses a algorithm that deletes all the rows and creates them again.

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

Example
=======

For this example we’ll use the functions described above. First we install the  plpgsql language:

.. code-block:: sql

           viewm=# CREATE PROCEDURAL LANGUAGE plpgsql;
           CREATE LANGUAGE

With this installed, we create *matviews* and then we add the functions *create_matview*, *drop_matview* y *refresh_matview* to the database. The relation *game_score* is created, as well as the virtual view *player_total_score_v*.

.. code-block:: sql

           CREATE TABLE game_score (
            pname VARCHAR(255) NOT NULL,
            score INTEGER NOT NULL);

           CREATE VIEW player_total_score_v AS
           SELECT pname, sum(score) AS total_score
           FROM game_score GROUP BY pname;

As many teams play each day, and it’s very costly to access every time the data, it’s decided that a materialized view *player_total_score_v* should be implemented. For this, we create the view calling the *create_matview* giving it as parameters the name of the materialized view (*player_total_score_mv*) and the name of the virtual view (*player_total_score_v*).

.. code-block:: sql

           viewm=# SELECT create_matview('player_total_score_mv', 'player_total_score_v');

           create_matview
           ----------------
          
           (1 row)

When :sql:`SELECT` is executed over a the materialized view, we can observe that the view exists and is empty.

.. code-block:: sql

           viewm=# SELECT * FROM player_total_score_mv;
           pname | total_score
           -------+-------------
           (0 row)

The data from the view is stored in the relation *matviews*.

.. code-block:: sql

           SELECT * FROM matviews;
                       mv_name        |        v_name        |         last_refresh         
           -----------------------+----------------------+------------------------------
           player_total_score_mv | player_total_score_v | 2013-02-11 10:54:56.08571-03
           (1 row)


We add the values in the relation *game_score*:

.. code-block:: sql

           viewm=# INSERT INTO game_score ( pname, score)  VALUES ('UCH',2), ('SW',4);
           INSERT 0 2

When we execute a :sql:`SELECT` we observe that the view is still empty:

.. code-block:: sql

           viewm=# SELECT * FROM player_total_score_mv;
           pname | total_score
           -------+-------------
           (0 row)

To update the materialized view we must use the *refresh_matview* function:

.. code-block:: sql

           viewm=# SELECT refresh_matview('player_total_score_mv');
           refresh_matview
           -----------------
          
           (1 row)

Now, if we select again the materialized view, the inserted values will appear in the relation *game_score*.

.. code-block:: sql

           viewm=# SELECT * FROM player_total_score_mv;
           pname | total_score
           -------+-------------
           SW    |           4
           UCH   |           2
           (2 rows)

To delete the materialized view we use the function *drop_matview*:

.. code-block:: sql

           viewm=# SELECT drop_matview('player_total_score_mv');
           drop_matview
           --------------
          
           (1 row)

If we do a :sql:`SELECT` of the materialized view we receive an error as the view no longer exists:

.. code-block:: sql

           viewm2=# SELECT * FROM player_total_score_mv;
           ERROR:  relation "player_total_score_mv" does not exist
           LÍNEA 1: SELECT * from player_total_score_mv;

We check the relation *matviews* and see that here the materialized view is also inexistent:

.. code-block:: sql

           viewm=# SELECT * from matviews;
           mv_name | v_name | last_refresh
           ---------+--------+--------------
           (0 row)

