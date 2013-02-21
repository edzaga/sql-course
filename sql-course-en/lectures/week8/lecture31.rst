Lecture 31 - Backup and Recovery Services Database
--------------------------------------------------

.. role:: sql(code)
 :language: sql
 :class: highlight

Structure to follow:

We’re going to start this reading with some question that will be answered as the reading advances:

1. Why should we back up a DB? It’s possible to recover the information? What is the importance of this type of services?
2. How do they work?
3. Are they supported by the main DB systems? Does PostgreSQL supports it?

It’s very important to have a data recovery/back up system because it allows:

1. Have system with a certain degree of security and stability in face of failures
2. Be able to roll back to a safe point state of the DB, after dangerous changes.

Their workings are based in “states”. In each moment the DB is in a defined state. When we execute modification commands such as:

1. :sql:`INSERT`
2. :sql:`UPDATE`
3. :sql:`DELETE`

We change states, creating a new one.

.. note::

 :sql:`SELECT` is not considered as it doesn’t provokes changes. We must remember it’s only a selection operation.

At moment of back up, the current state of the DB will be backed up. It can be done in various ways, be it through the sequence of operation that created this state, or other ways. Most DB engines have tools for this and PostgreSQL isn’t the exception.

========================
Services in PostgreSQL
========================

In native form, PostgreSQL has the following functions:

.. warning::

 Some of the following commands are executed under UNIX terminals, not necessarily in the PostgreSQL (psql) environment.

=========
SQL Dump
=========

pg_dump
^^^^^^^

This function generates a text file with the SQL commands that, when executed (under certain context) in the server, should leave the DB in the same state as when the DB at the moment of execution of the command.

.. note::

 This is only if and when the DB is empty, meaning in the initial state. pg_dump
 saves the command till the control point. Example 1 should clarify doubts.  

Its sintaxs is::

 pg_dump dbname > output_file

And is used from the command line.
To make the restoration we use::

 psql dbname < Input_file

Where **Input_file** is the **output_file** of the **pg_dump** instruction.

Example 1
^^^^^^^^^^

Let’s suppose we have a DB called lecture31, and inside it a sole table called **Number** with attributes *Number* and *Name*, with data::

 1 One
 2 Two
 3 Three

In other words

.. code-block:: sql

 CREATE DATABASE lecture31;

Connecting::

 \c lecture31

.. code-block:: sql

 CREATE TABLE Numbers(Number INTEGER, Name VARCHAR(20));
 INSERT INTO Numbers VALUES (1, 'One' );
 INSERT INTO Numbers VALUES (2, 'Two' );
 INSERT INTO Numbers VALUES (3, 'Three' );

executing a select::

 number | name
 -------+-------
  1        | One
  2        | Two
  3        | Three

To perform a Back Up, we use pg_dump::

 pg_dump lecture31 > resp.sql

A possible problem when using pg_dump is::

 pg_dump lecture31 > resp.sql (bash: permission denied)

To avoid this, the DB user must have writing rights in the folder in which the file is going to be located.

.. note::

 For the local users, you only need to execute “cd” in the command line (as postgres user), to access the postgres folder. If you want to work from   a  dedicated server, you can create DBs from your session and store the backup files in your home folder.

.. note::

 It’s possible to change the reading and writing right on the folder, giving acces to user that isn’t the owner of the DB. We will not elaborate in   this topic, as it escapes the scope of this course.

Suppose that an error is made, deleting national security information, let’s say the tuple “1,One”. Using the backup file it’s posible to go back to the previous state::

 psql lecture31 < resp.sql

.. note::

 Note that within the output of the command the following appears:
 ERROR: relation "numbers" already exists

Checking the table through::

 \c lecture31

.. code-block:: sql

 SELECT * FROM Numbers;

The output is::

 number | name
 -------+-------
  2        | Two
  3        | Three
  1        | One
  2        | Two
  3        | Three

Which clearly doesn’t correspond to the initial information.

**Before restoring, it’s necessary to recreate context the DB had. Specifically users possessing certain objects or rights. If this doesn’t match the original DB, it is possible the restoration will not be correctly executed**.

In this case the initial context corresponds to a empty BD, within which a table is created and some data is added. The reader is invited to delete the table and make a restoration.
It’s nesesary to clarify that a existing DB is needed to make the restoration. If it doesn’t exists, for example using the lecture32 DB instead of lecture31, the following error will appear::

 psql: FATAL: database "lecture32" does not exist

But what happens if we use the atribute *number* as PK?, in other words, modifying only the line (and following the other steps in the same way):

.. code-block:: sql

 CREATE TABLE Numbers(Number INTEGER, Name VARCHAR(20), PRIMARY KEY (Number));

At the moment we delete a tuple, “3,Three” for example, and we try to restore, in the command line outputs::

 ERROR: relation "numbers" already exists
 ERROR: duplicate key violates unique constraint "numbers_pkey"
 CONTEXT: COPY numbers, line 1: "1          One"
 ERROR: multiple primary keys for table "numbers" are not allowed

