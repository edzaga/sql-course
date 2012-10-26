Assignment 1
============

--------------------------
Entity Relationship Model
--------------------------

^^^^^^^^^^^
Question 1:
^^^^^^^^^^^

Make an entity relationship model (E-R): 

  1. We have a university in which there are several courses and special workshops. 
  Each workshop is directed by a teacher who can direct several workshops. Special 
  workshops demand many resources, so that only allows that each student enrolls to 
  one workshop of this type. On the other hand, a course consists of several subjects. 
  Each of them has a number of credits. Students can enroll to the subjects they want. 
  Finally, the student receives a grade for each subject, at the end of the course.

  2. We want to make a database with discs that we have at home. A disc can have a singer 
  or a group, or more. Also a disc has a record. We are going to complicate the example the 
  previous example: now we must keep in mind that a disc is composed of songs. These can be 
  written by the same person who sings, but often they are different people.

--------------------------
Multiple-choice questions 
--------------------------

^^^^^^^^^^^
Question 1:
^^^^^^^^^^^

Suppose relation R(A,B,C) has the following tuples

.. math::

 \begin{array}{|c|c|c|}
  \hline
  \textbf{A} & \textbf{B} & \textbf{C} \\
  \hline
  1 & 2 & 3 \\
  \hline
  4 & 2 & 3 \\
  \hline
  4 & 5 & 6 \\
  \hline
  2 & 5 & 3 \\
  \hline
  1 & 2 & 6 \\
  \hline
 \end{array}

and relation S(A,B,C) has the following tuples:

.. math::

 \begin{array}{|c|c|c|}
  \hline
  \textbf{A} & \textbf{B} & \textbf{C} \\
  \hline
  2 & 5 & 3 \\
  \hline
  2 & 5 & 4 \\
  \hline
  4 & 5 & 6 \\
  \hline
  1 & 2 & 3 \\
  \hline
 \end{array}

Compute the intersection of the relations R and S. Which of the following tuples is in the result?

a) (4,5,6)
b) (1,2,6)
c) (4,2,3)
d) (2,4,3)

^^^^^^^^^^^
Question 2:
^^^^^^^^^^^

Suppose relation R(A,B,C) has the following tuples:

.. math::

 \begin{array}{|c|c|c|}
  \hline
  \textbf{A} & \textbf{B} & \textbf{C} \\
  \hline
  1 & 2 & 3 \\
  \hline
  4 & 2 & 3 \\
  \hline
  4 & 5 & 6 \\
  \hline
  2 & 5 & 3 \\
  \hline
  1 & 2 & 6 \\
  \hline
 \end{array}

and relation S(A,B,C) has the following tuples:

.. math::

 \begin{array}{|c|c|c|}
  \hline
  \textbf{A} & \textbf{B} & \textbf{C} \\
  \hline
  2 & 5 & 3 \\
  \hline
  2 & 5 & 4 \\
  \hline
  4 & 5 & 6 \\
  \hline
  1 & 2 & 3 \\
  \hline
 \end{array}

Compute (R - S) union (S - R) often called the "symmetric difference" of R and S. 
Which of the following tuples is in the result?

a) (2,2,3)
b) (4,2,3)
c) (4,5,6)
d) (4,5,3)

^^^^^^^^^^^
Question 3:
^^^^^^^^^^^

Suppose relation R(A,B,C) has the following tuples:

.. math::

 \begin{array}{|c|c|c|}
  \hline
  \textbf{A} & \textbf{B} & \textbf{C} \\
  \hline
  1 & 2 & 3 \\
  \hline
  4 & 2 & 3 \\
  \hline
  4 & 5 & 6 \\
  \hline
  2 & 5 & 3 \\
  \hline
  1 & 2 & 6 \\
  \hline
 \end{array}

and relation S(A,B,C) has de following tuples:

.. math::

 \begin{array}{|c|c|c|}
  \hline
  \textbf{A} & \textbf{B} & \textbf{C} \\
  \hline
  2 & 5 & 3 \\
  \hline
  2 & 5 & 4 \\
  \hline
  4 & 5 & 6 \\
  \hline
  1 & 2 & 3 \\
  \hline
 \end{array}

Compute the union of R and S. Which of the following tuples DOES NOT appear in the result?

a) (2,5,3)
b) (2,5,4)
c) (4,5,6)
d) (1,5,4)

^^^^^^^^^^^
Question 4:
^^^^^^^^^^^
Suppose relation R(A,B) has the following tuples:

.. math::

 \begin{array}{|c|c|}
  \hline
  \textbf{A} & \textbf{B} \\
  \hline
  1 & 2 \\
  \hline
  3 & 4 \\
  \hline
  5 & 6 \\
  \hline
 \end{array}

and relation S(B,C,D) has de following tuples:

.. math::

 \begin{array}{|c|c|c|}
  \hline
  \textbf{B} & \textbf{C} & \textbf{D} \\
  \hline
  2 & 4 & 6 \\
  \hline
  4 & 6 & 8 \\
  \hline
  4 & 7 & 9 \\
  \hline
 \end{array}

Compute the natural-join of R and S. Which of the following tuples is in the result? 
Assume each tuple has schema (A,B,C,D).

a) (5,6,4,6) 
b) (1,4,6,8)
c) (5,6,7,9)
d) (3,4,7,9)

