Lecture 13 - SQL: Null Values
-------------------------------

.. role:: sql(code)
   :language: sql
   :class: highlight

:sql:`NULL` indicates that a value is unknown or that there is no a value within a database. 
:sql:`NULL` does not belong to any data domain (not in integers, or booleans, or floats, etc). 
It can be considered as a marker indicating the absence of a value.

.. note::
    :sql:`NULL` should not be confused with a value 0, since the value 0 belongs to any data type 
    (integer or float), while as it was already mentioned,
    :sql:`NULL` is the absence of a data.


CREATE TABLE
~~~~~~~~~~~~~~~

By default a column can be  :sql:`NULL`. If you want to disallow a :sql:`NULL` in a column, 
you should place a restriction on this column specifying that :sql:`NULL` is now a valid value.

General form:

.. code-block:: sql

 CREATE TABLE nameTable
 (atributte1 typeAtributte NOT NULL,
 atributte2 typeAtributte);


The query above creates a table called nameTable with two attributes. The first attribute1 do not accept 
null values (:sql:`NULL`), since it is accompanied with the instruction :sql:`NOT NULL`. Attribute2 might not 
have values, in other words, you can find that attribute2 might have in some rows, some unknown 
values. In order to illustrate the particularities and usefulness of NULL, we will show the next 
example: a table of clients which stores the rut, last name, name, debt and client address 
`\text{Client}(\underline{\text{rut}},\text{name,lastName, debt,address})` .

Create the Client table  where *rut*, *name* and *lastName* do not include :sql:`NULL`, 
while *address* and *debt* can include :sql:`NULL`. That means that you could disown the address 
of the client without giving problems to the database. The SQL query which makes the action 
is the following:

.. code-block:: sql

    postgres=# CREATE TABLE Client
    (rut int NOT NULL,
    name varchar (30) NOT NULL,
    lastname varchar(30)NOT NULL,
    debt int,
    address varchar (30));
    CREATE TABLE


INSERT y UPDATE
~~~~~~~~~~~~~~~~

:sql:`NULL` values can be inserted in one column if you explicitly indicate :sql:`NULL` in an :sql:`INSERT` 
instruction. In the same way a value can be updated by specifying that is :sql:`NULL` in the query.

General form:

.. code-block:: sql

 INSERT INTO nameTable (atributte1,atributte2) values(valueValid, null);
 
 UPDATE nameTable SET atributte2= null WHERE condition;


Continuing with the previous example, insert a client:

.. code-block:: sql
 
 postgres=# INSERT INTO Client (rut,name,lastname,debt,address) values(123,'Tom', 'Hofstadter', 456, null);
 INSERT 0 1

While you put the values of the client 'Tom Hofstadter', it was store the attribute address as :sql:`NULL`, 
that is without a designated value. Before exposing how :sql:`UPDATE` works, add new clients in order to show in 
a better way the following queries:

.. code-block:: sql
 
 postgres=# INSERT INTO Client (rut, name, last name, debt, address) values
 (412,'Greg', 'Hanks',33, 'Cooper'), (132,'Mayim ', 'Bialik',null, 'Barnett 34'),
 (823,'Jim', 'Parsons',93, null),(193,'Johnny', 'Galecki',201, 'Helberg 11'),
 (453,'Leslie', 'Abbott',303,null), (583,'Hermione', 'Weasley',47, 'Leakey 24'),
 (176,'Ron', 'Granger',92,'Connor 891'), (235,'Hannah', 'Winkle',104, null),
 (733,'Howard', 'Brown',null, null);
 INSERT 0 9


By doing a :sql:`SELECT` query to see all clients who were inserted, you will be able to observe an empty 
space in the values which carry :sql:`NULL` at the moment to apply :sql:`INSERT`.  For instance, you can see the 
case of Tom Hofstadler’s address or Mayim Bialik’s debt.

.. code-block:: sql

    postgres=# SELECT * FROM Client;
      rut    |  name    |   lastname  | debt  | address 
    ---------+----------+-------------+-------+------------
     123     | Tom      | Hofstadter  |   456 |
     412     | Greg     | Hanks       |    33 | Cooper
     132     | Mayim    | Bialik      |       | Barnett 34
     823     | Jim      | Parsons     |    93 |
     193     | Johnny   | Galecki     |   201 | Helberg 11
     453     | Leslie   | Abbott      |   303 |
     583     | Hermione | Weasley     |    47 | Leakey 24
     176     | Ron      | Granger     |    92 | Connor 891
     235     | Hannah   | Winkle      |   104 |
     733     | Howard   | Brown       |       |
    (10 rows)


