Lecture 18 - Relational Design Theory: Multivalued dependencies (4th normal form)
---------------------------------------------------------------------------------

.. role:: sql(code)
   :language: sql
   :class: highlight

Multivalued dependencies
~~~~~~~~~~~~~~~~~~~~~~~~

Introduction
============

A **multivalued dependency** is an affirmation where two attributes or sets of attributes 
are independent of each other. 
If A implies B, the **functional dependencies** prohibit the existence of two tuples with 
the same value of A and different values from B. This means A has associated a unique 
value of B. On the contrary, the **multivalued dependencies** permit that a same value of 
A can have associated different value of B. However, it requires that these are present 
in the relation of a determined form. For this reason, the functional dependencies are 
known as **dependencies of generation of equality**. And multivalued dependencies are denominated 
**dependencies of generation of tuples**.

Attribute of Independence and Redundancy
========================================

In databases, **redundancy** refers to the storage of the same data several times in 
different places. This can bring problems such as increased work, waste of space of 
storage and inconsistency of data. If a database is well design, you should not have 
redundancy in the data (excepting the redundancy of controlled data, which is used to 
improve the performance in the queries of a database).

Example
^^^^^^^

Suppose that we have information about the names of courses, teachers and texts. 
The tuple indicates that such course can be taught for any described professor and that 
it can use as a reference all the specified texts. For a given course, it can be any 
number of professors and any quantity of corresponding texts. Professors and texts are 
independent between them. Thus mean that independently of who is giving the course, the 
same texts are used.

.. code-block:: sql

	course         | professor | text
	---------------+----------+----------------------------
	Database       |  Ullman  | A First Course in Database
	Database       |  Ullman  | Database System Concepts
	Database       |  Widom   | A First Course in Database
	Database       |  Widom   | Database System Concepts
	Programming    |  Ullman  | Rapid GUI Programming
	Programming    |  Ullman  | Learning Python
	Programming    |  Ullman  | Python Algorithms

It can be seen that the example involves a fair amount of **redundancy**, which leads 
to certain anomalies of updating. For example, to add the information that the Database 
course can be taught by a new teacher, called Hetland, you need to insert two new tuples, 
one for each of the texts.

.. code-block:: sql

	course         | professor | text
	---------------+----------+----------------------------
	Database       |  Ullman  | A First Course in Database
	Database       |  Ullman  | Database System Concepts
	Database       |  Widom   | A First Course in Database
	Database       |  Widom   | Database System Concepts
	Database       |  Hetland | A First Course in Database
	Database       |  Hetland | Database System Concepts
	Programming    |  Ullman  | Rapid GUI Programming
	Programming    |  Ullman  | Learning Python
	Programming    |  Ullman  | Python Algorithms


These issues are caused by the fact that professors and texts are completely independent 
from each other.

The existence of relations Normal Form of Boyce-Codd (BCNF), "problems" as the example 
led to present the notion of multivalued dependencies.

Multivalued dependencies are a generalization of functional dependencies, in the sense 
that every functional dependency (FD) is a multivalued dependency (MVD), but the opposite 
is not true (ie, there are MVDs that are not FDs).

Formal definition
=================

Let R be a relation and A, B and C subsets of attributes of R. Then we say that B is 
multi-dependent of A, if and only if in all possible valid value of R, the set of B values 
that match with a particular pair (value A, value C) depends only on the value of A and 
is independent of the value of C.

It is easy to show that given R {A, B, C}, ``A->->B`` is valid if and only if it is also 
valid ``A->->C``. Multivalued dependencies always go in pairs, in this form. For this reason, 
it is common represent both in one only statement in this form:

``A->->B|C``

From the definition of multivalued dependency you can obtain the following rule:

If ``A->B``, then ``A->->B``.

In other words, each functional dependency is also a multivalued dependency.

Multivalued dependencies are used in two ways:

1. To verify the relationship and determine if they are legal under a given set of functional 
and multivalued dependencies. 

2. To specify constraints of all legal relations, in this way, you just have to worry 
about the relations that satisfy a given set of functional and multivalued dependencies. 

Fourth normal form
~~~~~~~~~~~~~~~~~~

The fourth normal form (4NF) is to eliminate multivalued dependencies. The 4NF ensures 
that independent multivalued dependencies are correctly and efficiently represented in 
a database design. The 4NF is the next level of normalization after the normal form of 
Boyce-Codd (BCNF).

Definition
==========

* A relation is in 4NF if and only if every non trivial multivalued dependency ``A->->B``, 
  A is a **candidate key**. A multivalued dependency ``A->->B`` is trivial when B is part of A. 
  This happens when A is a set of attributes, and B is a subset of A.

In other words a relation is in 4NF if it is in third normal form or BCNF and has no 
nontrivial multivalued dependencies. As it was mentioned, a relation has a multivalued 
dependency when the existence of two or more independent relations many to many causes 
redundancy. It is this redundancy which is removed by the fourth normal form.