What happens if we delete the first tuple before restoring?

Example 2
^^^^^^^^^

This example is very similar to the previous ones, but instead of working with Integer attributes, it will work with serial attributes::

 \c lecture31

.. code-block:: sql

 DROP TABLE Numbers;
 CREATE TABLE Numbers2(Number SERIAL, Name VARCHAR(20));
 INSERT INTO Numbers2 (name) VALUES ('One' );
 INSERT INTO Numbers2 (name) VALUES ('Two' );
 INSERT INTO Numbers2 (name) VALUES ('Three' );

If a select is execute, it can be observed::

 number | name
 -------+-------
  1        | One
  2        | Two
  3        | Three

To make a backup with pg_dump::

 pg_dump lecture31 > resp2.sql

Let’s say we add the tuple “4, 'Four'” and we delete the tuple “3, 'Three'” after executing the backup::

 number | name
 -------+-------
  1        | One
  2        | Two
  4        | Four

Then the restoration is executed::

 psql lecture31 < resp.sql

.. note::

 In the output it’s possible to observe:
 setval
 3

Checking the table through::

 \c lecture31

.. code-block:: sql

 SELECT * FROM Numbers2;

The output is::

 number | name
 -------+-------
  1        | One
  2        | Two
  4        | Four
  1        | One
  2        | Two
  3        | Three

This is a problem, as we are working with serial values. In fact if we add the tuple “4, Four” and we check the contents of the table, the output is::

 number | name
 -------+-------
  1        | One
  2        | Two
  4        | Four
  1        | One
  2        | Two
  3        | Three
  4        | Four

This is because the counter goes back to 3.

Proposed exercise:
^^^^^^^^^^^^^^^^^^

We leave in hands of the reader to discover what happens in case you work with a PK serial attribute:

.. code-block:: sql

 CREATE TABLE Numbers2(Number SERIAL, Name VARCHAR(20), PRIMARY KEY (number));

And then follow the same steps, meaning add the tuples (1, 'One'), (2, 'Two') and (3, 'Three').Then make a backup, access the DB, delete the last tuple, add (4, 'Four'), execute the restoration, try to add more tuples (connecting to the DB beforehand) and whatever the reader wants to do.
As a hint, if when a tuple is added, this appears::

 ERROR: duplicate key value violates unique constraint "numbers2_pkey"

Keep trying, you’ll that it’s possible to add more tuples. Keep an eye on the value of the primary key. How many time did you had to try? What happens if instead deleting the last tuple, you delete the first?

pg_dumpall
^^^^^^^^^^

A little inconvenient of pg_dump is that it can only make backups of one DB each time. Also it doesn’t backs up information about the user roles and similar information.
To make a backup of the DB and the data cluster, the command pg_dumpall exist.

The sintaxis is::

 pg_dumpall > output_file

and for the restoration (using the Unix command) ::

 psql -f input_file postgres

It works by issuing queries and command to create roles, table spaces and empty DB. Then we call pg_dump for each DB to corroborate internal consistency.

.. warning::

 It’s possible that the dedicated server doesn’t allow you to restore, as the postgres is being used. Please only use this command locally. Or using your own username.


=============================
File Level Backup
=============================

Another way of doing backups is through the direct management of files, instead of the commands issued.
However 2 restrictions make this method less practical that using pg_dump:

1. The server **must** be turn off to be able to back up correctly.
2. Each time a backup is made, the server must be turn off, so the changes are saved in fullness.

.. warning::

 Most of the time, root access is needed to be able to execute this type of operation, as it’s necessary to edit the configuration files of postgres. It’s of utmost importance that these configurations be done correctly, as any failure could wipe out the whole DB. Because of this, we will not board this topic extensively. Howerver, you can find information on the subject in the Internet.

Rsync
^^^^^

*Rsync* is a program that synchronizes 2 directories through 2 different file systems, even if they are in different physical computers. It uses SSH (*Secure Shell*) to make secure transferences based in authentication keys.

The main advantage of using *Rsync* instead of other similar commands, like *scp*, is that if the file in the destination is the same that the one in the source, no data transfer takes place; if the files are different, **only those parts that are different are transmitted**, instead of the whole file. This allows for a shorter *downtime* of the DB, meaning that it doesn’t have to stay turn of that long.
It must be noted that it’s very important to prepare the DB for the backup, to avoid potential disasters. [1] explains with great detail how to prepare the DB. However, the changes made are under your own responsibility, and we strongly recommend making test locally.


=============
Conclusions
=============

In conclusion, **in general** the backup made through **SQL Dump** usually are smaller in size that those made by means of file backup, as they don’t have to deal with indexes and such things. They only store the command that creates them. It’s because of this that the SQL Dump backups are usually faster.

[1] http://www.howtoforge.com/how-to-easily-migrate-a-postgresql-server-with-minimal-downtime

