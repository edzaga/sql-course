Lecture 15 - Relational Desing Theory: Overview
-------------------------------------------------

Design a scheme of database
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

* Generally there are many possible designs.
* Some are better than others.
* How should we choose?

The design of relational database can be addressed in two forms:

* **Getting the relational scheme directly:** objects and rules captured from real-world analysis, represented by a set of schemes of relation, their attributes and constraints of integrity.
* **Design of the conceptual scheme:** make the design of the “conceptual” scheme of the BD (E/R model) and transforming it into a relational scheme.   

In database schemes is possible to find anomalies which will be deleted thanks to the process of normalization.
Those anomalies are:

* **The redundancy of data:** repetition of data in a system.
* **Anomalies of update:** inconsistency of data as a result of redundant data and partial updates.
* **Anomalies of elimination:** unintentional loss of data because other data are deleted.
* **Anomalies of insertion:** inability to add data to the database because of the absence of other data.

Now we will show you a table and then its problems presented with more detail:

.. math::

   \begin{array}{|c|c|c|c|c|c|}
    \hline
    \textbf{Name_author} & \textbf{Country} & \textbf{Cod_book} & \textbf{Title_book} & \textbf{publisher} & \textbf{Address_publishing_house}\\
    \hline
    \text{Cortázar, Julio} & \text{Arg} & \text{9786071110725} & \text{Cuentos Completos 1 Julio Cortazar}  & \text{Alfaguara} & \text{Padre Mariano 82}\\
    \hline
    \text{Rosasco, José Luis}  & \text{Chi} & \text{9789561224056} & \text{Donde Estas, Constanza} & \text{Zig-Zag} & \text{Los Conquistadores 1700} \\
    \hline
    \text{Rosasco, José Luis}  & \text{Chi} & \text{9561313669} & \text{Hoy Día es Mañana} & \text{Andrés Bello} & \text{Ahumada 131}\\
    \hline
    \text{Coloane, Francisco} & \text{Chi} & \text{9789563473308} & \text{Golfo De Penas} & \text{Alfaguara} & \text{Padre Mariano 82}\\
    \hline
   \end{array}


* **Redundancy:** when an author has several books, his/her nationality is repeated.
* **Anomalies of modification:** if you change the address of “Algaguara” editorial, you must modify two rows. A priori, you cannot tell how many books an author has. Errors are very frequent when you forget to modify an author.
* **Anomalies of insertion:** you want to insert an author who does not present books. “Name_author” and “Cod_book” are key fields, so the keys cannot be null values.

By deleting these anomalies ensures:

* **Integrity among data:** consistency of the information.

Other example is shown in the following table:


**Apply(SSN, sName, cName, HS, HScity, hobby)**

.. note::
  
 The notation that we use in the table is:
 
 HS = high school


*123 Ann of PAHS (P.A) and GHS (P.A) plays tennis and the trumpet. She applied to Stanford, Berkeley and MIT.*

The inserted data in the table could be the ones shown::

.. math::

   \begin{array}{|c|c|c|c|}
    \hline
    \text{123} & \text{Ann} & \text{Stanford} & \text{PAHS} & \textbf{P.A} & \text{tennis} \\
    \hline
    \text{123} & \text{Ann} & \text{Berkeley} & \text{PAHS}  & \text{P.A} & \text{tennis}\\
    \hline
    \text{123}  & \text{Ann} & \text{Berkeley} & \text{PAHS} & \text{P.A}  & \text{trumpet}\\
    \hline
    \text{.}  & \text{.} & \text{.} & \text{GHS} & \text{.} & \text{.}\\
    \hline
    \text{.} & \text{.} & \text{.} & \text{.} & \text{.} & \text{.}\\
    \hline
   \end{array}

* **Redundancy:** captures information many times, for instance: “123 Ann”, “PAHS”, “tennis” or “MIT”.
* **Anomalies of update:** update data in a different way such as “bugle” for “trumpet.”
* **Anomalies of elimination:** data inadvertent eliminated.

A correct form to do the previous table without anomalies is

  * Student(SSN, sName);
  * Apply(SSN, cName);
  * High_School(SSN, HS);
  * Located(HS, HSciudad);
  * Hobbies(SSN, hobby);

Exercise
=========
Consider the possibility of a database containing information about the courses taken by students. 
Students have a unique ID of student and (possibly not a unique) name. Courses have a unique number of 
courses and (possibly not a unique) title. Students take a course of a determined year and receive a grade.

Which of the following eschemes would you recommend?

 1. Took(SID, name, courseNum, title, year, grade)
 2. Course(courseNum, title, year), Took(SID, courseNum, grade)
 3. Student(SID, name), Course(courseNum, title), Took(SID, courseNum, year, grade)
 4. Student(SID, name), Course(courseNum, title), Took(name, title, year, grade)

