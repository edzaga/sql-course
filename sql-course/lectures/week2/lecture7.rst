Lecture 7 - Basic SELECT Statement
----------------------------------
.. role:: sql(code)
   :language: sql
   :class: highlight

Corresponde a la forma más simple de hacer una consulta en SQL, la cual sirve para preguntar por aquellas tuplas de una relación
que satisfagan una condición. Es análoga a la selección en álgebra relacional. Esta consulta, al igual que la mayoría
de las realizadas en este lenguaje de programación, utiliza 3 palabras clave: SELECT - FROM - WHERE.

En palabras simples, lo que se busca con esta consulta es seleccionar cierta información (SELECT) de alguna tabla (FROM)
que satisfaga (WHERE) ciertas condiciones. Por ejemplo:

.. code-block:: sql

   Obtener los nombres de los alumnos que hayan nacido en el mes de Noviembre
   SELECT "los nombres" FROM "alumnos" WHERE "hayan nacido en el mes de Noviembre"

Cabe destacar que en este ejemplo, se infiere la existencia de una tabla de nombre "alumnos" que alberga datos personales de ciertos
estudiantes.

Desde el Algebra Relacional
~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. index:: Desde el álgebra relacional

El operador de selección en el Algebra relacional hace uso de la palabra clave  WHERE. Por lo general, las expresiones que siguen
a esta keyword incluyen expresiones condicionales. Podemos construir expresiones mediante la comparación de valores (como por ejemplo
tipos de datos enteros, cadenas de caracteres, etc) utilizando los 6 operadores más comunes de comparación:

  * ``=``   "igual a"
  * ``<>``   "distinto a" o "no igual a"
  * ``<``   "menor que"
  * ``>``   "mayor que"
  * ``<=``   "menor o igual a"
  * ``>=``   "mayor o igual a"

Estos operadores tienen el mismo significado que en el lenguaje C, siendo el único diferente el símbolo "<>" que corresponde a
"distinto a"; el lenguaje C utiliza el símbolo "!=" para este comparador. Siguiendo la comparación entre estos lenguajes, el símbolo de
igualdad en SQL corresponde a "=", mientras que en C es "==".

Estos valores pueden ser comparados incluyendo constantes y atributos de las relaciones nombradas despues de la palabra clave FROM.
En el ejemplo, correspondería al atributo del mes de nacimiento del individuo con el mes de Noviembre.


..      Además de los 6 operadores ya mencionados, es posible  The values that may be compared include constants and attributes of the relations
         mentioned after FROM. We may also apply the usual arithmetic operators, +, * , and so on, to numeric values before we compare them. We may
        apply the concatenation operator || to strings; for example 'foo' || 'bar' has value 'foobar'.

Algunos ejemplos de comparación:

.. code-block:: sql

        StudioName = 'Ubisoft' : se compara que el atributo studioName sea 'Ubisoft'
        mesesVidaUtil <> 5 : se compara que el atributo mesesVidaUtil no sea igual a 5
        mesNacimiento = 'Noviembre':  se compara que el atributo mesNacimiento sea igual a 'Noviembre'

SELECT-FROM-WHERE
~~~~~~~~~~~~~~~~~

.. index:: SELECT-FROM-WHERE


Trabajemos bajo el siguiente ejemplo, el cual consiste en consultar toda la información de la relación (o tabla) "Juegos" cuyos atributos
"StudioName" sea 'Ubisoft' y que su atributo "year" sea igual a 2000.

.. code-block:: sql

        SELECT *
        FROM Juegos
        WHERE StudioName = 'Ubisoft' AND year = 2000;

Esta consulta exhibe el típico SELECT-FROM-WHERE de la mayoría de las consultas SQL. La palabra clave FROM entrega la relacion o relaciones
de donde se obtiene la información. En este ejemplo, se utilizan dos comparaciones unidas por la condición "AND". Ojo, al utilizar

.. code-block:: sql

    SELECT *

el símbolo  "*" equivale a TODOS los valores del (los) atributo(s) de la(s) relación(es) en cuestion que cumplan con la(s) condición(es).

El atributo "StudioName" de la relación Juegos es probada por igualdad contra la constante 'Ubisoft'. Esta constante corresponde a una
cadena de caracteres (se conoce como string), y en SQL se denotan  rodeando a la cadena en cuestión utilizando comillas simples.

.. code-block:: sql

        '¡Hola!, soy un string SQL!!!'

SQL soporta además el uso de constantes numéricas, números enteros y números reales. SQL utiliza las notaciones comunes para
los números reales, tales como -12.34 o 1.23E45.


Como se mencionó anteriormente, la consulta del tipo SELECT-FROM-WHERE busca la información de una o más relaciones que cumplan con ciertas
condiciones. Hasta ahora sólo se ha visto qué pasa si se comparan atributos de las relaciones con constantes. Pero ¿cómo se pueden comparar
los valores almacenados de  atributos que están en varias relaciones?.

El siguiente ejemplo combina dos relaciones a la hora de realizar la consulta, la que consiste en seleccionar todos los datos de las
relaciones Juegos y Ventas que sean de la compañia 'Infity Ward' y cuyas ventas sean iguales o mayores a 100.000 unidades

.. code-block:: sql

        SELECT *
        FROM Juegos, Ventas
        WHERE Juegos.StudioName = 'Infinity Ward' AND Ventas.Unidades>= 100000;

