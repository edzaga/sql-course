Lecture 17 - Theory of relational design: Boyce-Codd normal form
-----------------------------------------------------------------

.. role:: sql(code)
   :language: sql
   :class: highlight

Previous concepts:
~~~~~~~~~~~~~~~~~~

Types of keys
==============

**Primary key, candidate key, and superkey** refer to an attribute or a set of attributes that identify a record univocally. This means that there is not in that relation a record which has the same value in that/those attribute(s).
 
* **Superkey:** (Compound key) is a set of one or more attributes that taken collectively, allows identifying each record of the table univocally. It is a sub-set of attributes which help to distinguish each of the tuples in a unique way. If you join other attribute to the previous sub-set, the result will still be a superkey.
 
Example
^^^^^^^^ 
The *idClient* attribute of the relation *Client* is sufficient to distinguish a row of a *Client* of the others. So, *idClient* is a superkey. Analogously, the combination of name and *idClient* is a superkey of the set of *Client* relation. The attribute *name* of client is not a superkey because several people could have the same name.

The concept of a superkey is not sufficient for what we have proposed here, since a superkey can contain unnecessary attributes. If K is a superkey, then so is any superset of K. Often superkeys are interested such that the proper subsets of them are not superkey. **Such "minimum" superkeys are called candidate keys.**
 
* **Candidate key:** when a superkey is reduced to the minimum of attributes that compose it, but still is useful to identify the tuple, so it becomes a candidate key. The candidate key is just in a conceptual level. In a relation, more than one attribute could become primary key, since it can identify each tuple. This means that there are not two values for that attribute that are equal. Those attributes that are proposed to recognize a tuple, is called candidate key since there are candidates to be a primary key.  
 
Example
^^^^^^^^ 
 
It is possible that different set of attributes could serve as candidate key. Suppose that a combination called name and address are is sufficient to distinguish between the members of the set of the *Client* relation. So, the set *{idClient}* and *{name, street}* are candidate keys. Although the attributes *idClient* and name together could distinguish the tuples of *Client*, their combination does not form a candidate key, since the *idClient* attribute by itself is a candidate key.  
 
* **Primary key:** once you choose which attributes of the candidate key will be the one that allows identifying each record in a table, which the selected attribute becomes the primary key. You can say that the primary key is a candidate key, selected by the designer of the database to identify the tuples univocally.
 
.. note::

	Other concept that we will be using is functional dependence (FD) which you can review in `Lecture16`_

Boyce-Codd normal form
~~~~~~~~~~~~~~~~~~~~~~~~~~ 

The original definition of 3NF was not satisfactory in the case of a relation that had two or more compound candidate keys, and had at least one attribute in common. This is why we establish a **Boyce-Codd normal form (BCNF)** which is a normal form strictly stronger than 3NF, which deals with cases that are not covered properly by 3NF.
 
.. note::

	It's not as frequent to find relations with more than one compound candidate keys ​​and at least one attribute in common. For a relationship where these cases do not happen, the 3NF and BCNF are equivalent.

Definition
==========
 
A scheme of relation R is in BCNF if, for all the functional dependencies of the form ``A->B``, where A and B are subsets of R. The following conditions are met:
 
* ``A->B`` **is a trivial functional dependency (FD):** (B is subset of A) So the condition of BCNF remains as only one non trivial FD can violate this condition.

* **A is a superkey of scheme R:** if you have ``A->B``, but no ``B->A``, then A is a superkey and each non trivial dependency contains A on the left, therefore there is no violation to the BCNF condition.

* All trivial functional dependency has a candidate key as its determinant.
 
A design of database is in BCNF if each member of the set of schemes of the relation that constitutes the design is in BCNF. It is worth noting that the BCNF definition is conceptually simpler than the previous definition of 3NF since does not make explicit references to the first and second normal forms as such, nor the concept of transitive dependency. Furthermore, although (as already indicated) the BCNF is strictly stronger than 3NF, it remains the case that any given relation can be decomposed into a collection lossless equivalent of BCNF relations.
 
Decomposition to achieve BCNF
===================================
 
In some instances with the appropriate choice of decomposition, you may break any scheme of relation of a collection of subsets of its attributes with the following important properties:
 
	1. These subsets are schemes of relations in BCNF.

	2. The data of the original relation is faithfully represented by the data in the resultant relations of the decomposition. Broadly speaking, we have to be able to reconstruct the original relation accurately from decomposed relations.
 
This suggest that perhaps the only thing to do is break a scheme of relation in subsets of two attributes, and the result will be in BCNF. However, such arbitrary decomposition could not satisfy the condition (2). In fact, it should be more careful and use the correct FD to guide the decomposition. The strategy of decomposition that we are going to follow is to search a trivial FD `A_1 A_2...A_n−>B_1 B_2...B_m` which violates BCNF, this means, `A_1,A_2,...,A_n` is not a superkey. We are going to add to the right as many attributes are functionally determined by `A_1,A_2,...,A_n`. This step is not compulsory, but often it is reduced the quantity of work performed, so we decided to include it in our algorithm. The following figure shows how the attributes are divided in two schemes of relations that are superposed. One is of all the involucrate attributes in the violation of FD, and the other is the left side of FD and all the attributes that do not participate in the FD, this means, all attributes except the B’s that are not A’s.

