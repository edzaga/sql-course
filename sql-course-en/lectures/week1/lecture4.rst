Lecture 4 - Relational Algebra: Set operators, renaming, notation
===================================================================

Set operations:
-------------------

.. index:: Set operations

Union
*****

In math, **algebra of sets** is called to the basic operations that can be performed on sets, 
such as union, intersection, etc. A **set** is a collection of objects considered as an object
in itself. The ``Union`` of two sets `\text{A}` and `\text{B}` is the set that contains all the elements 
of `\text{A}` and `\text{B}`. The symbol `\cup` is used to represent ``Union``.

The operator ``Union`` is **commutative**, that is `\text{A} \cup \text{B} = \text{B} \cup \text{A}`. 
Remember that an operation is commutative when the result of the operation is the same, 
whatever the order of the elements with which it operates.
 
.. image:: ../../../sql-course/src/union.png
   :align: center

In an analogous manner joining two relations `\text{R}` and `\text{S}`, is another relation that contains 
tuples that are in `\text{R}` or `\text{S}`, or both, eliminating duplicated tuples. `\text{R}` and `\text{S}` must be 
**union-compatible**, that is, defined on the same set of attribute (`\text{R}` and `\text{S}` must have 
identical schemas. Should have the same columns and their order must be the same).
 
**Notation in relational algebra**

.. math::

     \text{R} \cup  \text{S} \\

If you perform `\text{R} \cup \text{S}` is the same as `\text{S} \cup \text{R}` , that is the same result is obtained.
This is due to the property of commutativity derived from the algebra of sets. 


Example 
^^^^^^^^
Given the following relations:

.. math::
 \textbf{Engineers Table} \\

   \begin{array}{|c|c|c|}
        \hline
         \textbf{id} & \textbf{name} & \textbf{age}\\
        \hline
        123 & \text{Mark}   & 39\\
        \hline
        234 & \text{Tomas}  & 34\\
        \hline
        345 & \text{Owen}   & 45\\
        \hline
        143 & \text{Lexie} & 25\\
        \hline
   \end{array}

.. math::
 \textbf{Chiefs Table} \\

      \begin{array}{|c|c|c|}
        \hline
         \textbf{id} & \textbf{name} & \textbf{age}\\
        \hline
        123 & \text{Mark}   & 39\\
        \hline
        235 & \text{Meredith}   & 29\\
        \hline
      \end{array}

Apply the operator ``Union``:

.. math::

 \textbf{Engineers Table} \cup  \textbf{Chiefs}  \\

   \begin{array}{|c|c|c|}
        \hline
         \textbf{id} & \textbf{name} & \textbf{age}\\
        \hline
        123 & \text{Mark}   & 39\\
        \hline
        234 & \text{Tomas}  & 34\\
        \hline
        345 & \text{Owen}   & 45\\
        \hline
        143 & \text{Lexie} & 25\\
        \hline
        235 & \text{Meredith} & 29\\
        \hline
   \end{array}


As it was mentioned before, performing the `\textbf{Chiefs} \cup \textbf{Engineers}`
operation would have as a result the same table above.

Difference
**********

Returning to the analogy of algebra of sets, the difference between two sets `\text{A}` and `\text{B}`
is the set that contains all the elements of `\text{A}` that do not belong to `\text{B}`. 

.. math::  \text{A} - \text{B}

.. image:: ../../../sql-course/src/a-b.png
   :align: center

.. math::
	 \text{B} - \text{A}

.. image:: ../../../sql-course/src/b-a.png
   :align: center

As it is shown in the images, the operation ``difference``, in sets, is not commutative, 
just as in subtraction, operator already learned in basic arithmetic. That is, if you
change the order of sets to which ``difference`` operation is applied, you will get 
different results. Therefore:

.. math::
    \text{A} - \text{B} \neq  \text{B} - \text{A}    

In the same way, the difference of two relations `\text{R}` and `\text{S}` is other relation 
that contains the tuples that are in the relation `\text{R}` but not in `\text{S}`. `\text{R}` and `\text{S}` 
must be **union-compatible** (they must have identical schemes).

**Notation in relational algebra**

.. math::

     \text{R} - \text{S}

It is important to highlight that  `\text{R} - \text{S}` is different from `\text{S} - \text{R}`.


Example 
^^^^^^^^

Using the same tables given in the previous example, perform `\textbf{Engineers - Chiefs}` 
and `\textbf{Chiefs - Engineers}`:

.. math::
   \textbf{Engineers - Chiefs} \\

   \begin{array}{|c|c|c|}
        \hline
         \textbf{id} & \textbf{name} & \textbf{age}\\
        \hline
        234 & \text{Tomas}  & 34\\
        \hline
        345 & \text{Owen}   & 45\\
        \hline
        143 & \text{Lexie} & 25\\
        \hline
   \end{array}

.. math::
   \textbf{Chiefs - Engineers} \\

   \begin{array}{|c|c|c|}
        \hline
        \textbf{id} & \textbf{name} & \textbf{age}\\
        \hline
        235 & \text{Meredith} & 29\\
        \hline
   \end{array}

