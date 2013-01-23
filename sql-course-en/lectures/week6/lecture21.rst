Lecture 21 - Constraints and triggers: Introduction
-----------------------------------------------------

.. role:: sql(code)
     	:language: sql
     	:class: highlight

Both are oriented to Relational Databases or better known by the abbreviation RDB. Even 
though SQL does not count with them, in the diverse implementations of the language this 
“error” has been corrected. Unfortunately, it does not count with a standard, so there 
is a huge amount of variations. 

Restrictions, which are also called restrictions of integrity, help us to define allowed 
states within Databases (DB).

On the contrary, the :sql:`triggers` monitors the changes in the DB, checks conditions, 
and start actions automatically. Therefore, they are considered of dynamic nature in 
contrast with the restrictions of integrity which are of static nature. 

Both will be analyzed in detail in the next lectures.

==============
Restrictions
==============

They impose restrictions of allowed data, beyond those imposed by structure and the type of data in the DB.

Suppose that we are under the context of a system for selecting students, which has been seen in previous lectures:


Example 1
^^^^^^^^^

For the student can be accepted, his/her average must be greater than 50::

  Average > 50


Example 2
^^^^^^^^^

The institution X cannot have more than 45000 students::

  Enrollment < 45000

Example 3
^^^^^^^^^

The criteria for the decision is True, False or **NULL**::

  Decision: 'T', 'F', **NULL**


The restrictions are used for:

1. Avoid errors when you insert data (:sql:`INSERT`).
2. Avoid errors when you modify data (:sql:`UPDATE`).
3. Force the consistency of data.

There are diverse types of restrictions. These are classified in:

1. **NOT NULL**          	: Do not permit null values.
2. **Key**               	: Allow only unique values, associated to the primary key.
3. **Referential Integrity**: Associated with the foreign key and multiple tables.
4. **Based on attributes**  : Restrict the value of an attribute.
5. **Based in tuples**    : Restrict the value if a tuple. More specific that the previous one.  
6. **Generals**         	: Restricts all the DB.


Declaring and forcing restrictions  
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

You can force the check up after each *dangerous* modification, that is those which violate 
a restriction. It is not necessary modify after a change of average in the Student table, 
as it would make the system slower. 

Another form to force check ups is  after each **transaction**. This concept will be seen 
later, but it is possible to anticipate that a transaction correspond to a set of 
operations which modify, at the end, the DB.

================
:sql:`triggers`
================

The logic of :sql:`trigger` is::

  "When something happens, we check a condition.
   If it is true, we perform an action."

As it was mentioned, in contrast to the restrictions, a :sql:`trigger` detects an event, 
verifies some condition of activation, and if it is true, you perform an action.

Contextualizing in the system of admission of Students: 

Example 4
^^^^^^^^^

If the capacity of an Institution X exceeds 30000, the system should start rejecting new applicants::


	Enrollment > 30000 -> reject new applicants


Example 5
^^^^^^^^^

If a student  has an average greater than 49.5, he is accepted::

  Student with  Average > 49.5 -> Decision='True'



The :sql:`triggers` are used for:

1. **Move the logic from the application to a Database Management System (DBMS)**, which 
   allows a more modular and automatized system. 

2. **Force restrictions**. No implemented system supports all the restrictions of other, that 
   means,  there is not a current standard. One case is example 5 in which some DBMS could 
   round  down rather than up; with :sql:`trigger` this could be solved. Also there are 
   restrictions that cannot be written in a direct form, but it is possible using :sql:`trigger`. 

3. **Force restrictions using reparative logic**. An error can be detected and perform an 
   action which could be for example: if there is the restriction **0 <= Average <= 100**, 
   and someone by typing mistake inserts an average -50, a  :sql:`trigger` could change the 
   value to 0. For instance, any value which is not in the rank, can be changed to 0.

As introduction, a  :sql:`trigger` is defined as

.. code-block:: sql

 CREATE trigger name
 BEFORE|AFTER|INSTEAD OF events
 [referencing-variables]
 [FOR EACH ROW]
 WHEN (condition)
 action

This mean that each  :sql:`trigger` has a name which is activated by events (before, during, or after).
You should take certain variables and for each row you check a condition and perform an action.
