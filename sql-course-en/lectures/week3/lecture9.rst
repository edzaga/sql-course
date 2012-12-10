Lecture 9 - Subqueries in WHERE clause
--------------------------------------
.. role:: sql(code)
   :language: sql
   :class: highlight

A subquery is a query which returns an unique value and which is nested within a SELECT, INSERT, UPDATE or DELETE. 
It could even be within another subquery. A subquery can be used in any place where an expression is allowed.+


SELECT-FROM-WHERE(SELECT)
~~~~~~~~~~~~~~~~~~~~~~~~~

Until now we have seen queries of the type :sql:`SELECT`, :sql:`WHERE`,
:sql:`FROM` and some of its derivations such as the use of JOIN and logical operators **AND, OR, NOT**
which are commonly use to filter results by the manipulation of a series of conditions.

However, there are other forms for filter queries: **the subqueries**. 
A subquery is a :sql:`SELECT` sentence which appears within another :sql:`SELECT` sentence and which are normally used to 
filter a WHERE clause with the set of results of the subquery.

A subquery has the same syntax of a normal :sql:`SELECT` sentence, except that it appears enclose in parentheses.

As is usual, it will be used the example of the easy “Admission to university” database::

    College (cName, state, enrollment)
    Student (sID,   sName, Average)
    Apply   (sID,   cName, major, decision)

whose tables are created by:

.. code-block:: sql

 CREATE TABLE College(id  serial,  cName VARCHAR(20), state VARCHAR(30),
 enrollment INTEGER, PRIMARY KEY(id));
 CREATE TABLE Student(sID serial,  sName VARCHAR(20), Average INTEGER,
 PRIMARY kEY(sID));
 CREATE TABLE   Apply(sID INTEGER, cName VARCHAR(20), major VARCHAR(30), 
 decision BOOLEAN,   PRIMARY kEY(sID, cName, major));


We will used 4 educational institutions:

.. code-block:: sql

 INSERT INTO College (cName, state, enrollment) VALUES ('Stanford','CA',15000);
 INSERT INTO College (cName, state, enrollment) VALUES ('Berkeley','CA',36000);
 INSERT INTO College (cName, state, enrollment) VALUES ('MIT',     'MA',10000);
 INSERT INTO College (cName, state, enrollment) VALUES ('Harvard', 'CM',23000);

8 students:

.. code-block:: sql

 INSERT INTO Student (sName, Average) Values ('Amy',    60);
 INSERT INTO Student (sName, Average) Values ('Edward', 65);
 INSERT INTO Student (sName, Average) Values ('Craig',  50);
 INSERT INTO Student (sName, Average) Values ('Irene',  49);
 INSERT INTO Student (sName, Average) Values ('Doris',  45);
 INSERT INTO Student (sName, Average) Values ('Gary',   53);
 INSERT INTO Student (sName, Average) Values ('Doris',  70);
 INSERT INTO Student (sName, Average) Values ('Tim',    60);

y 21 applications:

.. code-block:: sql

 INSERT INTO Apply (sID, cName, major, decision) VALUES (1, 'Stanford', 
 'science'        , True);
 INSERT INTO Apply (sID, cName, major, decision) VALUES (1, 'Stanford', 
 'engineering'    , False);
 INSERT INTO Apply (sID, cName, major, decision) VALUES (1, 'Berkeley', 
 'science'        , True);
 INSERT INTO Apply (sID, cName, major, decision) VALUES (1, 'Berkeley',
 'engineering'    , False);
 INSERT INTO Apply (sID, cName, major, decision) VALUES (2, 'Berkeley',
 'natural history', False);
 INSERT INTO Apply (sID, cName, major, decision) VALUES (3, 'MIT'     ,
 'math'           , True);
 INSERT INTO Apply (sID, cName, major, decision) VALUES (3, 'Harvard' ,
 'math'           , False);
 INSERT INTO Apply (sID, cName, major, decision) VALUES (3, 'Harvard'
 , 'science'        , False);
 INSERT INTO Apply (sID, cName, major, decision) VALUES (3, 'Harvard' ,
 'engineering'    , True);
 INSERT INTO Apply (sID, cName, major, decision) VALUES (4, 'Stanford',
 'marine biology' , True);
 INSERT INTO Apply (sID, cName, major, decision) VALUES (4, 'Stanford',
 'natural history', False);
 INSERT INTO Apply (sID, cName, major, decision) VALUES (5, 'Harvard' ,
 'science'        , False);
 INSERT INTO Apply (sID, cName, major, decision) VALUES (5, 'Berkeley',
 'psychology'     , True);
 INSERT INTO Apply (sID, cName, major, decision) VALUES (5, 'MIT'     ,
 'math'           , True);
 INSERT INTO Apply (sID, cName, major, decision) VALUES (6, 'MIT'     ,
 'science'        , False);
 INSERT INTO Apply (sID, cName, major, decision) VALUES (7, 'Stanford',
 'psychology'     , True);
 INSERT INTO Apply (sID, cName, major, decision) VALUES (7, 'Stanford',
 'science'        , True);
 INSERT INTO Apply (sID, cName, major, decision) VALUES (7, 'MIT'     ,
 'math'           , True);
 INSERT INTO Apply (sID, cName, major, decision) VALUES (7, 'MIT'     ,
 'science'        , True);
 INSERT INTO Apply (sID, cName, major, decision) VALUES (7, 'Harvard' ,
 'science'        , False);
 INSERT INTO Apply (sID, cName, major, decision) VALUES (8, 'MIT'     ,
 'engineering'    , True);

The situation which is pretending to be described with these sample tables is the application 
of students to educational institutions. In particular, the application of the student *sID* to 
the academic mention *major* imparted in the educational institution *cName*, whose approval or 
decision will be “True or False”.   

Example 1
^^^^^^^^^
The first example of subquery corresponds to a list of *IDs* and *Names* of students who have 
applied for studying “science” in a educational institution.

.. code-block:: sql

 SELECT sID, sName
 FROM Student
 WHERE sID in
 (SELECT sID FROM Apply WHERE major = 'science');

whose output is::

  sid | sname
  ----+-------
   6  | Gary
   1  | Amy
   3  | Craig
   7  | Doris
   5  | Doris

  (5 rows)

.. note::

  In the example there are two different people called Doris.


As it was mentioned previously, both subqueries and the use of :sql:`JOIN` and logical operators 
in the :sql:`WHERE` clause, are ways to filter results, therefore, the query can be reformulated as:

.. code-block:: sql

 SELECT Student.sID, sName FROM Student, Apply WHERE Student.sID = Apply.sID AND major = 'science';

.. warning::

   In the query you must specify that the attribute *sID* corresponds to the **Student** table, as the **Apply** 
   table also has that attribute. If you do not take this into account, it is likely that the query will 
   end in an error or with undesirable results.

in which case the output is:::

  sid | sname
  ----+-------
   1  | Amy
   1  | Amy
   3  | Craig
   6  | Gary
   7  | Doris
   7  | Doris
   7  | Doris
   5  | Doris

  (8 rows)

The 3 “extra” rows are because when using :sql:`JOIN` and logical operators, are taken into account 
all the results. For instance, Amy applied on two occasions science. When using subquery, you delete 
these duplicated results, making the query more faithful to reality since it asks for those students 
who have applied to “science” and no how many times they have applied to each one. Nonetheless, if you 
add the :sql:`DISTINCT` clause, you will get the same answer as when using the subquery. This means 
that for the query:

.. code-block:: sql

 SELECT DISTINCT Student.sID, sName
 FROM Student, Apply
 WHERE Student.sID = Apply.sID AND major = 'science';

its output will be::

  sid | sname
  ----+-------
   6  | Gary
   1  | Amy
   3  | Craig
   7  | Doris
   5  | Doris

  (5 rows)


Example 2
^^^^^^^^^
This example corresponds only to the list of names of students who have been 
selected to study science in an educational institution.  

.. code-block:: sql

  SELECT sName 
  FROM Student
  WHERE sID in
  (SELECT sID FROM Apply WHERE major = 'Science');

the output is::

   sname
   -------
   Gary
   Amy
   Craig
   Doris
   Doris

   (5 rows)

.. note::

 Both Doris do not correspond to a duplicate since sID attribute of one is 5 and the other one is 7.

