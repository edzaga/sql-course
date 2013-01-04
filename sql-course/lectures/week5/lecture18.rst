Lectura 18 - Teoría de diseño relacional: Dependencias Multivaluadas(4ta forma normal)
---------------------------------------------------------------------------------------

.. role:: sql(code)
   :language: sql
   :class: highlight

Dependencias multivaluadas
~~~~~~~~~~~~~~~~~~~~~~~~~~

Introducción
============

Una **dependencias multivaluadas** es una afirmación donde dos atributos o conjuntos de
atributos son independientes uno de otro.
Si A implica B, las **dependencias funcionales** prohíben que haya dos tuplas con igual
valor de A y distinto valores de B,  es decir A tiene asociado un único valor de B. Al
contrario las **dependencias multivaluadas** permite que un mismo valor de A tenga asociado
diferente valor de B, pero exige que estén presentes en la relación de una forma determinada.
Por este motivo, las dependencias funcionales se conocen también como **dependencias de
generación de igualdad** y las dependencias multivaluadas se denominan **dependencias de
generación de tuplas**.

Atributo de Independencia y redundancia
========================================

En bases de datos, la **redundancia** hace referencia al almacenamiento de los mismos
datos varias veces en diferentes lugares. Esto puede traer problemas como incremento del
trabajo, desperdicio de espacio de almacenamiento e inconsistencia de datos. Si una base
de datos está bien diseñada, no debería haber redundancia de datos (exceptuando la redundancia
de datos controlada, que se emplea para mejorar el rendimiento en las consultas a las bases de datos).

Ejemplo
^^^^^^^^
Suponga que se tiene información acerca de nombres de cursos, profesores y textos.
La tupla indica que dicho curso puede ser enseñado por cualquiera de los profesores
descritos y que utiliza como referencias todos los textos especificados. Para un curso dado,
puede existir cualquier número de profesores y cualquier cantidad de textos correspondientes.
Los profesores y los textos son independientes entre sí; es decir, independientemente de quién
imparta el curso, se utilizan los mismos textos.

.. code-block:: sql

	curso          | profesor | texto
	---------------+----------+----------------------------
	Base de datos  |  Ullman  | A First Course in Database
	Base de datos  |  Ullman  | Database System Concepts
	Base de datos  |  Widom   | A First Course in Database
	Base de datos  |  Widom   | Database System Concepts
	Programación   |  Ullman  | Rapid GUI Programming
	Programación   |  Ullman  | Learning Python
	Programación   |  Ullman  | Python Algorithms

Se puede observar que el ejemplo involucra una buena cantidad de **redundancia**, la
cual conduce a ciertas anomalías de actualización. Por ejemplo, para agregar la
información de que el curso de Base de datos puede ser impartido por un nuevo profesor,
llamado Hetland, es necesario insertar dos nuevas tuplas; una para cada uno de los textos.

.. code-block:: sql

	curso          | profesor | texto
	---------------+----------+----------------------------
	Base de datos  |  Ullman  | A First Course in Database
	Base de datos  |  Ullman  | Database System Concepts
	Base de datos  |  Widom   | A First Course in Database
	Base de datos  |  Widom   | Database System Concepts
	Base de datos  |  Hetland | A First Course in Database
	Base de datos  |  Hetland | Database System Concepts
	Programación   |  Ullman  | Rapid GUI Programming
	Programación   |  Ullman  | Learning Python
	Programación   |  Ullman  | Python Algorithms


Los problemas en cuestión son generados por el hecho de que los profesores y los textos
son completamente independientes entre sí.

La existencia de relaciones Forma Normal de Boyce-Codd (BCNF) "problemáticas" como la del
ejemplo llevaron a presentar la noción de las dependencias multivaluadas.

Las dependencias multivaluadas son una generalización de las dependencias funcionales,
en el sentido de que toda dependencia funcional(DF) es una dependencia multivaluada (DMV),
aunque lo opuesto no es cierto (es decir, existen DMVs que no son DFs).

Definición formal
==================

