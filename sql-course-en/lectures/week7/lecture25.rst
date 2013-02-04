Lecture 25 - Transactions: Introduction
-----------------------------------------

.. role:: sql(code)
            :language: sql
         :class: highlight

  
In this reading, we will present the concepts of transactions and actions as interactions with the database system.
The concept of transaction is identified by two very different meanings. The first relates to **concurrent access** 
by multiple clients to the database, while the other has relation with having a system resistant to system failures.

We’ll first see how the database system structure works and it’s interactions with the clients.
In the following image we can observe how the data is stored in the disk, who communicates with the database management 
system (DBMS), which controls the interaction with the data. Often we can find other applications over the DBMS, such 
as a web server or a applications server, that themselves interact with the users by means of commands like selection, 
update, table creation, delete commands, etc.. It’s here where the problem happens, the simultaneous interaction with 
multiple users.
 
.. image:: ../../../sql-course/src/lectura25/imagen1_semana7.png                             
  :align: center
 

Transaction integrity
~~~~~~~~~~~~~~~~~~~~~~

* A transaction is a set of instruction or commands that are executed together over a database. They cannot be separated
* The DBMS must maintain the integrity of the data. To this end, the DBMS ensures that no transaction end in an intermediate state.
* If by any reason a transaction must be canceled, the DBMS starts undoing the orders executed till the database gets back to 
initial state (called integrity point), as if the order was never executed.

We will now see examples of some difficulties that may occur when multiple clients are interacting with a database.

Attribute level inconsistencies
====================================

.. code-block:: sql

 UPDATE College SET enrollment = enrollment + 500 WHERE cName = 'UTFSM';

At the same time as

.. code-block:: sql

 UPDATE College SET enrollment = enrollment + 1000 WHERE cName = 'UTFSM';

In the example we can observe 2 clients, the first is issuing a command that raises the enrolment in *UTFSM* by 500 at the same time 
the second client is raising the enrolment by 1000. The problem that is generated in this case is that the second clients is modifying 
the value of enrolment over the modification the first client made. So the enrolment was modified two times in the database.
Lets suppose the initial enrolment value was at 3000, and then both commands are executed. Now the enrolment is 500+1000+3000 = 4500.

Tuple level Inconsistencies
================================
.. code-block:: sql

 UPDATE Apply SET major = 'history' WHERE sID = 1;

At the same time as

.. code-block:: sql

 UPDATE Apply SET decision = 'Y' WHERE sID = 1;

In this example we have 2 clients who are modifying a tuple (or row) *sID = 1*; the first one changes the specialty to *history* and the 
second one changed a the value of a decision to *Y*. It’s possible both modification can be seen in the database, but there is a chance 
only one of them appears.

Table level inconsistency
=================================

.. code-block:: sql

 UPDATE Apply SET decision = 'Y' WHERE sID IN (SELECT sID FROM Student WHERE GPA > 3.9);

At the same time as

.. code-block:: sql

 UPDATE Student SET GPA = (1.1) * GPA WHERE sizeHS > 2500;

We have the first client working in the table **Apply**, but the conditions  that are detailed in that table depend on the table **Student**. 
At the same time the second client is modifying the **Student** table.

So what happens with the **Apply** table depends if the modification happens before, after o during the modification of the **Student** table. 
Then the *GPA* are modified and then the acceptances are made, or vice versa.

Purpose of Concurrency
~~~~~~~~~~~~~~~~~~~~~~~~~~~

We have multiple clients interaction with the database at the same time, and if the command that are executed were really intercalated, 
the *update* command and even the *selection* command would usually behave inconsistently and in a unexpected manner.

The ideal is that the client be allowed to issue commands to the database and not worry about what others are doing at the same time.

Main Objective
==================

Execute secuebces of SQL instruction that appear to be working in isolation.
**Simple Solution:** Execute them in isolation.
But we want to enable concurrency every time is safe to do.
Usually to be able to get a environment to work in concurrency, the system must be a:

* Multi-processor System
* Multi-thread System

Next we’ll explain system failures.

Resistance to system failures
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Once more we have our database system with data in the disk. Lets suppose we are in the process of a massive loading of data into the database. 
Maybe a large amount of data from an external source, a set of files maybe. In that precise instant we have a system failure. This might be 
because of a software or hardware problem, or something as simple as a power failure. Because of this, only half of the data were loaded.
What happens when the system comes back online?

The database will be in a state of great inconsistency. As example, let’s say we were making a lot of changes in the data.  When something 
is updated, they are modified in memory and then sent to the disk again. So let’s suppose the system failure occurred in the middle of this 
process. This would also leave the database in an inconsistent state.

So the main objective in confronting the system failures is to tell the system that me want to guarantee the execution of everything or 
nothing from a set of instructions.  In this way, even with a system failure, the database integrity will remain the same.

Solutions for concurrencies and failures
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

A transaction is a sequence of one or more SQL operation treated as a single unit.

* Transactions appear to work isolated
* If the system fails, the changes of each transaction are complete not partial.

SQL Standard:

* A transaction starts automatically with the first SQL sentence.
* When the “commit” command is issued, the actual transaction ends and a new one starts.
* The current transaction also ends when its session period ends in the database.
* “Autocommit” each SQL sentence is executed as a transaction.

