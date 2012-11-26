Lecture 8 - Table variables and set operators
------------------------------------------------
.. role:: sql(code)
   :language: sql
   :class: highlight

Table Variables
~~~~~~~~~~~~~~~

.. index:: Table Variables

Consider the following tables::

        College (cName, state, enrollment)
        Student (sID, sName, Average)
        Apply (sID, cName, major, decision)

which represent a simple system of application of students to Universities, and are created through:

.. code-block:: sql

 CREATE TABLE College(id serial, cName VARCHAR(20), state VARCHAR(30), enrollment INTEGER, PRIMARY KEY(id));
 CREATE TABLE Student(sID serial, sName VARCHAR(20), Average INTEGER, PRIMARY kEY(sID));
 CREATE TABLE Apply(sID INTEGER, cName VARCHAR(20), major VARCHAR(30), decision BOOLEAN, PRIMARY kEY(sID, cName, major));

We will use 4 Universities:

.. code-block:: sql
        
 INSERT INTO College (cName, state, enrollment) VALUES ('Stanford','CA',15000);
 INSERT INTO College (cName, state, enrollment) VALUES ('Berkeley','CA',36000);
 INSERT INTO College (cName, state, enrollment) VALUES ('MIT','MA',10000);
 INSERT INTO College (cName, state, enrollment) VALUES ('Harvard','CM',23000);

4 students: 

.. code-block:: sql
        
 INSERT INTO Student (sName, Average) Values ('Amy', 60);
 INSERT INTO Student (sName, Average) Values ('Edward', 65);
 INSERT INTO Student (sName, Average) Values ('Craig', 50);
 INSERT INTO Student (sName, Average) Values ('Irene', 49);

And 6 applications:

.. code-block:: sql

 INSERT INTO Apply (sID, cName, major, decision) VALUES (1, 'Stanford', 'science', True);
 INSERT INTO Apply (sID, cName, major, decision) VALUES (1, 'Stanford', 'engineering', False);
 INSERT INTO Apply (sID, cName, major, decision) VALUES (2, 'Berkeley', 'natural hostory', False);
 INSERT INTO Apply (sID, cName, major, decision) VALUES (3, 'MIT', 'math', True);
 INSERT INTO Apply (sID, cName, major, decision) VALUES (3, 'Harvard', 'science', False);
 INSERT INTO Apply (sID, cName, major, decision) VALUES (4, 'Stanford', 'marine biology', True);


Example 1
^^^^^^^^^

This example looks for information of the name and ID of the students who applicate for one or more 
Universities with a determinate average:

.. code-block:: sql

  SELECT Student.sID, sName, Apply.cName, Average FROM Student, Apply WHERE Apply.sID = Student.sID;
  
whose output is::

  sid |  sname  |  cname   | Average
  ----+---------+----------+-----
   1  | Amy     | Stanford |  60
   1  | Amy     | Stanford |  60
   2  | Edward  | Berkeley |  65
   3  | Craig   | MIT      |  50
   3  | Craig   | Harvard  |  50
   4  | Irene   | Stanford |  49

.. note::

   There is a supposed duplicate in the first rows. This is because Amy applicate to 'Science'
   and 'Engineer' in Standford University. This can be avoided using :sql:`SELECT DISTINCT` 
   instead of :sql:`SELECT`.

Also you can do it as:

.. code-block:: sql

 SELECT S.sID, sName, A.cName, Average FROM Student S, Apply A WHERE A.sID = S.sID;

whose output is::

   sid |  sname |  cname   | Average
   ----+--------+----------+---------
   1   | Amy    | Stanford |  60
   1   | Amy    | Stanford |  60
   2   | Edward | Berkeley |  65
   3   | Craig  | MIT      |  50
   3   | Craig  | Harvard  |  50
   4   | Irene  | Stanford |  49

.. note::

   As in the previous query, it is possible to avoid the duplicated value using :sql:`SELECT DISTINCT` instead of :sql:`SELECT`.

As shown, you can assign variables to the relations "R" and use these variables in both "L" list and condition "C". The reader may 
wonder what is the usefulness of this, beyond writing less (depending on the name of the variable used); and the answer corresponds 
to the cases in which they must compare multiple instances of the same relation, just like you will see in example 2.

Example 2
^^^^^^^^^

Be careful with duplicates!

If the reader looks at the situation described, names of some attributes of different relations and/or tables are repeated, 
which could raise the question: to what table refers the attribute itself? To solve this problem, it precedes the name of 
the attribute with the name of the table and a dot, that is::

  "TableName.attribute"

Specifically in the previous example, the clash of names are by sID of the Student table and sID of Apply table. 
The difference is performed by:

.. code-block:: sql

        Student.sID o S.sID
        Apply.sID o  A.sID

For the embodiment of this example, assume that to the last time you received papers from one more applicant. 
So the administrator of the databases will have to add the necessary information, that is:


.. code-block:: sql

 INSERT INTO Student (sName, Average) Values ('Tim', 60);


In varied occasions, names of attributes are repeated, since we make comparisons in two instances of a table. 
In the following example, we search all the pairs of students with the same Average:

.. code-block:: sql

        SELECT S1.sID, S1.sName, S1.Average, S2.sID, S2.sName, S2.Average
        FROM Student S1, Student S2
        WHERE S1.Average = S2.Average;

At the time to make this query (two instances of a table), the result will have one or several duplicate; for example, 
let’s consider 5 students::


   sid | sname    | Average
   ----+----------+--------- 
   1   | Amy      |  60
   2   | Edward   |  65
   3   | Craig    |  50
   4   | Irene    |  49
   5   | Tim      |  60

.. note::
   The table above was obtained making the query :sql:`SELECT * FROM Student` ;    

