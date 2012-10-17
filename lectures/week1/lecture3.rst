Lectura 3 - Álgebra Relacional: Select, Project, Join
-------------------------------------------------------

El Álgebra Relacional se define como un conjunto de operaciones que se ejecutan
sobre las relaciones (tablas) para obtener un resultado, el cual es otra relación.


Operaciones relacionales:
~~~~~~~~~~~~~~~~~~~~~~~~~~

.. index:: relational operators

Los operadores relacionales se utilizan para filtrar, cortar o combinar tablas.

SELECT
******

Este operador se aplica a una relación R produciendo una nueva relación con un
subconjunto de tuplas de R. Las tuplas de la relación resultante son las que
satisfacen una condición C sobre algún atributo de R. Es decir selecciona **filas**
de una tabla según un cierto criterio C. C es una expresión condicional, similar
a las declaraciones del tipo “if”, es “booleana” esto quiere decir que para cada
tupla de R toma el valor Verdad o Falso.

* Valores de atributos con NULL no cumplirán ninguna condición.

* Cada condición simple o cláusula C tiene el formato:

.. math::
    \mbox{<Atributo> <Comparador> <Atributo o Constante del Dominio>} \\

        \mbox{Donde:} \\

    \mbox{<Comparador>}  \in {\{=,\geq,>,<, \neq,\leq \}}\\

* Las cláusulas C pueden conectarse con los operadores lógicos:

  * **NOT**: El operador NOT denota una salida verdadera si la entrada es falsa, 
    y una salida falsa si la entrada es verdadera.

  * **AND**: El operador AND denota una salida verdadera si y sólo si sus entradas 
   son verdaderas.

  * **OR**: El operador OR denota una salida verdadera si hay alguna de las entradas
    (o ambas) verdaderas.

**Notación en Álgebra Relacional**

Para representar SELECT en álgebra relacional se utiliza la letra griega sigma:

.. math::

    \sigma_{c} \hspace{0.2cm} \mbox{R}

Se aplica la condición C a cada tupla de R. Si la condición es Verdad (true),
dicha tupla pertenecerá al resultado y si es Falsa (false), dicha tupla no será seleccionada. 
El esquema de la relación resultante es el mismo esquema R, se muestran los
atributos en el mismo orden que se usan en la tabla R.

Ejemplo 1
^^^^^^^^^

.. math::

 \textbf{Tabla Ingenieros} \\

   \begin{array}{|c|c|c|c|}
    \hline
    \textbf{ID} & \textbf{Nombre} & \textbf{Edad} & \textbf{Años_trabajados(AT)}\\
    \hline
    123 & \mbox{Leon} & 39 & 15 \\
    \hline
    234 & \mbox{Tomas} & 34 & 10 \\
    \hline
    345 & \mbox{Jose} & 45 & 21 \\
    \hline
    143 & \mbox{Josefa} & 25 &  1 \\
    \hline
  \end{array}

Seleccionar las tuplas de la tabla **Ingenieros** que cumplan con tener una edad
mayor a 30 años:

**Respuesta**

.. math::
     \sigma_{edad>30} \hspace{0.2cm} \mbox{Ingenieros}


Así quedaría la tabla:

.. math::

 \textbf{Tabla Ingenieros} \\

   \begin{array}{|c|c|c|c|}
    \hline
    \textbf{ID} & \textbf{Nombre} & \textbf{Edad} & \textbf{Años_trabajados(AT)}\\
    \hline
    123 & \mbox{Leon} & 39 & 15 \\
    \hline
    234 & \mbox{Tomas} & 34 & 10 \\
    \hline
    345 & \mbox{Jose} & 45 & 21 \\
    \hline
  \end{array}

Ejemplo 2
^^^^^^^^^

Seleccionar de la tabla **Ingenieros** las personas que tienen más de 30 años
y que lleven menos de 16 años trabajando:

**Respuesta**

.. math::
    \sigma_{edad >30 \wedge AT <16}  \hspace{0.3cm}  \mbox{Ingenieros}

Así finalmente quedaría la tabla:

