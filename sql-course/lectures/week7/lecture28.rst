Lectura 28 - Vistas: Vistas y modificaciones automáticas
---------------------------------------------------------
.. role:: sql(code)
         :language: sql
         :class: highlight

=======
Repaso
=======

Por lo general, las tablas son constituidas por un conjunto de definiciones y almacenan
datos físicos.

Por otra parte las vistas se encuentran en un nivel superior, es decir son constituidas
por un conjunto de definiciones, pero no almacenan datos, pues utilizan los datos que 
están almacenadas en las tablas. Es por ello que, podemos decir que las vistas son 
=======
por un conjunto de definiciones, pero no almacenan datos, pues utilizan los datos que
están alamacenadas en las tablas. Es por ello que, podemos decir que las vistas son
tablas virtuales.

Su sintaxis es:

.. code-block:: sql

 CREATE VIEW "view_name" AS "sql_instruction";

Donde:

1. "view_name": corresponde al nombre de la vista
2. "sql_instruction": corresponde a alguna instrucción SQL vista hasta ahora, es
    decir, operaciones de inserción.

Toda Base de Datos (BD), puede ser vista como un árbol de 3 niveles:

1. **La raíz**, compuesta por la parte **física** de la BD, es decir el(los) 
   disco(s) duro(s).
2. **El tronco**, compuesto por las relaciones de dentro de la BD, es decir,
   su parte **conceptual**.
3. **Las ramas**, que corresponde a la parte **lógica**, se refiere a las relaciones 
    que nacen desde las relaciones del tronco y/o relaciones desde las ramas.


.. agregar el dibujo(?)

Realizar modificaciones en una vista no tiene mucho sentido, pues al no almacenar 
información,estos cambios simplemente se perderían. No obstante, si el ojetivo de 
estos cambios corresponde a modificar la(s) tabla(s) bases, dicha modificación 
adquiere sentido.

.. note::

  Por modificación se entienden operaciones de tipo INSERT, UPDATE y DELETE.

Estas modificaciones en las vistas deben ser traducidas a modificaciones que 
afecten a las tablas involucradas. Esta lectura está orientada a profundizar como se 
automatiza este proceso.

=============
Reglas
=============

Dentro del estandar de SQL, existen 4 reglas para las "vistas modificables", ellas son:

.. El proceso de automatizado de traducción está sujeto a 4 grandes reglas, ellas son:
.. ojo, buscar más info aca
1. Hacer un select de una tabla, no de un join (??)
2. Si un atributo no esta en la vista, debe permitirsele tener valor NULL o uno por defecto
3. Si la vista está sobre la relación/tabla T, las subconsultas no pueden referirse a T, pero
   si a otras relaciones/tablas.
4. En una vista, no se puede usar GROUP BY o AGGREGATION


============
Contexto
============

Para esta lectura, se utilizará el sistema de Postulación de Estudiantes a 
Establecimientos Educacionales, con los datos utilizados en la lectura 9(tercera semana).