The right choice is letter (c), as it says in the statement that there are students with a unique ID, which in 
this case is "SID" and "name". The courses have an unique ID which is "courseNum" and "title". Further says that
students take a course in a given year "year" and receive a "grade", but the attribute "courseNum" acts as 
foreign key of the Course table with which you can get the title of the course. And also must have a primary
 key to identify the course that will be taken "SID".


Desing by decomposition
~~~~~~~~~~~~~~~~~~~~~~~~~

* Start with *“mega” relations* which contain everything.
* *Decompose* in smaller parts to obtain better relations with the same information.
* Can you *decompose it automatically*?

Automatic decomposition:

* “Mega” relations + properties of data
* The system decompose based on the properties.
* Final ser of relations satisfy the normal form.
* There are no anomalies; there is a loss of information.
 
Normalization
~~~~~~~~~~~~~

Process that analyzes dependencies between attributes of a relation in a way to combine those attributes, 
in entities and associations less complex and smaller. It consists of a set of rules called normal forms (NF), 
which establish the properties that data must meet to achieve a normalized representation. In this step, you 
take every relationship to become them into an entity (relationship or table) no normalized. Defined rules are 
applied for 1NF, 2NF, 3NF, Boyce Codd and 4NF.


Normal Forms
===============

The following image shows the three main levels used in the design of schemes of database:

.. image:: ../../../sql-course/src/formas_normales.png
   :align: center

The process of normalization is essential in order to obtain an efficient design of database. 

In a non-normalized entity, generally expressed in a plane form (like a table), it is very likely there are 
one or two more repetitive groups. In that case, its primary key cannot be a simple attribute.
 

A continuación se dará una definición y un ejemplo de las formas normales:


Primera formal normal (1FN)
^^^^^^^^^^^^^^^^^^^^^^^^^^^

Una tabla está normalizada o en 1FN, si contiene sólo valores atómicos en la intersección
de cada fila y columna, es decir, no posee grupos repetitivos.
Para poder cumplir con esto, se deben pasar a otra tabla aquellos **grupos repetitivos**
generándose dos tablas a partir de la tabla original. Las tablas resultantes deben
tener algún atributo en común, en general una de las tablas queda con una clave primaria
compuesta. Esta forma normal genera tablas con problemas de redundancia, y por ende,
anomalías de inserción, eliminación o modificación; la razón de esto es la existencia
de lo que se denomina **dependencias parciales**.

Ejemplo
"""""""

Se dice que una tabla está encuentra en primera forma normal (1FN) si y solo si cada uno
de los campos contiene un único valor para un registro determinado.
Supongamos que deseamos realizar una tabla para guardar los cursos que están realizando
los estudiantes de informática de la USM, podríamos considerar el siguiente diseño.

.. math::

 \begin{array}{|c|c|c|}                                                          
    \hline                                                                           
    \textbf{Código} & \textbf{Nombre} & \textbf{Cursos} \\
    \hline                                                                           
    \text{1} & \text{Patricia} & \text{Estructura de datos} \\
    \hline                                                                           
    \text{2}  & \text{Margarita} & \text{Bases de datos, Teoría de sistemas} \\
    \hline                                                                           
    \text{3}  & \text{Joao} & \text{Estructura de datos, Bases de datos} \\         
    \hline                                                                           
   \end{array}   

Se puede observar que el registro 1 cumple con la primera forma normal, puesto que cada 
campo cumple con la condición de tener solo un dato, pero esta condición no se cumple con 
el registro 2 y 3, en el campo de *Cursos*, ya que en ambos existen dos datos.
La solución a este problema es crear dos tablas del siguiente modo.

.. math::                                                                            
 \text{Tabla 1}
                                                                                     
 \begin{array}{|c|c|}                                                            
    \hline                                                                           
    \textbf{Código} & \textbf{Nombre}  \\                           
    \hline                                                                           
    \text{1} & \text{Patricia}  \\                       
    \hline                                                                           
    \text{2}  & \text{Margarita} \\      
    \hline                                                                           
    \text{3}  & \text{Joao} \\          
    \hline                                                                           
   \end{array}  

 \text{Tabla 2}                                                                           
                                                                                     
 \begin{array}{|c|c|}                                                            
    \hline                                                                           
    \textbf{Código} & \textbf{Cursos} \\                           
    \hline                                                                           
    \text{1} & \text{Estructura de datos} \\                       
    \hline                                                                           
    \text{2}  & \text{Bases de datos} \\      
    \hline                                                                           
    \text{2}  & \text{Teoría de sistemas} \\          
    \hline    
