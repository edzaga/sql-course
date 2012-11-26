Lecture 7 - Basic SELECT Statement
-----------------------------------
.. role:: sql(code)
   :language: sql
   :class: highlight

It corresponds to the simplest form of doing a query in SQL, which is used to ask for those tuples of a relation that 
satisfies a condition. It is analogous to the selection in relational algebra. This query, like most of those carried 
out in this programming language, use 3 keywords: :sql:`SELECT` - :sql:`FROM` - :sql:`WHERE`.

In simple words, what is sought with this query is to select certain information (:sql:`SELECT`) of any table (:sql:`FROM`)
that satisfies (:sql:`WHERE`) certain conditions: For example:

.. code-block:: sql

   Get the names of the students that were born in the month of November 
   SELECT "the names" FROM "students" WHERE "that were born in the month of November"c

Note that in this example, it is inferred the existence of a table named “students” which holds personal data of certain students. 

From the Relational Algebra
~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. index:: From the Relational Algebra

The operator of selection in Relational Algebra make used of the keyword :sql:`WHERE`. Generally, these expressions that
follow this keyword include conditional expressions. We can build expressions by comparing the values (such as data 
integer data types, strings of characters, etc) using the 6 operators most common of comparison:

  * ``=``   “equal to”
  * ``<>``  “different to” or “not equal”
  * ``<``   “less than”
  * ``>``   “greater than”
  * ``<=``  "less than or equal to”
  * ``>=``  “greater than or equal to”

These operators have the same meaning as in C language, and the only difference is the symbol “<>” which corresponds 
to “different to”; the C language uses the symbol “!=” for this comparison. Following the comparison between these
languages, the symbol of equality in SQL correspond to “=”, while in C is “==.”

These values can be compared including constants and attributes of the relations named after the keyword :sql:`FROM`. 
In the example, would correspond to the attribute of the individual’s birth month with the month of November. 

Some examples of comparison:


.. code-block:: sql

	StudioName = 'Ubisoft' : it is compare that the attribute studioName is 'Ubisoft'
	mesesVidaUtil <> 5 : it is compared that the attribute monthsServiceLife is not equal to 5
	monthBirth = 'November':  it is compared that the attribute monthBirth is equal to 'November'

        
SELECT-FROM-WHERE
~~~~~~~~~~~~~~~~~

.. index:: SELECT-FROM-WHERE

Work under the following example which involves selecting all the information of the **Employees** 
relation (or table) whose department attributes is 'Computer' and that its *year_entry* attribute
is greater than or equal to 2005.

To start making this example, first we should create the **Employees** table as follows.

.. code-block:: sql

 postgres=# CREATE TABLE Employees(id_employee serial, name_employee VARCHAR(30),  department VARCHAR(30), year_entry INTEGER);

returning the following PostgreSQL::

 NOTICE:  CREATE TABLE will create an implicit sequence «employees_id_employee_seq» for the serial column «employees.id_employee»
 CREATE TABLE

Now we insert some data in the **Employees** table.

.. code-block:: sql

 postgres=# INSERT INTO Employees(name_employee, department, year_entry) VALUES('Edgar', 'Administration', 2000);
 INSERT 0 1
 postgres=# INSERT INTO Employees(name_employee, department, year_entry) VALUES('Andrew', 'Commercial', 2009);
 INSERT 0 1
 postgres=# INSERT INTO Employees(name_employee, department, year_entry) VALUES('Valerie', 'Informatics', 2000);
 INSERT 0 1
 postgres=# INSERT INTO Employees(name_employee, department, year_entry) VALUES('Karl', 'Informatics', 2008);
 INSERT 0 1
 postgres=# INSERT INTO Employees(name_employee, department, year_entry) VALUES('Kevin', 'Finances', 2010);
 INSERT 0 1

Finally we can make the query of interest.

