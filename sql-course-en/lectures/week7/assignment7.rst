Assignment 7
============

Deadline:
Wednesday  February 20  2013 till 23:59
-----------------------------------------------------------

.. role:: sql(code)
 :language: sql
 :class:
highlight


-----------------
Transactions
-----------------

Question 1:
^^^^^^^^^^^

Consider the relation R(x) that contains integers. 3 transactions are executed:

* **Sentence
1:**

           .. code-block:: sql

           SELECT sum(x) FROM R;
           commit;

* **Sentence
2:**

           .. code-block:: sql

           INSERT INTO R VALUES (10);
           INSERT INTO R VALUES (20);
           INSERT INTO R VALUES (30);
           commit;  

* **Sentence
3:**

           .. code-block:: sql

           DELETE FROM R WHERE x=30;
           DELETE FROM R WHERE x=20;
           commit;  

Before the execution of these transactions, the sum of integers in R is 1000, and doesn’t contain the integers 10, 20 or 30. If the 3 sentences are executed almost at the same time, and in isolation from one another, write 3 possible results from the sum that sentence 1 could show. Explain how you obtained these results.

Question
2:
^^^^^^^^^^^
Consider the relation R(x) that contains {3, 4, 8, 6, 20}. 3 transactions are executed:

* **Sentence 1:**

           .. code-block:: sql

           SELECT * FROM R;
           commit;  

* **Sentence 2:**

           .. code-block:: sql

           UPDATE R SET x = x*2 + 1;
           commit;

* **Sentence 3:**

           .. code-block:: sql

           UPDATE R SET x = 100- x;
           commit;
3 transactions are executed at almost the same time and are presented under the property of isolation and atomicity. Write 3 possible results that could show sentence 1. Explain briefly how you obtained these results.
 

-------------
Views
-------------

We have a database about tv series with the following structure:
* `\text{Series}(\underline{\text{sID}},\text{title, creator, year, audience, genre, season, final})`
           The **Series** table has *sID* which is a unique ID and primary relationship key. Also it stores the series’ *title*, the *creator*, *year* which is the year of the first season premiere, the average annual *audience*, the series’ genre, the number of *season* till year 2012 and *final* which tell if the series is still running.

*
`\text{Evaluator}(\underline{\text{eID}},\text{name})`
           The evaluator is who rates the series, and the relationship **Evaluator** has an attribute *eID* (unique ID) which is the primary key, and another attribute *Name* which is the evaluator’s name.

*
`\text{Grade}(\underline{\text{eID,sID}},\text{score, dateg})`
           After the evaluator rates a series, the Score is stored in the table **Grade** which has two foreign keys, *eID* which is the ID of the evaluator and *sID* which is the id of the series. Both key united conform the primary key of **Grade**. It also contains the *score* given by the evaluator and the date of the qualification.

Clicl
here to download the file with the data:

Question
1:
^^^^^^^^^^^
Create the view **Vista LateGrade:** that contains the classification of  movies after January 20 2012. The view contains *sID*, the*title*, the *score* and the rating date (*dateg*).

..
code-block:: sql

           postgres=# SELECT * FROM LateGrade;

           sid |        title        | score |   dateg    
           -----+---------------------+-------+------------
             4 | Bones               |     8 | 2012-07-22
             6 | The Walking Dead    |     5 | 2012-05-19
             1 | The Big Bang Theory |     8 | 2012-01-22
             3 | Dexter              |     8 | 2012-09-27
             6 | The Walking Dead    |     5 | 2012-06-08
             7 | Lost                |     7 | 2012-07-15
             1 | The Big Bang Theory |     7 | 2012-02-23
             8 | Spartacus           |     4 | 2012-03-17
           (8 rows)


Question
2:
^^^^^^^^^^^
Create the view **Vista NoGrade:** contains series without clasification, namely those that have a NULL value in the *score*. The view contains *sID* of the series and the *title*.

..
code-block:: sql

           postgres=# SELECT * FROM NoGrade;

           sid |    title     
           -----+--------------
             5 | Glee
             9 | The Simpsons
           (2 rows)


Question
3:
^^^^^^^^^^
Create the view “**Vista HighlyGrade:** that contains series with at least one *score* greater than 5. The view contains *sID* of the series and the *title*.

..
code-block:: sql

           postgres=# SELECT * FROM HighlyGrade;

           sid |        title        
           -----+---------------------
             1 | The Big Bang Theory
             2 | Greys Anatomy
             3 | Dexter
             4 | Bones
             6 | The Walking Dead
             7 | Lost
             8 | Spartacus
           (7 rows)


Question
4:
^^^^^^^^^^
Create the view **Vista nullDate:** containing the names of the evaluators that didn’t enter a rating date.

..
code-block:: sql

           postgres=# SELECT * FROM nullDate;

               name      
           ---------------
           Harry Shearer
           Jon Lovitz
           David Crosby
           (3 rows)


Question
5:
^^^^^^^^^^^
Create the view **VistaTotalGrade:**, that contains the *title* of each series and its average *score*. The view is in descending order of score, with column name *total_score*.
.. code-block:: sql

           postgres=# SELECT * FROM TotalGrade;

                       title        |    total_score     
           ---------------------+--------------------
           The Big Bang Theory | 8.0000000000000000
           Dexter              | 8.0000000000000000
           Bones               | 7.6666666666666667
           Lost                | 7.0000000000000000
           Greys Anatomy       | 6.0000000000000000
           The Walking Dead    | 5.6666666666666667
           Spartacus           | 5.6666666666666667
           (7 rows)


.. note::

The assigment must be delivered in a file assigment7.doc, .docx, .txt or .pdf, that includes the answer to all the answer. Be carefull with the delivey format, as other formats will not be accepted.
      *10 pts. penalty for delivering the assignment to the teacher’s email.
      *
if you have problem with the delivery, write an email to the teacher with pertinent
excuse before the deadline (Wednesday February 20 2013).

.. _`Delivery`: https://csrg.inf.utfsm.cl/claroline/