^^^^^^^^^^^
Question 5:
^^^^^^^^^^^
Suppose relation R(A,B,C) has the following tuples:

.. math::
 
 \begin{array}{|c|c|c|}
  \hline  
  \textbf{A} & \textbf{B} & \textbf{C} \\
  \hline
  1 & 2 & 3 \\
  \hline 
  4 & 2 & 3 \\
  \hline 
  4 & 5 & 6 \\
  \hline
  2 & 5 & 3 \\
  \hline
  1 & 2 & 6 \\
  \hline
 \end{array}

Compute the projection

.. math::
     
 \pi_{C,B} (R)

Which of the following tuples is in the result? 

a) (6,2)
b) (2,5)
c) (4,2,3)
d) (1,2)


---------------
Query Questions
---------------

Next, it will be carried out a series of query questions on the databases formed by 
the SUPPLIERS, Components, SUPPLIES and SHIPPING tables. In each database is stored 
the following information:

.. math::

 \textbf{Suppliers}

 \begin{array}{|c|c|c|c|}
  \hline
  \textbf{P#} & \textbf{pname} & \textbf{category} & \textbf{city} \\
  \hline
  P1 & Sergio & 20 & Valparaíso \\
  \hline
  P2 & Pedro & 10 & Iquique \\
  \hline
  P3 & Cristian & 30 & Valparaíso \\
  \hline
  P4 & Javiera & 20 & Valparaíso \\
  \hline
  P5 & Andrea & 30 & Santiago \\
  \hline
 \end{array}

 \textbf{Components}

 \begin{array}{|c|c|c|c|c|}
  \hline
  \textbf{C#} & \textbf{cname} & \textbf{color} & \textbf{weight} & \textbf{city} \\
  \hline
  C1 & X3A & Rojo & 12 & Valparaíso \\
  \hline
  C2 & B85 & Verde & 17 & Iquique \\
  \hline
  C3 & C4B & Azul & 17 & Rancagua \\
  \hline
  C4 & C4B & Rojo & 14 & Valparaíso \\
  \hline
  C5 & VT8 & Azul & 12 & Iquique \\
  \hline
  C6 & C30 & Rojo & 19 & Valparaíso \\
  \hline
 \end{array}

 \textbf{Supplies}
     
 \begin{array}{|c|c|c|}
  \hline
  \textbf{T#} & \textbf{tname} & \textbf{city} \\
  \hline
  T1 & Clasifficator & Iquique \\
  \hline
  T2 & Drill & Rancagua \\
  \hline
  T3 & Reader & Santiago \\
  \hline
  T4 & Console & Santiago \\
  \hline
  T5 & Mixer & Valparaíso \\
  \hline
  T6 & Terminal & Arica \\
  \hline
  T7 &  Tape & Valparaíso \\
  \hline
 \end{array}

 \textbf{Shipping}

  \begin{array}{|c|c|c|c|} 
   \hline 
   \textbf{P#} & \textbf{C#} & \textbf{T#} & \textbf{quantity} \\
   \hline
   P1 & C1 & T1 & 200 \\
   \hline
   P1 & C1 & T4 & 700 \\
   \hline
   P2 & C3 & T1 & 400 \\
   \hline
   P2 & C3 & T2 & 200 \\
   \hline
   P2 & C3 & T3 & 200 \\
   \hline
   P2 & C3 & T4 & 500 \\
   \hline
   P2 & C3 & T5 & 600 \\
   \hline
   P2 & C3 & T6 & 400 \\
   \hline
   P2 & C3 & T7 & 800 \\
   \hline
   P2 & C5 & T2 & 100 \\
   \hline
   P3 & C3 & T1 & 200 \\
   \hline
   P3 & C4 & T2 & 500 \\
   \hline
   P4 & C6 & T3 & 300 \\
   \hline
   P4 & C6 & T7 & 300 \\
   \hline
   P5 & C2 & T2 & 200 \\
   \hline
   P5 & C2 & T4 & 100 \\
   \hline
   P5 & C5 & T4 & 500 \\
   \hline
   P5 & C5 & T7 & 100 \\
   \hline
   P5 & C6 & T2 & 200 \\
   \hline
   P5 & C1 & T4 & 100 \\
   \hline
   P5 & C3 & T4 & 200 \\
   \hline
   P5 & C4 & T4 & 800 \\
   \hline
   P5 & C5 & T5 & 400 \\
   \hline
   P5 & C6 & T4 & 500 \\
   \hline
 \end{array}

**Suppliers:** data from the suppliers of components for the manufacture of supplies and their city of residence.

**Components:** information of the pieces used in the manufacture of different supplies, indicating the place of manufacture of the component.

**Supplies:** supplies that are manufacture and place of assembly.

**Shipping:** supplies made by different providers of specific quantities of assigned components for the elaboration of the corresponding article.

^^^^^^^^^^
Questions:
^^^^^^^^^^

1. Select all the details of the supplies that are assembled in the city Santiago.
2. Get all the values of P# for the suppliers that supply the item T1.
3. Get the lists of the pair of attributes (color, city) of the components table removing the duplicated pairs.
4. Select the values of P# for the suppliers who provide for the item T1, the component C1.
5. Get the values of P# for the suppliers who provide the items T1 and T2.

   
