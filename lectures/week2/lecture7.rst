Lecture 7 - Basic SELECT Statement
----------------------------------
.. role:: sql(code)
   :language: sql
   :class: highlight

Perhaps the simplest form of query in SQL asks for those tuples of some one relation that satisfy a condition. Such a query is analogous to a 
selection in relational algebra. This simple query, like almost all SQL queries, uses the three keywords, SELECT, FROM, and WHERE that 
characterize SQL.


Desde el álgebra relacional
~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. index:: Desde el álgebra relacional

The selection operator of relational algebra, and several others, make use of the WHERE SQL clause. The expressions that may follow WHERE
include conditional expressions like those found in common languages such as C or Java

We may build expressions by comparing values using the six common comparison operators:
  * =    "igual a"
  * <>   "distinto a" o "no igual a"
  * <    "menor que"
  * >    "mayor que"
  * <=   "menor o igual a"
  * >=   "mayor o igual a"

These operators have the same meanings as in C, but <> is the SQL symbol for "not equal to"; it corresponds to != in C and also SQL uses = for "equal" as opposed to == on C.

The values that may be compared include constants and attributes of the relations mentioned after FROM. We may also apply the usual arithmetic
operators, +, * , and so on, to numeric values before we compare them. We may apply the concatenation operator || to strings; for example 
'foo' || 'bar' has value 'foobar'.

Algunos ejemplos de comparasión::
        studioName = 'Ubisoft'
        mesesVidaUtil <> 5
        otros...

SELECT-FROM-WHERE
~~~~~~~~~~~~~~~~~

.. index:: SELECT-FROM-WHERE


Trabajemos bajo el siguiente ejemplo

.. code-block:: sql

        SELECT *
        FROM Juegos
        WHERE StudioName = 'Ubisoft' AND year = 2000;

This query exhibits the typical select-from-where form of most SQL queries. The FROM clause gives the relation or relations to 
which the query refers to(1x1 in our example). The query is about the relation Juegos.

In the example, the attribute studioName of the relation Juegos is tested for equality against the constant 'Ubisoft'. This constant is 
string-valued: strings in SQL are denoted by surrounding them with single quotes. Numeric constants, integers and reals, are also allowed, and 
SQL uses the common notations for reals such as -12.34 or 1.23E45.

El siguiente ejemplo combina dos relaciones a la hora de realizar la consulta

.. code-block:: sql

        SELECT *
        FROM Juegos, Tipo
        WHERE Juegos.StudioName = 'Infinity Ward' AND Tipo.Genero='FPS';

El resultado de esta consulta es el listado de los Juegos cuyo StudioName sea igual a 'Infinity Ward' y cuyo Tipo.genero sea igual a 'FPS'


The result of a comparison is a boolean value: either TRUE or FALSE. Boolean values may be combined by the logical operators AND, OR, and NOT.
with their espected meanings. 


====================
Resultados Repetidos
====================

Al realizar una consulta SELECT, no hay omisión de resultados repetidos, este "problema" se soluciona agregando DISTINCT a la consulta. Por
ejemplo, si en una base de datos hipotética <agregar ejemplo>

.. code-block:: sql

        SELECT FROM WHERE
        SELECT DISTINCT FROM WHERE


.. note::
        SQL es case insensitive, es decir que no distingue entre mayúsculas y minúsculas. Por ejemplo, FROM (palabra reservada) es 
        equivalente a from, inclusive a From. Los nombres de los atributos, relaciones, etc. son, también, case insensitive.

        El único caso en que se distingue entre mayúsculas y minúsculas es al momento de encerrar un string entre ' '. Por ejemplo 'FROM' es diferente
        a 'from'; por supuesto ambas son diferentes de FROM.



The simple SQL queries that we have seen so far all have the form

.. code-block:: sql

        SELECT L
        FROM R
        WHERE C

in which L is a list of espressions, R is a relation, and C is a condition. The meaning of any such expression is the same as that of the 
relational algebra espression

.. math::
   \pi_{L} (\theta_{C} (R))

That is, we start with the relation in the FROM clause, apply to each tuple whatever condition is indicated in the WHEHE clause, and 
then project onto the list of attributes and/or expressions in the SELECT clause. 


SELECT-BY-ORDER
~~~~~~~~~~~~~~~

.. index:: SELECT-BY-ORDER


Hasta este momento, podemos obtener datos de una tabla utilizando los comandos SELECT y WHERE. Sin embargo, muchas veces es
necesario enumerar el resultado en un orden particular. Esto podría ser en orden ascendente, en orden descendente, o podría 
basarse en valores numéricos o de texto. En tales casos, podemos utilizar la palabra clave ORDER BY para lograr esto.

.. code-block:: sql

        SELECT "a"
        FROM "b"
        WHERE "c"
        ORDER BY "a" [ASC, DESC];

donde:

  * "a" corresponde al nombre de la columna.
  * "b" corresponde al nombre de la tabla.
  * "c" corresponde a la condición de la selección.
  * ASC corresponde a un orden ascendente (corresponde a la opción por defecto)
  * DESC corresponde a uno descendente.


Su sintaxis corresponde a  ORDER BY y luego una lista de Campos que definirán los campos a ordenar:

.. code-block:: sql

        SELECT campo1, campo2, campo3, campo4 FROM Clientes ORDER BY campo_ordenar_primero, campo_ordenar_segundo...

Como se puede apreciar, con la sentencia ORDER BY se pueden ordenar las consultas a través de multiples campos. En este caso 
todos los campos estarían ordenados de forma ascendente (ASC).


NOT-IN
~~~~~~

.. index:: NOT-IN






^^^^^^^^^^
Ejercicios
^^^^^^^^^^