.. math::

 \textbf{Tabla Ingenieros} \\

 \begin{array}{|c|c|c|c|}
  \hline
  \textbf{ID} & \textbf{Nombre} & \textbf{Edad} & \textbf{Años_trabajados(AT)} \\
  \hline
  123 & \mbox{Leon} & 39 & 15 \\
  \hline
  234 & \mbox{Tomas} & 34 & 10 \\
  \hline
 \end{array}

PROJECT
*******

El operador PROJECT se utiliza para producir una nueva relación desde R. Esta
nueva relación contiene sólo algunos de los atributos de R,
es decir, realiza la selección de algunas de las **columnas** de una tabla R.

**Notación en Álgebra Relacional**

PROJECT en Álgebra Relacional se representa por la letra griega **pi**:

.. math::
       \pi \hspace{0.2cm} _{(A_1,...,A_n)} \hspace{0.3cm} \mbox{R}

El resultado es una relación seleccionando solo los atributos `A_1,...,A_n` de la
relación R.
Si `A_1,...,A_n` no incluye una llave (o clave), podrían producirse tuplas
repetidas en el resultado, las cuales serán eliminadas.

Ejemplo 1
^^^^^^^^^
.. math::

 \textbf{Tabla Ingenieros} \\ 

 \begin{array}{|c|c|c|c|}
  \hline
  \textbf{ID} & \textbf{Nombre} & \textbf{Edad} & \textbf{Años_trabajados(AT)} \\
  \hline
  123 & \mbox{Leon} & 39 & 15 \\
  \hline
  234 & \mbox{Tomas} & 34 & 10 \\
  \hline
  345 & \mbox{Jose} & 45 & 21 \\
  \hline
  143 & \mbox{Josefa} & 25 & 1 \\
  \hline
 \end{array}

Escoger columnas de ID y nombre de la tabla de ingenieros:

**Respuesta**

.. math::
           \pi \hspace{0.2cm}_{(ID,Nombre)} \hspace{0.3cm} \mbox{Ingenieros}

La tabla finalmente queda como:

.. math::

 \textbf{Tabla Ingenieros}  \\ 

 \begin{array}{|c|c|}
  \hline
  \textbf{ID} & \textbf{Nombre} \\
  \hline
  123 & \mbox{Leon} \\
  \hline
  234 & \mbox{Tomas} \\
  \hline
  345 & \mbox{Jose} \\
  \hline
  143 & \mbox{Josefa} \\
  \hline
 \end{array}

Ejemplo 2
^^^^^^^^^

Seleccionar ID y nombre de los Ingenieros que tienen más de 30 años.

**Respuesta**

.. math::
       \pi \hspace{0.2cm} _{(\mbox{ID,Nombre})} (\sigma_{edad>30} \hspace{0.3cm} \mbox{Ingenieros})

Finalmente la tabla queda de la siguiente manera:

.. math::

 \textbf{Tabla Ingenieros} \\

 \begin{array}{|c|c|}
  \hline
  \textbf{ID} & \textbf{Nombre} \\
  \hline
  123 & \mbox{Leon} \\
  \hline
  234 & \mbox{Tomas} \\
  \hline
  345 & \mbox{Jose} \\
  \hline
 \end{array}


CROSS-PRODUCT
*************

En teoría de conjuntos, el producto cartesiano de dos conjuntos es una operación
que resulta en otro conjunto cuyos elementos son todos los pares ordenados que
pueden formarse tomando el primer elemento del par del primer conjunto,
y el segundo elemento del segundo conjunto. En el Álgebra Relacional se mantiene
esta idea con la diferencia que R y S son relaciones, entonces los miembros de R
y S son tuplas, que generalmente consisten de más de un componente,
cuyo resultado de la vinculación de una tupla de R con una tupla de S es una tupla
más larga, con un componente para cada uno de los componentes de las tuplas
constituyentes. Es decir Cross-product define una relación que es la concatenación
de cada una de las filas de la relación R con cada una de las filas de la relación S.


**Notación en Álgebra Relacional**

Para representar Cross-product en Álgebra Relacional se utiliza la siguiente
terminología:

.. math::
    \mbox{R} \times \mbox{S}

