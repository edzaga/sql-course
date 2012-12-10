Lecture 10 - Subqueries in FROM and SELECT
------------------------------------------
.. role:: sql(code) 
      :language: sql 
   :class: highlight 
 
 
In lecture 9, you could see how subqueries are used in the condition **C**:: 
         
 SELECT L 
 FROM R 
 WHERE C; 

In this lecture you will see how to use them in both **L** and **R**

For the examples of this subsection we will exercise with the values used in the previous lecture (lecture 9).

SELECT(SELECT)-FROM-WHERE 
~~~~~~~~~~~~~~~~~~~~~~~~~ 

It is possible use a subquery as a another column.

Example 1
^^^^^^^^^
You want to know a list a students. Suppose that the period of application has ended and you want to obtain 
a list of the students and how many times they were accepted.

.. code-block:: sql

   SELECT Sid, sName, 
   (SELECT COUNT (*) FROM apply A WHERE A.Sid = S.Sid and A.decision = 't')
   as accepted
   FROM student S
   ORDER BY accepted DE SC;

whose output is::

   Sid | sName  | accepted
   ----+--------+--------
    7  | Doris  |  4     
    5  | Doris  |  2     
    1  | Amy    |  2     
    4  | Irene  |  1     
    3  | Craig  |  1    
    8  | Tim    |  1   
    6  | Gary   |  0    
    2  | Edward |  0     

 

Example 2
^^^^^^^^^

You want to know the average of a particular student and his difference with the highest average of the group 
of students. This could be achieved by finding the highest average group, and then in another query, calculate 
the difference with the the value the average of the student in question (in this case Doris). This is possible 
to do in a single query:

.. code-block:: sql
 
  SELECT sName, average, average-(SELECT max(average) FROM student )
  as diferencia
  FROM student
  WHERE sName ='Doris';

whose output is::

  sName | average | diferencia
  ------+---------+-----------
  Doris |  45     | -25
  Doris |  70     |   0


To distinguish both Doris, you can add the attribute *sID* to the query:

.. code-block:: sql
 
  SELECT Sid, sName, average, average-(SELECT max(average) FROM student )
  as diferencia
  FROM student
  WHERE sName ='Doris';

in which case the output will be::

  slid | sname | average | diferencia
  ----+-------+---------+-----------
   5  | Doris |  45     | -25
   7  | Doris |  70     |   0

so that, effectively distinguishes which person is the one with the average 45 and the one with 70.

.. note::   
 
  This example use SQL function: MAX (attribute), which returns the greatest 
  value in a column. If it is applied to a column of type string, the method 
  of comparison corresponds to the ASCII value of the first letter. Moreover MIN 
  function (attribute), returns the smallest value in a column.

We must be careful when we return only one value when making a subquery within a SELECT. Otherwise it will 
return an error, as discussed in Example 3.

Example 3
^^^^^^^^^

Suppose you work under the context of Example 2, but without using the MAX function, which returns only one value:

.. code-block:: sql
 
  SELECT sname, average, average-(SELECT average FROM student )
  as difference
  FROM student
  WHERE sname ='Doris';

In which case the output will correspond to the following error::
  
   ERROR: more than one row returned by a subquery used as an expression.

Example 4
^^^^^^^^^
Suppose you want to know the name of each student, their average, and their difference from the lowest average of the course:

.. code-block:: sql
 
  SELECT sname, average, average-(SELECT min(average) FROM student ) as diferencia
  FROM student;

in which case the output will be::
  
   sname  | average | diferencia
   -------+---------+-----------
   Amy    |  60     |  15
   Edward |  65     |  20 
   Craig  |  50     |   5
   Irene  |  49     |   4
   Doris  |  45     |   0
   Gary   |  53     |   8
   Doris  |  70     |  25
   Tim    |  60     |  15
  

 
SELECT-FROM(SELECT)-WHERE 
~~~~~~~~~~~~~~~~~~~~~~~~~ 
Another use that you can give to subqueries is in the reserved word FROM. In the FROM of the query, it is possible to use 
a subquery. Anyway, it is necessary to add an alias since the result of the subquery does not have an established name. 
If you don’t do it, the follow error will appear::
 
 ERROR: subquery in FROM must have an alias
 HINT: For example, FROM (SELECT ...) [AS] foo.

As already mentioned, the FROM clause is used to list all the tables and relationships that you will use to get some data. 
So, this subquery seeks make “another table” where you will find some data.


Example 5
^^^^^^^^^

To show how it works a subquery inside the FROM clause, suppose that you want to know the *sid* and sname of each 
student inside the **student** relationship.

.. code-block:: sql

 SELECT sid, sname FROM student;

whose output is::
 
 sid | sname  
 ----+--------
  1  | Amy    
  2  | Edward 
  3  | Craig 
  4  | Irene
  5  | Doris
  6  | Gary 
  7  | Doris
  8  | Tim   




that is equivalent to this query:

.. code-block:: sql

 SELECT sid, sname FROM (SELECT * FROM student) as example;

whose output is::
 
 sid | sname  
 ----+--------
  1  | Amy    
  2  | Edward 
  3  | Craig 
  4  | Irene
  5  | Doris
  6  | Gary 
  7  | Doris
  8  | Tim   

They are equivalent, because the alias “example” has all the data of **student**.

SUMMING UP
~~~~~~~~~~
 
Subqueries are used when the query is too complex to perform. As it was mentioned in the previous reading, 
you can perform tasks of insertion, updating and deleting data in subqueries.

Extra example
^^^^^^^^^^^^^

.. note::
  
  Next we will provide examples of subqueries in updating and deleting data. 
  Its syntax and properties are explained  in reading 14 (week 4). Now we are 
  exposing them to make clear which subqueries can be used in any of the 
  four basic operations.


Let's consider that you want to know the name and grades of the student with the lowest average, in addition to its difference 
with the best average. ..of the student table, the student with the lowest average.
 

.. code-block:: sql
  
   SELECT sname, average, average- (SELECT max(average) FROM student) as diferencia  
   FROM student 
   WHERE average = (SELECT min(average) FROM student ); 

whose output is::
  
  sname  | average | diferencia
  -------+---------+-----------
  Doris  |  45     | -25
  
Suppose that the case of a student who has the lowest average, Doris, corresponds to a payroll error. 
They decide to update the average using subqueries (considering it is the only student with the lowest average):

.. code-block:: sql

  UPDATE student SET average = 100
  WHERE average = (SELECT min(average) FROM student);

in which case, and after making a :sql:´SELECT * FROM student´, the output is::
 
   sid | sname  | average  
   ----+--------+---------
    1  | Amy    |  60
    2  | Edward |  65    
    3  | Craig  |  50  
    4  | Irene  |  49
    6  | Gary   |  53
    7  | Doris  |  70   
    8  | Tim    |  60 
    5  | Doris  |  100    


However, it was discovered that Doris id = 5 was cheating. She managed to remotely enter without permission to the data server 
where there were the forms of grades, and proceeded to alter those that contributed to her average. As punishment, it was 
decided to remove her from the application process. The person in charge removed her by using subqueries, considering that 
Doris was the only student with average 100, which corresponds to the best grade:

.. code-block:: sql

  DELETE FROM student where average = (SELECT max(average) FROM student);

Whose output after making the rigor SELECT is::

   sid | sname  | average  
   ----+--------+---------
    1  | Amy    |  60
    2  | Edward |  65    
    3  | Craig  |  50  
    4  | Irene  |  49
    6  | Gary   |  53
    7  | Doris  |  70   
    8  | Tim    |  60 


