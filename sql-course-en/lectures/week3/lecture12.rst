Lecture 12 - Aggregation functions
----------------------------------

.. role:: sql(code)
   :language: sql
   :class: highlight

Aggregation Functions
~~~~~~~~~~~~~~~~~~~~~

Aggregation Functions perform a calculation on a set of data and return a single value.

Some useful features added are:

* ``AVG()``   - Returns the average value
* ``COUNT()`` - Returns the number of rows
* ``MAX()``   - Returns the largest value
* ``MIN()``   - Returns the lowest value
* ``SUM()``   - Returns the sum


To show the performance of such functions, consider the following example:

This will *create* a table of **Purchases** that have the attributes of ``id``, ``date_purchases``, 
``price_purchases`` and the ``customer``.

.. code-block:: sql

 postgres=# CREATE TABLE Purchases(id serial, date_purchases DATE, price_purchases INTEGER, client VARCHAR(30), PRIMARY KEY(id));

Now we *enter* data to the **Purchases** table.

.. code-block:: sql

 postgres=# INSERT INTO Purchases(date_purchases, price_purchases, client) VALUES('2010/09/23', 1120,'Alison');
 INSERT 0 1
 postgres=# INSERT INTO Purchases(date_purchases, price_purchases, client) VALUES('2007/02/21',1990,'Alicia');
 INSERT 0 1
 postgres=# INSERT INTO Purchases(date_purchases, price_purchases, client) VALUES('2006/06/09',400,'Alison');
 INSERT 0 1
 postgres=# INSERT INTO Purchases(date_purchases, price_purchases, client) VALUES('2006/04/01',700,'Alison');
 INSERT 0 1
 postgres=# INSERT INTO Purchases(date_purchases, price_purchases, client) VALUES('2005/03/30',2120,'Brad');
 INSERT 0 1
 postgres=# INSERT INTO Purchases(date_purchases, price_purchases, client) VALUES('2011/11/17',160,'Alicia');
 INSERT 0 1

AVG() function
==============

The function AVG () returns the average value of a numeric column.

In SQL the syntax is the in the following way:

.. code-block:: sql

 SELECT AVG(name_column) FROM name_table;

For calculating the ``average price`` of the purchases we make the following query:

.. code-block:: sql

 postgres=# SELECT AVG(price_purchases) AS price_average FROM Purchases;
    price_average
 -----------------------
  1081.6666666666666667
 (1 row)

.. note::

 In the query is used the word "AS", this is to give a name to the table of return in 
 this case is called "price_average".
 
We can also calculate with the nested :sql:`SELECT` price of purchases which are greater 
than the calculated average, returning the ``id``, ``date_purchases``, ``price_purchases`` 
and the ``client``.

.. code-block:: sql

 postgres=# SELECT id, date_purchases, price_purchases, client FROM Purchases WHERE price_purchases > (SELECT AVG(price_purchases) FROM Purchases);
  id | date_purchases | price_purchases | client
 ----+---------------+----------------+---------
   1 | 2010-09-23    |           1120 | Alison
   2 | 2007-02-21    |           1990 | Alicia
   5 | 2005-03-30    |           2120 | Brad
 (3 rows)


COUNT() function
================

The ``COUNT()`` function returns the number of rows according to the specified criteria.

In SQL the syntax that we use to make the query is:

SQL COUNT(name_column)
^^^^^^^^^^^^^^^^^^^^^^

``COUNT(name_column)`` returns the number of values that are located in the specified column. 
You should not count the NULL values.

.. code-block:: sql

 SELECT COUNT(name_column) FROM name_table;

We will make the query COUNT (clients) to return the number of *clients* who have the 
name of *Alison* and exist in the **Purchases** table.

.. code-block:: sql

 postgres=# SELECT COUNT(client) AS client_Alison FROM Purchases WHERE client='Alison';
  client_alison
 ----------------
               3
 (1 row)

SQL COUNT(*)
^^^^^^^^^^^^

``COUNT(*)`` returns the number of records of a table.

.. code-block:: sql

 SELECT COUNT(*) FROM name_table;

