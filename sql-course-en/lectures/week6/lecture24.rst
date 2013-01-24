Lecture 24 - Constraints and triggers: Triggers intro and demo
---------------------------------------------------------------

.. role:: sql(code)
        :language: sql
        :class: highlight

Triggers
~~~~~~~~~~~~~~~~~~~~~~~~

During the execution of a database application, there are occasions in which one or more actions must be executed automatically, if a given event happens. In other words, the event triggers the actions. The denominated “Triggers” are the mechanism that allows this activation in SQL.


Definition
===========

**A triggers is an order that the system executes automatically**, as a side effect of a modification to the database. Then the triggers follow the sequence        ``Event->Condition->Action``. They are executed with the commands :sql:`INSERT`, :sql:`DELETE` and :sql:`UPDATE`.

For the design of a trigger, some requisites must be meet:

1. **A stored Procedure:** A database with all its relationships must be created before the trigger definition.
2. **Specify conditions for the trigger activation:** A condition that must be fulfilled must be defined, as well as an event that provokes the check on the condition.
3. **Specify the action specify the actions to be executed:** it must be defined what actions are to be executed when the trigger activates.
 
The database stores the triggers as if they were normal data, so they are persistent and accessible for all the operations of the database. Once a trigger is stored, the system of the database assumes responsibility for executing it each time the specified event happens and the condition is met.
 
Some applications of Triggers
================================  
Triggers are very useful in a variety of situations. An example is the registry function. Some critical actions in the database, such as insert, edit, or delete a row could trigger an action that records in a registry what was done. This registry could record also who and when made the modification.  

Triggers can also be used to maintain a consistent database. For example, if a relationship “Orders” exist, the order of a certain product can activate a trigger that changes the state in the “Inventory” table, changing it from “Available” to “Reserved”. In the same way the elimination of a row in the “Orders” table can change the status of that product back to “Available”. Triggers offer a greater flexibility that the one showed in these examples.
 
Creating a Trigger.  
=======================
1.   	A trigger is created by the command :sql:`CREATE TRIGGER`.
2.       After creation, the trigger is waiting the activation event
3.   	When the event happens, an action is triggered.
 


*General form:*

.. code-block:: sql

  	(1)CREATE TRIGGER triggerName
  	(2)BEFORE|AFTER|INSTEAD OF someEvent
  	    ON tableName
  	(3)WHEN (condition)
  	(3)Action

Special Variables.
^^^^^^^^^^^^^^^^^^^^
Some words are reserved, that are available to be used by the triggers. This are some of them:

* :sql:`NEW`: Variable that contains the new row of the table for the :sql:`INSERT/UPDATE` operations.

* :sql:`OLD`: Variable that contains the old row of the table for the :sql:`UPDATE/DELETE` operations.

* :sql:`TG_NAME`: Variable that contains the name of the trigger used by the current function.

* :sql:`TG_RELID`: identifier of the object in the table that activated the trigger.

* :sql:`TG_TABLE_NAME`: name of the table that activated the trigger.

Example :
^^^^^^^^^

.. note::

	The following example explains the operation of a trigger. To be tested  in postgreSQL, the database and the table “Employee” must be created. Later on a practical example will be presented, that will be possible to copy directly in the console.

The following trigger activates when the attribute “salary” changes. The intend of this trigger is to foil any attempts to lower the “salary” in the table “Employee”.

`\text{Employee}(\underline{\text{cert}},\text{name, address, salary})`

.. code-block:: sql

        	(1) CREATE TRIGGER salaryTrigger
        	(2) AFTER UPDATE OF salary ON Employee
        	(3) REFERENCING
        	(4) OLD ROW AS OldTuple,
        	(5) NEW ROW AS NewTuple
        	(6) FOR EACH ROW
        	(7) WHEN (OldTuple.salary > NewTuple.salary)
        	(8) UPDATE Employee
        	(9) SET salary = OldTuple.salary
        	(10) WHERE cert = NewTuple.cert ;

* **(1) The trigger is created:** with the keywords :sql:`CREATE TRIGGER` and the name *salaryTrigger*.

* **(2) Activation Event:** in this case is the modification of the *salary* attribute in the table *Employee*

* **(3) (4) and (5) Road for the condition:** the old tuple (from before the modification) has assigned to it the name “OldTuple” and the new one (from after the modification) is assigned the name “NewTuple”. In the condition and action, this name can be used as variables declared in the :sql:`FROM` clause of a SQL query SQL.

* **(6)** The command  :sql:`FOR EACH ROW`, expresses the order that this trigger must be executed for each tuple updated.

* **(7) Trigger condition:** Specifies that the action must only be executed when the new salary is lower than the old salary.

* **(8) (9) y (10) Trigger Action:** this action is a SQL update instruction with the effect of restoring the salary to what it was before the modification. It must be noted that in beginning each tuple of “Employee” is considered for the update, but the command :sql:`WHERE` in line (10) guarantees that only the modified tuple is affected (with the correct *cert*).


Function
==========

