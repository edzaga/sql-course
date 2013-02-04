Lecture 28 - Views: View and automatic modifications 
----------------------------------------------------



.. role:: sql(code)
           :language: sql
           :class: highlight

In general, tables are constituted by a set of definitions and store data. In the other hand, views are in 
superior level, as they are constituted by definitions, but don’t store data, as they use the data In the tables.
Because of this, views are considered “Virtual Tables”.

Its syntaxes is:

.. code-block:: sql
 
 CREATE VIEW "view_name" AS "sql_instruction";

Where:

1. **"view_name"**  : corresponds to the name of the view.
2. **"sql_instruction"**: corresponds to a SQL instruction executed till now, in other words, modification or/and insertion operations.

Every Database (DB) can be seen as a 3-level tree:

1. **The Root**, is the **physical** part of the DB, the hard drives.
2. **The Core**, is the set of relations in the DB, in other words the **conceptual** part.
3. **Branches**, they correspond to the **Logical** part of the DB. It refers to the relations that are born from the Core (tables) or/and other branches (other views).

Modifying data in a view is useless, as it doesn’t stores any data, and any modification would be lost. However if this modifications modify also the tables, this modification would be very useful.

.. note::
 By modification we understand operation like INSERT, UPDATE and DELETE.

This modification in the views must be translated into modification that affects the involved 
tables. This reading is oriented towards how to automate this process.

=============
Rules
=============

In the SQL standard, 4 rules exist to make a “modifiable view”, namely when we modify a view, the involved relation/table is also modified.
These rules are:

1. Do a :sql:`SELECT` of a table, not of a Join. Also the table can’t be :sql:`DISTINCT`.
2. If an attribute is not in the view, it must be able to support **NULL** values or 1 (one).
3. if the view is over the relation/table **T**, the sub queries cannot refer to **T**, but they can refer to other relations/tables.
4. in a view you can’t use :sql:`GROUP BY` or :sql:`AGREGGATION`.

============
Context
============

Let’s suppose that during the first semester of class, specifically on a month in which a new 
College-Application system is being implemented, 4 students apply. Because of this, is decided to make an 
upgrade using views, as they simplify complex queries about tables, be it by selecting (:sql:`SELECT`.) 
and/or (:sql:`INSERT`, :sql:`UPDATE`, :sql:`DELETE`) data.

Also, more strict criteria will be implemented. In the first version of the system, students with a lower 
average were allowed to apply. This new system will be called Application 2.0 (BETA).


Because of this, for this reading we will use this College Application System as an example.

.. code-block:: sql
 
 CREATE TABLE College(cName VARCHAR(20), state VARCHAR(30),
 enrollment INTEGER, PRIMARY KEY(cName));
 CREATE TABLE Student(sID SERIAL,  sName VARCHAR(20), Average INTEGER,
 PRIMARY KEY(sID));
 CREATE TABLE   Apply(sID INTEGER, cName VARCHAR(20), major VARCHAR(30),
 decision BOOLEAN,   PRIMARY KEY(sID, cName, major));
 
With the following data for the table **College**, **Student** and **Apply** respectively:

4 Establishments:

.. code-block:: sql
 
 INSERT INTO College VALUES ('Stanford','CA',15000);
 INSERT INTO College VALUES ('Berkeley','CA',36000);
 INSERT INTO College VALUES ('MIT',        'MA',10000);
 INSERT INTO College VALUES ('Harvard', 'CM',23000);

.. note::
 
 This data is not necessarily real and now enquiries were made to check their truthfulness, as it escapes the scope of 
 this course. They are only tools for the development of this reading’s examples.

3 Students:

.. code-block:: sql
 
 INSERT INTO Student (sName, Average) VALUES ('Clark',  70);
 INSERT INTO Student (sName, Average) VALUES ('Marge',  85);
 INSERT INTO Student (sName, Average) VALUES ('Homer',  50);
 
8 Applicants:

.. code-block:: sql
 
 INSERT INTO Apply VALUES (1, 'Stanford', 'science'         , True);
 INSERT INTO Apply VALUES (1, 'Berkeley', 'science'         , False;
 INSERT INTO Apply VALUES (2, 'Harvard' , 'science'         , False;
 INSERT INTO Apply VALUES (2, 'MIT'       , 'engineering'   , True);
 INSERT INTO Apply VALUES (2, 'Berkeley', 'science'         , True);
 INSERT INTO Apply VALUES (3, 'MIT'       , 'science'         , True);
 INSERT INTO Apply VALUES (3, 'Harvard' , 'engineering'   , True);
 INSERT INTO Apply VALUES (3, 'Harvard' , 'natural history' , True);
 

.. note::
 
 This data is not necessarily real and now enquiries were made to check their truthfulness, as 
 it escapes the scope of this course. They are only tools for the development of this reading’s examples.

===========================================
Automatic modification of tables and views.
===========================================

Suppose we want to select those students that applied and were accepted in Science, in any establishment, but using views:

.. code-block:: sql
 
 CREATE VIEW scAccepted as
 SELECT sid, sname FROM Apply
 WHERE major='science' and decision = true;
 
This view has 4 restriction imposed by the SQL standard  so it can be considered a “modifiable view”.

1. Only the data from the table **Apply** are selected.
2. The attributes of that table don’t contain a restriction of the type **NOT NULL**.
3. No sub queries exist that refer to the table **Apply**.
4. :sql:`GROUP BY` or  :sql:`AGREGGATION` are not used.

If the data from the view is selected:

.. code-block:: sql
 
 SELECT * FROM scAccepted;

The output is::
 
 sid | cname
 ----+----------
   1 | Stanford
   2 | Berkeley
   3 | MIT
 
Example 1
^^^^^^^^^
Suppose we want to eliminate from the view the student with *sID* = 3 (Homer), because he cheated in his test. 
The idea is to delete him from the view, and at the same time, delete him from the *Apply* table, so we don’t need to execute 2 operations.

.. code-block:: sql
 
 DELETE FROM scAccepted WHERE sid = 3;
 
However::
 
 ERROR: you cannot delete from view "scaccepted"
 HINT: You need a unconditional ON DELETE DO INSTEAD rule or
 INSTEAD OF DELETE trigger.

Because MySQL is the only system, in relation to PostgreSQL or SQLite that allows the management of data of this type. 
These last two allow for the modification according to rules and/or :sql:`triggers` only.

.. warning::
 
 Even though the Database engine used in this course doesn’t support the topic of this reading, some cases 
 and tips will be explained for systems that support this feature. Either way, all examples are made using PostgreSQL.

Example 2
^^^^^^^^^

Let’s suppose we want to create a view that contains all the students that applied to Science or engineering.

.. code-block:: sql
 
 CREATE VIEW sceng as
 SELECT sid, cname, major  FROM Apply
 WHERE major = 'science' or major = 'engineering';
 
We verify through selection:

.. code-block:: sql
 
 SELECT * FROM sceng;

The output is::

  sid | cname     | major
  ----+----------+-------------
   1  | Stanford | science
   1  | Berkeley | science
   2  | Harvard  | science
   2  | MIT         | engineering
   2  | Berkeley | science
   3  | MIT         | science
   3  | Harvard  | engineering
 


If we want to add a row:

.. code-block:: sql
 
 INSERT INTO sceng VALUES (1, 'MIT', 'science');

There is now problem, as it follows the 4 rules for “modifiable views”. This example works in MySQL and in theory.

Example 3
^^^^^^^^^
Suppose we want to add a row to the view **scAccepted**:

.. code-block:: sql
 
 INSERT INTO scAccepted VALUES (2, 'MIT');

even thought someone could think that as the view has predetermined values for the values *major* and *decisión* it would
 be enough to add the rest of the atributes, namely *sID* and *cName*.  But, at the moment we select the data 
from the view, we will not see a new row. This is because:

1. Even though the view has **selection** values, it doesn’t mean they are also for **insertion**. 
2. as it doesn’t have its attributes *major* and *decision* set to 'science' y 'true', it doesn’t pass the view filter.

It must be noted that the table (**Apply** in this case), a new row is added. It has its *major* and *decision* set 
to **NULL**, so it doesn’t make any sense.

Example 4
^^^^^^^^^
In systems that allow for this automatic change, it’s possible to evade inconsistencies like the one in example 3, adding at the end of the view:

.. code-block:: sql
 
 CREATE VIEW scAccepted2 as
 SELECT sid, sname FROM Apply
 WHERE major='science' and decision = true;
 WITH CHECK OPTION;
 
However this option is not implemented in PostgreSQL, so the following error message would appear if executed::
 
 ERROR: WITH CHECK OPTION is not implemented.


=============
Conclusions
=============

1. Automatic changes are only possible in “modifiable tables”, namely those who fulfill the 4 rules.
2. PostgreSQL **doesn’t support this type of modification**, it only allows it through rules and/or :sql:`triggers`. SQLite also doesn’t allow it.  MySQL does.