Now you can update a client:

.. code-block:: sql
  
 postgres=# UPDATE Client SET address=null WHERE rut=412;
 UPDATE 1

Now we can update the client’s id number 412, leaving its address without a known value.

By doing :sql:`SELECT` again to observe the client Table, you can see that client with the id number 412, 'Greg Hanks', 
now presents an address without an assigned value.

.. code-block:: sql

    postgres=# SELECT * FROM Client;

       rut   |   name   |  lastname   | debt  | address 
    ---------+----------+-------------+-------+------------
     123     | Tom      | Hofstadter  |   456 |
     132     | Mayim    | Bialik      |       | Barnett 34
     823     | Jim      | Parsons     |    93 |
     193     | Johnny   | Galecki     |   201 | Helberg 11
     453     | Leslie   | Abbott      |   303 |
     583     | Hermione | Weasley     |    47 | Leakey 24
     176     | Ron      | Granger     |    92 | Connor 891
     235     | Hannah   | Winkle      |   104 |
     733     | Howard   | Brown       |       |
     412     | Greg     | Hanks       |    33 |
    (10 rows)


SELECT
~~~~~~~~

Select NULL attributes 
===========================

* To check if there is any :sql:`NULL` value, you use :sql:`IS NULL` or 
* IS :sql:`IS NOT NULL` in the WHERE clause.

General form:

.. code-block:: sql

    SELECT attribute1 FROM nameTable WHERE attribute2 IS NULL

Using the same example, select all the names and last names of the clients where the address is :sql:`NULL`:

.. code-block:: sql
 
	postgres=# SELECT name,lastname FROM Client WHERE address IS NULL;

	name    |  last name
	--------+------------
	Tom     | Hofstadter
	Jim     | Parsons
	Leslie  | Abbott
	Hannah  | Winkle
	Howard  | Brown
	Greg    | Hanks
	(6 rows)

Select all the names and last names of the clients where the address is different to :sql:`NULL`:

.. code-block:: sql 
 
	postgres=# SELECT name,lastname FROM Client WHERE address IS NOT NULL;

	name      | last name
	----------+----------
	Mayim     | Bialik
	Johnny    | Galecki
	Hermione  | Weasley
	Ron       | Granger
	(4 rows)

When you use the :sql:`IS NOT NULL` instruction, you select all clients who have a known address, 
that is, the ones who have any designated value in the database.


Comparisons with NULL
=======================

* The comparison between two :sql:`NULL` or between any value and :sql:`NULL` have an unknown result, since the value 
  of each :sql:`NULL` is unknown. Also you can say that there is not two identical :sql:`NULL` .  

In the following query select the name and lastName of the clients who have a debt greater to 100 or lower/equal to 100. 
You can see this query would cover all clients since any integer is greater, lower or equal to 100.

.. code-block:: sql

    postgres=# SELECT name,lastName FROM Client WHERE debt > 100 or debt <=100;


However, doing this query returns the following table:

.. code-block:: sql
 
	  name   |  lastname
	---------+------------
	Tom      | Hofstadter
	Jim      | Parsons
	Johnny   | Galecki
	Leslie   | Abbott
	Hermione | Weasley
	Ron      | Granger
	Hannah   | Winkle
	Greg     | Hanks
	(8 rows)

You can observe that not all clients are included because debt attribute admits :sql:`NULL` values, and as it 
was mentioned before, a :sql:`NULL` cannot be compared with any value since it returns an unknown result.

To obtain all clients, you should do the following:

.. code-block:: sql
 
	postgres=# SELECT name,lastname FROM Client WHERE debt > 100 or debt <=100 or debt IS NULL;
 
	name      |  lastname
	----------+------------
	Tom       | Hofstadter
	Mayim     | Bialik
	Jim       | Parsons
	Johnny    | Galecki
	Leslie    | Abbott
	Hermione  | Weasley
	Ron       | Granger
	Hannah    | Winkle
	Howard    | Brown
	Greg      | Hanks
	(10 rows)

