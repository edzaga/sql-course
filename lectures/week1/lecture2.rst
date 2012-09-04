Lecture 2: Relational Databases: Querying relational databases
--------------------------------------------------------------

 **Utilizando una Base de Datos Relacional**

Los pasos necesarios a la hora de crear una Base de Datos (BD) Relacional
  * Diseñar el esquema, es decir, la estrucutra entre las relaciones, usando un DDL (Data Definition Languaje)
  * Ingresar los datos iniciales
  * Ejecutar operaciones de consulta y modificación

 **Consultas en lenguajes de alto nivel**

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


 **Lenguajes de consultas**

Algunos de los lenguajes de consultas son
  * Algebra Relacional: Lenguaje formal y matemático
  * SQL: Lenguaje actual e implementado que nace del Algebra relacional.

Si bien se profundizará sobre ambos, a medida que avance el curso, se deja el siguiente ejemplo:
Consultar por el "ID de los alumnos con nota mayor o igual a 55 en programación":

Utilizando Algebra relacional:

.. math::

        \prod_{ID} \sigma_{\geq 55 \wedge ramos.nombre ='programacion' (alumnos \infty ramos)}

Utilizando SQL::
        
        SELECT alumnos.ID FROM alumnos, ramos WHERE alumnos.ID = ramos.ID AND nota :math:\geq 55 and ramos.nombre='progamacion'