And you get the same 5 students. Analogously to the previous example, we will made the equivalent 
to the subquery by using :sql:`JOIN` and logical operator:

.. code-block:: sql

 SELECT sName FROM Student, Apply WHERE Student.sID = Apply.sID AND major = 'science';

whose output is::

  sname
  -------
  Amy
  Amy
  Craig
  Gary
  Doris
  Doris
  Doris
  Doris

  (8 rows)


Therefore just like the previous example, :sql:`DISTINCT` will be used, which means:


.. code-block:: sql

 SELECT DISTINCT sName
 FROM Student, Apply
 WHERE Student.sID = Apply.sID AND major = 'science';

whose output is::

  sname
  -------
  Amy
  Craig
  Doris
  Gary

  (4 rows)

But there are only 4 students. This is because in the previous example we used both *sID* and *sName*. 
Since both Doris have a different *sID* we did not take them into account as a duplicate. But in this 
query, as we only have *sName*, both Doris are taken as two instances of the same, so we removed one.

The only way to get the “correct number of duplicates” is by using subqueries.

IN AND NOT IN
=============

:sql:`IN` and :sql:`NOT IN` allow to perform filters in a more specific form, necessary to 
answer questions like in example 3.

Example 3
^^^^^^^^^

In the next  example we want to know the *sID* and *sName* of those students 
who have applied to science, but no an engineering:


.. code-block:: sql

  SELECT sID, sName FROM Student WHERE
  sID in (SELECT sID FROM Apply WHERE major = 'science')
  and sID not in (SELECT sID FROM Apply WHERE major = 'engineering');

whose output corresponds precisely to::

  sid  | sname
  -----+-------
   5   | Doris
   6   | Gary
   7   | Doris

  (3 rows)

.. note::

   It is possible to corroborate the result by running: sql:´SELECT * FROM Apply;´
   and checked it manually.
 
The query we have made in this example is possible to make it another way:

.. code-block:: sql

  SELECT sID, sName FROM Student WHERE
  sID in (SELECT sID FROM Apply WHERE major = 'science')
  and not sID in (SELECT sID FROM Apply WHERE major = 'engineering');

whose output is equivalent to the previous.


EXISTS AND NOT EXISTS
=====================

:sql:`EXISTS` is a SQL function which returns true when a subquery returns at least one row.


Example 4
^^^^^^^^^

In this example we look for the name of all educational institutions which share the same 
condition. If we run:

.. code-block:: sql

 SELECT cName, state FROM College;

whose output is::

 cname    | state
 ---------+-------
 Stanford | CA
 Berkeley | CA
 MIT      | MA
 Harvard  | CM

 (4 rows)

the expected result should include the **Stanford-Berkeley** pair

The query which pretends to solve this question is:

.. code-block:: sql

 SELECT cName, state
 FROM College C1
 WHERE exists
 (SELECT * FROM College C2 WHERE C2.state = C1.state);

.. note::

 This query tries to verify that for each result obtained in C1, by comparing them with the results in C2.
 
 
whose output is::

 cname    | state
 ---------+-------
 Stanford | CA
 Berkeley | CA
 MIT      | MA
 Harvard  | CM

 (4 rows)

This happens because C1 and C2 can be the same institution. Therefore, it is necessary to make clear 
that C1 and C2 are different.

.. code-block:: sql

 SELECT cName, state
 FROM College C1
 WHERE exists
 (SELECT * FROM College C2 WHERE C2.state = C1.state and C1.cName <> C2.cName);

in which case the output corresponds to the correct, which means::

 cname    | state
 ---------+-------
 Stanford | CA
 Berkeley | CA

 (2 rows)


MATHEMATICAL COMPUTATIONS
=========================

It is possible to make mathematical computations (highest value, lowest value) using subqueries:

Example 5
^^^^^^^^^

It search the institution with the largest number of students. The query that will be performed 
corresponds to search all the institutions where there is no other institution whose number of
students is greater than the first.



.. code-block:: sql

 SELECT cName, state
 FROM College C1
 WHERE exists
 (SELECT * FROM College C2 WHERE C2.enrollment > C1.enrollment);

Where the result corresponds to *Berkeley*.

.. note::

 Likewise it is possible to calculate the institution with fewer students, changing the mathematical sign **>** by **<**