.. code-block:: sql

 postgres=# SELECT * FROM Employees WHERE department='Informatics' AND year_entry>=2005;
  id_employee |  name_employee  |  department  | year_entry 
 -------------+-----------------+--------------+-------------
            4 | Karl            | Informatics  |        2008
 (1 row)

.. note::

 The query returns the record that were meeting both conditions.

You can make the following query: find in the **Employees** table the record of person/people
who are from the 'Informatics' department or that their year of entry is greater or equal to 
the year 2005.

.. code-block:: sql

 postgres=# SELECT * FROM Employees WHERE department='Informatics' OR year_entry>=2005;
  id_employee |  name_employee  |  department  | year_entry 
 -------------+-----------------+--------------+-------------
            2 | Andrew          | Commercial   |        2009
            3 | Valerie         | Informatics  |        2000
            4 | Karl            | Informatics  |        2008
            5 | Kevin           | Finances     |        2010
 (4 rows)

.. note::

 The query carried out returns the records that meet one of two conditions or when 
 both are met at the same time.

This query exhibits the typical :sql:`SELECT` - :sql:`FROM` - :sql:`WHERE` of the majority of the SQL queries.
La palabra clave FROM entrega la relación o relaciones de donde se obtiene la información (tablas). 
En estos ejemplos, se utilizaron dos comparaciones unidas por la condición "AND" y "OR". 

The department attribute of the **Employees** table is tested for equality against the constant 
'Informatics'. This constant corresponds to a string of characters of variable length that in SQL,
as it was explained in the previous lecture, is denominated as VARCHAR (n) and at the time de entry 
of data to the tables is written between simple quotation marks.

As it was mentioned before, the query of the :sql:`SELECT` - :sql:`FROM` - :sql:`WHERE` type
search the information of one or more relations that meets with certain conditions. So far we
have only seen what happens if we compare attributes of the relations with constants. Nevertheless, 
how can you compare the stored values of attributes which are in several relations?  


The previous example could be done in other way in order to combine two relations (tables)
when we are making a query, but first we must create the **Employees** and **Department** table.

.. warning::
 Before creating the tables, we must delete the **Employees** table with an :sql:`DROP TABLE Employees`.

To make the example we must create the **Departments** table.

.. code-block:: sql

 postgres=# CREATE TABLE Departments(id_department serial, department VARCHAR(30), PRIMARY KEY(id_department));

Now we create the **Employees** table.

.. code-block:: sql

 postgres=# CREATE TABLE Employees(id_Employees serial, name_employee VARCHAR(30), id_department INTEGER, year_entry INTEGER, PRIMARY KEY(id_Employees), FOREIGN KEY(id_department) REFERENCES departments(id_department));

now we should enter the data in the **Departments** and **Employees** table.

.. code-block:: sql
 
 postgres=# INSERT INTO Departments(department) VALUES('Administration');
 INSERT 0 1
 postgres=# INSERT INTO Departments(department) VALUES('Informatics');
 INSERT 0 1
 postgres=# INSERT INTO Departments(department) VALUES('Finances');
 INSERT 0 1
 postgres=# INSERT INTO Departments(department) VALUES('Commercial');
 INSERT 0 1

 postgres=# INSERT INTO Employees(name_employee, id_department, year_entry) VALUES('Edgar', 1, 2000);
 INSERT 0 1
 postgres=# INSERT INTO Employees(name_employee, id_department, year_entry) VALUES('Andrew', 4, 2009);
 INSERT 0 1
 postgres=# INSERT INTO Employees(name_employee, id_department, year_entry) VALUES('Valerie', 2, 2000);
 INSERT 0 1
 postgres=# INSERT INTO Employees(name_employee, id_department, year_entry) VALUES('Karl', 2, 2008);
 INSERT 0 1
 postgres=# INSERT INTO Employees(name_employee, id_department, year_entry) VALUES('Kevin', 3, 2010);
 INSERT 0 1

