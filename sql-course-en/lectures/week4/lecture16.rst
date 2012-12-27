Lecture 16 - Relational Desing Theory: Multivalued dependencies (4th normal form)
-----------------------------------------------------------------------------------

Functional dependency
~~~~~~~~~~~~~~~~~~~~~

Attributes A and B are given from a relation R. It is said that B depends functionally on A if each 
value of A has associated a unique value of B. In other words, if it is known the value of A, we can 
know the value of B. Both A and B can be set of attributes. The functional dependence is symbolize 
in the following way:


.. math::

 R.A \rightarrow R.B

.. math::

 Nif \rightarrow (Nombre, address)

For example in the relation  R(`\underline{Nif}`, Name, Address), *Name* and 
*Address* attributes depend functionally on *Nif*.

The functional dependencies are generally useful for:

*  Storage of data- understanding
*  Rationing about queries- Optimization


Example 1:
==========

Student(SSN, sName, address, HScode, HSname, HScity, GPA, priority)

Apply(SSN, cName, state, date, major)

Suppose the priority is determined by GPA

GPA > 3.8 priority=1

3.3<GPA<=3.8 priority=2

GPA<=3.3 priority=3

Two tuples with same GPA have the same priority


.. math::

 \forall t, u \in Student

 t.GPA = u.GPA \Rightarrow t.priority = u.priority

 GPA \rightarrow priority

The general form will be:

.. math::

 \forall t, u \in R

 t.A = u.A \Rightarrow t.B = u.B

 A \rightarrow B

 \forall t, u \in R

 t.[A_{1}, ..., A_{n}] = u.[A_{1}, ..., A_{n}] => t.[B_{1}, ..., B_{n}] = u.[B_{1}, ..., B_{n}]

 A_{1}, A_{2}, ..., A_{n} \rightarrow B_{1}, B_{2}, ..., B_{n}

 \overline{A} \rightarrow \overline{B}


Example 2
=========

Consider the possibility of a relation R(A,B,C,D,E) with functional dependencies:

.. math::

 A,B \rightarrow C

 C,D \rightarrow E.

Suppose there are a maximum of 3 different values for each of A, B, and D. What is the maximum number of different values for E?

a) 27
b) 9
c) 3
d) 81

The correct choice is (a) since there are at most 3*3=9 combinations of A,B values, so A,B -> C has at 
maximum 9 different values for C, with a maximum of 3 different values for D. By C,D -> E there is a 
maximum of 9*3=27 different values for E.

The functional dependencies for the tables are:


**Student(SSN, sName, address, HScode, HSname, HScity, GPA, priority)**

SSN `\rightarrow` sName

SSN `\rightarrow` address

HScode `\rightarrow` HsName, HScity

HsName, HScity `\rightarrow` HScode

SSN `\rightarrow` GPA

GPA `\rightarrow` priority

SSN `\rightarrow` priority

**Apply(SSN, cName, state, date, major)**

cName `\rightarrow` date

SSN, cName `\rightarrow` major

SSN `\rightarrow` state

Example 3
=========
For the relation Apply(SSN,cName,state,date,major), what in the real-world is captured by the restriction SSN,cName → date?

a) A student can only apply to one school
b) A student can apply to each school only once.
c) A student must apply to all schools on the same date.
d) Every application from a student to a specific school must be on the same date

The correct alternative is (d) since any of the two tuples with the same SSN-cName combination should 
also have the same date. So if a student (SSN) applies to an university (cName) more than once, they must be on the same date.


Functional dependencies and keys
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

* Relation without duplicate
* Let’s suppose `\overline{A}` all the attributes.

* Trivial Functional dependency

`\overline{A} \rightarrow \overline{B}`  `\overline{B} \subseteq A`

* Non trivial functional dependency

`\overline{A} \rightarrow \overline{B}` `\overline{B} \not\subseteq A`

* Complete trivial functional dependency

`\overline{A} \rightarrow \overline{B}` `\overline{A} \cap \overline{B} = \oslash`

