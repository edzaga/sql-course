Lecture 2: Relational Databases: Querying relational databases
--------------------------------------------------------------

.. index:: **Utilizando una Base de Datos Relacional**

Los pasos necesarios a la hora de crear una Base de Datos Relacional
  * Diseñar el esquema, es decir, la estrucutra entre las relaciones, usando un DDL (Data Definition Languaje)
  * Ingresar los datos iniciales
  * Ejecutar operaciones de consulta y modificación [1] (agregar lo de las operacines basicas).

.. index:: **Lenguajes de consultas**

Algunos de los lenguajes de consultas son
  * Algebra Relacional: Lenguaje formal y matemático
  * SQL: Lenguaje actual e implementado que nace del Algebra relacional.

Si bien se profundizará sobre ambos, a medida que avance el curso, se deja el siguiente ejemplo:
Consultar por el "ID de los alumnos con nota mayor o igual a 55 en programación":

Utilizando Algebra relacional:

.. math::

        \prod_{ID} \sigma_{\geq 55 \wedge ramos.nombre ='programacion' (alumnos \infty ramos)}

Utilizando SQL:

.. math::
        
        SELECT alumnos.ID FROM alumnos, ramos WHERE alumnos.ID = ramos.ID AND nota \geq 55 and ramos.nombre='progamacion'
