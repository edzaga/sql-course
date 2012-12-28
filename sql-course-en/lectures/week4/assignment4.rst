Assignment 4
============

Date Line: Monday January 7 2013, till 23:59 
-----------------------------------------------------------

.. role:: sql(code)
   :language: sql
   :class: highlight

-------------
Database
-------------

It has a zoological database with the following scheme:

`\text{Zoo}(\underline{\text{name}}, \text{city, country,size, budget})`


This table stores the data of zoos. Their *name*, *city* and *country* in which it is located, *size* is 
the size of the hectares and the *budget* of monetary units.

.. code-block:: sql

		 name           |      city        |    country     | size    | budget 
	------------------------+------------------+----------------+---------+-------------
	 Metropolitano          | Santiago         | Chile          |     4.8 |         100
	 BuinZoo                | Buin             | Chile          |         |          60
	 San Diego              | San Diego        | USA            |      14 |       405.5
	 Parque Safari          | Rancagua         | Chile          |         |          50
	 London Zoo             | Londres          | UK             |       9 |       253.9
	 Chapultepec            | Ciudad de Mexico | Mexico         |      16 |            
	 Buenos Aires           | Buenos Aires     | Argentina      |      18 |       253.9
	 Parque de las Leyendas | Lima             | Peru           |         |            
	(8 rows)

`\text{Specie}(\underline{\text{cientName}},\text{comName, family})`


This table stores the data characterizing animal species. Stores the cientific name in *cientName*, the 
common name by which he or she is known, is saved in *comName* and the family who belongs the specie.

.. code-block:: sql

		cientName        |           comName            | family  
	-------------------------+------------------------------+----------
	 Panthera tigris         | Tigre                        | Mamifero
	 Aptenodytes patagonicus | Pinguino Rey                 | Ave
	 Ailuropoda melanoleuca  | Oso Panda                    | Mamifero
	 Vultur gryphus          | Condor                       | Ave
	 Pongo pygmaeus          | Orangutan                    | Mamifero
	 Chelonoidis nigra       | Tortuga gigante de Galapagos | Reptil
	 Balaenoptera musculus   | Ballena Azul                 | Mamifero
	 Glaucidium nanum        | Chuncho                      | Ave
	 (15 rows)

`\text{Animal}(\underline{\text{numid}},\text{zooName, specieName, sex, byear, country})`

The animal table saves data of the animals that inhabit every zoo. The foreign *zooName* is key attribute **Zoo**, refers to 
the zoo in which an animal is, *specieName* is foreign key to *specie* belonging to each, also stored gender, year of 
birth in *byear* and country of origin *country*.

.. code-block:: sql

	numid  |         zooName        |       specieName        |  sex   |   byear   |   country    
	-------+------------------------+-------------------------+--------+-----------+-----------
	     1 | Metropolitano          | Panthera tigris         | Male   |           | India
	     2 | San Diego              | Panthera tigris         | Male   |      2010 | Nepal
	     3 | London Zoo             | Panthera tigris         | Male   |      2008 | Birmania
	     4 | BuinZoo                | Pongo pygmaeus          | Female |      2004 | Indonesia
	     5 | Metropolitano          | Hippocamelus bisulcus   | Female |           | Chile
	     6 | Parque Safari          | Panthera tigris         | Male   |      2009 | India
	(28 rows)

There are specified rules for foreign keys, after having consulted with the heads of zoos:

* The *name* of the zoos should be a known value.

* Every species must have a scientific name.

* Every animal has *numid* known, is in a zoo known and belongs to a species known.

.. note::
	 The tables above are for reference only. It created a file assignment 4, having 
         the information table creation with assigned values.


Question 1 (5 points):
^^^^^^^^^^^^^^^^^^^^^^^^

Modify the assignment 4.sql so creating tables meet the three rules described above.

Question 2 (10 points):
^^^^^^^^^^^^^^^^^^^^^^^^

Assign a value unknown (NULL) year of birth of the animal that has the common name "Leon" and living in 'Safari Park'.

Question 3 (10 points):
^^^^^^^^^^^^^^^^^^^^^^^^

Update budgets that have null values, assigning a budget value = 0.


Question 4 (10 points):
^^^^^^^^^^^^^^^^^^^^^^^^

Select the "common name" (Especie.comName), "name of the zoo" (Zoo.name) and "country" (Animal.country), 
animals known their country of origin.

Question 5 (15 points):
^^^^^^^^^^^^^^^^^^^^^^^^

Remove from database (table **Animal**) reptiles of 'London Zoo'.

-------------------------------
Relational Design Theory
-------------------------------

It has the following views:

* VIEW 1 (DATE-ENTRY, DATE-DEATH, #ANIMAL, NAME-COMMON, NAME-CIENT, NICKNAME, 
  HABITAT, CLASS, LENGHT, WEIGHT, LONGEVITY, PHOTO, 
  {DATE-R, #EMP, DIAG, {#REMEDY, NOM-REMEDY, DOSIS}, OBSERVATION)

View1 allows a web visitor, learn about animals ZooChile. DATE-R is the date and time it was 
revised animal. # REMEDY is added to reduce redundancy, since these remedies may be supplied to different animals.

* VIEW 2 (DATE, NOM-V, SIGNATURE-V, {CLASS{#ANIMAL, {TYPE-NOURISHMENT, CANT}}})

The view 2 allows the Director of the Zoo, know the number of revisions performed monthly each of their veterinarians. 
The date is saved for when and how an animal ate, so we can deliver information to the veterinarian for any illness. 
Eliminate intermediate entities with attributes such as: (DATE, CLASS) and (date, type, # ANIMAL) since not provide 
additional information.

Question 1 (50 points):
^^^^^^^^^^^^^^^^^^^^^^^^
Normalize each view to 1FN, 2FN y 3FN.. 


.. note :: 
	The task is delivered in a compressed file .rar , containing:

	* assignment4.sql file with the answers to the questions of "Database".
	* assignment4.doc file,. Docx or. Pdf including response to the item "Relational Design Theory".