Now let’s check the comparison with other sentence:

 
.. code-block:: sql
   
	postgres=# SELECT name,lastname FROM Client WHERE debt > 100 or name= 'Howard';

	name    |  lastname
	--------+------------
	Tom     | Hofstadter
	Johnny  | Galecki
	Leslie  | Abbott
	Hannah  | Winkle
	Howard  | Brown
	(5 rows)

'Howard' has a debt :sql:`NULL`. It was demonstrated previously that you cannot compare :sql:`NULL`, so it does 
not meet with debt > 100. Despite this issue, you can see it in the result of the query since it 
meets with the second condition: name = 'Howard'. The aim of this example is to show you that 
having a :sql:`NULL` value within its attributes does not mean that it becomes completely invisible. That is, 
while you do not compare only the :sql:`NULL` attribute, you can still have them in the result.

As a summary:

      * A = NULL. You cannot say that A has the same value as NULL.
      * A <> NULL. You cannot say that A has a different value to NULL.
      * NULL = NULL. It is impossible to know if both NULL are equal.


Operations with NULL
=====================

* Remember that NULL means unknown. While doing a sum where one of
* the data is unknown, the sum is also unknown:

.. code-block:: sql
 
 postgres=# SELECT (SELECT debt FROM client WHERE rut=132)+( SELECT debt FROM client WHERE rut=583) as sum;

 sum
 ------
 
 (1 row)

The sentence sum the debt of the client 132 which is NULL with the debt of 47 of the client 538. NULL + 47 
gives as a result NULL. The same happens in the case of the subtraction, multiplication and division.


Logical operators 
===================


* When there are NULL values in the data, the logical operators and the comparison 
  can return a third UNKNOWN result instead of a simple TRUE or FALSE. This necessity of logic 
  of three values is the origin of many mistakes of this application.

A new column is added which contains boolean values:

.. code-block:: sql
	
	 postgres=# ALTER table Client add current bool;
	 ALTER TABLE

Some values are inserted to the new current column. This column describes if a client 
is current or if it is not a client of the company anymore.

.. code-block:: sql
	 
	postgres=# UPDATE Client SET current=true WHERE rut=412;
	UPDATE 1
	postgres=# UPDATE Client SET current=true WHERE rut=123;
	UPDATE 1
	postgres=# UPDATE Client SET current=true WHERE rut=193;
	UPDATE 1
	postgres=# UPDATE Client SET current=false WHERE rut=733;
	UPDATE 1
	postgres=# UPDATE Client SET current=false WHERE rut=823;
	UPDATE 1
	postgres=# UPDATE Client SET current=false WHERE rut=453;
	UPDATE 1


.. code-block:: sql
  
	postgres=#  SELECT * FROM Client;

	rut |   name   |  lastname  | debt  |  address   | current
	----+----------+------------+-------+------------+--------
	132 | Mayim    | Bialik     |       | Barnett 34 |
	583 | Hermione | Weasley    |    47 | Leakey 24  |
	176 | Ron      | Granger    |    92 | Connor 891 |
	235 | Hannah   | Winkle     |   104 |            |
	412 | Greg     | Hanks      |    33 |            | t
	123 | Tom      | Hofstadter |   456 |            | t
	193 | Johnny   | Galecki    |   201 | Helberg 11 | t
	733 | Howard   | Brown      |       |            | f
	823 | Jim      | Parsons    |    93 |            | f
	453 | Leslie   | Abbott     |   303 |            | f
	(10 rows)

:sql:`IS UNKNOWN` returns the values which are neither :sql:`false` or :sql:`true`. Now we will show how to use it, 
by selecting in the client table all the names which have in the current attribute no value at all.

.. code-block:: sql


	postgres=#  SELECT name FROM client WHERE current IS UNKNOWN;

	name
	----------
	Mayim
	Hermione
	Ron
	Hannah
	(4 rows)


:sql:`IS NOT UNKNOWN` works in the same way but it only returns the values which have an assigned value,
either :sql:`true` or :sql:`false`.

For the AND and OR operators which involve NULL, in general terms it can be said that:

      * NULL or false = NULL
      * NULL or true = true
      * NULL or NULL = NULL
      * NULL and false = false
      * NULL and true = NULL
      * NULL and NULL = NULL
      * not (NULL) the inverse of NULL it is also NULL.

.. note::
	To minimize maintenance tasks and possible effects in queries or reporting data should 
	be minimized the use of unknown values. It is good practice to raise queries and instructions 
	on modifying data so that NULL data have minimal effect.