As can be seen, both operations gave as a result different relations, as it was 
mentioned above.

Intersection
************

In algebra of sets the ``Intersection`` of two sets `\text{A}` and `\text{B}` is the set that contains 
all the common elements of `\text{A}` and `\text{B}`. The symbol `\cap` represent the ``Intersection`` 
of two sets. As operator ``Union``, ``Intersection`` is commutative, so is fulfilled that
`\text{A} \cap  \text{B} =  \text{B} \cap  \text{A}` .

.. math::
     \text{A} \cap  \text{B}

.. image:: ../../../sql-course/src/inter.png
   :align: center

In a homologous way, in relational algebra ``Intersection`` is defined as a relation that 
contains tuples that are in both relation `\text{R}` and `\text{S}`. `\text{R}` and `\text{S}` must be **union-compatible**.
(same attributes and same order).

**Notation in relational algebra**

.. math::
     \text{R} \cap  \text{S}

If it is perform `\text{R} \cap \text{S}` is the same as `\text{S} \cap \text{R}`, which means that obtains the same result, 
so it can be said that ``Intersection`` is commutative.

**Equivalence with previous operators**

.. math::
    \text{R} \cap \text{S} = \text{R} - (\text{R} - \text{S})

Example 
^^^^^^^^

Using the same tables from the previous example, find the intersection of the `\textbf{Engineers}`
table with the one of `\textbf{Chiefs}`:

.. math::
    \text{Engineers} \cap \text{Chiefs}

      \begin{array}{|c|c|c|}
        \hline
         \textbf{id} & \textbf{name} & \textbf{age}\\
        \hline
        123 & \text{Mark}   & 39\\
        \hline
      \end{array}

.. important::

   When we apply these operations to relations, we need to put some conditions on `\text{R}` and `\text{S}`:

	* `\text{R}` and `\text{S}` must have schemas with identical sets of attributes, and the types (domains) 
          for each attribute must be the same in `\text{R}` and `\text{S}`.
	* Before compute the set-theoretic union, intersection, or difference of sets of tuples, 
          the columns of `\text{R}` and `\text{S}` must be ordered so that the order of attributes is the same for both relations.


Dependent and independent operations
************************************

Some of the operations that we have described in the lectures 3 and 4, can be expressed in
terms of other relational-algebra operations. For example, intersection can be expressed in terms
of set difference: `\text{R} \cap \text{S} = \text{R} - (\text{R} - \text{S})`. That is, if `\text{R}` and `\text{S}` are any two relations with the
same schema, the intersection of `\text{R}` and `\text{S}` can be computed by first subtracting `\text{S}` from `\text{R}` to form a
relation `T` consisting of all those tuples in `\text{R}` but not `\text{S}`. We then subtract `T` from `\text{R}`, 
leaving only those tuples of `\text{R}` that are also in `\text{S}`.


Relational algebra as a constraint language
*******************************************

There are two ways in which we can use expressions of relational algebra to express constraints:

   1. If `\text{R}` is an expression of relational algebra, then `\text{R} = 0` is a constraint that says
      "The value of R must be empty," or equivalently "There are no tuples in the result of `\text{R}`."
   2. If `\text{R}` and `\text{S}` are expressions of relational algebra, then `\text{R} \subset \text{S}` is a constraint
      that says "Every tuple in the result of R must also be in the result of S."
      Of course the result of `\text{S}` may contain additional tuples not produced by `\text{R}`.

These ways of expressing constraints are actually equivalent in what they can express,
but sometimes one or the other is clearer or more succinct.
That is, the constraint `\text{R} \subset \text{S}` could just as well have been written `\text{R} - S = 0`.
To see why, notice that if every tuple in `\text{R}` is also in `\text{S}`, then surely `\text{R} - \text{S}` is empty.
Conversely, if `\text{R} - \text{S}` contains no tuples, then every tuple in `\text{R}` must be in `\text{S}`
(or else it would be in `\text{R} - \text{S}`).

On the other hand, a constraint of the first form, `\text{R} = 0`, could just as well have been written
`\text{R} \subset 0`.
Technically, `0` is not an expression of relational algebra, but since there are expressions
that evaluate to `0`, such as `\text{R} - \text{R}`, there is no harm in using `0` as a relational-algebra
expression.
Note that these equivalences hold even if `\text{R}` and `\text{S}` are bags, provided we make the conventional
interpretation of `\text{R} \subset \text{S}`: each tuple **t** appears in `\text{S}` at least as many times as it
appears in `\text{R}`.


Exercises 
**********

Exercise 1
^^^^^^^^^^^^
The base relations that form the databases of a video club are the following:

* `\text{Member}(\underline{\text{codmember}}, \text{name},\text{address},\text{phone})` : 
  stores the data of each of the members of the video club: member code, name, address, and phone.

* `\text{Film}(\underline{\text{codfilm}}, \text{title},\text{genre})` : stores information 
  about each of the films from which have copies the video club: code of the movie, title, 
  and genre (horror, comedy, etc.).

