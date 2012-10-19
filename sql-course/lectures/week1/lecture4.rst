Lectura 4 - Álgebra Relacional: Set operators, renaming, notation
===================================================================

Operaciones de conjunto:
------------------------

.. index:: Operaciones de conjunto:

UNIÓN
*****

En matemáticas, se denomina álgebra de conjuntos a las operaciones básicas que pueden realizarse con conjuntos, como la unión, intersección, etc. Un conjunto es una colección de objetos considerada como un objeto en sí. La unión de dos conjuntos `A` y `B` es el conjunto que contiene todos los elementos de `A` y de `B`.

.. math::
    A \cup B = B \cup A\\

.. image:: ../../../sql-course/src/union.png

De manera análoga la unión de dos relaciones `R` y `S`, es otra relación que contiene las tuplas que están en `R`, o en `S`, o en ambas, eliminándose las tuplas duplicadas. `R` y `S` deben ser unión-compatible, es decir, definidas sobre el mismo conjunto de atributo (`R` y `S` deben tener esquemas idénticos. Deben poseer las mismas columnas y su orden debe ser el mismo).

**Notación en álgebra relacional**

.. math::

    R \cup S \\

.. math::

    \text{ Si se realiza } R \cup S \text{ es lo mismo que }  S \cup R \text{ , es decir se obtiene el mismo resultado.} \\

Se puede decir entonces que el operador **UNIÓN** es conmutativo. Cabe recordar que una operación es conmutativa cuando el resultado de la operación es el mismo, cualquiera que sea el orden de los elementos con los que se opera.


Ejemplo 
^^^^^^^^
Dadas las siguientes relaciones:

.. math::
 \textbf{Tabla Ingenieros} \\

   \begin{array}{|c|c|c|}
        \hline
         \textbf{ID} & \textbf{Nombre} & \textbf{Edad}\\
        \hline
        123 & \text{Leon}   & 39\\
        \hline
        234 & \text{Tomas}  & 34\\
        \hline
        345 & \text{Jose}   & 45\\
        \hline
        143 & \text{Josefa} & 25\\
        \hline
   \end{array}

.. math::
 \textbf{Tabla Jefes} \\

      \begin{array}{|c|c|c|}
        \hline
         \textbf{ID} & \textbf{Nombre} & \textbf{Edad}\\
        \hline
        123 & \text{Leon}   & 39\\
        \hline
        235 & \text{Maria}   & 29\\
        \hline
      \end{array}

Aplicar el operador **UNIÓN**:

.. math::

 \textbf{Tabla Ingenieros} \cup  \textbf{Jefes}  \\

   \begin{array}{|c|c|c|}
        \hline
         \textbf{ID} & \textbf{Nombre} & \textbf{Edad}\\
        \hline
        123 & \text{Leon}   & 39\\
        \hline
        234 & \text{Tomas}  & 34\\
        \hline
        345 & \text{Jose}   & 45\\
        \hline
        143 & \text{Josefa} & 25\\
        \hline
        235 & \text{Maria} & 29\\
        \hline
   \end{array}

Como se mencionó anteriormente realizar la operación: 

.. math::
	\text{Jefes} \cup \text{Ingenieros}

Daría como resultado la misma tabla anterior, debido a la propiedad de conmutatividad.

DIFERENCIA
**********

Volviendo a la analogía de álgebra de conjuntos, la diferencia entre dos conjuntos `A` y `B` es el conjunto que contiene todos los elementos de `A` que no pertenecen a `B`.

A-B

.. image:: ../../../sql-course/src/a-b.png

B-A

.. image:: ../../../sql-course/src/b-a.png

Como se aprecia en las imágenes la operación **DIFERENCIA**, en conjuntos, no es conmutativa, al igual que la resta o sustracción, operador aprendido en aritmética básica. Es decir, si se cambia el orden de los conjuntos a los  que se aplica la operación **DIFERENCIA**, se obtendrán resultados distintos. Por lo tanto:

.. math::
    \text{A} \times \text{B} \neq  \text{B} \times \text{A}    


