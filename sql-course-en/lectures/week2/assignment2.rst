Assignment 2
============

Deadline: December 10, 2012 until 23:59
-----------------------------------------

.. role:: sql(code)
   :language: sql
   :class: highlight
-------------
Database
-------------

* `\text{Series}(\underline{\text{sID}},\text{Title, Creator, Year, Audience, Genre, Season, final})`
	The **Series** table has *sID* which is a unique ID and primary relationship key. Also it stores the series’ *Title*, the *Creator*, *Year* which is the year of the first season premiere, the average annual *Audience*, the series’ genre, the number of *Season* till year 2012 and *final* which tell if the series is still running.

* `\text{Evaluator}(\underline{\text{eID}},\text{Name})`
	The evaluator is who rates the series, and the relationship **Evaluator** has an attribute *eID* (unique ID) which is the primary key, and another attribute *Name* which is the evaluator’s name.

* `\text{Grade}(\underline{\text{eID,sID}},\text{Score, Date})`
	After the evaluator rates a series, the Score is stored in the table **Grade** which has two foreign keys, *eID* which is the ID of the evaluator and *sID* which is the id of the series. Both key united conform the primary key of **Grade**. It also contains the *score* given by the evaluator and the date of the qualification. 

.. math::

  \textbf{Series} \\

	\begin{array}{|c|c|c|c|c|c|c|c|}
        \hline
	\textbf{sID} & \textbf{Title} & \textbf{Creator} & \textbf{Year} & \textbf{Audience} & \textbf{Genre}& \textbf{Season}& \textbf{final} \\
	\hline
	1 & \text{The Big Bang Theory} & \text{Bill Prady} & 2007 & 45.99 & \text{comedy} & 6 & false\\
	\hline
	2 & \text{Grey’s Anatomy} & \text{Shonda Rhimes} & 2005 & 40.35 & \text{drama} & 9 & false \\
	\hline
	3 & \text{Dexter} & \text{James Manos} & 2006 & 50.24	& \text{crime} & 7 & false\\
	\hline
	4 & \text{Bones} & \text{Hart Hanson} & 2005 & 30.61 & \text{crime} &	8 & false \\
	\hline
	5 & \text{Glee} & \text{Ryan Murphy} & 2009 &	39.67 & \text{musical} &	4 & false\\
	\hline
	6 & \text{The Walking Dead} &	\text{Frank Darabont}  & 2010 &	34.78 &	\text{horror} & 3 & false \\
	\hline
	7 & \text{Lost} & \text{Jeffrey Lieber} & 2004 & 49.32	& \text{fantasia} & 6 & true \\
	\hline
	8 & \text{Spartacus} & \text{Steven S. DeKnight} & 2010 & 38.51 &	\text{action} & 2 & false \\
	\hline
	9 & \text{The Simpsons} & \text{Matt Groening} & 1989 & 55.82	& \text{comedy} & 25 & false\\
	\hline
	 \end{array}

.. math::

	\textbf{ Evaluator} \\

	\begin{array}{|c|c|}
	\hline
	\textbf{eID} & \textbf{Name}  \\
	\hline
	1	& \text{Nancy Cartwright} \\
	\hline
	2	& \text{Harry Shearer} \\
	\hline
	3	& \text{Frank Welker} \\
	\hline
	4	& \text{Jon Lovitz} \\
	\hline
	5	& \text{Charles Napier} \\
	\hline
	6	& \text{Glenn Sloan} \\
	\hline
	7	& \text{Stacy Keach} \\
	\hline
	8	& \text{David Crosby} \\
	\hline
	9	& \text{Keley Jones} \\
	\hline
	\end{array}