.. image:: ../../../sql-course/src/L17.png                               
      :align: center 
 
Example 1
^^^^^^^^^^

.. code-block:: sql
	Movie:

	title         | year |  length  | genre  |     director    | actor
	--------------+------+----------+--------+-----------------+-------------
	Forrest Gump  | 1994 |   142    | Drama  | Robert Zemeckis | Tom Hanks
	Forrest Gump  | 1994 |   142    | Drama  | Robert Zemeckis | Robin Wright
	Forrest Gump  | 1994 |   142    | Drama  | Robert Zemeckis | Gary Sinise
	The Godfather | 1972 |   175    | Crime  | Mario Puzo      | Marlon Brando
	Matrix        | 1999 |   136    | Action | Wachowski       | Keanu Reeves
	Matrix        | 1999 |   136    | Action | Wachowski       | Laurence Fishburne
	 
 
The *Movies* relation is not in BCNF. To see why, we must first determine which sets of attributes are keys. Our hypothesis is that *{title, year, actor}* are in a key set. To show that it is a key in the first place we have to verify that uniquely identifies a tuple. Let's suppose two tuples have the same value in these three attributes: *{title, year, actor}*. By being the same movie, the other attributes *{length, genre, director}* are equal too. Thus, two different tuples cannot agree on *{title, year, actor}* since actually it would be the same tuple.

Now, we must argue that no proper subset of *{title, year, actor}* functionally determines all the rest of the attributes. First it is observed that the title and the year do not determined actor, because many Movies have more than one actor. Therefore, *{title, year}* is not a key. *{year, actor}* is not a key, because we could have an actor in two Movies in the same year, thus: actor year -> title is not a FD. Furthermore, we argue that *{title, actor}* is not a key, because two *Movies* with the same *title*, held in different years, from time to time have a common *actor*.

As *{title, year, actor}* is a key, any set of attributes containing these three is a superkey. The same arguments above can be used to explain why there is not a set of attributes that does not include the three attributes *{title, year, actor}* that could be a superkey. Therefore, we say that *{title, year, actor}* is the only key for *Movies*.

However, keep in mind:

``title year-> length genre actor``
 
Unfortunately, the left side of the previous FD is not a superkey. In particular, it is known that the title and year do not attribute functionally determine the attribute actor. Therefore, the existence of the FD violates BCNF and tells us that *Movies* **is not in BCNF**.

On the other hand:

.. code-block:: sql 
	Movies2:

	title         | year |  length  | genre  |     director
	--------------+------+----------+--------+-----------------
	Forrest Gump  | 1994 |   142    | Drama  | Robert Zemeckis
	The Godfather | 1972 |   175    | Crime  | Mario Puzo
	Matrix        | 1999 |   136    | Action | Wachowski
 
``year title -> length genre director``
 
The only key for *Movie2* is *{title, year}*. Moreover, the only non trivial FD should have at least title and year in the left side, and therefore the left side must be the superkey. As a result, *Movies2* **is in BCNF**.

Example 2
^^^^^^^^^^
 
We have a scheme of relation and its respective functional dependencies:

* client = (nameC, address, citeC)

``nameC -> address city``
 
* office = (nameS, active,cityS)

``nameS -> active cityS``
 
It can be affirmed that client is in BCNF. Observe that a candidate key for the relation is nameC. The only functional non trivial dependencies that are met in client have nameC on the left of the arrow. Since nameC is a candidate key, the functional dependencies with nameC on the left are not violating the definition of BCNF. Also, we can demonstrate easily that relation Office is in BCNF.
 
Example 3
^^^^^^^^^^

.. code-block:: sql 

	Classes:

	ID  | subject | teacher
	----+---------+----------
	121 | Spanish | Paul
	121 | Math    | David
	345 | Spanish | Paul
	567 | math    | Robert
	567 | Spanish | Julia
	563 | Math    | Robert
 
The table is in 3NF because it has not transitive dependencies. But it is not in the form of Boyce - Codd, since ``(ID, subject)->teacher`` and ``teacher-> subject.`` In this case, the redundancy occurs because of a bad selection of the key. The redundancy of the subject is completely avoidable. The solution will be:

.. code-block:: sql 
	ID  | teacher
	----+----------
	121 | Paul
	121 | David
	345 | Paul
	567 | Robert
	567 | Julia
	563 | Robert

	subject | teacher
	--------+----------
	Spanish | Paul
	Math    | David
	Math    | Robert
	Spanish | Julia
 
In the forms of Boyce-Codd you must be careful when you decompose, since you might lose information for a bad decomposition.

.. _`lecture16`: http://sql.csrg.cl/en/lectures/week4/lecture16.html