Now we make the following query, find in the **Employees** table the record of the person/people that
are from the 'Informatics' table and that their year of entry is greater or equal to the year 2005.

.. code-block:: sql

 postgres=# SELECT * FROM Employees, departments WHERE Employees.id_department=departments.id_department AND Employees.year_entry>=2005 AND departments.department='Informatics';

  id_Employees |  name_employee  |  id_department  |  year_entry |  id_department  | department 
 --------------+-----------------+-----------------+-------------+-----------------+--------------
             4 | Karl            |               2 |        2008 |               2 | Informatics
 (1 fila)

.. note::
 Is possible give reference to an attribute of each table with the **name_table.attribute**, to do the  conditions.


Regardless of the type of query, the result of a comparison is a Boolean value, that is to say returns ``TRUE`` or ``FALSE`` values, which 
can be combined with their ``AND``, ``OR``, and ``NOT`` operators, with their respective meanings.

As a review, the logical operators mentioned are:

    * :sql:`AND`: returns TRUE as long as ALL attributes to compare are TRUE. If there is AT LEAST ONE value FALSE, it returns FALSE. 
      	Its truth table is:
      .. math::

       \begin{array}{|c|c|c|}
        \hline
        \textbf{P} & \textbf{Q} & \textbf{AND} \\
        \hline
        \text{True}       & \text{True}       &  \text{True}   \\
        \text{True}       & \text{False}      &  \text{False}  \\
        \text{False}      & \text{True}       &  \text{False}  \\
        \text{False}      & \text{False}      &  \text{False}  \\
        \hline
       \end{array}

    * :sql:`OR`: returns TRUE as long as AT ELAST ONE of the attributes to compare are TRUE. If ALL the values are FALSE, it returns FALSE.
      	Its truth table is:


      .. math::

       \begin{array}{|c|c|c|}
        \hline
        \textbf{P} & \textbf{Q} & \textbf{OR} \\
        \hline
        \text{True}       & \text{True}       &  \text{True}  \\
        \text{True}       & \text{False}      &  \text{True}  \\
        \text{False}      & \text{True}       &  \text{True}  \\
        \text{False}      & \text{False}      &  \text{False}  \\
        \hline
       \end{array}

    * :sql:`NOT`: returns the contrary value to the current value, that is if the value is TRUE, returns False.  
	Its truth table is:

      .. math::

       \begin{array}{|c|c|c|}
        \hline
        \textbf{P} & \textbf{NOT P} \\
        \hline
        \text{True}       & \text{False}  \\
        \text{False}      & \text{True}   \\
        \hline
       \end{array}

.. note::

 SQL is case insensitive, that is to say it does not distinguish between uppercase and lowercase letters. 
 For example, :sql:`FROM` (reserved word) is equivalent to :sql:`from`, inclusive to :sql:`From`. The names of the attributes, 
 relations, etc. are also case insensitive. The only case in which are distinguish uppercase and lowercase 
 letters is at the moment of enclosing a string between *‘ ‘*. For example :sql:`'WORD'`  is different to :sql:`'word'`.
                                                                 

Repeated Results
~~~~~~~~~~~~~~~~~

When you perform a :sql:`SELECT` query, there is no omission of the repeated results; this “problem” is solved by 
adding :sql:`DISTINCT` to the query. 

.. code-block:: sql

        SELECT FROM WHERE
        SELECT DISTINCT FROM WHERE

In the previous example it is also possible to delete repeated results, as there are many people working
in the same department. However if we delete the repetitions, only the existing departments will return.

First, we will show the result with a query with repetitions.


.. code-block:: sql

 postgres=# SELECT departments.department, Employees.id_department FROM Employees, departments WHERE Employees.id_department=departments.id_department;     

     department  | id_department 
 ----------------+-----------------
  Administration |               1
  Commercial     |               4
  Informatics    |               2
  Informatics    |               2
  Finances       |               3
 (5 rows)