* `\text{Tape}(\underline{\text{codtape}}, \text{codfilm})` : stores information referring 
  to the existing copies of each film (different copies of the same film will have a different tape code).

* `\text{Loan}(\underline{\text{codmember,codtape,date}}, \text{pres_dev})` : stores 
  information of the loans that have been made. Each loan is from a tape to a member in a date. 
  If the loan has not yet finalized, pres_dev has the value “borrowed”; otherwise its value is “returned”.

* `\text{WaitingList}(\underline{\text{codmember,codfilm}}, \text{date})` : stores information 
  about the members who wait available copies of films for borrowing them. It also saves the date
  in which they began the wait for maintaining the order. It is important to take into account
  that when a member gets the desired film, it disappears from the waiting list.

In previous relations, primary keys are the attributes and groups of attributes in bold. Foreign keys are shown in the following referential diagrams:

Solve the following queries using relational algebra (remember that also in lecture 3 some operators of relational algebra were given):

1.1 Select all the members who are called: “Charles”.


**Answer**

.. math::
    \sigma_{\text{name='Charles'}} \text{(Member)}

1.2 Select the member code of all the members who are called: “Charles.”

**Answer**

.. math::
    \pi_{\text{codmember}}(\sigma_{\text{name='Charles'}} \text{(Member))}

1.3 Select the names of films that are on the waiting list.

**Answer**

.. math::
    \pi_{\text{title}}(\text{Film} \rhd \hspace{-0.1cm} \lhd \text{WaitingList})


1.4 Get the names of the members who are waiting films.

**Answer**

.. math::
    \pi_{\text{name}}(\text{Member} \rhd \hspace{-0.1cm} \lhd \text{WaitingList})

1.5 Get the names of the members who have actually borrowed a film that had already borrowed previously.

**Answer**

.. math::
    \pi_{\text{name}} ( \{(\text{Loan} \rhd \hspace{-0.1cm} \lhd_{ (\text{pres_dev='prestada'})} \text{Tape}) \cap (\text{Loan} \rhd \hspace{-0.1cm} \lhd_{(\text{pres_dev='devuelta'})} \text{Tape})\} \rhd \hspace{-0.1cm}\lhd \text{Member})


1.6. Get the titles of the movies that have never been borrowed.

**Answer**

.. math::
    \pi_{\text{title}} \{(\pi_{\text{codfilm}} \text{Film}  - \pi_{\text{codfilm}} (\text{Loan} \rhd \hspace{-0.1cm} \lhd \text{Tape}) ) \rhd \hspace{-0.1cm} \lhd \text{Film}\}

(All movies) except (the movies that have ever been borrowed)

1.7. Get the names of the members who have borrowed the film “WALL*E” once or are waiting to borrow.

**Answer**

.. math::
    \pi_{\text{codmember,name}}((\text{Member} \rhd \hspace{-0.1cm} \lhd \text{Loan} \rhd \hspace{-0.1cm} \lhd \text{Tape} \rhd \hspace{-0.1cm} \lhd_{\text{title='WALL*E'}} \text{Film}) \cup \\ (\text{Member} \rhd \hspace{-0.1cm} \lhd \text{WaitingList} \rhd \hspace{-0.1cm} \lhd_{\text{title='WALL*E'}} \text{Film}) )

1.8. Get the names of the members who have ever borrowed the film WALL*E and that also are on its waiting list.
 
**Answer**

.. math::
    \pi_{\text{codmember,name}}((\text{Member} \rhd \hspace{-0.1cm} \lhd \text{Loan} \rhd \hspace{-0.1cm} \lhd \text{Tape} \rhd \hspace{-0.1cm} \lhd_{\text{title='WALL*E'}} \text{Film}) \cap \\ (\text{Member} \rhd \hspace{-0.1cm} \lhd \text{WaitingList} \rhd \hspace{-0.1cm} \lhd_{\text{title='WALL*E'}} \text{Film}) )

Exercise 2
^^^^^^^^^^^^

Consider the following databases:
 
	1.  Person ( `\underline{\text{name}}`, age, gender ) : name is a key
	2.  Frequents ( `\underline{\text{name}, \text{pizzeria}}` ) : (name, pizzeria) is a key
	3.  Eats ( `\underline{\text{name}, \text{pizza}}` ) : (name, pizza) is a key
	4.  Serves ( `\underline{\text{pizzeria}, \text{pizza}}`, price ): (pizzeria, pizza) is a key

Write relational algebra expressions for the following nine queries. (Warning: some of the later queries are a bit challenging.)

	* Find all pizzerias frequented by at least one person under the age of 18.
	* Find all pizzerias that serve at least one pizza that Amy eats for less than $10.00.
	* Find all pizzerias that are frequented by only females or only males.
	* For each person, find all pizzas the person eats that are not served by any pizzeria the person frequents. Return all such person (name) / pizza pairs.
	* Find the names of all people who frequent only pizzerias serving at least one pizza they eat.
	* Find the names of all people who frequent every pizzeria serving at least one pizza they eat.
	* Find the pizzeria serving the cheapest pepperoni pizza. In the case of ties, return all of the cheapest-pepperoni pizzerias.

