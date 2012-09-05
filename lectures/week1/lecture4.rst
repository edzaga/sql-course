Lecture 4 - Relation algebra: Set operators, renaming, notation
---------------------------------------------------------------

Operaciones de conjunto: 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.. index:: Operaciones de conjunto: 

* UNION: La unión de dos relaciones R y S, es otra relación que contiene las tuplas que están en R, o en S, o en ambas, eliminándose las tuplas duplicadas. R y S deben ser unión-compatible, es decir, definidas sobre el mismo conjunto de atributo (R y S deben tener esquemas idénticos. El orden de las columnas debe ser el mismo).

**Tabla Ingenieros** 

==== ====== ====   
ID   Nombre Edad     
==== ====== ====          
123  León    39           
234  Tomás   34
345  José    45
143  Josefa  25
==== ====== ====

**Tabla Jefes** 

==== ====== ====   
ID   Nombre Edad      
==== ====== ====          
123  León   39           
235  María  29
==== ====== ====

**Ejemplo Ingenieros ``U``Jefes** 

==== ====== ====   
ID   Nombre Edad     
==== ====== ====          
123  León   39           
234  Tomás  34
345  José   45
143  Josefa 25
235  María  29
==== ====== ====

* INTERSECT: Define una relación que contiene el conjunto de todas las filas que están tanto en la relación R como en S. R y S deben ser unión-compatible.
Utilizando las mismas tablas del ejemplo anterior:

**Ejemplo Ingenieros INTERSECT Jefes** 

==== ====== ====   
ID   Nombre Edad      
==== ====== ====          
123  León   39           
==== ====== ====

* MINUS (o DIFFERENCE): La diferencia de dos relaciones R y S, es otra relación que contiene las tuplas que están en la relación R, pero no están en S. R y S deben ser unión-compatible. Es importante resaltar que R - S es diferente a S - R.

**Ejemplo Ingenieros ``-`` Jefes** 

==== ====== ====   
ID   Nombre Edad     
==== ====== ====          
234  Tomás    34
345  José   45
143  Josefa   25
==== ====== ====

* TIMES (producto cartesiano):  Define una relación que es la concatenación de cada una de las filas de la relación R con cada una de las filas de la relación S. 

**Tabla Ingenieros** 

==== ====== ====   
ID   Nombre D#     
==== ====== ====          
123  León     39           
234  Tomás    34
143  Josefa   25
==== ====== ====

**Tabla Proyectos** 

======== ========   
Proyecto Duración      
======== ========          
ACU0034  300  
USM7345  60   
======== ======== 

**Ejemplo Ingenieros ``x`` Proyectos** 

==== ====== ==== ======== ========   
ID   Nombre D#   Proyecto Duración      
==== ====== ==== ======== ========          
123  León    39  ACU0034  300  
123  León    39  USM7345  60   
234  Tomás   34  ACU0034  300  
234  Tomás   34  USM7345  60   
143  Josefa  25  ACU0034  300     
143  Josefa  25  USM7345  60   
==== ====== ==== ======== ======== 



**sumario**
:
