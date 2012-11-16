Lectura 15 - Teoría del diseño Relacional: Información General
--------------------------------------------------------------

Normalización
~~~~~~~~~~~~~

Proceso mediante el cual se transforman datos complejos a un conjunto de estructuras 
de datos más pequeñas, que además de ser más simples y más estables, son más
fáciles de mantener.
También consiste en un conjunto de reglas denominadas Formas Normales (FN), las cuales 
establecen las propiedades que deben cumplir los datos para alcanzar una representación 
normalizada.

Grados de normalización
~~~~~~~~~~~~~~~~~~~~~~~

Existen básicamente tres niveles de normalización: Primera Forma Normal (1NF), 
Segunda Forma Normal (2NF) y Tercera Forma Normal (3NF). Cada una de estas formas 
tiene sus propias reglas.

Primera formal normal (1FN)
===========================

Una tabla está normalizada o en 1FN, si contiene sólo valores atómicos en la intersección 
de cada fila y columna, es decir, no posee grupos repetitivos.
Para poder cumplir con esto, se deben pasar a otra tabla aquellos grupos repetitivos 
generándose dos tablas a partir de la tabla original. Las tablas resultantes deben 
tener algún atributo en común, en general una de las tablas queda con una clave primaria 
compuesta. Esta forma normal genera tablas con problemas de redundancia, y por ende, 
anomalías de inserción, eliminación o modificación; la razón de esto es la existencia 
de lo que se denomina dependencias parciales.

Segunda forma normal (2FN)
==========================

Una tabla está en 2FN, si está en 1FN y se han eliminado las dependencias parciales 
entre sus atributos. Una dependencia parcial se da cuando uno o más atributos que no 
son clave primaria, son sólo dependientes de parte de la clave primaria compuesta, 
o en otras palabras, cuando parte de la clave primaria determina a un atributo no clave. 
Este tipo de dependencia se elimina creando varias tablas a partir de la tabla con 
problemas: una con los atributos que son dependientes de la clave primaria completa 
y otras con aquellos que son dependientes sólo de una parte. Las tablas generadas deben
quedar con algún atributo en común para representar la asociación entre ellas.
Al aplicar esta forma normal, aún se siguen teniendo problemas de anomalías
pues existen dependencias transitivas.

Tercera forma normal (3FN)
==========================

Una tabla está en 3FN, si está en 2FN y no contiene dependencias transitivas. Es decir, 
cada atributo no clave primaria no depende de otros atributos no claves primarias, sólo 
depende de la clave primaria. Este tipo de dependencia se elimina creando una nueva 
tabla con el o los atributo(s) no clave que depende(n) de otro atributo no clave, y 
con la tabla inicial, la cual además de sus propios atributos, debe contener el atributo 
que hace de clave primaria en la nueva tabla generada; a este atributo se le denomina 
clave foránea dentro de la tabla inicial (por clave foránea se entiende entonces, a
aquel atributo que en una tabla no es clave primaria, pero sí lo es en otra tabla).