De la misma forma la diferencia de dos relaciones `R` y `S`, es otra relación que contiene las tuplas que están en la relación `R`, pero no están en `S`.
`R` y `S` deben ser unión-compatible.

**Notación en álgebra relacional**

.. math::

    R - S

Es importante resaltar que `R - S` es diferente a `S - R`.


Ejemplo 
^^^^^^^^

Empleando las mismas tablas dadas en el ejemplo anterior, realice Ingenieros
``-`` Jefes y Jefes ``-`` Ingenieros:

Ingenieros ``-`` Jefes

.. math::

   \begin{array}{|c|c|c|}
        \hline
         \textbf{ID} & \textbf{Nombre} & \textbf{Edad}\\
        \hline
        234 & \text{Tomas}  & 34\\
        \hline
        345 & \text{Jose}   & 45\\
        \hline
        143 & \text{Josefa} & 25\\
        \hline
   \end{array}

Jefes ``-`` Ingenieros

.. math::

   \begin{array}{|c|c|c|}
        \hline
        \textbf{ID} & \textbf{Nombre} & \textbf{Edad}\\
        \hline
        235 & \text{Maria} & 29\\
        \hline
   \end{array}

Como se puede apreciar, ambas operaciones dieron como resultado distintas relaciones, tal como se había mencionado anteriormente.

INTERSECCIÓN
************

En  álgebra de conjuntos la intersección de dos conjuntos `A` y `B` es el conjunto que contiene todos los elementos comunes de `A` y `B`. 

.. math::
    A \cap B

.. image:: ../../../sql-course/src/inter.png

De forma homóloga en álgebra relacional INTERSECTION define una relación que contiene las tuplas que están tanto en la relación `R` como en `S`. `R` y `S` deben ser unión-compatible.

**Notación en algebra relacional**

.. math::
    R \cap S

.. math::
    \text{ Si se realiza } R \cap S \text{ es lo mismo que }  S \cap R \text{ , es decir se obtiene el mismo resultado} \\

**Equivalencia con operadores anteriores**

.. math::
    R \cap S= R-(R-S)

Ejemplo 
^^^^^^^^

Utilizando las mismas tablas del ejemplo anterior, encontrar la intersección de la tabla de Ingenieros con la de Jefes:

.. math::
    Ingenieros \cap Jefes

      \begin{array}{|c|c|c|}
        \hline
         \textbf{ID} & \textbf{Nombre} & \textbf{Edad}\\
        \hline
        123 & \text{Leon}   & 39\\
        \hline
      \end{array}

.. important::

   Cuando aplicamos estas operaciones a relaciones, necesitamos poner algunas condiciones `R` y `S`:

      * `R` y `S` deben tener esquemas con conjuntos de atributos idénticos, y de tipos (dominios) para cada atributo deben ser las mismas en `R` y `S`.
      * Antes de computar el conjunto-teórico unión, intersección, o diferencia de conjuntos de tuplas, las columnas de `R` y `S` deben ser ordenadas para que el orden de los atributos sean los mismos para ambas relaciones.

OPERACIONES DEPENDIENTES Y INDEPENDIENTES
*****************************************

Algunas de las operaciones que hemos descrito en las lecturas 3 y 4, pueden ser expresadas en términos de operadores de algebra relacional. 
Por ejemplo, la intersección puede ser expresada en términos de conjuntos de diferencia: R <INTERSECCCIÓN> S = R - (R - S). Es decir, si `R` y `S` son dos relaciones con el mismo esquema, la intersección de `R` y `S` puede ser resuelta restando primero `S` de `R` para formar una relación `T` que consiste en todas aquellas tuplas en `R` pero no en `S`. Cuando restamos `T` de `R`, dejamos solo esas tuplas de `R` que están también en `S`.


ÁLGEBRA RELACIONAL COMO IDIOMA RESTRICTOR
*****************************************

Hay dos maneras en las cuales podemos usar expresiones de algebra relacional para expresar restricción:

   1. Si `R` es una expresión de algebra relacional, entonces `R = 0` es una restricción que dice “El valor de R debe ser vacio,” o equivalentemente “No hay tuplas en el resultado de `R`."
   2. Si `R` y `S` son expresiones de algebra relacional, entonces `R \subset S` es una restricción que dice “Cada tupla en resultado de R debe estar también en resultado de S." Por supuesto, el resultado de `S` puede contener tuplas adicionales no producidas en `R`.

