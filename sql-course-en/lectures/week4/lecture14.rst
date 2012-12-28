Lecture 14 - SQL: Data modifications statements
------------------------------------------------

.. role:: sql(code)
         :language: sql
         :class: highlight

As it was said in some previous lectures, there are 4 basic operations related with the manipulation of data in a SQL table::

	Selection     -> SELECT
	Insertion     -> INSERT
	Update        -> UPDATE
	Deleting      -> DELETE

In this lecture you will see in depth those operations which allow modifying data. That is, INSERT, UPDATE, and DELETE.


INSERT
~~~~~~

There are at least two forms for inserting data. One of them has been studying in one the first lectures (INSERT INTO):

.. code-block:: sql
	
	INSERT INTO table VALUES (attribute1, attribute2 ...);

That is to insert in the table the corresponding values to the attributes of the table. In order to use this form, 
it is necessary that the quantity of values associated to the attributes is equal to the quantity of attributes of 
the table, and that both are in the same order on terms of the type of data and the one that you want to insert. 
Example 1 will show better this situation:

Context
^^^^^^^^

Let’s use the **Student** table which has been already used in previous lectures::

 Student (sID, sName, Average)

and let’s create a new table called **Student_new**, with a similar structure, but empty:

.. code-block:: sql

 CREATE TABLE Student_new (sID serial, sName VARCHAR(20), 
 Average INTEGER,  PRIMARY KEY(sID));


That is, it has 3 attributes which are: the identifier or *sID* of integer and serial character which means 
that if you do not specification a value, it will take a integer value; the name or sName which corresponds 
to a chain of characters; and the average or *Average* which is a integer.


Example 1
^^^^^^^^^
Suppose that worksheet students housed in the **Student** table has already been sent and cannot be changed, 
that is why you need to create a new spreadsheet (another student table), and added to the new 
student applications.

Therefore it is possible to add a student by:

.. code-block:: sql

  INSERT INTO Student_new VALUES (1,'Betty', 78);

whose output after doing:

.. code-block:: sql

 SELECT * student;

is ::

   sid | sname  | average
   ----+--------+---------
    1  | Betty  |  78

By using the *sID* attribute as serial, it is possible to omit the value of this attribute 
when you are going to insert a new student:

.. code-block:: sql

  INSERT INTO Student_new (sName, Average) VALUES ('Wilma', 81);

But, this lead us to the following error::

  ERROR: duplicate key value violates unique constraint "student_new_pkey"
  DETAIL: Key(sid)=(1) already exists.


That is because *sID* is primary key, and serial has its own counter which starts in 1 (which is not link 
necessarily to the values of diverse rows that can appear in the table). Until this point, you can only 
still add students by explicitly adding all and each of the attributes of the table, without dispense in 
this case the *sID* and its characteristic of been serial as the attribute-value tuple (sID)=(1) is locked.

.. note::
 
   You can directly delete the row corresponding to 'Betty', but that step is reserved to the subsection  
   of DELETE, presented later in this reading

Example 2
^^^^^^^^^

You can modify the insertion of 'Betty' to be similar to 'Wilma'.

.. note::
 
  Now we will use the command SQL DROP TABLE, which allows to delete a whole table.

.. code-block:: sql

  DROP TABLE Student_new;
  CREATE TABLE Student_new(sID serial, sName VARCHAR(20), 
  Average INTEGER,  PRIMARY kEY(sID));
  INSERT INTO Student_new (sName, Average) VALUES ('Betty', 78);
  INSERT INTO Student_new (sName, Average) VALUES ('Wilma', 81);


As it has been modified the query 'Betty', we can use the own counter of the serial attribute, 
so there are no conflicts.

If you select the entire table information:

.. code-block:: sql

  SELECT * FROM Student_new;

the output is::

   sid | sname  | average
   ----+--------+---------
    1  | Betty  |  78
    2  | Wilma  |  81



UPDATE
~~~~~~
It is possible to modify or update data by using the UPDATE command whose syntax is:

.. code-block:: sql

  UPDATE table SET Attr = Expression  WHERE Condition;

In other words, it is updated of the table the attribute *Attr* (the previous value 
for the “expression” value”), under a certain “condition”.

.. note::

   It is important to highlight that the condition can change, as it can be of a extremely complex character, 
   a sub-query, a sentence which involves other tables. “Expression” also can be a value which involves 
   other tables, no necessarily corresponds to a value of a direct comparison. You can apply the same for 
   the condition.

It is necessary to highlight that even though you can update an attribute, you can also update several
at the same time:

.. code-block:: sql

  UPDATE table
  SET Attr1 = Expression1, Attr2 = Expression2,..., AttrN = ExpressionN
  WHERE Condition;


Example 3
^^^^^^^^^^

Under the context of Example 2, suppose that the grade of 'Wilma' corresponds to 91 instead of 81. You want 
to correct the typo through the UPDATE command. We must remember that depending on the number of attributes 
of the table, it is possible in many ways to update:

.. code-block:: sql

   UPDATE Student_new
   SET Average = 91
   WHERE sName = 'Wilma';

or:

.. code-block:: sql

   UPDATE Student_new
   SET Average = 91
   WHERE Average = 81;