El resultado de esta consulta es el listado de los Juegos cuyo StudioName sea igual a 'Infinity Ward' y cuyas Ventas igualen o superen
las 100000 unidades.

Independientemente del tipo de consulta, el resultado de una comparación es un valor booleano, es decir retorna valores TRUE o FALSE, los
cuales se pueden combinar con sus operadores AND, OR y NOT, con sus respectivos significados.

A modo de repaso, los operadores lógicos mencionados son:

    * :sql:`AND`: Retorna TRUE siempre y cuando TODOS los atrbutos a comparar sean TRUE. Si hay AL MENOS UN valor FALSE, retornará FALSE.
            Su tabla de verdad es:

      .. math::

       \begin{array}{|c|c|c|}
        \hline
        \textbf{P} & \textbf{Q} & \textbf{AND} \\
        \hline
        True       & True       &  True   \\
        True       & False      &  False  \\
        False      & True       &  False  \\
        False      & False      &  False  \\
        \hline
       \end{array}

    * :sql:`OR`: Retorna TRUE siempre y cuando AL MENOS UNO de los atributos a comparar sea TRUE. Si TODOS los valores son FALSE, retornará FALSE.
            Su tabla de verdad es:

      .. math::

       \begin{array}{|c|c|c|}
        \hline
        \textbf{P} & \textbf{Q} & \textbf{OR} \\
        \hline
        True       & True       &  True  \\
        True       & False      &  True  \\
        False      & True       &  True  \\
        False      & False      &  False  \\
        \hline
       \end{array}

    * :sql:`NOT`: Retorna el valor contrario al valor actual, es decir que si el valor es TRUE, retorna FALSE y vice versa.
            Su tabla de verdad es

      .. math::

       \begin{array}{|c|c|c|}
        \hline
        \textbf{P} & \textbf{NOT P} \\
        \hline
        True       & False  \\
        False      & True   \\
        \hline
       \end{array}


Resultados Repetidos
~~~~~~~~~~~~~~~~~~~~~

Al realizar una consulta SELECT, no hay omisión de resultados repetidos, este "problema" se soluciona agregando DISTINCT a la consulta.

.. code-block:: sql

        SELECT FROM WHERE
        SELECT DISTINCT FROM WHERE


SQL es case insensitive, es decir que no distingue entre mayúsculas y minúsculas.
Por ejemplo, :sql:`FROM` (palabra reservada) es equivalente a :sql:`from`,
inclusive a :sql:`From`.
Los nombres de los atributos, relaciones, etc. son, también, case insensitive.
El único caso en que se distingue entre mayúsculas y minúsculas es al momento de
encerrar un string entre *' '*. Por ejemplo *'PALABRA'* es diferente a *'palabra'*.

.. The simple SQL queries that we have seen so far all have the form
.. Como ya se ha mencionado, la consulta que se está viendo en esta lectura es la más simple de SQL:

.. .. code-block:: sql
        SELECT "L"
        FROM "R"
        WHERE "C";
 En la cual "L" es una lista de expresiones, "R" es una relación y "C" es una condición. Cabe destacar que se utilizan comillas dobles y
 no simples, pues tanto "L" como "R" y "C" no corresponden a strings, sino que son representaciones.
 El resultado de cuaquier expresión de este estilo es el mismo que el de la siguiente expresión en álgebra relacional:
.. .. math::
   \pi_{L} (\theta_{C} (R))
 Eso es, se comienza con la relación expresada despues de la keyword FROM, aplicada a cada tupla cuya condición es aplicada a través de
 la keyword WHERE, y luego se proyecta en una lista de atributos y/o expresiones aplicadas mediante la keyword SELECT.
.. joao: tengo la duda de que palabra utilizar en lugar de clause (etoy sacando informacion en ingles también
  , por ejemplo "we start with the relation in the FROM clause"  )


SELECT-BY-ORDER
~~~~~~~~~~~~~~~

.. index:: SELECT-BY-ORDER

Hasta este momento, es posible obtener datos de una tabla utilizando los comandos SELECT y WHERE. Sin embargo, muchas veces es
necesario enumerar el resultado en un orden particular. Esto podría ser en orden ascendente, en orden descendente, o podría basarse en
valores numéricos o de texto. En tales casos, podemos utilizar la palabra clave ORDER BY para lograr esto.

.. code-block:: sql

        SELECT "L"
        FROM "R"
        WHERE "C"
        ORDER BY "O" [ASC, DESC];

donde:

  * "L" corresponde a la lista de atributos que se requieren, por lo general se la asocia a una(s) columna(s).
  * "R" corresponde al nombre de la relación, que por lo general se asocia a una tabla.
  * "C" corresponde a la condición de la selección.
  * "O" corresponde a cómo será ordenada la lista "L".
  * ASC corresponde a un orden ascendente (corresponde a la opción por defecto)
  * DESC corresponde a uno descendente.


Estrictamente, su sintaxis corresponde a ORDER BY y luego una lista de atributos que definirán los campos a ordenar:

.. code-block:: sql

        SELECT atributo1, atributo2 ...
        FROM Clientes ORDER BY atributo_ordenar_primero, atributo_ordenar_segundo...

Como se puede apreciar, con la sentencia ORDER BY se pueden ordenar las consultas a través de múltiples atributos. En este caso todos los
campos estarían ordenados de forma ascendente (ASC).





