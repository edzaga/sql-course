Lecture 22 - Constraints and triggers: Constraints of several types
--------------------------------------------------------------------

.. role:: sql(code)
     	:language: sql
     	:class: highlight

.. context

As it was observed in the previous lecture, there are several types of restrictions which are divided in:

  1. Restrictions that do not allow  *NULL* values.
  2. Restrictions of primary key.
  3. Restrictions of attribute and tuple.
  4. General restrictions. 
 
==========
Context
==========

In this lecture we will use the example of the system of Application of Students to Educational Institutions::

	Student(sID, sName, Average);
	College(cName, State, Enrollment);
	Apply(sID, cName, Major, Decision);

Let’s start to see the different types of restriction:

========================================
Restriction to avoid NULL values
========================================

As its name indicates, this type has the aim to avoid that a certain attribute contains null values. 

Example 1
^^^^^^^^^

Let’s create a table of students in which it is not allowed the field ‘Average’ empty. 

.. code-block:: sql

  CREATE TABLE Student (sID SERIAL, sName VARCHAR(50)
  Average INT NOT NULL, PRIMARY KEY (sID) );

And afterwards we make a series of insertions:

.. code-block:: sql

  INSERT INTO Student (sName, Average) VALUES ('Amy', 60);
  INSERT INTO Student (sName, Average) VALUES ('Tim', null);
  INSERT INTO Student (sName, Average) VALUES (null, 90);

Which for the second insertion, the following error will appear::

  ERROR: null value in column "average" violates not-null constraint

Example 2
^^^^^^^^^

If we try using commands of updating (**UPDATE**)

Lets say that the average of ‘Amy’ is incorrect, but we do not know it yet. Therefore, the person in charge of doing this job (who does not know the restriction of the table) decides to insert a NULL value:

.. code-block:: sql

  UPDATE Student SET Average = null where sid = 1;

Nonetheless, it appears::

  ERROR: null value in column "average" violates not-null constraint

==================================
Restriction of primary key
==================================

Remembering, a primary key is a key which is used to identify the form 
**unique for each
line in a table**.

Lets try this type of restriction with a couple of examples:

Example 3
^^^^^^^^^

Lets create a table of students (suppose students 2 for not having misunderstandings afterwards) which declares explicitly its primary key. 

.. code-block:: sql

  CREATE TABLE Student2 (sID INT PRIMARY KEY, sName VARCHAR(50),
  Average INT);

And then we insert some data: 

.. code-block:: sql

 INSERT INTO Student2 VALUES (123,'Amy', 60);
 INSERT INTO Student2 VALUES (234,'Tim', 70);
 INSERT INTO Student2 VALUES (123,'Bob', 55);

With the first two insertions there are not problems, but with the third appears the following error::


  ERROR: duplicate key value violates unique constraint "student2_pkey"
  DETAIL: Key (sid)=(123) already exists.


This occurs because it was defined *sID* as the primary key of the table. 

Example 4
^^^^^^^^^^
Similar to the case of example 2, if we want to to update the value of attribute *sID*, 

.. code-block:: sql

  UPDATE Student2 SET sID = 123 where sid = 234;

the following error appears::

  ERROR: duplicate key value violates unique constraint "student2_pkey"
  DETAIL: Key (sid)=(123) already exists.

It should be noted that if we want to update a *sID* which does not exist by '123', such error would not appear; but, you will not have updating:

.. code-block:: sql

  UPDATE Student2 SET sID = 123 where sid = 999;

The output is::

 UPDATE 0


Example 5
^^^^^^^^^
A curious case is given when we want to do several changes at the same time. 
The current state of the table **Student2** is::

  sid | sname | average
  ----+-------+--------
  123 | Amy   | 60
  234 | Tim   | 70

What happens if we want to subtract 111 to both *sID*?

.. code-block:: sql

  UPDATE Student2 SET sID = sID - 111;

The output is::

 UPDATE 2

and the state of the table is::

  sid | sname | average
  ----+-------+--------
   12 | Amy   | 60
  123 | Tim   | 70

So there are not problems. However, what happens if we want to add 111 instead of subtract? 

.. code-block:: sql

  UPDATE Student2 SET sID = sID + 111;

The output is::

  ERROR: duplicate key value violates unique constraint "student2_pkey"
  DETAIL: Key (sid)=(123) already exists.

That is, the order of the operations is FIFO since in the operation of subtract there were no problems: the *sID* of ‘Amy’ goes from 123 to 12, then the one of ‘Tim’ goes from 234 to 123. 

In the second case of adding, the *sID* of ‘Amy’ goes from 12 to 123, but it generates conflict with the one of ‘Tim’.

.. note::
 
   FIFO is an acronym for "First In First Out", in order words, it addresses first to the first that comes. This model of attention is known as tail.

There is more than one way to define primary keys: 