Both cases are not wrong because they perform the requested change. However, *you must make a habit of working 
with attributes that are unique, that is the primary key* (in this case the attribute *SID*). The reason is that 
in case of having more than one 'Wilma', the average of the two would be changed. The same would apply in the event 
that several people have an average equal to 81. Therefore the ideally query corresponds to:

.. code-block:: sql

   UPDATE Student_new
   SET Average = 91
   WHERE sID = 2;


Checking through the execution of a select:
 
.. code-block:: sql

  SELECT * FROM Student_new;

the output is::

   sid | sname  | average
   ----+--------+---------
    1  | Betty  |  78
    2  | Wilma  |  91

That is, it was successfully upgraded the grade of 'Wilma'.


DELETE
~~~~~~

You can delete rows of information, that meet a certain condition. This is especially useful 
in cases where you want to delete specific rows instead of having to delete the entire table.

The syntax of the command DELETE is:

.. code-block:: sql

  DELETE FROM table WHERE Condition;

This mean that of the table it is delete the values which meet the “condition.”

.. note::

   It is noteworthy that the condition may vary; it can be of an extremely complex character, 
   a sub-query, a sentence involving other tables.


Example 4
^^^^^^^^^

If we place temporarily at the end of Example 1, with the error::

  ERROR: duplicate key value violates unique constraint "student2_pkey"
  DETAIL: Key(sid)=(1) already exists.

When you want to insert a 'Wilma', you can delete the row for 'Betty' and insert both back as was done 
in Example 2, without the need to remove the table, create it and add it all over again:

.. code-block:: sql

  DELETE FROM Student_new WHERE sID = 1;

if we check:

.. code-block:: sql

  SELECT * FROM Student_new;

the output is::

   sid | sname  | average
   ----+--------+---------


Which allows to eliminate the row for 'Betty' and leave the table empty. Subsequently it is possible 
to fill it again by using the last two queries of Example 2, that is:

.. code-block:: sql

  INSERT INTO Student_new (sName, Average) VALUES ('Betty', 78);
  INSERT INTO Student_new (sName, Average) VALUES ('Wilma', 81);

and checking:

.. code-block:: sql

  SELECT * FROM Student_new;

the output is::

   sid | sname  | average
   ----+--------+---------
    1  | Betty  |  78
    2  | Wilma  |  81



Example 5
^^^^^^^^^

Suppose that 'Wilma' gets upset by the typo and want to leave the application process. That is why she 
must be eliminated from the new template of students:

.. code-block:: sql

  DELETE FROM Student_new WHERE sID = 2;

RECAP
~~~~~

Below it is an example expose, involving the use of all commands learned in this lecture.

Extra example
^^^^^^^^^^^^^

Considering Example 5, suppose that 'Betty' moves to the stage of applications and decides to do it in 
two universities. Apply to Science and Engineering at Stanford and Natural History in Berkeley. She is 
accepted in all the places she has postulated. **Apply** table as well as table **Student** had already been 
sent without the possibility of editing data. That is why **Apply_new** table is created with the same 
characteristics as **Apply**:

.. code-block:: sql

   CREATE TABLE   Apply_new(sID INTEGER, cName VARCHAR(20), major VARCHAR(30),
   decision BOOLEAN,   PRIMARY kEY(sID, cName, major));


  INSERT INTO Apply_new (sID, cName, major, decision) VALUES (1, 'Stanford',
  'science'        , True);
  INSERT INTO Apply_new (sID, cName, major, decision) VALUES (1, 'Stanford',
  'engineering'    , True);
  INSERT INTO Apply_new (sID, cName, major, decision) VALUES (1, 'Berkeley',
  'natural history'    , True);


checking the output:

.. code-block:: sql

  SELECT * FROM Apply_new;

the output is::
  
  sid |   cname   |     major        | decision
  ----+-----------+------------------+---------
   1  | Stanford  | science          |  t 
   1  | Stanford  | engineering      |  t
   1  | Stanford  | natural history  |  t

 
Suppose now that there was an error in the management of papers with respect to engineering application: 
Basically 'Betty' was not accepted in this major therefore must be modified:

.. code-block:: sql

  UPDATE Apply SET decision = false
  WHERE sid = 1 and cname = 'Stanford' and major = 'engineering';

which results in the change of the table::
  
  sid |   cname   |     major        | decision
  ----+-----------+------------------+---------
   1  | Stanford  | science          |  t 
   1  | Stanford  | natural history  |  t
   1  | Stanford  | engineering      |  f



Suppose now that 'Betty', thankfully, is a distracted person and because of her great desire to get 
into science is not aware of the error. The responsible for the error, for fear of putting his 
reputation at stake, decides to eliminate the registration of the application, on what he considers 
a master plan since **Apply_new** table does not have a serial counter that would cause any conflict.

.. code-block:: sql

 DELETE FROM Apply
 WHERE sid = 1 and cname = 'Stanford' and major = 'engineering';

Which result in the change of the table::
  
  sid |   cname   |     major        | decision
  ----+-----------+------------------+---------
   1  | Stanford  | science          |  t 
   1  | Stanford  | natural history  |  t

and the impunity of the responsible.

