Lecture 2 - Relational Databases: Querying relational databases
----------------------------------------------------------------

.. role:: sql(code)
   :language: sql
   :class: highlight


Utilizando una Base de Datos Relacional
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. index:: Uso de una base de datos relacional

Los pasos necesarios a la hora de crear una Base de Datos Relacional (BDR) son:

  * Diseñar el esquema, es decir, la estructura de las tablas y las relaciones, usando un DDL
    (Data Definition Language).
  * Ingresar los datos iniciales.
  * Ejecutar operaciones de consulta y mantención usando en DML (Data Manipulation Language).

.. note::

   Existen las llamadas "Operaciones Básicas" de DML que se pueden realizar en una Base de
   Datos Relacional:

    1. Consultar: :sql:`SELECT`
    2. Almacenar: :sql:`CREATE, INSERT`
    3. Actualizar: :sql:`UPDATE`
    4. Borrar: :sql:`DELETE, DROP`

.. note::

   Existen las llamadas "Operaciones Básicas" de DDL que se pueden realizar en una Base de
   Datos Relacional:

    1. Almacenar: :sql:`CREATE`
    2. Borrar: :sql:`DROP`


Por ahora sólo se nombran junto a sus funciones SQL relacionadas.
A medida que el curso avance, se profundizará el contenido.

Consultas en lenguajes de alto nivel
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. index:: consultas, lenguaje alto nivel

Existen lenguajes de alto nivel que permiten realizar consultas relativamente simples
en la BD, sin la necesidad de escribir complejos algoritmos.

Una 'consulta a la BD', puede entenderse como una pregunta que se le realiza para obtener
'cierta información'. Algunos ejemplos pueden ser:
  * "Todos los estudiantes con nota mayor o igual a 55".
  * "Todas los departamentos de Ingeniería con una cantidad mayor o igual a 1000 alumnos".
  * "Los 5 primeros estudiantes con mejor promedio de notas en el ramo de Química".

Independiente del lenguaje que se utiliza, se debe tener en cuenta que:
  * Algunas consultas son fáciles de formular, otras son un poco más difíciles.
  * Algunos SGBD las ejecutan de forma eficiente, otros no.
  * Los 2 puntos anteriores no son dependientes uno del otro, puede existir una consulta
    fácil de formular, pero difícil de ejecutar de forma eficiente, dependiendo del DBMS.
  * El lenguaje utilizado para ejecutar consultas puede modificar/actualizar información
    de la BD, a esto se le llama Data Manipulation Language (DML).

Consultas y relaciones (tablas)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. index:: consultas y relaciones

Las consultas realizadas a las tablas de una BD al momento de ser ejecutadas producen,
como resultado, tablas; las cuales pueden ser:
  * Cerradas: Cuando la estructura del objeto que se obtiene de la consulta, es igual
    a la estructura de los objetos consultados, se tiene una tabla cerrada
  * Compuestas: Cuando la consulta se hace sobre, al menos una tabla que corresponde
    al resultado de una consulta previa. En otras palabras, corresponde a la consulta del
    resultado de una consulta.

Lenguajes de consultas
~~~~~~~~~~~~~~~~~~~~~~

.. index:: Lenguajes de consultas

Algunos de los lenguajes de consultas son
  * Álgebra Relacional: Lenguaje formal y matemático
  * SQL: Lenguaje actual e implementado que nace del Álgebra Relacional.

Si bien se profundizará sobre ambos, a medida que avance el curso, se deja la siguientes tablas

.. math::
 
 \textbf{Tabla Alumnos}

 \begin{array}{|c|c|c|c|}
  \hline
  \textbf{ID} & textbf{ID_ramo} & textbf{nombre_alumno} & \textbf{promedio_nota} \\
  \hline
  1 & 1 & Robert & 45 \\
  \hline
  2 & 2 & Robert & 70 \\
  \hline
  3 & 1 & Harry & 55 \\
  \hline
  4 & 1 & Jane & 60 \\
  \hline
  5 & 3 & Mary & 35 \\
  \hline
 \end{array}

 \textbf{Tabla Ramos}

 \begin{array}{|c|c|}
  \hline
  \textbf{ID} & \textbf{nombre_ramo} \\
  \hline
  1 & Lenguajes de Programación \\
  \hline
  2 & Base de datos \\
  \hline
  3 & Estructuras de datos \\
  \hline
 \end{array}

Consultar por el "ID de los alumnos con nota mayor o igual a 55 en programación":

Utilizando Álgebra Relacional:

.. CMA: QUE ES ESTO?????? No puedo entender que significa esta productora :/

.. math::
   \pi \hspace{0.2cm} _{ID} \hspace{0.2cm} \sigma_{\geq 55 \wedge \text{ramos.nombre ='programacion'} (alumnos \rhd \hspace{-0.1cm} \lhd ramos)}

Se puede decir que: 

.. math::
        \pi 

realiza un PROJECT sobre una tabla, es decir selecciona una columna. Por otro lado:

.. math::
        \sigma

selecciona una fila que cumpla con una cierta condición, en el ejemplo dado se seleccionan las filas que cumplen con tener nota mayor a 55 y que el ramo.nombre sea 'programación'. 

.. math::
        \rhd \hspace{-0.1cm} \lhd 

realiza un JOIN entre dos relaciones en la lectura 3 se profundiza acerca de estos operadores y sus respectivos significados.

Utilizando SQL

.. code-block:: sql

   SELECT alumnos.ID FROM alumnos, ramos WHERE alumnos.ID = ramos.ID AND nota > 55 AND ramos.nombre='progamacion'


En las próximas lecturas, se estudiará con mayor detalle tanto el álgebra relacional,
como el lenguaje SQL.

.. To begin our study of operations on relations, we shall learn about a special
.. algebra, called relational algebra (lectures 3 and 4), that consists of some simple but powerful ways
.. to construct new relations from given relations. When the given relations are
.. stored data, then the constructed relations can be answers to queries about this data.