Sea R una relación y sean A, B y C subconjuntos de los atributos de R. Entonces decimos que B
es multidependiente de A, si y solamente si en todo valor válido posible de R, el conjunto de
valores B que coinciden con un determinado par (valor A, valor C) depende sólo del valor de A
y es independiente del valor de C.

Es fácil mostrar que dado R{A,B,C}, ``A->->B`` es válida si y solamente si también es válida ``A->->C``.
Las dependencias multivaluadas siempre van en pares, de esta forma. Por esta razón, es común representar
ambas en un solo enunciado de esta manera:

``A->->B|C``

A partir de la definición de dependencia multivalorada se puede obtener la regla siguiente:

Si ``A->B``, entonces ``A->->B``.

En otras palabras, cada dependencia funcional es también una dependencia multivalorada.

Las dependencias multivaluadas se utilizan de dos maneras:

1. Para verificar las relaciones y determinar si son legales bajo un conjunto dado de dependencias
   funcionales y multivaluadas.

2. Para especificar restricciones del conjunto de relaciones legales; de este modo, sólo habrá que
   preocuparse de las relaciones que satisfagan un conjunto dado de dependencias funcionales y multivaluadas.


Cuarta forma normal
~~~~~~~~~~~~~~~~~~~~~

La cuarta forma normal (4FN) tiene por objetivo eliminar las dependencias multivaluadas.
La 4FN se asegura de que las dependencias multivaluadas independientes estén correcta y
eficientemente representadas en un diseño de base de datos. La 4FN es el siguiente nivel
de normalización después de la forma normal de Boyce-Codd (BCNF).

Definición
==========

* Una relación está en 4FN si y sólo si, en cada dependencia multivaluada ``A->->B`` no trivial,
  A es **clave candidata**. Una dependencia multivaluada ``A->->B`` es trivial cuando B es parte de A.
  Esto sucede cuando A es un conjunto de atributos, y B es un subconjunto de A.


.. note::

	Si una relación tiene más de una clave, cada una es una **clave candidata**. Una de ellas es
	arbitrariamente designada como clave primaria, el resto son secundarias.

Es otras palabras una relación está en 4FN si esta en Tercera forma normal o en BCNF y no posee dependencias
multivaluadas no triviales. Como se mencionó, una relación posee una dependencia multivaluada cuando la existencia
de dos o más relaciones independientes muchos a muchos causa redundancia; y es esta redundancia la que es
suprimida por la cuarta forma normal.

Ejemplo 1
^^^^^^^^^^
Consideremos nuevamente el ejemplo anterior de cursos, profesores y textos.
Se consigue una mejora si se descompusiera en sus dos proyecciones:
Profesores (curso,profesor) y Textos (curso,texto).

.. code-block:: sql

	Profesores:

	curso          | profesor
	---------------+----------
	Base de datos  |  Ullman
	Base de datos  |  Widom
	Programación   |  Ullman

	Textos:

	curso          |  texto
	---------------+-----------------------------
	Base de datos  | A First Course in Database
	Base de datos  | Database System Concepts
	Programación   |  Rapid GUI Programming
	Programación   |  Learning Python
	Programación   |  Python Algorithms


Para agregar la información de que el curso de Base de datos puede ser impartido
por un nuevo profesor, sólo tenemos que insertar una tupla en la relación Profesores:

.. code-block:: sql

	Profesores:

	curso          | profesor
	---------------+----------
	Base de datos  |  Ullman
	Base de datos  |  Widom
	Base de datos  |  Hetland
	Programación   |  Ullman

También se observa que se puede recuperar la relación inicial al juntar nuevamente
Profesores y Textos, de manera que la descomposición es sin pérdida. Por lo tanto,
es razonable sugerir que debe existir una forma de "normalizar aún más", es así como nace la 4FN

En este ejemplo hay dos DMVs válidas:

``CURSO ->-> PROFESOR``

``CURSO ->-> TEXTO``

La primera DMV se lee como "Profesor es **multidependiente** de Curso" o manera equivalente,
"Curso **multidetermina** a Profesor".

Ejemplo 2
^^^^^^^^^^