We will make a ``COUNT(*)`` query which will return a number of purchases of the 
**Purchases** table.

.. code-block:: sql

 postgres=# SELECT COUNT(*) AS number_purchases FROM Purchases;
 number_purchases
 ----------------
               6
 (1 row)

SQL COUNT(DISTINCT name_column)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

``COUNT(DISTINCT name_column)`` returns the number of the different values to the specified 
column.

.. code-block:: sql

 SELECT COUNT(DISTINCT name_column) FROM name_table;

We will make the ``COUNT(DISTINCT client)`` query, which will return the quantity of 
the different clients that exists in the **Purchases** table: *Alison*, *Alicia*, and *Brad*.

.. code-block:: sql

 postgres=# SELECT COUNT(DISTINCT client) AS number_of_clients FROM Purchases;
 number_of_clients
 --------------------
                   3
 (1 row)

MAX() function
==============

The ``MAX()`` function returns the greater value of the selected column.

In SQL the syntax used is in the following way:

.. code-block:: sql

 SELECT MAX(name_column) FROM name_table;

We will make the ``MAX(price_purchases)`` query which returns the greater Price of the 
purchases in the **Purchases** table.

.. code-block:: sql

 postgres=# SELECT MAX(price_purchases) AS greater_price FROM Purchases;
  greater_price
 --------------
          2120
 (1 row)

MIN() function
==============

The ``MIN()`` function returns the minimum value of the selected column.

In SQL the syntax used is in the following way:

.. code-block:: sql

 SELECT MIN(name_column) FROM name_table;

We will make the MIN(price_purchases) query that will return the lowest price of the 
purchases in the **Purchases** table.

.. code-block:: sql

 postgres=# SELECT MIN(price_purchases) AS lowest_price FROM Purchases;
  lowest_price
 --------------
           160
 (1 row)

SUM() function
==============

The ``SUM()`` function returns the total sum of the numeric column.

In SQL the syntax used is the following:

.. code-block:: sql

 SELECT SUM(name_column) FROM name_table;

We will make the ``SUM(price_purchases)`` query that will return the total price of 
the purchases that are in the **Purchases** table.

.. code-block:: sql

 postgres=# SELECT SUM(price_purchases) AS price_total FROM Purchases;
 price_total
 --------------
          6490
 (1 row)

SQL GROUP BY
~~~~~~~~~~~~

The :sql:`GROUP BY` statement is used in combination with the aggregation functions to group the 
result set of one or more columns.

.. code-block:: sql

 SELECT name_column, function_of_adding(name_column) FROM name_table WHERE condition GROUP BY name_column;

The next query will use the ``GROUP BY`` instruction to make the ``sum`` for the ``clients`` 
of the prices of purchases in the **Purchases** table.

.. code-block:: sql

 postgres=# SELECT client, SUM(price_purchases) FROM Purchases GROUP BY client;
  client | sum
 ---------+------
  Alison  | 2220
  Brad    | 2120
  Alicia  | 2150
 (3 rows)

SQL HAVING
~~~~~~~~~~

The :sql:`HAVING` clause is used in SQL since the keyword *WHERE* cannot be used with the 
functions of aggregation in its conditions.

In SQL the syntax used is the following:

.. code-block:: sql

 SELECT name_column, function_of_adding(name_column) FROM name_table WHERE condition GROUP BY name_column HAVING function_of_adding(name_column) operator value;

Now we want to know if any client has a total price of purchases greater than 2130.

.. code-block:: sql

 postgres=# SELECT client, SUM(price_purchases) FROM Purchases GROUP BY client HAVING SUM(price_purchases)>2130;
  client | sum
 ---------+------
  Alison  | 2220
  Alicia  | 2150
 (2 rows)

We will make the previous query by adding the *WHERE* clause with the condition that 
the ``client`` is equal to “Alison”.

.. code-block:: sql

 postgres=# SELECT client, SUM(price_purchases) FROM Purchases WHERE client='Alicia' GROUP BY client HAVING SUM(price_purchases)>2130;
  client | sum
 ---------+------
  Alicia  | 2150
 (1 row)

