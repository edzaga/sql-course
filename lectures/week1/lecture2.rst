Lecture 2: Relational Databases: Querying relational databases
--------------------------------------------------------------

Utilizando una Base de Datos Relacional
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. index:: Uso de una base de datos relacional

Los pasos necesarios a la hora de crear una Base de Datos (BD) Relacional
  * Diseñar el esquema, es decir, la estrucutra entre las relaciones, usando un DDL (Data Definition Languaje)
  * Ingresar los datos iniciales
  * Ejecutar operaciones de consulta y modificación

Nota: Existen las llamadas "Opraciones Básicas" que se pueden realizar en una Base de Datos Relacional:
  
  1)Consultar: SELECT

  2)Almacenar: CREATE, INSERT
  
  3)Actualizar: UPDATE
  
  4)Borrar: DELETE, DROP

Por ahora sólo se nombran junto a sus funciones SQL relacionadas. A medida que el curso avance, se profundizará el contenido.

Consultas en lenguajes de alto nivel
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. index:: consultas, lenguaje alto nivel

Existen lenguajes de alto nivel que permiten realizar consultas relativamente simples en la BD, sin la necesidad de escribir complejos
algoritmos. 

Una 'consulta a la BD', puede entenderse como una pregunta que se le realiza para obtener 'cierta información'. Algunos ejemplos pueden ser:
  * "Todos los estudiantes con nota mayor o igual a 55"
  * "Todas los departamentos de Ingniería con una cantidad mayor o igual a 1000 alumnos"
  * "Los 5 primeros estudiantes con mejor promedio de notas en el ramo de Química"

Independiente del lenguaje que se utilize, se debe tener en cuenta que:
  * Algunas consultas son faciles de formular, otras son un poco más difíciles.
  * Algunos Data Base Management System (DBMS) las ejecutan de forma eficiente, otros no.
  * Los 2 puntos anteriores no son dependientes uno del otro, puede existir una consulta fácil de formular, pero difícil de ejecutar de forma eficiente, dependiendo del DBMS.
  * El lenguaje utilizado para ejecutar consultas puede modificar/actualizar información de la BD, a esto se le llama Data Manipulation Languaje (DML). 


Consultas y relaciones
~~~~~~~~~~~~~~~~~~~~~~

.. index:: consultas y relaciones

Las consultas realizadas a las relaciones de una BD al momento de ser ejecutadas producen, como resultado, relaciones; las cuales pueden ser:
  * Cerradas: Cuando la estructura del objeto que se obtiene de la consulta, es igual a la estructura de los objetos consultados, se tiene una relación cerrada
  * Compuestas: Cuando la consulta se hace sobre, al menos una relación que corresponde al resultado de una consulta previa. En otras palabras, corresponde a la consulta del resultado de una consulta.


Lenguajes de consultas
~~~~~~~~~~~~~~~~~~~~~~

.. index:: Lenguajes de consultas

Algunos de los lenguajes de consultas son
  * Álgebra Relacional: Lenguaje formal y matemático
  * SQL: Lenguaje actual e implementado que nace del Algebra relacional.

Si bien se profundizará sobre ambos, a medida que avance el curso, se deja el siguiente ejemplo::

        Consultar por el "ID de los alumnos con nota mayor o igual a 55 en programación":

Utilizando Algebra relacional:

.. math::

        \prod_{ID} \sigma_{\geq 55 \wedge ramos.nombre ='programacion' (alumnos \infty ramos)}

Utilizando SQL::
        
        SELECT alumnos.ID FROM alumnos, ramos WHERE alumnos.ID = ramos.ID AND nota > 55 and ramos.nombre='progamacion'


En las próximas lecturas, se estudiará con mayor detalle tanto el álgebra relacional, como el lenguaje SQL.

To begin our study of operations on relations, we shall learn about a special
algebra, called relattonal algebra (lectures 3 and), that consists of some simple but powerful ways
to construct new relations from given relations. When the given relations are
stored data, then the constructed relations can be answers to queries about this data.

