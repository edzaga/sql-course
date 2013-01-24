Assignment 6
============

Deadline:  23:59 Wednesday 6 February 2013
------------------------------------------------------

.. role:: sql(code)
  :language: sql
  :class: highlight

-----------------------
Referential Integration
-----------------------

Question 1 (15 pts.)
^^^^^^^^^^^^^^^^^^^^^

Generate an example in which the content of this week reading is used:

* Create 3 or more tables, which must include ``PRIMARY KEY, FOREIGN KEY, CASCADE, SET NULL`` (5 pts.)
* Insert data in the tables. (2.5 pts.)
* Use UPDATE, DELETE or both.  (2.5 pts.)
* Explain a brief explanation of what you did. (5 pts.)

-----------------------
Triggers
-----------------------

Question 1 (15 pts.)
^^^^^^^^^^^^^^^^^^^^^

Create a trigger that when a **non-null** integer is inserted, recalculates the four columns “Integer +1”, “Integer +2”, “Integer Squared” and “Integer Cubed”

* Create a table named “Question1”, with the attributes ``Num``, ``Sum1``, ``Sum2``, ``Squared`` and ``Cubed`` (2.5 pts)
* Create Function “Quest1()”.  (7 pts.)
* Create Trigger “Quest1”. (3 pts.)
* Insert the Integers "2", "4", "6" y "8". (2.5 pts)

The output is:

.. code-block:: sql

	SELECT * FROM Question1;
	Num | Sum1 | Sum2 | Squared | Cubed
	----+------+------+---------+------
	 2  | 	3  |   4  |    4    |    8
	 4  | 	5  |   6  |   16    |   64
	 6  |   7  |   8  |   36    |  216
	 8  |   9  |  10  |   64    |  512
	(4 rows)

.. note::

	**Num:** Integer non-null.
	**Sum1:** Integer.
	**Sum2:** Integer.
	**Squared:** Integer.
	**Cubed:** Integer.
	**PRIMARY KEY:** Num.

	For each unfulfilled condition, one point will be discounted.

Question 2 (30 pts.)
^^^^^^^^^^^^^^^^^^^^^

Find F(x) when x=1, x=3, x=6 and x=8.
 
.. math::

	f(x) = (x ^ 4 + x ^ 3 ) * 3 + x + 2

* Create table “Question 2” with the attributes “Num” and “Result”. (5 pts.)
* Create Function “Quest1 ()”. (15 pts.)
* Create Trigger “Quest1”. (5 pts.)
* Insert integers 1,3,6 and 8 (8 pts).

The output is:

.. code-block:: sql

	SELECT * FROM Question2;
	 Num | Result
	-----+-----------
	   1 |         9
	   3 |       329
	   6 |      4544
	   8 |     13834
	(4 rows)

.. note::

	**Num:** non-null integer.
	**Result:** integer


	For each unfulfilled condition, one point will be discounted.

 
Question 3 (40 pts.)
^^^^^^^^^^^^^^^^^^^^^

Calculate the value of the tax on the salary of a worker.

* Create a table “Question 3” with attributes "ID", "name", "salary" y "duty". (5 pts)
* Create FUNCTION "Quest3()" (25 pts.)
* Create TRIGGER "Quest3". (5 pts.)
* Insert 4 data created by you. (5 pots)

Condition for the calculation of the tax:

* If salary < 2500 (5% tax)
* If salary >= 2500 and <= 3999 (6% tax)
* If salary >= 4000 and <= 3999 (8% tax)
* If salary > 8000 (10% tax)

.. note::

	**ID:** serial.
	**name:** VARCHAR.
	**salary:** INTEGER.
	**duty:** REAL.
	**PRIMARY KEY:** ID.
	For each unfulfilled condition, one point will be discounted.

	Tip: To use conditions in the Function:
	 
	IF (condition) THEN

	// Instruction;

	ELSIF (condition) THEN

	// Instruction ;

	ENDIF;

An example Output would be:

.. code-block:: sql

	SELECT * FROM Question3;
	 id | name | salary |  duty  
	----+------+--------+--------
	  1 | Brad |   2506 | 150.36
	  2 | Tom  |   4500 |    360
	(2 rows)

.. note::

	The Assignment is to be `delivered`_ in a compressed file, containing:
	* File Assigment6.doc, .docx, .txt or .pdf, which includes the answer to all the questions, 
          including the images. Be careful with the file format, as other formats will not be accepted.
	* There will be a 10 points discount for sending the assignment to the teacher’s email.
	* Anyone with problem with the delivery must write an email to the teacher with the pertinent excuse.

.. _`delivered`: https://csrg.inf.utfsm.cl/claroline/