.. math::

	\textbf{Grade} \\

	\begin{array}{|c|c|}
	\hline
	\textbf{eID} & \textbf{sID} & \textbf{Score} & \textbf{Date}  \\
	\hline
	1 &	6&	5	&2012-06-08 \\
	\hline
	1 &	4&	6	&2011-04-13 \\
	\hline
	1 &	1&	8	&2012-01-22 \\
	\hline
	2	&6&	7	&2012-02-23 \\
	\hline
	3	&3&	8&	2011-11-20\\
	\hline
	3	&8&	4	&2011-11-12\\
	\hline
	4	&1&	9&	2012-01-09\\
	\hline
	5	&3	&8	&2012-09-27\\
	\hline
	5&	4&	8&	2012-07-22\\
	\hline
	5	&8&	4	&2012-03-17\\
	\hline
	6	&7&	7	&2012-07-15 \\
	\hline
	6	&6&	5	&2012-05-19 \\
	\hline
	7	&7&	5	&2011-09-20\\
	\hline
	7	&2&	6	&2011-12-08\\
	\hline
	8	&4&	9&	2011-10-02\\
	\hline
	\end{array}


Question 1:
^^^^^^^^^^^

* Create a database with the name “Assigment2”
* Create 3 tables from of given database, with their respective attributes.

Choose the type of data which suits better each attribute, according to the provided values.


Question 2:
^^^^^^^^^^^

Insert the provided data in the previously showed tables.


Question 3:
^^^^^^^^^^^

Make a query in SQL which returns all the titles of all the series from the comedy genre.

Expected query result:

.. code-block:: sql

 Title
 ---------------------
  The Big Bang Theory
  The Simpsons

Question 4:
^^^^^^^^^^^

Search all the titles and audiences of the series, and sort them in descendent order.

Expected query result:

.. code-block:: sql

          Title         | Audience
   ---------------------+-----------
    The Simpsons        |     55.82
    Dexter              |     50.24
    Lost                |     49.32
    The Big Bang Theory |     45.99
    Greys Anatomy       |     40.35
    Glee                |     39.67
    Spartacus           |     38.51
    The Walking Dead    |     34.78
    Bones               |     30.61



Question 5:
^^^^^^^^^^^

Search all the titles (without repetition) of the series with a score greater than 7.

Expected query result:

.. code-block:: sql

       Title
 ---------------------
  Dexter
  The Big Bang Theory
  Bones


Question 6:
^^^^^^^^^^^

Search all the premiere years that have series that received a score 5 or 6, and sort them in a decedent order.

Expected query result:

.. code-block:: sql

 Year
 ------
  2004
  2005
  2010


Question 7:
^^^^^^^^^^^

Search all the evaluator’s names (without repetition) that rated any series with more than 7 seasons or that has finalized.

Expected query result:

.. code-block:: sql

  Name
 ------------------
  Glenn Sloan
  Charles Napier
  Stacy Keach
  Nancy Cartwright
  David Crosby


Question 8:
^^^^^^^^^^^

Write a query that returns: the evaluator’s name, the title of the series, the score and the date of qualification. Sort the data, in first place by the evaluator’s name, then by the series’ title, and lastly, by the score given.

Expected query result:

.. code-block:: sql

         Name      |        Title        | score |   date
 ------------------+---------------------+------+------------
  Charles Napier   | Bones               |    8 | 2012-07-22
  Charles Napier   | Dexter              |    8 | 2012-09-27
  Charles Napier   | Spartacus           |    4 | 2012-01-27
  David Crosby     | Bones               |    9 | 2011-10-02
  Frank Welker     | Dexter              |    8 | 2011-11-20
  Frank Welker     | Spartacus           |    4 | 2011-11-12
  Glenn Sloan      | Lost                |    7 | 2012-07-15
  Glenn Sloan      | The Walking Dead    |    5 | 2012-05-19
  Harry Shearer    | The Walking Dead    |    7 | 2012-02-23
  Jon Lovitz       | The Big Bang Theory |    9 | 2012-01-09
  Nancy Cartwright | Bones               |    6 | 2011-04-13
  Nancy Cartwright | The Big Bang Theory |    8 | 2012-01-22
  Nancy Cartwright | The Walking Dead    |    5 | 2012-06-08
  Stacy Keach      | Greys Anatomy       |    6 | 2011-12-08
  Stacy Keach      | Lost                |    5 | 2011-09-20


Question 9:
^^^^^^^^^^^

The evaluator with eID = 4 entered wrong the score of the series with sID = 1, so he has to change the score from a 9 to an 8. Write the necessary sentence to accomplish the required adjustment.