Se tiene una relación entre estudiantes, ramo y deporte. Los estudiantes pueden inscribirse en
varios ramos y participar en diversos deportes. Esto quiere decir que sid no será único, de esta
forma la única clave candidata posible es la combinación de los atributos (sid, ramo, deporte).
El estudiante 1 tiene los ramos física y programación, participa en natación y tenis.  El  estudiante
2 sólo tiene el ramo matemáticas y participa en vóleibol.

.. code-block:: sql

	sid |     ramo     | deporte
	----+--------------+------------
	1   |	física     | natación
	1   | programación | natación
	1   |   física     | tenis
	1   | programación | tenis
	2   | matemáticas  | vóleibol

La relación entre sid y ramo no es una dependencia funcional porque los estudiantes pueden tener
distintos ramos. Un valor único de sid puede poseer muchos valores de ramo.  Esto también se aplica
a la relación entre sid y deporte.

Se puede notar entonces que tal dependencia por atributos es una dependencia multivaluada. Se aprecia
la redundancia en el ejemplo pues el estudiante 1 tiene cuatros registros. Cada uno de los cuales
muestra uno de sus ramos junto con uno de sus deportes. Si los datos se almacenaran con menos filas:
si hubiera sólo dos tuplas, uno para física y natación y uno para programación y tenis, las implicaciones
serían engañosas. Parecería que el estudiante 1 sólo nadó cuando tenía física como ramo y jugó tenis sólo
cuando tenía programación como ramo. Esa interpretación no es lógica. Sus ramos y sus deportes son
independientes entre sí.  Para prevenir tales engañosas conclusiones se almacenan todas las combinaciones
de ramos y deportes.

Si el estudiante 1 decide que quiere inscribirse en fútbol, se deben agregar dos tuplas con el fin
de mantener la consistencia en los datos, se debe agregar una fila para cada uno de sus ramos,
como en se muestra a continuación:

.. code-block:: sql

	sid |     ramo     | deporte
	----+--------------+------------
	1   |   física     | fútbol
	1   | programación | fútbol
	1   |	física     | natación
	1   | programación | natación
	1   |   física     | tenis
	1   | programación | tenis
	2   | matemáticas  | vóleibol

Esta relación está en BCNF (2FN porque todo es clave; 3FN porque no tiene dependencias transitivas;
y BCNF porque no tiene determinantes que no son claves). A pesar de esto se aprecia esta anomalía
de actualización, pues hay que hacer demasiadas actualizaciones para realizar un cambio en los datos.

Lo mismo ocurre si un estudiante se desea inscribir un nuevo ramo. También existe anomalía si un estudiante
desinscribe un ramo pues se deben eliminar cada uno de los registros que contienen tal materia. Si participa
en cuatro deportes, habrá cuatro tuplas que contengan el ramo que ha dejado y deberán borrarse las cuatro tuplas.

Para evitar tales anomalías se construyen dos relaciones, donde cada una almacena datos para solamente uno
de los atributos multivaluados. Las relaciones resultantes no tienen anomalías:

.. code-block:: sql

	Ramos:

	sid | ramo
	----+-------------
	1   | física
	1   | programación
	2   | matemáticas

	Deportes:

	sid | deporte
	----+----------
	1   | fútbol
	1   | natación
	1   | tenis
	2   | vóleibol

A partir de estas observaciones, se define la 4FN: Una relación está en 4FN si está en BCNF y
no tiene dependencias multivaluadas.

Ejemplo 3
^^^^^^^^^^
Se tiene una tabla de Agenda con atributos multivaluados:

Agenda(nombre, teléfono, correo)

Se buscan las claves y las dependencias. Las claves candidatas deben identificar de forma
unívoca cada tupla. De modo los tres atributos deben formar la clave candidata.

Pero las dependencias que se tienen son:

``nombre ->-> teléfono``

``nombre ->-> correo``

Y nombre no es clave candidata de esta relación, por lo que se debe separar esta relación en
2 relaciones:

`Teléfonos(nombre, teléfono)`

`Correos(nombre, correo)`

Ahora en las dos relaciones se cumple la 4FN.

.. note::

	De manera general una relación se separa en tantas relaciones como atributos multivaluados tenga.