Example 1
^^^^^^^^^

Let’s consider again the previous example of courses, professors and texts. We will get 
an improvement if we decompose in its two projections: Professors (course, professor) 
and Texts (course, text).

.. code-block:: sql

	Professors:

	course         | professor
	---------------+----------
	Database       |  Ullman
	Database       |  Widom
	Programming    |  Ullman

	Texts:

	course         |  text
	---------------+-----------------------------
	Database       | A First Course in Database
	Database       | Database System Concepts
	Programming    |  Rapid GUI Programming
	Programming    |  Learning Python
	Programming   |  Python Algorithms

To add information that the course of database can be imparted by a new professor, we 
just have to insert a tuple in the Professor relation:

.. code-block:: sql

	Professors:

	course         | professor
	---------------+----------
	Database       |  Ullman
	Database       |  Widom
	Database       |  Hetland
	Programming    |  Ullman

It also shows that you can recover the initial relation when you join Professors and 
Texts again, so that the decomposition is lossless. Therefore, it is reasonable to suggest 
that there must be a form of “normalize even more”, which is called 4NF.

In this example there are two valid MVDs:

``COURSE ->-> PROFESSOR``

``COURSE ->-> TEXT``

The first MVD is read as “Professor is **multi-dependent** of the Course” or in an equivalent 
way, “Course **multi-determines** a Professor”.

Example 2
^^^^^^^^^

There is a relation between students, subject and sport. Students may sign in more classes 
and participate in different sports. This means that sid will not be unique. In this way, 
the unique possible candidate key is the combination of attributes (sID, subject, sport). 
The student 1 has the subjects of physics and programming, and he also participates in 
swimming and tennis. The student 2 only has the subject math and participates in volleyball.

.. code-block:: sql

	sid |    subject   | sport
	----+--------------+------------
	1   |	physics    | swimming
	1   | programming  | swimming
	1   |   physics    | tennis
	1   | programming  | tennis
	2   |     math     | volleyball

The relation between sid and subject is not a functional dependency since students can 
have different subjects. A unique value of sid can have many values of the subject. This 
is also apply to the relation between sid and sport.
You can notice then, that this dependency for attributes is a multivalued dependency. You 
can see that redundancy in the example since the student 1 has 4 records. Each one shows 
one of the subjects with one of the sports.

If the data is stored with fewer rows: if there were only two tuples, one for physics 
and swimming, and one for programming and tennis, the implications would be engyearsas. 
It seems like student 1 only swam when he had physics as a subject and played tennis only 
when he had programming as a subject. That interpretation is not logic because his subjects 
and sports were independent from each other. To prevent those engyearsas conclusions, it 
is stored all the combinations of subjects and sports.

If the student 1 decides that he wants to sign fot soccer, you must add two tuples in 
order to maintain the consistency in the data. So you must add a row for each of his 
subjects, as it is shown next:

.. code-block:: sql

	sid |    subject   | sport
	----+--------------+------------
	1   |   physics    | soccer
	1   | programming  | soccer
	1   |	physics    | swimming
	1   | programming  | swimming
	1   |   physics    | tennis
	1   | programming  | tennis
	2   |     math     | volleyball

This relation is in BCNF (2NF because everything is key; 3NF because it does not have 
transitive dependencies; and BCNF because it does not have determinants that are no key). 
Although it can be seen this anomaly of updating since you must do too many updates to 
do a change in the data. The same happens if a student wants to sign a new subject.

There is also a student anomaly if he disenroll a subject, since it should be eliminated 
because each of the records containing such matter. If you participate in four sports, 
there will be four tuples containing the subject that has left and the four tuples should be deleted.

To avoid such anomalies two relationships are constructed, each of which stores data 
for only one of the multivalued attributes. The resulting relationships are not anomalies:

.. code-block:: sql

	Subject:

	sid | subject
	----+-------------
	1   | physics
	1   | programming
	2   | math

	Sports:

	sid | sport
	----+----------
	1   | soccer
	1   | swimming
	1   | tennis
	2   | volleyball

From these observations, we define the 4NF: A relation is in 4NF if it is in BCNF and 
does not have multivalued dependencies.

Example 3
^^^^^^^^^

It has a Calendar table with multivalued attributes:

Agenda (name, phone, email)

You are searching keys and dependencies. The candidate keys must uniquely identify each 
tuple. So the three attributes must be the candidate key.

But dependencies that have are:

``name ->-> phone``

``name ->-> email``

A name is not the candidate key of this relation, therefore it must be separated this 
relation in 2 relations:

`Phones(name,phone)`

`Emails(name,email)`

Now the two relations meet the 4NF.

.. note::

 Generally a relation is separated into as many relationships as multivalued attributes has.
