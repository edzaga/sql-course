Lecture 3 - Relation algebra: Select, project, join
---------------------------------------------------

El álgebra relacional se define como un conjunto de operaciones que se ejecutan sobre las relaciones (tablas) para obtener un resultado (el cual es otra relación), es preescriptivo o procedural (algorítmico). 


Operaciones relacionales: 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.. index:: Operaciones relacionales:

* SELECT: picking certain rows. 

.. math::
\sigma_{ c} R1 
C  is a condition (as in “if” statements) that refers to attributes of R. 

**Ingenieros** 

==== ====== ==== ===================   
ID   Nombre Edad Años trabajados(AT)    
==== ====== ==== ===================          
123  León    39           15
234  Tomás   34           10
345  José    45           21
143  Josefa  25           1
==== ====== ==== ===================

Seleccionar ingenieros que tienen más de 30 años:

.. math::
\sigma_{edad}>30 Ingenieros

**Ingenieros** 

==== ====== ==== ===================   
ID   Nombre Edad Años trabajados(AT)    
==== ====== ==== ===================          
123  León    39           15
234  Tomás   34           10
345  José    45           21
==== ====== ==== ===================

Seleccionar ingenieros que tienen más de 30 años y que lleven menos de 16 años trabajando: 

.. math::
\sigma_{edad >30 \wedge AT <16}    Ingenieros

**Ingenieros** 

==== ====== ==== ===================   
ID   Nombre Edad Años trabajados(AT)    
==== ====== ==== ===================          
123  León    39           15
234  Tomás   34           10
==== ====== ==== ===================


* PROJECT: picking certain columns.
Escoger columnas de ID y nombre de la tabla de ingenieros:

.. math::
\pi_{ID,Nombre} Ingenieros

**Ingenieros** 

==== ====== 
ID   Nombre 
==== ====== 
123  León  
234  Tomás    
345  José   
143  Josefa   
==== ====== 


To pick both rows and columns
Seleccionar ID y nombre de los Ingenieros que tienen más de 30 años

.. math::
\pi_{ID,Nombre} (\sigma_{edad}>30 Ingenieros)

** Ingenieros** 

==== ====== 
ID   Nombre 
==== ====== 
123  León  
234  Tomás    
345  José   
==== ====== 

* JOIN 


