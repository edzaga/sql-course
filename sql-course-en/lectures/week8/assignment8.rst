Assignment 8
============

Deadline: Wednesday, March 6, 2013 till 23:59
---------------------------------------------------------------


.. role:: sql(code)
  :language: sql
  :class: highlight


-------------------------------------
Materialized Views (25 pts)
-------------------------------------

Question 1 (25 pts.)
^^^^^^^^^^^^^^^^^^^^^

In your own words, and according to the readings:

1.   What are materialized views? In which ways are they different from the views  explained in week 7? (7 pts.)
2.   What does the*refresh matviews* command do? What happens to the materialized view if the command is not used? (8 pts.)
3.   How does the concepts of materialized view and incremental view relate? (5 pts.)
4.   Name an advantage and a disadvantage of materialized view in comparison with normal views, according to they function and what was explained in the course. Which is better for your work? Explain why (5 pts.)

------------------------------------------------
Database (DB) Maintenance (40 pts.)
------------------------------------------------

Question 1 (25 pts.)
^^^^^^^^^^^^^^^^^^^^^

In your own words, and according to the readings:

1. What is the effect of VACUUM? Why is it important? (8 pts.)
2. What is the effect REINDEX DATABASE? Explain how it works (8 pts.)
3. Why is important to use the index of a table? (5 pts.)
4. What does EXPLAIN do? (4 pts.)


Question 2 (15 pts.)
^^^^^^^^^^^^^^^^^^^^

Create a DB, a table and enter some data. Execute the operation VACUUM using the VERBOSE option on the table.
What is the output?

Erase one or more tuples and execute the operation VACUUM again on the table.
What is the output?

Analyze what is needed to make VACUUM make a change on the table (15 pts.)

**HINT:** You can use the following content to create the table and enter the data. You’re free to add more tuples:

.. code-block:: sql

 create table score (a serial, b integer);
 insert into score (b) values (1);
 insert into score (b) values (2);
 insert into score (b) values (3);
 insert into score (b) values (4);
 select * from score;

-----------------------------------------------
Database Back Up and Restore Services (35 pts.)
-----------------------------------------------

Question 1 (35 pts.)
^^^^^^^^^^^^^^^^^^^^

In your own words, and according to the readings:

1. Why is important to back up a DB¿ (8 pts.)
2. How does the command pg_dump works? Is there any requisite for its use? Which? (9 pts.)
3. Which is the main difference between backing up by *DUMP* and by files? (8 pts.)
4. Which is the difference between pg_dump and pg_dumpall? (5 pts.)
5. What is Rsync? It’s possible to say that Rsync Works in an incremental manner? Explain (5 pts.)
