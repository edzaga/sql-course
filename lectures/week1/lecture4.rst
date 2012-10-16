Lectura 4 - Algebra Relacional: Set operators, renaming, notation
===================================================================

Conceptos básicos de álgebra relacional
---------------------------------------

.. index:: basics of relational algebra

Algebra, en general, consiste de operadores y operandos atómicos. Por ejemplo, een el álgebra de la aritmética, los operandos atómicos son variable como `r`, y constantes como 15. 
Los operadores son los usuales en la aritmética:

  * Suma
  * Resta
  * Multiplicación
  * División.

Cualquier álgebra nos permite construir expresiones mediante la aplicación de operadores a operandos atómicos y/o otras expresiones del álgebra. En general, los paréntesis son necesarios para agrupar operadores y sus operandos. Por ejemplo, en aritmética tenemos expresiones tales como `(x + y) * z` ó `((x + 7)/(y - 3)) + x`.

El Álgebra Relacional es otro ejemplo del álgebra. Sus operandos atómicos son: 

   1. Variables que representan relaciones.
   2. Constantes que son relaciones finitas.

Como mencionamos, en el álgebra relacional clásica, todos los operandos y sus resultados de expresiones son conjuntos. Los operadores del álgebra relacional tradicional se divide en cuatro grandes categorías: 

  a. Los conjuntos habituales de operaciones –unión, intersección, y diferencia- se aplica a las relaciones. 
  b. Las operaciones que eliminan parte de una relación: “selección” elimina algunas filas (tuplas), y “proyección” elimina algunas columnas.
  c. Las operaciones que combinan las tuplas de dos relaciones, como el “producto cartesiano,” que empareja las tuplas de dos relaciones en todas las maneras posibles y varios tipos de operadores “unión”, los cuales forman parejas de tuplas de dos relaciones selectivamente.
  d. Una operación llama “renombrar” que no afecta las tuplas de una relación, pero que cambia el esquema de relación, es decir, lo nombres de los atributos y/o los nombres de la relación misma.

Debemos por lo general referirnos a las expresiones del álgebra relacional como consultas. 
A pesar de que aún no tengan los símbolos necesarios para mostrar muchas de las expresiones del algebra relacional, se debería familiarizar con las operaciones de grupo `(a)`; y por lo tanto reconocer `(R U S)` como un ejemplo de una expresión de álgebra relacional.
`R` y `S` son operandos atómicos para relaciones, cuyos conjuntos de tuplas son desconocidas. 
Esta consulta pregunta por la unión de cualquiera tuplas que están en las relaciones nombradas `R` y `S`.

Las tres operaciones más comunes en conjuntos son unión, intersección, y diferencia. 
Las cuales se definen como los siguientes conjuntos arbitrarios `R` y `S`:

.. role:: sql(code)
   :language: sql
   :class: highlight

Operaciones de conjunto:
------------------------

.. index:: Operaciones de conjunto:

UNIÓN
*****

En matemáticas, se denomina álgebra de conjuntos a las operaciones básicas que pueden realizarse con conjuntos, como la unión, intersección, etc. Un conjunto es una colección de objetos considerada como un objeto en sí. La unión de dos conjuntos A y B es el conjunto que contiene todos los elementos de A y de B.

De manera análoga la unión de dos relaciones `R` y `S`, es otra relación que contiene las tuplas que están en `R`, o en `S`, o en ambas, eliminándose las tuplas duplicadas. `R` y `S` deben ser unión-compatible, es decir, definidas sobre el mismo conjunto de atributo (`R` y `S` deben tener esquemas idénticos. Deben poseer las mismas columnas y su orden debe ser el mismo).

**Notación en álgebra relacional**

.. math::

    R \cup S \\

.. math::

    \textrm{ Si se realiza } R \cup S \textrm{ es lo mismo que }  S \cup R \textrm{ , es decir se obtiene el mismo resultado} \\

Ejemplo 1
^^^^^^^^^
Dadas las siguientes relaciones:


**Tabla Ingenieros**

.. math::

   \begin{array}{|c|c|c|}
        \hline
         \textbf{ID} & \textbf{Nombre} & \textbf{Edad}\\
        \hline
        123 & \mbox{Leon}   & 39\\
        \hline
        234 & \mbox{Tomas}  & 34\\
        \hline
        345 & \mbox{Jose}   & 45\\
        \hline
        143 & \mbox{Josefa} & 25\\
        \hline
   \end{array}