The pair of students will be::

         Amy    -       Tim

but the output shows::

        sid | sname  | Average | sid | sname  | Average
        ----+--------+---------+-----+--------+--------
        1   | Amy    |    60   |   5 | Tim    | 60
        1   | Amy    |    60   |   1 | Amy    | 60
        2   | Edward |    65   |   2 | Edward | 65
        3   | Craig  |    50   |   3 | Craig  | 50
        4   | Irene  |    49   |   4 | Irene  | 49
        5   | Tim    |    60   |   5 | Tim    | 60
        5   | Tim    |    60   |   5 | Amy    | 60


which can be avoid modifying the query

.. code-block:: sql

        SELECT S1.sID, S1.sName, S1.Average, S2.sID, S2.sName, S2.Average
        FROM Student S1, Student S2
        WHERE S1.Average = S2.Average and S1.sID <> S2.sID;
That is, the id of the student S1 will be different to the id of the student S2; whose case, the output of the query is::

        sid | sname  | Average | sid | sname  | Average
        ----+--------+---------+-----+--------+-----
        1   | Amy    |  60     |   5 | Tim    | 60
        5   | Tim    |  60     |   1 | Amy    | 60
    

Set Operators
~~~~~~~~~~~~~~~

.. index:: Set Operators

Set operators are three:

  * Union
  * Intersection
  * Exception


The following will explain each one with an example:


Union
^^^^^^

The operator :sql:`UNION` allows combining the result of two or more :sql:`SELECT` statements. It is necessary that these have the same
number of columns, and furthermore, that they have the same data types. For example, we have the following tables:

.. code-block:: sql

     Employees_Norway:
        E_ID    E_Name
        1      Hansen, Ola
        2      Svendson, Tove
        3      Svendson, Stephen
        4      Pettersen, Kari

        Employees_USA:
        E_ID    E_Name
        1      Turner, Sally
        2      Kent, Clark
        3      Svendson, Stephen
        4      Scott, Stephen

Which can be created by the :sql:`CREATE TABLE` command:

.. code-block:: sql

    CREATE TABLE Employees_Norway (E_ID serial, E_Name varchar(50), PRIMARY KEY(E_ID));

    CREATE TABLE Employees_USA ( E_ID serial, E_Name varchar(50), PRIMARY KEY(E_ID));


And fill in with the data shown next:

.. code-block:: sql

        INSERT INTO Employees_Norway (E_Name)
        VALUES
        ('Hansen, Ola'),
        ('Svendson, Tove'),
        ('Svendson, Stephen'),
        ('Pettersen, Kari');

        INSERT INTO Employees_USA (E_Name)
        VALUES
        ('Turner, Sally'),
        ('Kent, Clark'),
        ('Svendson, Stephen'),
        ('Scott, Stephen');

The result of the following query that includes the operator :sql:`UNION`:

.. code-block:: sql

        SELECT E_Name FROM Employees_Norway
        UNION
        SELECT E_Name FROM Employees_USA;


is:

.. code-block:: sql

        e_name
      --------------
        Turner, Sally
        Svendson, Tove
        Svendson, Stephen
        Pettersen, Kari
        Hansen, Ola
        Kent, Clark
        Scott, Stephen


Pay attention! We have to take into account that there is in both tables an employee with the same name "Svendson, Stephen".
However, in the output we only name one. If you want them to appear use :sql:`UNION ALL`:

.. code-block:: sql

        SELECT E_Name as name FROM Employees_Norway
        UNION ALL
        SELECT E_Name as name FROM Employees_USA;

Using :sql:`as` it is possible to change the name of the column where the result will be:

.. code-block:: sql

        name
      ---------------
        Hansen, Ola
        Svendson, Tove
        Svendson, Stephen
        Pettersen, Kari
        Turner, Sally
        Kent, Clark
        Svendson, Stephen
        Scott, Stephen

It is seen that the output contains names of the duplicated employees: 

.. note::
   In the previous example, it is used "as name" in both :sql:`SELECT` . As a curiousity, if you use different names next to :sql:`as`,
   for example "as name1" and "as name2", remains as name of the :sql:`UNION` table the first to be declared.   

Intersection
^^^^^^^^^^^^^

Similar to :sql:`UNION` operator, :sql:`INTERSECT` also operates with two SELECT statements. The difference is that :sql:`UNION` acts as an OR, while INTERSECT as a AND. 

.. note::
   You can find the truth tables of these OR and AND in lecture 7.

This means that INTERSECT returns the repeated values.

Using the example of the employees, and making the query:

.. code-block:: sql

        SELECT E_Name as name FROM Employees_Norway
        INTERSECT
        SELECT E_Name as name FROM Employees_USA;


whose output is::

        e_name
        ----------
        Svendson, Stephen

Exception
^^^^^^^^^^

Similar to previous operators, its structure is componed by two or more SELECT statements, and the EXCEPT operator. It is equivalent to the difference in relational algebra.

Using the same tables of the employees, and performing the following query:

.. code-block:: sql

        SELECT E_Name as name FROM Employees_Norway
        EXCEPT
        SELECT E_Name as name FROM Employees_USA;

Its output is::

        e-name
        -----------
        Pettersen, Kari
        Svedson, Tove
        Hansen, Ola

That is, it returns the no repeated results in the same tables.

Attention! Unlike previous operators, the output of EXCEPT is not commutative as we execute the query in the inverse way, that is:

.. code-block:: sql

        SELECT E_Name as name FROM Employees_USA
        EXCEPT
        SELECT E_Name as name FROM Employees_Norway;

Its output will be:

.. code-block:: sql

   e-name
   ------------
   Turner, Sally
   Kent, Clark
   Scott, Stephen