Estas formas para expresar restricción son de hecho equivalentes en lo que pueden expresar, pero algunas veces uno de los dos es más clara o más sucinta. Es decir, la restricción `R \subset S` pudo también ser escrito `R - S = 0`. Para ver por qué, observe que si cada tupla en `R` está también en `S`, entonces seguramente `R - S` es vacío. A la inversa, si `R - S` no contiene tuplas, entonces cada tupla en `R` debe estar en `S` (o de lo que sería `R - S`).

Por otra parte, una restricción de la primera forma, `R = 0`, también pudo haber sido escrita como `R \subset 0`. Técnicamente, `0` no es una expresión de algebra relacional, pero ya que hay expresiones que evalúan a `0`, tal como `R - R`, no hay nada malo en usar `0` como una expresión de algebra relacional. Tenga en cuenta que estas equivalencias sostienen se sostienen incluso si `R` y `S` son bolsas, dado que hacemos la interpretación convencional de `R \subset S`: cada tupla `t` aparece en `S` al menos tantas veces como aparece en `R`.


EJERCICIOS PROPUESTOS
*********************

Ejercicio 1
^^^^^^^^^^^^
Las relaciones base que forman la base de datos de un video club son las siguientes:

* SOCIO(**codsocio**,nombre,direccion,telefono)

* PELICULA(**codpeli**,titulo,genero)

* CINTA(**codcinta**,codpeli)

* PRESTAMO(**codsocio,codcinta,fecha**,pres_dev)

* LISTA_ESPERA(**codsocio,codpeli**,fecha)

SOCIO: almacena los datos de cada uno de los socios del video club: código del socio, nombre, dirección y teléfono.

PELÍCULA: almacena información sobre cada una de las películas de las cuales tiene copias el vídeo club: código de la película, título y género (terror, comedia, etc.).

CINTA: almacena información referente a las copias que hay de cada película (copias distintas de una misma película tendrán distinto código de cinta).

PRÉSTAMO: almacena información de los préstamos que se han realizado. Cada préstamo es de una cinta a un socio en una fecha. Si el préstamo aún no ha finalizado, pres_dev tiene el valor 'prestada'; si no su valor es 'devuelta'.

LISTA_ESPERA: almacena información sobre los socios que esperan a que haya copias disponibles de películas, para tomarlas prestadas. Se guarda también la fecha en que comenzó la espera para mantener el orden. Es importante tener en cuenta que cuando el socio consigue la película esperada, éste desaparece de la lista de espera.

En las relaciones anteriores, son claves primarias los atributos y grupos de atributos que aparecen en negrita. Las claves ajenas se muestran en los siguientes diagramas referenciales:

Resolver las siguientes consultas mediante el álgebra relacional (recuerde que en la lectura 3 también se dieron algunos operadores de álgebra relacional):

1.1. Seleccionar todos los socios que se llaman: "Charles".

**Respuesta**

.. math::
    \sigma_{\text{nombre='Charles'}} \text{(SOCIO)}

1.2. Seleccionar el código socio de todos los socios que se llaman: "Charles".

**Respuesta**

.. math::
    \pi_{\text{codsocio}}(\sigma_{\text{nombre='Charles'}} \text{(SOCIO))}

1.3. Seleccionar los nombres de las películas que se encuentran en lista de espera.

**Respuesta**

.. math::
    \pi_{\text{titulo}}(\text{PELICULA} \rhd \hspace{-0.1cm} \lhd \text{LISTA ESPERA})


1.4. Obtener los nombres de los socios que esperan películas.

**Respuesta**

.. math::
    \pi_{\text{nombre}}(\text{SOCIO} \rhd \hspace{-0.1cm} \lhd \text{LISTA ESPERA})

1.5. Obtener los nombres de los socios que tienen actualmente prestada una película que ya tuvieron prestada con anterioridad.