Rules for functional dependencies.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

*  Rule for division

`\overline{A} \rightarrow B_{1}, B_{2},...,B_{n}`

`\overline{A} \rightarrow B_{1}` `\overline{A} \rightarrow B_{2}` `...`

* Can we also divide it to the left?

`A_{1}, A_{2}, ..., A_{n} \rightarrow \overline{B}`

`A_{1} \rightarrow \overline{B}` `A_{2} \rightarrow \overline{B}` `...`

You cannot make a division to the left.

* Rules of combination

`\overline{A} \rightarrow B_{1}`

`\overline{A} \rightarrow B_{2}`

`\overline{A} \rightarrow B_{.}`
en
`\overline{A} \rightarrow B_{n}`

`\rightarrow` `\overline{A} \rightarrow B_{1}, B_{2}, ..., B_{n}`

* Rules of trivial dependency

`\overline{A} \rightarrow \overline{B}`  `\overline{B} \subseteq A`

`\overline{A} \rightarrow \overline{B}` then `\overline{A} \rightarrow \overline{A} \cup \overline{B}`

`\overline{A} \rightarrow \overline{B}` then `\overline{A} \rightarrow \overline{A} \cap \overline{B}`

* Transitive rule

`\overline{A} \rightarrow \overline{B}` `\overline{B} \rightarrow \overline{A}` then `\overline{A} \rightarrow \overline{C}`

Closing of attributes

* Given a relation, dependently functional, a set of attributes `\overline{A}`
* Find all the B so that `\overline{A} \rightarrow B`

Example 4
=========

Student(SSN, sName, address, HScode, HsName, HScity, GPA, priority)

SSN `\rightarrow` sName, address, GPA

GPA `\rightarrow` priority

HScode `\rightarrow` HsName, HScity

{SSN, HScode} `^{+}` `\rightarrow` (all attributes)(key)

{SSN, HScode, sName, address, GPA, priority, HsName, HScity}

Closing and Keys
~~~~~~~~~~~~~~~~~

* ¿Is  `\overline{A}` a key for R?

Calculate `\overline{A^{+}}` if= all attributes, so `\overline{A}`  is a key.

* How can we find all the keys with a given set of functional dependencies?

Consider each subgroup`\overline{A}` the attributes.

`A^{+} \rightarrow` all attributes

Is key

Example 5
=========

Consider the relation R(A,B,C,D,E) and suppose we have the functional dependencies:


.. math::

 AB \rightarrow C

 AE \rightarrow D

 D \rightarrow B



Which of the following pair of attributes is a key for R?

a) AB
b) AC
c) AD
d) AE

The correct choice is (d) because  {AB}+ = {ABC}; {AC}+ = {AC}; {AD}+ = {ABCD}; {AE}+ = {ABCDE}


Functionally dependent specification for a relationship
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

S1 and S2 set functionally dependent.

S2 "follows" S1 if every instance of relation satisfy S1, if also satisfies S2

S2: {SSN, priority}

S1: {SSN `\rightarrow` GPA, GPA `\rightarrow` priority}

.. note::

 It is observed that S1 satisfies  S2

Example 6
=========

Consider the relation R(A,B,C,D,E) and the set of functional dependencies
S1 = {AB `\rightarrow` C, AE `\rightarrow` D, D `\rightarrow` B}.


Which of the following set S2 of FDs CANNOT be deduced from S1?

a) S2 = {AD `\rightarrow` C}
b) S2 = {AD `\rightarrow` C, AE `\rightarrow` B}
c) S2 = {ABC `\rightarrow` D, D `\rightarrow` B}
d) S2 = {ADE `\rightarrow` BC}


The correct alternative is (c) because using the FDs in 
S1: {AD}+ = {ABCD}; {AE}+ = {ABCDE}; {ABC}+ = {ABC}; {D}+ = {B}; {ADE}+ = {ABCDE}




Assignment 4

Deadline: January 7th, 2013 (23:59)



