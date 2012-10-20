Lectura 3 - Álgebra Relacional: Select, Project, Join
-------------------------------------------------------

Conceptos básicos de álgebra relacional
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. index:: basics of relational algebra

Basics of relational algebra

Algebra, in general, consists of operators and atomic operands. For instance, in the algebra of 
arithmetic, the atomic operands are variables like r, and constants like 15. The operators are 
the usual arithmetic ones:

* Addition
* Subtraction
* Multiplication
* Division.

Any algebra allows us to build expressions by applying operators to atomic operands and/or 
other expressions of the algebra. Usually, parentheses are needed to group operators and their 
operands. For instance, in arithmetic we have expressions such a `(x + y) * z` ó `((x + 7)/(y - 3)) + x`.

Relational algebra is another example of algebra. Its atomic operands are:

	1.  Variables that stand for relations
	2.  Constants, which are finite relations

As we mentioned, in the classical relational algebra, all operands and the results of expressions are sets. 
The operations of the traditional relational algebra fall into four broad classes:
	1.  	The usual set operations - union, intersection, and difference - applied to relations.
	2.  	Operations that remove parts of a relation: “selection” eliminates some rows (tuples), 
	and “projection” eliminates some columns.
	3.  	Operations that combine the tuples of two relations, including “Cartesian product”, 
	which pairs the tuples of two relations in all possible ways and various kinds of “join” 
	operations, which selectively pair tuples from two relations.
	4.  	An operation called “renaming” that does not affect the tuples of a relation, but 
	changes the relation schema, i.e., the names of the attribute sand/or the name of the relation itself.

We shall generally refer to expressions of relational algebra as queries. While we don’t yet
have the symbols needed to show many of the expressions of relational algebra, you should be
familiar with the operations of group `(a)`; and thus recognize ( `R \cup S` ) as an example 
of an expression of relational algebra. `R` and `S` are atomic operands standing for relations,
whose sets of tuples are unknown. This query asks for the union of whatever tuples are in the
relations named `R` and `S`.
The three most common operations on sets are **union, intersection, and difference**, que se verán en la lectura 4.  

.. role:: sql(code)
   :language: sql
   :class: highlight

.. CMA: El Álgebra Relacional se define como un conjunto de operaciones que se ejecutan sobre las relaciones (Tables) para obtener un resultado, el cual es otra relación.


Operaciones relacionales:
~~~~~~~~~~~~~~~~~~~~~~~~~~

.. index:: relational operators

Relational operators are used to filter, cut or join tables.

SELECT
*******

.. CMA: Que es una tupla?

This operator is applied to a relation `R` producing a new relation with a subset of tuples of `R`. 
The tuples of the resulting relation are the ones that satisfy a condition `C` about some attribute
of `R`. In other words, it selects rows of a table according to a certain criterion `C`. Es decir 
selecciona **filas (tuplas)** de una Table según un cierto criterio `C`. 
`C` is a conditional expression, similar to the statements of the type “if”, is “booleana” this means 
that for each tuple of `R`, it takes the value of True or False.
* Values of attributes with NULL will not meet any condition.
* Each simple condition or clause C has the format

  .. math::
    \text{<Atributte> <Comparator> <Atributte or Constant>}

donde:
El campo `Comparator` es uno de los **operadores lógicos** que se muestran a contnuación:

	  .. math::
	    \text{<Comparator>}  \in {\{=,\geq,>,<, \neq,\leq \}}

	* `=` : equal sign.

	* `\neq`: not-equal sign, en algunos libros este operador esta representado por el símbolo ``!=``.
        
        * `\geq`: mayor que or equal.

        * `>`: mayor que.
 
        * `<`: less than.

	* `\leq`: less than or equal. 

