Lectura 20 - Lenguaje de Modelado Unificado: UML a las relaciones
-----------------------------------------------------------------

Base de datos de alto nivel y modelo de diseño

* Fácil de usar (gráfica) especificación del lenguaje
* Traducido al modelo de DBMS

.. image:: ../../../sql-course/src/dibujo1_semana5.png                               
   :align: center  

UML (Lenguaje de Modelado Unificado)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Subconjunto de datos de modelado

* Cinco Conceptos

 1) Clases
 2) Asociaciones 
 3) Asociación de clases
 4) Subclases
 5) Composición y agregación

* Los diseños pueden ser traducidos automáticamente a las relaciones

 Siempre y cada clase "regular" tiene una clave.

Clases
======

Cada clase se convierte en una relación; pk -> clave primaria

.. image:: ../../../sql-course/src/diagrama1_semana5.png                               
   :align: center   

Según las clases descritas anteriormente tenemos las siguientes relaciones:

.. math::

 Estudiante(\underline{sID}, sName, GPA)

 Universidad(\underline{cName}, state, enr)

Asociaciones
============

Relación con la clave de cada lado.

.. image:: ../../../sql-course/src/diagrama2_semana5.png                               
   :align: center 

Se obtendrán las mismas relaciones del ejemplo anterior, pero se agregará una nueva 
relación con las claves primarias de ambas clases.

.. math::

 Aplicado(\underline{sID}, \underline{cName})

Claves para las relaciones de asociación
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

* Depende de la multiplicidad

.. image:: ../../../sql-course/src/diagrama3_semana5.png                               
   :align: center

.. math::                                                                            
     
 Clase1(\underline{Atr1_clase1}, Atr2_clase1)

 Clase2(\underline{Atr1_clase2}, Atr2_clase2)
                                                                                  
 A(\underline{Atr1_clase1}, \underline{Atr2_clase2})



Ejemplo
=======

Supongamos que tenemos 0..2 en el lado derecho, por lo que los estudiantes pueden 
solicitar hasta un máximo de 2 universidades. ¿Existe todavía una forma de "plegarse" 
la relación de asociación en este caso, o que tenemos una relación independiente *Aplicado*? 

.. note::

 La multiplicidad se muestra como un rango [mín...máx] de valores no negativos, con 
 un asterisco (*) representando el infinito en el lado máximo.
