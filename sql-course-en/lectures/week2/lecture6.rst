Lecture 6 - Type of data
-------------------------

.. role:: sql(code)
   :language: sql
   :class: highlight

Description
~~~~~~~~~~~

In SQL there are several types of data. When we create a table with the instruction 
create table, we have to specify of type of data of each column. [1]_


1. **Strings of characters of fixed and variable length:** an attribute of a table of 
   type ``CHAR(n)`` denotes a fixed-length string of n characters.  That is, i fan attribute 
   is of the type ``CHAR (n)``, then in any tuple the component for this attribute will be a 
   string of n characters. ``Varchar (n)`` denotes a string of  up to n characters. 

2. **Strings of bits of fixed or variable length:** These strings are analogue to the strings
   of characters fixed and variable length, but its values are strings of bits instead of characters. 
   The type ``BIT (n)`` denotes a string of bits of n length, and BIT VARYING (n) is a string of bits 
   of variable length.

3. **Boolean data type:** ``BOOL`` denotes an attribute whose value is logical. The possible values
   for this type of attribute are TRUE, FALSE, and UNKNOWN.

4. **Integer data type:** ``INTEGER`` denotes typical integer values. The type ``SMALLINT`` also
   denotes whole numbers but the number of bits allowed may be lower.

5. **Floating data type:** We can use the type ``FLOAT`` for typical floating-point numbers.

6. **Date/Hour data type:** They can be represented by ``DATE`` and ``TIME``. These values are 
   essentially strings of characters of a special form. There is also a data type called ``TIMESTAMP``.
   The format should be shown in the following table:

.. math::

 \begin{array}{|c|l|}
  \hline
  \textbf{Type} & \textbf{Description} \\
  \hline
  \text{DATE} & \text{Date ANSI SQL "yyyy-mm-dd".} \\
  \hline
  \text{TIMESTAMP} & \text{Date y hora "yyyy-mm-dd hh:mm:ss".} \\
  \hline
  \text{TIME} & \text{Hour ANSI SQL "hh:mm:ss".} \\
  \hline
 \end{array}

Practical example
^^^^^^^^^^^^^^^^^^

Next we will show examples made with PostgreSQL, of the type of data that was named before:

* This example is the game Guess Who, where there are questions such as if your character wears
  glasses, is blond or tall, etc. The table is as follows using the Boolean values to create the tables:

  .. code-block:: sql

     postgres=# CREATE TABLE Guess_who(Character VARCHAR(30), GLASSES BOOL, BLOND BOOL, TALL BOOL);
     CREATE TABLE
     postgres=# INSERT INTO Guess_who(Character,GLASSES,BLOND,TALL) VALUES('Tomas',true,false,true);
     INSERT 0 1
     postgres=# SELECT*FROM Guess_who;

      Character | GLASSES | BLOND | TALL
     -----------+-------+-------+------
      Tomas     | t     | f     | t
     (1 row)

* Next it will be shown an example in which we use the type of data ``VARCHAR``, ``CHAR`` and ``DATETIME``.
  ``VARCHAR``, ``CHAR`` and ``DATETIME``.

  We Create the person table with the ID of type serial, name, and last name of the type ``VACHAR`` 
  with a long variable to 35 characters; genre of the type ``CHAR`` with only one character; and the 
  date of birth which is a type of data ``DATETIME``.

  .. code-block:: sql

     postgres=# CREATE TABLE person(id serial, name VARCHAR(25), lastname VARCHAR(25), genre CHAR(1), date_birth DATE);

  .. note::
	The following tests, were in a spanish version of postgres, so the terminal exit will be in spanish.

  Returning the following PostgreSQL
  ::

   NOTICE:  CREATE TABLE creará una secuencia implícita «person_id_seq» para la columna serial «person.id»
   CREATE TABLE

  Now we *insert* the data of a person:

  .. code-block:: sql

     postgres=# INSERT INTO person(name,lastname,genre,date_birth) VALUES('Paul','Anderson','M','1983-02-12');
     INSERT 0 1

 Finally, we *select* the table to see the data that it was inserted:  

  .. code-block:: sql

     postgres=# SELECT * FROM person;
      id | name   | lastname | genre  | date_birth
     ----+--------+----------+--------+------------
       1 | Paul   | Anderson | M      | 1983-02-12
     (1 row)