Los **operadores lógicos** que se utilizan, también llamados operadores relacionales, nos proporcionan 
un resultado a partir de que se cumpla o no una cierta condición. Son símbolos que se usan para comparar
dos valores. Si el resultado de la comparación es correcto la expresión considerada es verdadera, en caso 
contrario es falsa. Por Example, 11>4 (once mayor que cuatro) es verdadera, se representa por el valor true
del tipo básico boolean, en cambio, 11<4 (once menor que cuatro) es falsa se representa por el valor false. 

 The clauses C can be connected with the logical operators, que al igual que los anteriores que se usaban
como Comparator (entre Atributtes o Atributte y constante), arrojan booleano (true o false) de resultado:

  * **NOT**: The NOT operator denotes a true output if the input is false, and a false exit if input is true. 
   Su notación en algebra es: 

	.. math::
		¬ \text{C1}

  * **AND**:  The AND operator denotes true output, if and only if its inputs are true. 
    Si C1 se cumple y C2 también se cumple, la salida seré verdadera.
    La notación en algebra de un AND es:
  
	.. math::
		\text{C1} \wedge \text{C2}
    
  * **OR**:  The OR operator denotes a true output if there is any true input put (or both).
   Si C1 y/o C2 es o son verdaderas, la expresión será verdadera.
    La notación en algebra de un OR es: 

	.. math:: 
		\text{C1} \vee \text{C2}

**Notation in Relational Algebra**

To represent **SELECT** in relational algebra it is use the Greek **letter sigma**:
:math:`\sigma`. Por lo tanto, si se utilizamos la notación
:math:`\sigma_{c} \ \boldsymbol{R}` que quiere decir que se aplica la 
condition `C` is applied to each tuple of `R`. If the condition is true, this 
tuple will belong to the result and if it false, this tuple will not be selected. 
The scheme of the resulting relationship is the same scheme `R`, shows the attributes
in the same order as used in Table `R`. 

Example 1
^^^^^^^^^

.. math::

 \textbf{Engineers Table} \\

   \begin{array}{|c|c|c|c|}
    \hline
    \textbf{id} & \textbf{name} & \textbf{age} & \textbf{workingYears}\\
    \hline
    123 & \text{Mark} & 39 & 15 \\
    \hline
    234 & \text{Tomas} & 34 & 10 \\
    \hline
    345 & \text{Owen} & 45 & 21 \\
    \hline
    143 & \text{Lexie} & 25 &  1 \\
    \hline
  \end{array}

Select tuples from the **Engineers** table that comply an age greater than 30 years:

**Answer**

.. math::
     \sigma_{\text{age>30}} \hspace{0.2cm} \text{Engineers}

.. image:: ../../../sql-course/src/select2.png
   :align: center

En la imagen se ve que selecciona solo las filas que cumplen con la condición que se pedía 
(tener una age mayor a 30 años), la tupla de "Lexie" queda fuera de la selección por no 
cumplir la condición (pues 25 < 30).
So the table would look like this:

.. math::

 \textbf{Engineers Table} \\

   \begin{array}{|c|c|c|c|}
    \hline
    \textbf{id} & \textbf{name} & \textbf{age} & \textbf{workingYears}\\
    \hline
    123 & \text{Mark} & 39 & 15 \\
    \hline
    234 & \text{Tomas} & 34 & 10 \\
    \hline
    345 & \text{Owen} & 45 & 21 \\
    \hline
  \end{array}

Example 2
^^^^^^^^^

Select from the **Engineer** table people who are over 30 years old and carrying less than 16 years working:

**Answer**

.. math::
    \sigma_{(\text{age} >30 \wedge  <16)}  \ \text{Engineers}

.. image:: ../../../sql-course/src/select3.png
      :align: center

Al tener el operador lógico AND se pide que cumplan dos condiciones simultáneamente. 
Primero que la age sea mayor de 30 años, al igual que en el Example anterior, la tupla 
de "Lexie" queda fuera de la selección. Luego de las tuplas que quedan se evalúa la 
segunda condición. En la imagen se aprecia, que solo se seleccionan las filas que no 
tengan x en alguna de las condiciones. 

So the table would finally look like this:

.. math::

 \textbf{Engineers Table} \\

 \begin{array}{|c|c|c|c|}
  \hline
  \textbf{id} & \textbf{name} & \textbf{age} & \textbf{workingYears} \\
  \hline
  123 & \text{Mark} & 39 & 15 \\
  \hline
  234 & \text{Tomas} & 34 & 10 \\
  \hline
 \end{array}

PROJECT
*******

The **PROJECT** operator is used to produce a new relation from `R`. This new relation 
contains only some of the attributes of `R`, in other words, performs the selection 
of some of the **columns** of a table `R`.

**Notation in Relational Algebra**

**PROJECT** in Relational Algebra is represented by the Greek **letter pi**:

.. math::
       \pi \hspace{0.2cm} _{(A_1,...,A_n)} \hspace{0.3cm} \text{R}

The result is a relation selecting only attributes `A1,...,An` of the relation `R`. 
If `A1,...,An` does not include a key, it may cause repeated tuples in the result, 
which will be removed.

Example 1
^^^^^^^^^
.. math::

 \textbf{Engineers Table} \\

 \begin{array}{|c|c|c|c|}
  \hline
  \textbf{id} & \textbf{name} & \textbf{age} & \textbf{workingYears} \\
  \hline
  123 & \text{Mark} & 39 & 15 \\
  \hline
  234 & \text{Tomas} & 34 & 10 \\
  \hline
  345 & \text{Owen} & 45 & 21 \\
  \hline
  143 & \text{Lexie} & 25 & 1 \\
  \hline
 \end{array}

Select columns of ID and Name of the **Engineer** table:

**Answer**

.. math::
           \pi \hspace{0.2cm}_{(\text{id,name})} \hspace{0.3cm} \text{Engineers}

So the table would finally look like this:

.. math::

 \textbf{Engineers Table}  \\

 \begin{array}{|c|c|}
  \hline
  \textbf{id} & \textbf{name} \\
  \hline
  123 & \text{Mark} \\
  \hline
  234 & \text{Tomas} \\
  \hline
  345 & \text{Owen} \\
  \hline
  143 & \text{Lexie} \\
  \hline
 \end{array}

Example 2
^^^^^^^^^

Select id and name of the Engineers who have more than 30 years old.

**Answer**

.. math::
       \pi \hspace{0.2cm} _{(\text{id,name})} (\sigma_{\text{age>30}} \hspace{0.3cm} \text{Engineers})
       
Se aprecia que las tuplas que no cumplan con la condición de selección quedan fuera del resultado, 
luego se realiza un PROJECT sobre las filas del resultado, separando solo las columnas que
contienen los Atributtes id y name. Finally the table would look like this:

.. math::

 \textbf{Engineers Table} \\

 \begin{array}{|c|c|}
  \hline
  \textbf{id} & \textbf{name} \\
  \hline
  123 & \text{Mark} \\
  \hline
  234 & \text{Tomas} \\
  \hline
  345 & \text{Owen} \\
  \hline
 \end{array}


CROSS-PRODUCT
*************

In theory of sets, the **CROSS-PRODUCT** (or Cartesian product) of two sets is an operation that results 
in another set whose elements are all the ordered pairs that can be formed by taking
the first element of the pair of the first set, and the second element of the second
set. In Relational Algebra this idea is maintain except that `R` and `S` are relations,
so the members of `R` and `S` are tuples, which generally consist of more than one component,
which result of the link with a tuple of `R` with a tuple of `S` is a longer tuple, with
one component for each of the components of the constituent tuples. That is, **CROSS-PRODUCT**
defines a relation that is the concatenation of each of the rows of the relation 
`R` with each of the rows in the relation `S`.

**Notation in Relational Algebra**

To represent Cross-product in Relational Algebra, it is used the following terminology:

.. math::
    \text{R} \times \text{S}