..    ==== ====== ====
..    ID   Nombre Edad
..    ==== ====== ====
..    123  León    39
..         234  Tomás   34
..         345  José    45
..         143  Josefa  25
..         ==== ====== ====

**Tabla Jefes**

.. math::
      \begin{array}{|c|c|c|}
        \hline
         \textbf{ID} & \textbf{Nombre} & \textbf{Edad}\\
        \hline
        123 & \mbox{Leon}   & 39\\
        \hline
        235 & \mbox{Maria}   & 29\\
        \hline
      \end{array}

..         ==== ====== ====
         ID   Nombre Edad
         ==== ====== ====
         123  León   39
         235  María  29
         ==== ====== ====

Aplicar el operador Unión:

Ingenieros ``U`` Jefes


.. math::

   \begin{array}{|c|c|c|}
        \hline
         \textbf{ID} & \textbf{Nombre} & \textbf{Edad}\\
        \hline
        123 & \mbox{Leon}   & 39\\
        \hline
        234 & \mbox{Tomas}  & 34\\
        \hline
        345 & \mbox{Jose}   & 45\\
        \hline
        143 & \mbox{Josefa} & 25\\
        \hline
        235 & \mbox{Maria} & 29\\
        \hline
   \end{array}


..    ==== ====== ====
..    ID   Nombre Edad
..    ==== ====== ====
..    123  León   39
..    234  Tomás  34
..    345  José   45
..    143  Josefa 25
..    235  María  29
..    ==== ====== ====

Como se mencionó anteriormente realizar la operación Jefes ``U`` Ingenieros daría como resultado la misma tabla anterior.

DIFERENCIA
**********

Volviendo a la analogía de álgebra de conjuntos, la diferencia entre dos conjuntos A y B es el conjunto que contiene todos los elementos de A que no pertenecen a B.
De la misma forma la diferencia de dos relaciones `R` y `S`, es otra relación que contiene las tuplas que están en la relación `R`, pero no están en `S`.
`R` y `S` deben ser unión-compatible.

**Notación en álgebra relacional**

.. math::

    R - S

Es importante resaltar que `R - S` es diferente a `S - R`.

Ejemplo 2
^^^^^^^^^

Empleando las mismas tablas dadas en el ejemplo anterior, realice Ingenieros
``-`` Jefes y Jefes ``-`` Ingenieros:

Ingenieros ``-`` Jefes

.. math::

   \begin{array}{|c|c|c|}
        \hline
         \textbf{ID} & \textbf{Nombre} & \textbf{Edad}\\
        \hline
        234 & \mbox{Tomas}  & 34\\
        \hline
        345 & \mbox{Jose}   & 45\\
        \hline
        143 & \mbox{Josefa} & 25\\
        \hline
   \end{array}


..    ==== ====== ====
..    ID   Nombre Edad
..    ==== ====== ====
..    234  Tomás   34
..    345  José    45
..    143  Josefa  25
..    ==== ====== ====

Jefes ``-`` Ingenieros

.. math::

   \begin{array}{|c|c|c|}
        \hline
        \textbf{ID} & \textbf{Nombre} & \textbf{Edad}\\
        \hline
        235 & \mbox{Maria} & 29\\
        \hline
   \end{array}


..    ==== ====== ====
..    ID   Nombre Edad
..    ==== ====== ====
..    235  María  29
..    ==== ====== ====

Como se puede apreciar, ambas operaciones dieron como resultado distintas relaciones, tal como se había mencionado anteriormente.

INTERSECCIÓN
************

En  álgebra de conjuntos la intersección de dos conjuntos A y B es el conjunto que contiene todos los elementos comunes de A y B. De forma homóloga en álgebra relacional INTERSECTION define una relación que contiene las tuplas que están tanto en la relación `R` como en `S`. `R` y `S` deben ser unión-compatible.

**Notación en algebra relacional**

.. math::
    R \cap S

.. math::
    \textrm{ Si se realiza } R \cap S \textrm{ es lo mismo que }  S \cap R \textrm{ , es decir se obtiene el mismo resultado} \\

**Equivalencia con operadores anteriores**

.. math::
    R \cap S= R-(R-S)

Ejemplo 3
*********

Utilizando las mismas tablas del ejemplo anterior, encontrar la intersección de la tabla de Ingenieros con la de Jefes:

.. math::
    Ingenieros \cap Jefes

      \begin{array}{|c|c|c|}
        \hline
         \textbf{ID} & \textbf{Nombre} & \textbf{Edad}\\
        \hline
        123 & \mbox{Leon}   & 39\\
        \hline
      \end{array}

..    ==== ====== ====
    ID   Nombre Edad
    ==== ====== ====
    123  León   39
    ==== ====== ====


.. important::

   Cuando aplicamos estas operaciones a relaciones, necesitamos poner algunas condiciones R y S:

      * `R` y `S` deben tener esquemas con conjuntos de atributos idénticos, y de tipos (dominios) para cada atributo deben ser las mismas en `R` y `S`.
      * Antes de computar el conjunto-teórico unión, intersección, o diferencia de conjuntos de tuplas, las columnas de `R` y `S` deben ser ordenadas para que el orden de los atributos sean los mismos para ambas relaciones.

OPERACIONES DEPENDIENTES Y INDEPENDIENTES
*****************************************

Algunas de las operaciones que hemos descrito en las lecturas 3 y 4, pueden ser expresadas en términos de operadores de algebra relacional. 
Por ejemplo, la intersección puede ser expresada en términos de conjuntos de diferencia: R <INTERSECCCIÓN> S = R - (R - S). Es decir, si R y S son dos relaciones con el mismo esquema, la intersección de R y S puede ser resuelta restando primero S de R para formar una relación T que consiste en todas aquellas tuplas en R pero no en S. Cuando restamos T de R, dejamos solo esas tuplas de R que están también en S.


ÁLGEBRA RELACIONAL COMO IDIOMA RESTRICTOR
*****************************************

Hay dos maneras en las cuales podemos usar expresiones de algebra relacional para expresar restricción:

   1. If `R` is an expression of relational algebra, then `R = 0` is a constraint that says
      "The value of R must be empty," or equivalently "There are no tuples in the result of R."
   2. If `R` and `S` are expressions of relational algebra, then `R \subset S` is a constraint
      that says "Every tuple in the result of R must also be in the result of S."
      Of course the result of `S` may contain additional tuples not produced by `R`.

These ways of expressing constraints are actually equivalent in what they can express,
but sometimes one or the other is clearer or more succinct.
That is, the constraint `R \subset S` could just as well have been written `R - S = 0`.
To see why, notice that if every tuple in `R` is also in `S`, then surely `R - S` is empty.
Conversely, if `R - S` contains no tuples, then every tuple in `R` must be in `S`
(or else it would be in `R - S`).

On the other hand, a constraint of the first form, `R = 0`, could just as well have been written
`R \subset 0`.
Technically, `0` is not an expression of relational algebra, but since there are expressions
that evaluate to `0`, such as `R - R`, there is no harm in using `0` as a relational-algebra
expression.
Note that these equivalences hold even if `R` and `S` are bags, provided we make the conventional
interpretation of `R \subset S`: each tuple **t** appears in `S` at least as many times as it
appears in `R`.


Exercises
**********

Ejercicio 1
^^^^^^^^^^^^
Las relaciones base que forman la base de datos de un video club son las siguientes:

* SOCIO(**codsocio**,nombre,direccion,telefono)

* PELICULA(**codpeli**,titulo,genero)

* CINTA(**codcinta**,codpeli)

* PRESTAMO(**codsocio,codcinta,fecha**,pres_dev)

* LISTA_ESPERA(**codsocio,codpeli**,fecha)

SOCIO: almacena los datos de cada uno de los socios del video club: código del
socio, nombre, dirección y teléfono.

PELÍCULA: almacena información sobre cada una de las películas de las cuales tiene
copias el vídeo club: código de la película, título y género (terror, comedia, etc.).

CINTA: almacena información referente a las copias que hay de cada película
(copias distintas de una misma película tendrán distinto código de cinta).

PRÉSTAMO: almacena información de los préstamos que se han realizado. Cada préstamo
es de una cinta a un socio en una fecha. Si el préstamo aún no ha finalizado,
pres_dev tiene el valor 'prestada'; si no su valor es 'devuelta'.

LISTA_ESPERA: almacena información sobre los socios que esperan a que haya copias
disponibles de películas, para tomarlas prestadas. Se guarda también la fecha en
que comenzó la espera para mantener el orden. Es importante tener en cuenta que
cuando el socio consigue la película esperada, éste desaparece de la lista de espera.

En las relaciones anteriores, son claves primarias los atributos y grupos de
atributos que aparecen en negrita. Las claves ajenas se muestran en los siguientes
diagramas referenciales:

Resolver las siguientes consultas mediante el álgebra relacional (recuerde que en
la lectura 3 también se dieron algunos operadores de álgebra relacional):

1.1. Seleccionar todos los socios que se llaman: "Charles".

**Respuesta**

.. math::
    \sigma_{nombre='Charles'} (SOCIO)

1.2. Seleccionar el código socio de todos los socios que se llaman: "Charles".

**Respuesta**

.. math::
    \pi_{codsocio}(\sigma_{nombre='Charles'} (SOCIO))

1.3. Seleccionar los nombres de las películas que se encuentran en lista de espera.

**Respuesta**

.. math::
    \pi_{titulo}(PELICULA \rhd \hspace{-0.1cm} \lhd LISTA\_ESPERA)


1.4. Obtener los nombres de los socios que esperan películas.

**Respuesta**

.. math::
    \pi_{nombre}(SOCIO \rhd \hspace{-0.1cm} \lhd LISTA\_ESPERA)

1.5. Obtener los nombres de los socios que tienen actualmente prestada una película
que ya tuvieron prestada con anterioridad.

**Respuesta**

.. math::
    \pi_{nombre} ( \{(PRESTAMO \rhd \hspace{-0.1cm} \lhd_{ (pres\_dev='prestada')} CINTA) \cap (PRESTAMO \rhd \hspace{-0.1cm} \lhd_{(pres\_dev='devuelta')} CINTA)\} \rhd \hspace{-0.1cm}\lhd SOCIO )


1.6. Obtener los títulos de las películas que nunca han sido prestadas.

**Respuesta**

.. math::
    \pi_{titulo} \{(\pi_{codpeli} PELICULA  - \pi_{codpeli} (PRESTAMO \rhd \hspace{-0.1cm} \lhd CINTA) ) \rhd \hspace{-0.1cm} \lhd PELICULA \}

(todas las películas) menos (las películas que han sido prestadas alguna vez)

1.7. Obtener los nombres de los socios que han tomado prestada la película
“WALL*E” alguna  vez o que están esperando para tomarla prestada.

**Respuesta**

.. math::
    \pi_{codsocio,nombre}((SOCIO \rhd \hspace{-0.1cm} \lhd PRESTAMO \rhd \hspace{-0.1cm} \lhd CINTA \rhd \hspace{-0.1cm} \lhd_{titulo='WALL*E'} PELICULA) \cup \\ (SOCIO \rhd \hspace{-0.1cm} \lhd LISTA\_ESPERA \rhd \hspace{-0.1cm} \lhd_{ titulo='WALL*E'} PELICULA) )

1.8. Obtener los nombres de los socios que han tomado prestada la película
“WALL*E” alguna vez y que además están en su lista de espera.

**Respuesta**

.. math::
    \pi_{codsocio,nombre}((SOCIO \rhd \hspace{-0.1cm} \lhd PRESTAMO \rhd \hspace{-0.1cm} \lhd CINTA \rhd \hspace{-0.1cm} \lhd_{titulo='WALL*E'} PELICULA) \cap \\ (SOCIO \rhd \hspace{-0.1cm} \lhd LISTA\_ESPERA \rhd \hspace{-0.1cm} \lhd_{ titulo='WALL*E'} PELICULA) )

Ejercicio 2
^^^^^^^^^^^^

 Considere la siguiente base de datos:

   1. Person ( name, age, gender ) : name is a key
   2. Frequents ( name, pizzeria ) : (name, pizzeria) is a key
   3. Eats ( name, pizza ) : (name, pizza) is a key
   4. Serves ( pizzeria, pizza, price ): (pizzeria, pizza) is a key

Write relational algebra expressions for the following nine queries. (Warning: some of the later queries are a bit challenging.)

   * Find all pizzerias frequented by at least one person under the age of 18.
   * Find all pizzerias that serve at least one pizza that Amy eats for less than $10.00.
   * Find all pizzerias that are frequented by only females or only males.
   * For each person, find all pizzas the person eats that are not served by any pizzeria the person frequents. Return all such person (name) / pizza pairs.
   * Find the names of all people who frequent only pizzerias serving at least one pizza they eat.
   * Find the names of all people who frequent every pizzeria serving at least one pizza they eat.
   * Find the pizzeria serving the cheapest pepperoni pizza. In the case of ties, return all of the cheapest-pepperoni pizzerias.