.. note::

 According to the data that were entered in the **Employees** table, there are more tan one person in 
 the 'Informatics' department.

Now we make the query without repetitions.

.. code-block:: sql

 postgres=# SELECT DISTINCT departments.department, Employees.id_department FROM Employees, departments WHERE Employees.id_department=departments.id_department;
   department    | id_department 
 ----------------+-----------------
  Administration |               1
  Informatics    |               2
  Commercial     |               4
  Finances       |               3
 (4 rows)

.. note::

 You can notice that only returns the departments that exists.
 
SELECT-BY-ORDER
~~~~~~~~~~~~~~~

.. index:: SELECT-BY-ORDER

So far, it is possible to get data from a table using commands :sql:`SELECT` and :sql:`WHERE`. However, a lot of times are necessary 
to enumerate the result in a particular order. This could be in ascending order, descending order, or it could be based 
on numerical or text values. In such cases, we can use the keyword ORDER BY to accomplish this.

.. code-block:: sql

        SELECT "L"
        FROM "R"
        WHERE "C"
        ORDER BY "O" [ASC, DESC];

where:

  * “L” corresponds to the list of attributes that are required, generally associated to (a) column(s). 
  * “R” corresponds to the name of the relation, generally is associated to a table.  
  * “C” corresponds to the condition of the selection.  
  * “O” corresponds to how it will be ordered the list “L”.  
  * ASC corresponds to an ascending order  (corresponds to the default option)
  * DESC corresponds to a descending.

Strictly, the syntax corresponds to ORDER BY and then a list of attributes that will defined the fields to order:

.. code-block:: sql

       SELECT attribute1, attribute2 ...
       FROM Clients ORDER BY attribute_order_first, attribute_order_second...

As can be seen, with the judgment ORDER BY queries can be sorted by multiple attributes. 
In this case all the fields will be ordered in the ascending form (ASC). 

We can use the same examples that we have created previously, sorting the names 
of the employees of the **Employees** table.

.. code-block:: sql

 postgres=# SELECT * FROM Employees ORDER BY name_employee;
  id_Employees |  name_employee  |  id_department  | year_entry 
 --------------+-----------------+-----------------+-------------
             2 | Andrew          |               4 |        2009
             1 | Edgar           |               1 |        2000
             4 | Karl            |               2 |        2008
             5 | Kevin           |               3 |        2010
             3 | Valerie         |               2 |        2000
 (5 rows)

which is the same to say

.. code-block:: sql

 postgres=# SELECT * FROM Employees ORDER BY name_employee ASC;
  id_Employees |  name_employee  |  id_department  | year_entry 
 --------------+-----------------+-----------------+-------------
             2 | Andrew          |               4 |        2009
             1 | Edgar           |               1 |        2000
             4 | Karl            |               2 |        2008
             5 | Kevin           |               3 |        2010
             3 | Valerie         |               2 |        2000
 (5 rows)

and in descending form would be as follows.

.. code-block:: sql

 postgres=# SELECT * FROM Employees ORDER BY name_employee DESC;
  id_Employees | name_employee | id_department | year_entry 
 --------------+-----------------+-----------------+-------------
             3 | Valerie         |               2 |        2000
             5 | Kevin           |               3 |        2010
             4 | Karl            |               2 |        2008
             1 | Edgar           |               1 |        2000
             2 | Andrew          |               4 |        2009
 (5 rows)

Also is posible to do it with number or dates.

.. code-block:: sql

 postgres=# SELECT * FROM Employees ORDER BY year_entry DESC;
  id_Employees |  name_employee  |  id_department  | year_entry 
 --------------+-----------------+-----------------+-------------
             5 | Kevin           |               3 |        2010
             2 | Andrew          |               4 |        2009
             4 | Karl            |               2 |        2008
             1 | Edgar           |               1 |        2000
             3 | Valerie         |               2 |        2000
 (5 rows)