**Respuesta**

.. math::
    \pi_{\text{nombre}} ( \{(\text{PRESTAMO} \rhd \hspace{-0.1cm} \lhd_{ (\text{pres_dev='prestada'})} \text{CINTA}) \cap (\text{PRESTAMO} \rhd \hspace{-0.1cm} \lhd_{(\text{pres_dev='devuelta'})} \text{CINTA})\} \rhd \hspace{-0.1cm}\lhd \text{SOCIO})


1.6. Obtener los títulos de las películas que nunca han sido prestadas.

**Respuesta**

.. math::
    \pi_{\text{titulo}} \{(\pi_{\text{codpeli}} \text{PELICULA}  - \pi_{\text{codpeli}} (\text{PRESTAMO} \rhd \hspace{-0.1cm} \lhd \text{CINTA}) ) \rhd \hspace{-0.1cm} \lhd \text{PELICULA}\}

(todas las películas) menos (las películas que han sido prestadas alguna vez)

1.7. Obtener los nombres de los socios que han tomado prestada la película “WALL*E” alguna  vez o que están esperando para tomarla prestada.

**Respuesta**

.. math::
    \pi_{\text{codsocio,nombre}}((\text{SOCIO} \rhd \hspace{-0.1cm} \lhd \text{PRESTAMO} \rhd \hspace{-0.1cm} \lhd \text{CINTA} \rhd \hspace{-0.1cm} \lhd_{\text{titulo='WALL*E'}} \text{PELICULA}) \cup \\ (\text{SOCIO} \rhd \hspace{-0.1cm} \lhd \text{LISTA_ESPERA} \rhd \hspace{-0.1cm} \lhd_{\text{titulo='WALL*E'}} \text{PELICULA}) )

1.8. Obtener los nombres de los socios que han tomado prestada la película “WALL*E” alguna vez y que además están en su lista de espera.

**Respuesta**

.. math::
    \pi_{\text{codsocio,nombre}}((\text{SOCIO} \rhd \hspace{-0.1cm} \lhd \text{PRESTAMO} \rhd \hspace{-0.1cm} \lhd \text{CINTA} \rhd \hspace{-0.1cm} \lhd_{\text{titulo='WALL*E'}} \text{PELICULA}) \cap \\ (\text{SOCIO} \rhd \hspace{-0.1cm} \lhd \text{LISTA_ESPERA} \rhd \hspace{-0.1cm} \lhd_{\text{titulo='WALL*E'}} \text{PELICULA}) )

Ejercicio 2
^^^^^^^^^^^^

Considere la base de datos con el siguiente esquema:

 1. Persona (nombre, edad, genero); nombre es la clave.
 2. Frecuenta (nombre, pizzeria): (nombre, pizzeria) es la clave.
 3. Come (nombre, pizza): (nombre, pizza) es la clave.
 4. Sirve (pizzería, pizza, precio): (pizzería, pizza) es la clave.

Escribir las expresiones de álgebra relacional para las siguientes nueve consultas. (Precaución: algunas de las siguientes consultas son un poco desafiantes).

 * Encuentre todas las pizzerías frecuentadas por al menos una persona menor de 18 años.
 * Encuentre los nombres de todas las mujeres que comen pizza ya sea con champiñones o salchichón (o ambas).
 * Encuentre los nombres de todas las mujeres que comen pizzas con los dos ingredientes, champiñones y salchichón. 
 * Encuentre todas las pizzerías que sirven al menos una pizza que Amy come por menos de 10 dólares. 
 * Encuentre todas las pizzerías que son frecuentadas por solo mujeres o solo hombres. 
 * Para cada persona, encuentre todas las pizzas que la persona come, que no son servidas por ninguna pizzería que la persona frecuenta. Devuelve toda dicha persona (nombre)/ pizza pares.
 * Encuentre los nombres de todas las personas que frecuentan solo pizzerías que sirven al menos una pizza que ellos comen.
 * Encuentre la pizzería que sirve la pizza más barata de salchichón. En el caso de empate, vuelve todas las pizzerías que venden las pizzas de salchichón más baratas. 