* Suppose that in the following example a student is recording his grades of his subjects 
  at University in a table called Grades. He inserts the name of the subject as ``VARCHAR``
  with a length of 30 characters, Grade_1 and Grade_2 of the type ``INTERGER`` and finally
  his average of grades which is of the type ``FLOAT``.

  .. code-block:: sql

     postgres=# CREATE TABLE Grades(id serial, subject VARCHAR(30), Grade_1 INTEGER, Grade_2 INTEGER, average FLOAT);

   Returning PostgreSQL
  ::

   NOTICE:  CREATE TABLE creará una secuencia implícita «Grades_id_seq» para la columna serial «Grades.id»
   CREATE TABLE

  *Inserting* data

  .. code-block:: sql

     postgres=# INSERT INTO Grades(subject,Grade_1,Grade_2,average) VALUES('Database', 57, 36, 46.5);
     INSERT 0 1

  .. warning::

   To insert a ``FLOAT`` data type, the value does not carry a “comma”, but a “dot.”

* Now it will take place the following example in which the test_datatype table will 
  be created with the data types ``BIT(n)`` and ``BIT VARYING(n)``. In this case 
  data1 will have a fixed length of 4 and data2 a variable length of 6. 

  .. code-block:: sql

     postgres=# CREATE TABLE test_datatype_bit(data1 BIT(4), data2 BIT VARYING(6));
     CREATE TABLE
 
  We will *insert*  the data in the following way:

  .. code-block:: sql

     postgres=# INSERT INTO test_datatype_bit(data1,data2) VALUES(B'1010',B'10110');
     INSERT 0 1
     postgres=# INSERT INTO test_datatype_bit(data1,data2) VALUES(B'1011',B'101101');
     INSERT 0 1

  The following inserted data returned an error since it no longer meet the fixed and variable length defined in the creation of **test_datatype_bit**.

  .. code-block:: sql

     postgres=# INSERT INTO test_datatype_bit(data1,data2) VALUES(B'101',B'10110');
     ERROR:  el largo de la cadena de bits 3 no coincide con el tipo bit(4)

     postgres=# INSERT INTO test_datatype_bit(data1,data2) VALUES(B'1011',B'1011011');
     ERROR:  la cadena de bits es demasiado larga para el tipo bit varying(6)

* In this example it will be used the type of data ``SMALLINT`` and ``TIMESTAMP``. 
  A table will be shown, in which it will leave a register of the entry of workers to the company.

  .. code-block:: sql

     postgres=# CREATE TABLE registro(id_registro serial, name VARCHAR(30), lastname VARCHAR(30), entry TIMESTAMP, years_worked SMALLINT);

  Returning the following:
  ::

   NOTICE:  CREATE TABLE creará una secuencia implícita «registro_id_registro_seq» para la columna serial «registro.id_registro»
   CREATE TABLE

  *Inserting* the data of the register as follows:

  .. code-block:: sql

     postgres=# INSERT INTO registro(name,lastname,entry,years_worked) VALUES('Elliott', 'ALLEN', '2012-10-23 14:05:08', 13);
     INSERT 0 1

  Now we make a selection of the record table to verify the data that we have inserted.   

  .. code-block:: sql

     postgres=# SELECT * FROM registro;
      id_registro |   name  | lastname |        entry        | years_worked
     -------------+---------+----------+---------------------+-----------------
                1 | Elliott | ALLEN    | 2012-10-23 14:05:08 |              13
     (1 row)

  .. note::

     The difference between INTEGER and SMALLINT cannot be noticed in this type of examples, but INTEGER supports -2147483648 to +2147483647 and SMALLINT -32768 to +32767.


References
~~~~~~~~~~
.. [1] http://www.postgresql.org/docs/8.1/static/datatype.html