By convention for the previous statement, the components of `R` precede `S` components in 
the order of attributes for the result, creating a new relationship with all possible 
combinations of tuples of `R` and `S`. The number of tuples of the resulting new relation 
is the multiplication of the number of tuples of `R` by the number of tuples that have 
`S` (product of both).
If `R` and `S` have some common attributes, then we must invent new names for at least one 
of each pair of identical attributes. To eliminate ambiguity of an attribute `a`, which 
is in `R` and `S`, it is used `R.a` for the attribute of `R` and `S.a` for the attribute of `S`.


Cabe mencionar que por notación que:

.. math::
    \text{R} \times \text{S} \neq  \text{S} \times \text{R}


Example 1
^^^^^^^^^
.. image:: ../../../sql-course/src/CROSS-PRODUCT1.png
   :align: center

Con las Tables dadas realice el Cross-product de `R` con `S`:

.. image:: ../../../sql-course/src/CROSS-PRODUCT2.png
   :align: center

Con azul se resaltan las tuplas que provienen de `R` que preseden y se mezclan con las de `S` resaltadas en verde.

Con las Tables dadas realice el Cross-product de `S` con `R`:

.. image:: ../../../sql-course/src/CROSS-PRODUCT3.png
   :align: center

Example 2
^^^^^^^^^

Given the following tables:

.. math::

 \textbf{Engineers Table} \\

 \begin{array}{|c|c|c|}
  \hline
  \textbf{id} & \textbf{name} & \textbf{d#} \\
  \hline
  123 & \text{Mark} & 39 \\
  \hline
  234 & \text{Tomas} & 34 \\
  \hline
  143 & \text{Lexie} & 25 \\
  \hline
 \end{array}

 \textbf{Projects Table} \\

 \begin{array}{|c|c|}
  \hline
  \textbf{project} & \textbf{duration} \\
  \hline
  \text{ACU0034} & 300 \\
  \hline
  \text{USM7345} & 60 \\
  \hline
 \end{array}

Write the resulting table to perform the following operation:

.. math::
    \textbf{Engineers} \times \textbf{Projects}

**Answer**

.. math::

 \textbf{Engineers} \times \textbf{Projects} \\

 \begin{array}{|c|c|c|c|c|}
  \hline
  \textbf{id} & \textbf{name} & \textbf{d#} & \textbf{project} & \textbf{duration} \\
  \hline
  123 & \text{Mark} & 39 & \text{ACU0034} & 300 \\
  \hline
  123 & \text{Mark} & 39 & \text{USM7345} & 60 \\
  \hline
  234 & \text{Tomas} & 34 & \text{ACU0034} & 300 \\
  \hline
  234 & \text{Tomas} & 34 & \text{USM7345} & 60 \\
  \hline
  143 & \text{Lexie} & 25 & \text{ACU0034} & 300 \\
  \hline
  143 & \text{Lexie} & 25 & \text{USM7345} & 60 \\
  \hline
 \end{array}

NATURALJOIN
************

This operator is used when there is the need to link relations linking only tuples 
that match somehow. **NATURALJOIN** joins only the pairs of tuples of `R` and `S` that are 
common. More precisely a tuple `r` of `R` and a tuple `s` of `S` are matched correctly if 
and only if `r` and `s` coincide in each of the values of the common attributes, the 
result of the linking is a tuple, called “joined tuple.” So when performing 
**NATURALJOIN** it is obtained a relation with the attributes of both relations that 
have the same value in the common attributes.

**Notation in Relational Algebra**

PFor denoting **NATURALJOIN** it is used the following symbols:

.. math::
   \text{R} \rhd \hspace{-0.1cm} \lhd \text{S}

**Equivalence with basic operators**

NATURALJOIN can be written in terms of some operators already seen, the equivalence is:

.. math::
   R \rhd \hspace{-0.1cm} \lhd S=  \pi \hspace{0.2cm} _{R.A_1,...,R.A_n,  S.A_1,...,S.A_n} (\sigma_{R.A_1=S.A_1 \wedge ... \wedge R.A_n=S.A_n  }\hspace{0.3cm} (R \times S ))

**Método**

    1. Perform the CROSS-PRODUCT `R \times S`.
    2. Select those rows of the Cartesian product for which the common attributes have the same value.
    3. Delete from the result an occurrence (column) of each of the common attributes.


Example 1
^^^^^^^^^

.. math::

 \textbf{R}  \\

 \begin{array}{|c|c|c|}
  \hline
  \textbf{a} & \textbf{b} & \textbf{c} \\
  \hline
  1 & 2 & 3 \\
  \hline
  4 & 5 & 6 \\
  \hline
 \end{array}

 \textbf{S} \\

 \begin{array}{|c|c|}
  \hline
  \textbf{c} & \textbf{d} \\
  \hline
  7 & 5 \\
  \hline
  6 & 2 \\
  \hline
  3 & 4 \\
  \hline
 \end{array}

Con las Tables dadas realice el NaturalJoin de `R` y `S`:

.. image:: ../../../sql-course/src/NATURALJOIN.png
    :align: center

El Atributte que tienen en común `R` y `S` es el Atributte `C`, entonces las tuplas se unen donde `C` tiene el mismo valor en `R` y `S`

.. math::
 \textbf{R} \rhd \hspace{-0.1cm} \lhd \textbf{S} \\

 \begin{array}{|c|c|c|c|}
  \hline
  \textbf{a} & \textbf{b} & \textbf{c} & \textbf{d} \\
  \hline
  1 & 2 & 3 & 4 \\
  \hline
  4 & 5 & 6 & 2 \\
  \hline
 \end{array}

Example 2
^^^^^^^^^

Perform **NATURALJOIN** to the following tables:

.. math::

 \textbf{Engineers Table} \\

 \begin{array}{|c|c|c|}
  \hline
  \textbf{id} & \textbf{name} & \textbf{d#} \\
  \hline
  123 & \text{Mark} & 39 \\
  \hline
  234 & \text{Tomas} & 34\\
  \hline
  143 & \text{Lexie} & 25 \\
  \hline
  090 & \text{Maria} & 34 \\
  \hline
 \end{array}

 \textbf{Projects Table} \\

 \begin{array}{|c|c|}
  \hline
  \textbf{d#} & \textbf{project}\\
  \hline
  39 & \text{ACU0034} \\
  \hline
  34 & \text{USM7345} \\
  \hline
 \end{array}

**Answer**

.. math::

 \textbf{Engineers} \rhd \hspace{-0.1cm} \lhd \textbf{Projects} \\

 \begin{array}{|c|c|c|c|}
  \hline
  \textbf{id} & \textbf{name} & \textbf{d#} & \textbf{project} \\
  \hline
  123 & \text{Mark} & 39 & \text{ACU0034} \\
  \hline
  234 & \text{Tomas} & 34 & \text{USM7345} \\
  \hline
  090 & \text{Maria} & 34 & \text{USM7345} \\
  \hline
 \end{array}



THETAJOIN
**********

It defines a relation containing tuples that satisfy the predicate C in the 
Cartesian product(CROSS-PRODUCT) of `R \times S`. It connects relations when 
the values ​​of certain columns have a specific interrelation. The condition `C` 
is of the form `R.ai` <operator_of_comparation> `S.bi`, this condition is of the
same type used SELECT. The predicate does not have to be defined on common 
attributes. The term “join” usually refers to **THETHAJOIN**.


**Notation in Relational Algebra**

The notation of the **THETAJOIN** is the same symbol used for NATURALJOIN; the difference 
is that **THETHAJOIN** carries the predicate `C`:


.. math::
    \text{R} \rhd \hspace{-0.1cm} \lhd_C \text{S} \\

    \text{C = <Atributte> <Comparator> <Atributte o Constant>} \\

    \text{Donde:}\\

    \text{<Comparator>} \in {\{=,\geq,>,<, \neq,\leq \}}\\

**Equivalence with basic operators**

As NATURALJOIN, THETAJOIN can be written in function of previously viewed operators:

.. math::
   R \rhd \hspace{-0.1cm} \lhd_C S= \sigma_{F} (R \times S)

**Method**

   1. Form the CROSS-PRODUCT `R \times S`.
   2. Select, in the product, only the tuple that satisfy the condition `C`.

Example 1
^^^^^^^^^

.. math::

 \textbf{R} \\

 \begin{array}{|c|c|c|c|}
  \hline
  \textbf{a} & \textbf{b} & \textbf{c} & \textbf{d} \\
  \hline
  1 & 3 & 5 & 7 \\
  \hline
  3 & 2 & 9 & 1 \\
  \hline
  2 & 3 & 5 & 4 \\
  \hline
 \end{array}

 \textbf{S} \\

 \begin{array}{|c|c|c|}
  \hline
  \textbf{a} & \textbf{c} & \textbf{e} \\
  \hline
  1 & 5 & 2 \\
  \hline
  1 & 5 & 9 \\
  \hline
  3 & 9 & 2 \\
  \hline
  2 & 3 & 7 \\
  \hline
 \end{array}

Escriba la Table resultante al realizar la siguiente operación:

.. math::
   R \rhd \hspace{-0.1cm} \lhd_{(A >= E)} S 

**Answer**

.. image:: ../../../sql-course/src/THETAJOIN1.png
    :align: center

Se compara el Atributte `A` de la primera fila de `R` con cada uno de los valores del Atributte 
`E` de la Table `S`. En este caso ninguna de las comparaciones devuelve el valor verdadero (true). 

.. image:: ../../../sql-course/src/THETAJOIN2.png
    :align: center

Luego se compara el Atributte `A` de la segunda fila de `R` con cada uno de los valores del Atributte 
`E` de la Table `S`. En este caso 2 comparaciones devuelven el valor verdadero (true), por lo que en 
la relación de resultado quedará la segunda fila de `R` mezclada con la primera y tercera fila de `S`. 

.. image:: ../../../sql-course/src/THETAJOIN3.png
    :align: center

De igual forma ahora se compara el valor de `A` de la tercera tupla de `R`, nuevamente 2 tuplas de `S` 
cumplen con la condición.

.. math::

 \textbf{S} \\

 \begin{array}{|c|c|c|c|c|c|c|}
  \hline
  \textbf{R.a} & \textbf{b} & \textbf{R.c} & \textbf{d} & \textbf{S.a} & \textbf{S.c} & \textbf{e} \\
  \hline
  3 & 2 & 9 & 1 & 1 & 5 & 2 \\
  \hline
  3 & 2 & 9 & 1 & 3 & 9 & 2 \\
  \hline
  2 & 3 & 5 & 4 & 1 & 5 & 2 \\
  \hline
  2 & 3 & 5 & 4 & 3 & 9 & 2 \\
  \hline
 \end{array}

Example 2
^^^^^^^^^

With the following conceptual scheme, find the names of the directors of each department:

Department (numDpto, name, nIFDirector,  dateStart)

Employee (nIF, name, address, salary, dpto, nIFSupervisor)

**Answer**

.. math::
    \pi_{(\text{Department.name,Employee.name})} (\text{Department} \rhd \hspace{-0.1cm} \lhd_{\text{nIFDirector=nIF}} \text{Employee})

* Tuples with Null in the "Attributes of the Meeting", are not included in the result.


EXERCISES
***********

Consider the following databases:

1.  Person ( name, age, gender ) : name is a key.

2.  Frequents ( name, pizzeria ) : (name, pizzeria) is a key.

3.  Eats ( name, pizza ) : (name, pizza) is a key.

4.  Serves ( pizzeria, pizza, price ): (pizzeria, pizza) is a key.

Write relational algebra expressions for the following five queries.

*  Select those people who eat pizzas with extra cheese.

*  Select those people who eat pizzas with extra cheese and frequent the pizzeria X.

