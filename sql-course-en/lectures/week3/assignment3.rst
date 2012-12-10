Assignment 3
============

Deadline: 24/12/12 until 23:59
------------------------------

.. role:: sql(code)
  :language: sql
  :class: highlight

--------
Database
--------

A database containing the data of various football teams exist with the following scheme:

* `\text{Team}(\underline{\text{ideq}},\text{name, city, titles})`
  The table **Team** has *ideq*, which is a unique ID, and primary relationship key.
  The team’s name and homecity are stored in *name* and *city* accordingly. also the 
  *titles* attribute is an integer containing the number of times the team emerged 
  champion from a competition.

.. code-block:: sql

  ideq | name   |    city     | titles
 ------+--------+-------------+---------
     1 | UCH    | Santiago    |      16
     2 | ÑUB    | Chillan     |       0
     3 | SW     | Valparaiso  |       3
     4 | CDA    | Antofagasta |       0
     5 | COB    | Calama      |       8
     6 | UE     | Santiago    |       6
               (6 rows)

* `\text{Player}(\underline{\text{rut}},\text{ideq,name,position,shirtnum})`
    The relationship **Player** has the *rut* attribute as a unique ID and is the primary key.
    The *ideq* attribute is the foreign key that makes reference to the table of teams, 
    while *name* and *position* store the name and position of the player. The *shirtnum* 
    atribute corresponds to a integer with number in the player shirt.

.. code-block:: sql

  rut  | ideq |     name  | position  | shirtnum
 ------+------+-----------+-----------+-------------
  1760 |    1 | Diaz      | Volante   |          21
  1345 |    1 | Herrera   | Arquero   |          25
  1313 |    1 | Rojas     | Defensa   |          13
  1995 |    1 | Rivarola  | Delantero |           7
  1999 |    1 | Salas     | Delantero |          11
  2343 |    1 | Vargas    | Delantero |          17
  5678 |    2 | Rodriguez | Volante   |           6
  3423 |    2 | Videla    | Volante   |           2
  1234 |    2 | Garces    | Arquero   |          12
  1235 |    2 | Gutierrez | Delantero |           9
  1349 |    2 | Marino    | Volante   |           8
    (36 rows)


* `\text{Match}(\underline{\text{ideql,ideqv}},\text{golLocal,golVisit})`
  The **Match** table stores the results of the matches betwen two teams. *ideql* 
  corresponds to the ID of the local team, while *ideqv* corresponds to the ID of the 
  visiting team. *golLocal* and *golVisit* are the points scored by the local team and 
  the visiting team accordingly.
              

.. code-block:: sql

  ideql | ideqv | golLocal | golVisita
 -------+-------+----------+-----------
      1 |     2 |        4 |         3
      1 |     3 |        3 |         1
      1 |     4 |        3 |         2
      1 |     5 |        2 |         1
      1 |     6 |        3 |         0
      2 |     1 |        0 |         0
      2 |     3 |        3 |         1
      2 |     4 |        1 |         2
     (30 filas)

.. note::

 The tables provided above are only a reference. the file with the values can be found in the documents section of the curse platform.
        
      
Question 1 (10 points):
^^^^^^^^^^^^^^^^^^^^^^^

we want to know the team's name that has won more titles, using subqueries. You can not use mathematical commands.
Help: Find all teams where no other team with most titles achieved


Question 2 (10 points):
^^^^^^^^^^^^^^^^^^^^^^^

Retrieve the name of all the players, except those who play in the “delantero” or “arquero” position (use subqueries).


Question 3 (10 points):
^^^^^^^^^^^^^^^^^^^^^^^

Retrieve the name of all the players that play in the same position as “Sanchez” (use subqueries).


Question 4 (10 points):
^^^^^^^^^^^^^^^^^^^^^^^

Select all the field of the Player table whose team’s home city is “Santiago” or “Valparaíso” (use subqueries).


Question 5 (10 points):
^^^^^^^^^^^^^^^^^^^^^^^

We want to know:
	a) The name of the team that has won more titles (including the amount) and the difference in number of titles the team has won less.
	b) Corroborate this information, referring to the name of the team that has won less titles (including the amount) and the difference in number of titles the team has won more.


Question 6 (10 points):
^^^^^^^^^^^^^^^^^^^^^^^
Make a SQL query that returns the amount of matches “SW” won playing as local.


Question 7 (10 points):
^^^^^^^^^^^^^^^^^^^^^^^
Retrieve the name of the team that won more matches playing as local.


Question 8 (15 points):
^^^^^^^^^^^^^^^^^^^^^^^

Make a SQL query that returns the amount of points that “UCH” obtained during the 
championship ( won matches award 3 points, while a draw awards 1 and a defeat awards 
no points. the winner is the team that scored more goals)


Question 9 (15 points):
^^^^^^^^^^^^^^^^^^^^^^^

Through a SQL query, retrieve the team that won the championship (the team that has 
more points is the champion. the scoring system detailed in question 6 applies)
