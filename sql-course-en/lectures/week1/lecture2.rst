Lecture 2 - Relational Databases: Querying relational databases
----------------------------------------------------------------

.. role:: sql(code)
   :language: sql
   :class: highlight


Using a Relational Database
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. index:: Using a Relational Database

The necessary steps for the creation of a relational database (DB):

  * Design the scheme, in other words, the structure between relations,
    using a DDL (Data Definition Language).
  * Enter the initial data.
  * Execute query and modification operations using a DML(Data Manipulation
    Language).

.. note::

   There are the so-called “Basic Operations” of DML that can be performed 
   in a Relational Database:

    1. Consult: :sql:`SELECT`
    2. Store: :sql:`CREATE, INSERT`
    3. Update: :sql:`UPDATE`
    4. Delete: :sql:`DELETE, DROP`

.. note::

   There are the so-called “Basic Operations” of DDL that can be performed 
   in a Relational Database:

    1. Store: :sql:`CREATE`
    2. Delete: :sql:`DROP`


For now, they are only named along with their related SQL functions. As the 
course advances, the content will be deepened.

Consultations in high level languages
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. index:: Consultations in high level languages

There are high level languages that allow making relatively simple queries in 
the database, without the need to write complex algorithms.

A 'query to the database', can be understood as a question to be done to get 
'some information'. Some examples might be:

  * "All students with a grade greater than or equal to 55"
  * "All the departments of Engineering with a quantity greater or equal to 1000 students"
  * "The first 5 students with better GPA in the field of Chemistry"
 
Independent of the language used, it should be noted that:

  * Some queries are easy to formulate, others are a bit more difficult.
  * Some Data Base Management System (DBMS) are executing efficiently, others do not.
  * The two points above are not dependent on each other, it can exist an easy 
    query to formulate, but difficult to execute efficiently, depending on the DBMS.
  * The language used to execute queries can modify / update information from the 
    database; this is called Data Manipulation Language You (DML).

Consultations and relations
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. index:: Consultations and relations

The consultations carried out to the relations of a DB at the moment to be
executed produce as a result, relations, which can be:

  * Closed: When the structure of the object obtained from the query, is equal
    to the structure of objects consulted, there is a closed relationship.
  * Compound: When the query is done, at least one relation corresponds to the 
    result of a previous consultation. In other words, it corresponds to the 
    query of the result of a query.


Query languages
~~~~~~~~~~~~~~~~~

.. index:: Lenguajes de consultas

Some query languages are:

  * Relational Algebra: Formal and mathematical language.
  * SQL: Current language and implemented that born from Relational Algebra.

Although both will be deepen as the course progresses, take a look of the following example:
Look for the “Student’s ID with grade greater or equal to 55 in programmation”

.. math::

 \textbf{student table}

 \begin{array}{|c|c|c|c|}
  \hline
  \textbf{ID} & \textbf{subject_ID} & \textbf{student_name} & \textbf{gpa} \\
  \hline
  1           & 1                & \mbox{Robert}          & 45 \\
  \hline
  2           & 2                & \mbox{Robert}          & 70 \\
  \hline
  3           & 1                & \mbox{Harry}           & 55 \\
  \hline
  4           & 1                & \mbox{Jane}            & 60 \\
  \hline
  5           & 3                & \mbox{Mary}            & 35 \\
  \hline
 \end{array}

 \textbf{subjects table}

 \begin{array}{|c|c|}
  \hline
  \textbf{ID} & \textbf{subject_name} \\
  \hline
  1           & \mbox{Programming} \\
  \hline
  2           & \mbox{Database} \\
  \hline
  3           & \mbox{Math} \\
  \hline
 \end{array}

Consult for the "students ID with GPA greater or equal than  55 in the
subject of Programming ":

Using Relational Algebra:

.. CMA: QUE ES ESTO?????? No puedo entender que significa esta productora :/

.. math::

   \pi \hspace{0.2cm} _{student.ID} \hspace{0.2cm} \sigma_{\geq 55 \wedge \text{subjects.subject_name ='Programming'} (student \rhd \hspace{-0.1cm} \lhd subjects)}

One could say that:

.. math::
        \pi

Carried out a PROJECT on a table, that is to say select a column. On the other hand:

.. math::
        \sigma

select a row that complies with a certain condition, in the example given rows 
selected are the ones that have complied with having a grade higher(GPA) to 55 and 
that subjects.name_subject is ‘Programming’

.. math::
        \rhd \hspace{-0.1cm} \lhd

performs a JOIN between two relations. In lecture 3 we will get deeper about these
operators and their meanings.

Using SQL

.. code-block:: sql

 SELECT student.ID FROM student, subjects WHERE student.subjec_ID=subjec.ID 
 AND student.GPA>=55 AND subjects.subject_name ='Programming';

In the next lectures, it will be studied in greater detail both the relational algebra, 
and the SQL language.

.. To begin our study of operations on relations, we shall learn about a special
.. algebra, called relational algebra (lectures 3 and 4), that consists of some simple but powerful ways
.. to construct new relations from given relations. When the given relations are
.. stored data, then the constructed relations can be answers to queries about this data.