Example 6
^^^^^^^^^
Usually in SQL it is only allowed one primary key (that’s why the name), as well as several of their implementations. This key allows a fast and efficient order.

.. note::

	It is possible to define more than one attribute as primary key  itself, but we reserve the method for the following example
 
Suppose that we want to create the table **Student** again due to some failures. Instead of

.. code-block:: sql

  DROP TABLE Student;

create another table, it is used the command: in this new table we want as primary keys *sID and sName*.

.. code-block:: sql

  CREATE TABLE Student (sID INT PRIMARY KEY, sName VARCHAR(50) PRIMARY KEY,
  Average INT);

Nonetheless, the output is::

 ERROR: multiple primary keys for table "student" are not allowed
 LINE1: ... E student (sID PRIMARY KEY, sNname VARCHAR(50) PRIMARY KE...
                                                       	^

A form to avoid this error is to use :sql:`UNIQUE` instead of the PRIMARY KEY, for the *sName* attribute.

.. code-block:: sql

  CREATE TABLE Student (sID INT PRIMARY KEY, sName VARCHAR(50) UNIQUE,
  Average INT);

In whose case the output would be::

 NOTICE: CREATE TABLE / PRIMARY KEY will create implicit index "student_pkey"
 for table "student"
 NOTICE: CREATE TABLE / UNIQUE will create implicit index "student_sname_key"
 for table "student"
 CREATE TABLE

Using :sql:`UNIQUE` allowed even to have all the attributes which are not primary key. As key (no primary). :sql:`UNIQUE` works comparing **only the values of the column in question**. If a value is repeated, even though there are not keys in conflict in the primary key, you will found errors anyway:

.. code-block:: sql

 INSERT INTO Student VALUES (123,'Amy', 60);
 INSERT INTO Student VALUES (234,'Tim', 70);
 INSERT INTO Student VALUES (345,'Bob', 55);
 INSERT INTO Student VALUES (456,'Amy', 90);

For the first 3 insertions there are no problems. Even though in the fourth there is no conflict with the primary key::

 ERROR: duplicate key value violates unique constraint "student_sname_pkey"
 DETAIL: Key (sname)=(Amy) already exists.

In other words, we compare only the values of the column/attribute *sName*. As ‘Amy’ is already there, it will appear the error above. 

Example 7
^^^^^^^^^
As it was mentioned in the note of the previous example, it is possible to define a group of attributes as primary key. 

Let's use the **College** table. 

Suppose that we want to create the **College** table with 2 attributes as primary key:

*cName*
y *State*.

We already know by example 6 that something as the following would not work:

.. code-block:: sql

 CREATE TABLE College (cName VARCHAR(50) PRIMARY KEY,
 State VARCHAR (30) PRIMARY KEY, Enrollment INT);

As it is not allowed the use of  multiple primary keys. However, it is possible if it is defined the primary key at the end, unique, but of several attributes:

.. code-block:: sql

  CREATE TABLE College (cName VARCHAR(50), State VARCHAR(30),
  INT Enrollment, PRIMARY KEY (cName, State));

In this case the output will be::

 NOTICE: CREATE TABLE / PRIMARY KEY will create implicit index "college_pkey"
 for table "college"
 CREATE TABLE

If we notice, the primary key is composed by *cName* and *State*. This is known as **compound key**, since it is not one or the other, but the combination of both. For example, if we had left only the *cName*as primary key and *State* as :sql:`UNIQUE`, insertions of this type would not be allowed:

.. code-block:: sql

  INSERT INTO College VALUES ('MIT', 'CA',20000);
  INSERT INTO College VALUES ('Harvard', 'CA', 34000);

.. note::

   The data of the insertions above have not correlation with the data used in other lectures or the real ones. These are only used in order to explain the example.

Since with :sql:`UNIQUE` in the *State* column, it is not allowed ‘CA’ twice. Nevertheless, as it is a “compound primary key*, it is allowed. In this case a violation of the restriction will be the case of 2 rows which share the same values in both attributes, that is, in *cName* y *State*

.. note::

   For  the case of PostgreSQL, in an attribute declared as :sql:`UNIQUE`, allows the multiple use of NULL values. On the other hand, if we want to use NULL as a primary key (PK), it is not allowed. 

===================================
Restrictions of attribute and tuple
===================================

This type of restriction search to limit the values of entry (or updating) allowed in order to avoid errors such as inserting negative values when there are only admit positive ones. 
For this reasons, it is used the reserved word  **CHECK**.

Example 8
^^^^^^^^^
If we created the students 3 table, whose main characteristic is to verify that in the operations the insertion and updating, the averages are within the permitted value:

.. code-block:: sql

  CREATE TABLE Student3 (sID INT, sName VARCHAR(50),
  Average INT CHECK(Average>=0 and Average<=100));

To verify the check up, lets do some insertions:

.. code-block:: sql

 INSERT INTO Student3 VALUES (123,'Amy', 60);
 INSERT INTO Student3 VALUES (234,'Tim', 70);
 INSERT INTO Student3 VALUES (345,'Bob', -55);
 INSERT INTO Student3 VALUES (456,'Clara', 190);

With the first two insertions  there are no problems, but with the third and fourth the following error appears::

 ERROR: new row for relation "student3" violates check constraint "student3_average_check"

since it violates the restriction of the average.

Example 9
^^^^^^^^^

Also it is possible to restrict strings of characters, as the case of the *sName* attribute. Suppose that we want to deny the entry or updating of rude or pointless names. Lets limit the case to the strings: ‘amY’ and ‘amy’:

.. code-block:: sql

  DROP TABLE Student3;
  CREATE TABLE Student3 (sID INT,
  sName VARCHAR(50) CHECK(sName <> 'amY' and sName <> 'amy  '),
  Average INT CHECK(Average>=0 and Average<=100));

If we make some insertions:

.. code-block:: sql

 INSERT INTO Student3 VALUES (123,'amY', 60);
 INSERT INTO Student3 VALUES (234,'amy', 70);
 INSERT INTO Student3 VALUES (345,'amy  ',55);
 INSERT INTO Student3 VALUES (454,'Amy',90);

For both the first insertion and the third, we have::

  ERROR: new row for relation "student3" violates check constraint "student3_sname_check"

For the second and the fourth insertions there are not such error, because as it was mentioned during the first weeks, the unique case in which SQL is sensible to the use of capitals letters and lowercase letters is for strings of characters which are between quotation marks (“). Therefore, ‘amY’ or ‘amy’ which are restricted strings differ from the ‘Amy’ and ‘amy’. 

.. note::

	It is extremely important that if you want to declare strings of characters and that in addition
	you want to restrict specific values ​​(as in Example 9), the allowed length is not too long as to have 
        to restrict each specific case, either: 'amy', 'amy ', 'amy  ',... or 'Amy', 'Amy '... considering all 
	the possible combinations; neither too short to have problems of insertion with real data. 

As in the first example, if you want to update the attributes that have the type of restriction of this section, with values ​​that are out of range or within the restriction, you get an error of type::

  ERROR: new row for relation "**table**" violates check constraint "**table**_*attribute*_check" 

Where **table** refers to the relation itself and *attribute* to the attribute that counts with the restriction of the type  **CHECK**.

Also it is possible to use this type of restriction to avoid NULL values, as you will see in the following example.

Example 10
^^^^^^^^^^
Suppose that we want to create the table of application **Apply**, but that the *decision* attribute, of boolean type, does not admit null values, using restrictions of attribute and tuple. 

.. code-block:: sql

 CREATE TABLE Apply (sID INT, cName VARCHAR(50), Major VARCHAR(11),
 decision BOOL, CHECK(decision IS NOT NULL));

And then insert some data:

.. code-block:: sql

 INSERT INTO Apply VALUES (123, 'MIT', 'engineering', true);
 INSERT INTO Apply VALUES (123, 'Stanford', 'engineering', null);
For the first insertion there are no problems, but for the second::

 ERROR: new row for relation "apply" violates  check constraint "apply_decision_check"

If you want to update the first insertion to *decision=null*:

.. code-block:: sql

  UPDATE Apply SET decision = null WHERE sID = 123;

We found the same error::

 ERROR: new row for relation "apply" violates  check constraint "apply_decision_check"


Example 11
^^^^^^^^^^

Suppose that when adding a new application in the **Apply**, we want to verify the existence in the **Student** table through the *sID* attribute using for that, subqueries:

.. code-block:: sql

 DROP TABLE Student;
 CREATE TABLE Student (sID INT, sName VARCHAR (50), Average INT);
 CREATE TABLE (sID INT, cName VARCHAR(50), Major VARCHAR(11),
 decision BOOL, CHECK( sID IN (SELECT sID FROM Student)));

With the first 2 instructions there are no problems, but when we try to create the **Apply** table, the following error will appear:

 ERROR: cannot use subquery in check constraint

That is, using subqueries within a CHECK is not permitted in PostgreSQL. In fact, it is not allowed in the majority of motors of database. 

=========================
General restrictions
=========================
Although these are forms of powerful restrictions, they are not supported by almost no current system. 

Example 12
^^^^^^^^^^
Suppose a **T** table of *A* attribute.  We want to force that this attribute should be the key of **T**. 

.. code-block:: sql

 CREATE TABLE T (A INT);
 CREATE ASSERTION KEY CHECK ((SELECT COUNT (DISTINCT A) FROM T)=
 (SELECT COUNT(*) FROM T));

The query above is trying to force that for each row of the **T** table, the *A* attribute will be different, which would leave an *A* as key. 

Nonetheless, the function **assertion** is not implemented in PostgreSQL::

 CREATE ASSERTION is not yet implemented