There is a way to separate the action and conditions of a trigger. This is by the use of functions. One of the motives to use function is to maintain the logic away from the application, achieving consistency between application and a reduction in duplicated functionality.  Also is a way to make a predefined access to restricted elements.

SQL is a declarative language, but in occasions other types of languages are needed. The handling of different languages allows to use different types of languages, accordingly to each case.  For the effects of this course, a imperative language **PL/pgSQL** (Procedural Language/PostgreSQL Structured Query Language) will be used.

.. note::

	A **imperative language** orders the computer how to execute a series of steps or instructions. The execution of these commands is in most of the cases sequential, or in other words, till the first command isn’t executed, the next one will not be read. There are also controlled loops that repeat themselves till some event happens.

**PL/pgSQL** has structures both repetitive and conditional. Is possible to accomplish complex calculations and create new type of  user data. In **PL/pgSQL** functions can be made. In this section we will See how this function can be executed in the triggers.

Practical Example 1:
^^^^^^^^^^^^^^^^^^^^

Create a database and install the language **plpgsql**.

.. code-block:: sql

        	postgres=# create database trggr2;
        	CREATE DATABASE
        	postgres=# \c trggr2
        	psql (8.4.11)
        	
        	trggr2=# CREATE PROCEDURAL LANGUAGE plpgsql;
        	CREATE LANGUAGE

create relationship *numbers*

.. code-block:: sql

        	CREATE TABLE numbers(
        	 number int NOT NULL,
        	 square int,
        	 squareroot real,
        	 PRIMARY KEY (number)
        	);

Define function ``save_data()``, which will be in charge of inserting the data. At the end of the example we will explain in detail its workings.
 
.. code-block:: sql

        	CREATE OR REPLACE FUNCTION save_data() RETURNS Trigger AS $save_data$
        	 DECLARE
        	 BEGIN
        	  
        	  NEW.square := power(NEW.number,2);
        	  NEW.squareroot := sqrt(NEW.number);

        	  RETURN NEW;
        	 END;
        	$save_data$ LANGUAGE plpgsql;

PostgreSQL returns:

.. code-block:: sql

        	CREATE FUNCTION

Now a trigger that calls the function ``save_data()`` automatically each time a data is changed or updated can be defined.
 
.. code-block:: sql

        	CREATE TRIGGER save_data BEFORE INSERT OR UPDATE
        	   ON numbers FOR EACH ROW
        	   EXECUTE PROCEDURE save_data();

PostgreSQL returns:

.. code-block:: sql

        	CREATE TRIGGER

To see how the trigger works, insert the number 4, 9 and 6.

.. code-block:: sql

        	trggr2=# INSERT INTO numbers (number) VALUES (4),(9),(6);
        	INSERT 0 3

Do a select to see de stored data.
 
.. code-block:: sql

        	trggr2=#  SELECT * FROM numbers;

        	number | square | squareroot
        	--------+--------+------------
        	     4 |     16 |          2
        	     9 |     81 |          3
        	     6 |     36 |    2.44949
        	(3 rows)

They can also be updated.

.. code-block:: sql

        	trggr2=# UPDATE numbers SET number = 7 WHERE number = 6;
        	UPDATE 1
        	trggr2=# SELECT * FROM numbers;
        	number | square | squareroot
        	--------+--------+------------
        	     4 |     16 |          2
        	     9 |     81 |          3
        	     7 |     49 |    2.64575
        	(3 rows)

As you can observe, we have only inserted or updated the value of *number*, but doing so automatically filled the values for the *square* and *squareroot* attributes. This is because the Trigger was defined to be activated when performing a :sql:`INSERT` or :sql:`UPDATE`. For each of these commands, the trigger order the execution of the ``save_data()`` function once for each row involved. In other words, when we make the first :sql:`INSERT` (number = 4), the ``save_data`` trigger calls to the ``save_data()`` function one time. 

* When you start executing ``save_data()`` , the value of the variable “New” is: ``number=4, square=NULL, squareroot=NULL``. 
  The *numbers* table still is empty. 

* Next, we calculate the square and square root of 4; these values are assigned to ``NEW.square`` and``NEW.squareroot`` respectively. Now, the “New” variable contains ``number=4, square=16, squareroot=2``. 
 
  To calculate the square of a number, you should use the :sql:`power` instruction, which receives as parameters the number that will be inserted and the number to which is elevated. To calculate the square root of a number, you use the :sql:`sqrt` instruction which receives as parameter a new number.  

* With the sentence :sql:`RETURN NEW`, it returns the row :sql:`RECORD` stored in the :sql:`NEW` variable. Then the system stored :sql:`NEW` in the *numbers* table. 
 
Practical Example 2:
^^^^^^^^^^^^^^^^^^^^^

For this example we use the same **numbers** relation created previously with the values already inserted. 
The ``project_data`` function is used to protect data in a table. It will not be allowed the deletion of rows, since it returns :sql:`NULL` which as we know for previous lectures, is the inexistence of value. 