Por convención para la sentencia anterior, los componentes de R preceden a los
componentes de S en el orden de atributos para el resultado, creando así una nueva
relación con todas las combinaciones posibles de tuplas de R y S.
El número de tuplas de la nueva relación resultante es la multiplicación de la cantidad 
de tuplas de R por la cantidad de tuplas que tenga S (producto de ambos).
Si R y S tienen algunos atributos en común, entonces se debe inventar nuevos nombres 
para al menos uno de cada par de atributos idénticos. Para eliminar la ambigüedad de
un atributo A, que se encuentra en R y S, se usa R.A para el atributo de R y S.A para 
el atributo de S.

Ejemplo 1
^^^^^^^^^

.. math::

 \textbf{R} \\

 \begin{array}{|c|c|c|}
  \hline
  \textbf{A} & \textbf{B} & \textbf{D} \\
  \hline
  1 & 2 & 3 \\
  \hline
  4 & 5 & 6 \\
  \hline
 \end{array}

 \textbf{S} \\

 \begin{array}{|c|c|}
  \hline
  \textbf{A} & \textbf{C} \\
  \hline
  7 & 5 \\
  \hline
  9 & 2 \\
  \hline
  3 & 4 \\
  \hline
 \end{array}

 \textbf{R} \times \textbf{S} \\

   \begin{array}{|c|c|c|c|c|}
    \hline
    \textbf{R.A} & \textbf{B} & \textbf{D} & \textbf{S.A} & \textbf{C} \\
    \hline
     1 & 2 & 3 & 7 & 5 \\
    \hline
     1 & 2 & 3 & 9 & 2 \\
    \hline
     1 & 2 & 3 & 3 & 4 \\
    \hline
     4 & 5 & 6 & 7 & 5 \\
    \hline
     4 & 5 & 6 & 3 & 4 \\
    \hline
     4 & 5 & 6 & 9 & 2 \\
    \hline
  \end{array}

 \textbf{S} \times \textbf{R} \\

 \begin{array}{|c|c|c|c|c|}
  \hline
  \textbf{S.A} & \textbf{C} & \textbf{R.A} & \textbf{B} & \textbf{D} \\
  \hline
  7 & 5 & 1 & 2 & 3 \\
  \hline
  7 & 5 & 4 & 5 & 6 \\
  \hline
  9 & 2 & 1 & 2 & 3 \\
  \hline
  9 & 2 & 4 & 5 & 6 \\
  \hline
  3 & 4 & 1 & 2 & 3 \\
  \hline
  3 & 4 & 4 & 5 & 6 \\
  \hline
 \end{array}

Ejemplo 2
^^^^^^^^^

Dada las siguientes tablas:

.. math::

 \textbf{Tabla Ingenieros} \\

 \begin{array}{|c|c|c|}
  \hline
  \textbf{ID} & \textbf{Nombre} & \textbf{D#} \\
  \hline
  123 & \mbox{Leon} & 39 \\
  \hline
  234 & \mbox{Tomas} & 34 \\
  \hline
  143 & \mbox{Josefa} & 25 \\
  \hline
 \end{array}

 \textbf{Tabla Proyectos} \\

 \begin{array}{|c|c|}
  \hline
  \textbf{Proyecto} & \textbf{Duracion} \\
  \hline
  \mbox{ACU0034} & 300 \\
  \hline
  \mbox{USM7345} & 60 \\
  \hline
 \end{array}

Escriba la tabla resultante al realizar la siguiente operación:

.. math::

    \textbf{Ingenieros} \times \textbf{Proyectos}

**Respuesta**

.. math::

 \textbf{Ingenieros x Proyectos} \\

 \begin{array}{|c|c|c|c|c|}
  \hline
  \textbf{ID} & \textbf{Nombre} & \textbf{D#} & \textbf{Proyecto} & \textbf{Duracion} \\
  \hline
  123 & \mbox{Leon} & 39 & \mbox{ACU0034} & 300 \\
  \hline
  123 & \mbox{Leon} & 39 & \mbox{USM7345} & 60 \\
  \hline
  234 & \mbox{Tomas} & 34 & \mbox{ACU0034} & 300 \\
  \hline
  234 & \mbox{Tomas} & 34 & \mbox{USM7345} & 60 \\
  \hline
  143 & \mbox{Josefa} & 25 & \mbox{ACU0034} & 300 \\
  \hline
  143 & \mbox{Josefa} & 25 & \mbox{USM7345} & 60 \\
  \hline
 \end{array}

NATURALJOIN
************

Este operador se utiliza cuando se tiene la necesidad de unir relaciones vinculando sólo las tuplas que coinciden de alguna manera. NATURALJOIN une sólo los pares de tuplas de R y S que sean comunes. Más precisamente una tupla r de R y una tupla s de S se emparejan correctamente si y sólo si r y s coinciden en cada uno de los valores de los atributos comunes, el resultado de la vinculación es una tupla, llamada “joined tuple”. Entonces, al realizar NATURALJOIN se obtiene una relación con los atributos de ambas relaciones y se obtiene combinando las tuplas de ambas relaciones que tengan el mismo valor en los atributos comunes.

**Notación en Álgebra Relacional**

Para denotar NATURALJOIN se utiliza la siguiente simbología:

.. math::
   \mbox{R} \rhd \hspace{-0.1cm} \lhd \mbox{S}

**Equivalencia con operadores básicos**

NATURALJOIN puede ser escrito en términos de algunos operadores ya vistos, la equivalencia es la siguiente:

.. math::
   R \rhd \hspace{-0.1cm} \lhd S=  \pi \hspace{0.2cm} _{R.A_1,...,R.A_n,  S.A_1,...,S.A_n} (\sigma_{R.A_1=S.A_1 \wedge ... \wedge R.A_n=S.A_n  }\hspace{0.3cm} (R \times S ))

**Método**

   1. Se realiza el producto cartesiano `R x S`
   2. Se seleccionan aquellas filas del producto cartesiano para las que los atributos comunes tengan el mismo valor.
   3. Se elimina del resultado una ocurrencia (columna) de cada uno de los atributos comunes.

Ejemplo 1
^^^^^^^^^

.. math::

 \textbf{R}  \\

 \begin{array}{|c|c|c|}
  \hline
  \textbf{A} & \textbf{B} & \textbf{C} \\
  \hline
  1 & 2 & 3 \\
  \hline
  4 & 5 & 6 \\
  \hline
 \end{array}

 \textbf{S} \\

 \begin{array}{|c|c|}
  \hline
  \textbf{C} & \textbf{D} \\
  \hline
  7 & 5 \\
  \hline
  6 & 2 \\
  \hline
  3 & 4 \\
  \hline
 \end{array}

 \textbf{R} \rhd \hspace{-0.1cm} \lhd \textbf{S} \\

 \begin{array}{|c|c|c|c|}
  \hline
  \textbf{A} & \textbf{B} & \textbf{C} & \textbf{D} \\
  \hline
  1 & 2 & 3 & 4 \\
  \hline
  4 & 5 & 6 & 2 \\
  \hline
 \end{array}

Ejemplo 2
^^^^^^^^^

Realizar NATURALJOIN a las siguientes tablas:

.. math::

 \textbf{Tabla Ingenieros} \\

 \begin{array}{|c|c|c|}
  \hline
  \textbf{ID} & \textbf{Nombre} & \textbf{D#} \\
  \hline
  123 & \mbox{Leon} & 39 \\
  \hline
  234 & \mbox{Tomas} & 34\\
  \hline
  143 & \mbox{Josefa} & 25 \\
  \hline
  090 & \mbox{Maria} & 34 \\
  \hline
 \end{array}

 \textbf{Tabla Proyectos} \\

 \begin{array}{|c|c|}
  \hline
  \textbf{D#} & \textbf{Proyecto}\\
  \hline
  39 & \mbox{ACU0034} \\
  \hline
  34 & \mbox{USM7345} \\
  \hline
 \end{array}

**Respuesta**

.. math::

 \textbf{Ingenieros} \rhd \hspace{-0.1cm} \lhd \textbf{Proyectos} \\

 \begin{array}{|c|c|c|c|}
  \hline
  \textbf{ID} & \textbf{Nombre} & \textbf{D#} & \textbf{Proyecto} \\
  \hline
  123 & \mbox{Leon} & 39 & \mbox{ACU0034} \\
  \hline
  234 & \mbox{Tomas} & 34 & \mbox{USM7345} \\
  \hline
  090 & \mbox{Maria} & 34 & \mbox{USM7345} \\
  \hline
 \end{array}



THETAJOIN
**********

Define una relación que contiene las tuplas que satisfacen el predicado C en el producto cartesiano de `R x S`.
Conecta relaciones cuando los valores de determinadas columnas tienen una interrelación específica. La condición C es de la forma `R.ai` <operador_de_comparación> `S.bi`, esta condición es del mismo tipo que se utiliza SELECT. El predicado no tiene por que definirse sobre atributos comunes. El término “join” suele referirse a THETAJOIN.

**Notación en Álgebra Relacional**

La notación de THETAJOIN es el mismo símbolo que se utiliza para NATURALJOIN, la diferencia radica en que THETAJOIN lleva el predicado C:

.. math::
    \mbox{R} \rhd \hspace{-0.1cm} \lhd_C \mbox{S} \\

    \mbox{C = <Atributo> <Comparador> <Atributo o Constante del Dominio>} \\

    \mbox{Donde:}\\

    \mbox{<Comparador>} \in {\{=,\geq,>,<, \neq,\leq \}}\\

**Equivalencia con operadores básicos**

Al igual NATURALJOIN, THETAJOIN puede ser escrito en función de los operadores vistos anteriormente:

.. math::
   R \rhd \hspace{-0.1cm} \lhd_C S= \sigma_{F} (R \times S)

**Método**

   1. Se forma el producto cartesiano `R` x `S`.
   2. Se selecciona, en el producto, solo la tupla que cumplan la condición `C`.

Ejemplo 1
^^^^^^^^^

.. math::

 \textbf{R} \\

 \begin{array}{|c|c|c|c|}
  \hline
  \textbf{A} & \textbf{B} & \textbf{C} & \textbf{D} \\
  \hline
  1 & 3 & 5 & 7 \\
  \hline
  3 & 2 & 9 & 1 \\
  \hline
  2 & 3 & 5 & 4 \\
  \hline
 \end{array}

 \textbf{S} \\

 \begin{array}{|c|c|c|}
  \hline
  \textbf{A} & \textbf{C} & \textbf{E} \\
  \hline
  1 & 5 & 2 \\
  \hline
  1 & 5 & 9 \\
  \hline
  3 & 9 & 2 \\
  \hline
  2 & 3 & 7 \\
  \hline
 \end{array}

.. math::
   R \rhd \hspace{-0.1cm} \lhd_(A >= E) S 

**Respuesta**

.. math::

 \textbf{S} \\

 \begin{array}{|c|c|c|c|c|c|c|}
  \hline
  \textbf{R.A} & \textbf{B} & \textbf{R.C} & \textbf{D} & \textbf{S.A} & \textbf{S.C} & \textbf{E} \\
  \hline
  3 & 2 & 9 & 1 & 1 & 5 & 2 \\
  \hline
  3 & 2 & 9 & 1 & 3 & 9 & 2 \\
  \hline
  2 & 3 & 5 & 4 & 1 & 5 & 2 \\
  \hline
  2 & 3 & 5 & 4 & 3 & 9 & 2 \\
  \hline
 \end{array}

Ejemplo 2
^^^^^^^^^

Con el esquema conceptual siguiente, hallar los nombres de los directores de cada departamento:

Dpto (NumDpto, Nombre, NIFDirector, Fecha_inicio)

Empleado (NIF, Nombre, Direccion, Salario, Dpto, NIFSupervisor)

.. math::
    \pi_{(Dpto.Nombre,Empleado.Nombre)} (Dpto \rhd \hspace{-0.1cm} \lhd_{NIFDirector=NIF} \mbox{Empleado})

• Tuplas con Null en los “Atributos de la Reunión”, no se incluyen en el resultado.

EJERCICIO PROPUESTO
*******************

Considere la siguiente base de datos:

   1. Persona(nombre, edad, genero) : nombre es la clave.
   2. Frecuenta(nombre, pizzeria) : (nombre, pizzeria) es la clave.
   3. Come(nombre, pizza) : (name, pizza) es la clave.
   4. Sirve(pizzeria, pizza, precio): (pizzeria, pizza) es la clave.

Escribir expresiones en álgebra relacional para las siguientes dos preguntas:

  * Seleccionar a las personas que comen pizzas con extra queso.
  * Seleccionar a las personas que comen pizzas con extra queso y frecuentan la
    pizzería X.