.. code-block:: sql

	 CREATE OR REPLACE FUNCTION protect_data() RETURNS Trigger AS $Tprotect$
	  DECLARE
	  BEGIN
	   RETURN NULL;
	  END;
	$Tprotect$ LANGUAGE plpgsql;


The next trigger called ``Tprotect`` is activated before doing a deletion of data in the *numbers* table. Its action is to call the ``protect_data`` function. 

.. code-block:: sql

	CREATE Trigger Tprotect BEFORE DELETE 
	    ON numbers FOR EACH ROW 
	    EXECUTE PROCEDURE protect_data();

We try to delete all the data of *numbers* table with the next sentence:

.. code-block:: sql

	trggr2=# DELETE FROM numbers;
	DELETE 0

However, it is not possible to delete data, since the trigger drives the ``protect_data`` function, and no data is eliminated. 

.. code-block:: sql

	trggr2=# SELECT * FROM numbers;
		 number | square | squareroot 
		--------+--------+------------
		      4 |     16 |          2
		      9 |     81 |          3
		      7 |     49 |    2.64575
		(3 rows)

Practical Example 3:
^^^^^^^^^^^^^^^^^^^^^

Again, we use the relation *numbers*, the *functions* and *triggers* already created. 

The function that you will see next, search to avoid errors when you calculate square root of a negative number. 
Observe what occurs when we try to insert the value -4:

.. code-block:: sql

	trggr2=# INSERT INTO numbers (number) VALUES (-4);
	ERROR:  cannot take square root of a negative number
	CONTEXT:  PL/pgSQL function "save_data" line 5 at assignment


The console throws an error in the ``save_data`` function, as it cannot calculate the square root of a negative number. 

The ``invalid_root`` function takes the sentence :sql:`IF` to validate that the number is greater than 0.
The construction :sql:`IF` is used to execute codes only if a condition is true. Such condition must be a boolean expression. Also, the sentence :sql:`IF` has the  form: **if (condition is true), then do the sentence**. So if the condition  does not fulfill the line or lines, these are skipped and there are not executed. So then we evaluate the :sql:`ELSIF` conditions successively, which are an alternative condition to :sql:`IF`. In this case, it is specified that the number must be greater or equal to 0. 

When inserting the :sql:`IF` sentence, it is execute the same action of the ``project_data`` function. In other words, it returns :sql:`NULL` and it does not make any action on *numbers*. If it is greater or equal to 0, it execute the sentence which is inside the instruction :sql:`ELSIF`. This sentence is the same as the ``save_data`` function employed, that is, to calculate the square and square root.  

.. code-block:: sql

	CREATE OR REPLACE FUNCTION invalid_root() RETURNS Trigger AS $invalid_root$
	DECLARE
	BEGIN
		IF (NEW.number < 0) THEN
			RETURN NULL;
		ELSIF (NEW.number >= 0) THEN
		   NEW.square := power(NEW.number,2);
		   NEW.squareroot := sqrt(NEW.number);
		   RETURN NEW;
		END IF;

	END;
	$invalid_root$ LANGUAGE plpgsql;

After having the function, we define the trigger which detonates the function. The ``invalid_root`` trigger is activated when we make an insertion or update of data in *numbers*.

.. code-block:: sql

	CREATE TRIGGER invalid_root BEFORE INSERT OR UPDATE
	ON numbers FOR EACH ROW
	EXECUTE PROCEDURE invalid_root();

Now we try to prove again the insertion of a negative number:

.. code-block:: sql

	trggr2=# INSERT INTO numbers (number) VALUES (-4);
	INSERT 0 0

This time it does not result in an error, since inserts :sql:`IF` which restricts negative values and it does not insert the value.

If you try to insert a positive number, you have no problems: 

.. code-block:: sql

	trggr2=# INSERT INTO numbers (number) VALUES (5);INSERT 0 1
	trggr2=# SELECT * FROM numbers;
	 number | square | squareroot 
	--------+--------+------------
	      4 |     16 |          2
	      9 |     81 |          3
	      7 |     49 |    2.64575
	      5 |     25 |    2.23607
	(4 rows)

To delete a trigger and a function, first you must delete the trigger:

.. code-block:: sql

	trggr2=# DROP Trigger invalid_root ON numbers;
	DROP Trigger

And then you can delete the function:


.. code-block:: sql

	trggr2=# DROP FUNCTION invalid_root();
	DROP FUNCTION

When you should not use triggers
=====================================

There are some cases which can be managed in a better way, using other techniques:

* **Make summaries of data:** Many current systems of databases supports the materialized views which give a more simple form to maintain **the data of summary**.

* **Backup of databases:**  Before, designers of systems used triggers with the insertion, elimination, or update of the relations to register changes. A separate process copied the changes to the backup of the database, and the system would execute the changes over the replica. However, the systems of modern databases  give characteristics incorporated for the backup of databases, making unnecessary the triggers for the replica in the majority of cases. 


The triggers should be written very carefully, since one error of a trigger detected in time of execution cause a failure in the instruction of insertion, deletion or updating which started the trigger. 
In the worst case, this could produce an infinite string of triggers. Generally, the system of databases limit the length of strings of triggers. 
