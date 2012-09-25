Lecture 1 - Relational Databases, "The relational model"
--------------------------------------------------------

Base de datos Relacionales
~~~~~~~~~~~~~~~~~~~~~~~~~~
Permiten establecer interconexiones (relaciones) entre los datos (que están guardados en tablas), y a través de dichas conexiones relacionar los datos de ambas tablas.

**Ventajas:**

  * Sistemas de base de datos utilizada por las empresas comerciales más importantes.
  * Modelo simple.
  * Consultas a través de lenguajes de alto nivel.
  * Implementación eficiente

**Características**
  * Se compone de varias tablas o relaciones.
  * No existen dos o más tablas con el mismo nombre.
  * Una tabla es un conjunto de registros (filas o columnas).
  * La relación entre una tabla padre y un hijo se lleva a cabo por medio de clave primarias y foráneas.
  * Las claves primarias son la clave principal de un registro dentro de una tabla y éstas deben cumplir con la integridad de datos. 
  * Las claves foráneas se colocan en la tabla hija, contienen el mismo valor que la clave primaria del registro padre; por medio de éstas se hacen las relaciones.

Ejemplo:
~~~~~~~~

**Tabla Estudiante** 

==== ====== ====   
ID   Nombre Nota      
==== ====== ====          
123  Juan   3.9           
234  Ana    3.4
345  José   NULL
==== ====== ====

**Tabla Colegio**

=========== ========== =============
Name        Ciudad     Total alumnos
=========== ========== =============
Princess    Santiago   15.000
Saint Louis Valparaiso 16.000
Idop        Concepcion 20.000
=========== ========== =============

La tabla Estudiante posee 3 atributos (ID, Nombre, Nota) y 3 registros (o filas), en el tercer registro se aprecia que José no posee nota por lo que se agrega el valor "unknown" o "undefined" que se define como NULL. Esta tabla posee un atributo cuyo valor es único en cada tupla que es atributo ID y se le llama llave.

La tabla Colegio posee 3 atributos (Name, Ciudad, Total alumnos) y 3 registros (o filas). Esta tabla posee un conjunto de atributos cuyos valores son únicos combinados que son name y Ciudad y se le llama llave compuesta.

Ejemplo en SQL
~~~~~~~~~~~~~~
.. index:: string, text data types, str

.. CMA: Cambié las instrucciones, pues no eran correctas, si es que sólo querían dar un ejemplo que no funciona,
.. pero que sirve para darse cuenta de como es la sintaxis, creo que no es la mejor forma de hacerlo dentro de un "Ejemplo SQL"

La creación de relaciones (tablas) en SQL

.. code-block:: sql

   CREATE TABLE student(ID int, name varchar(50), grade int);
   CREATE TABLE school(name varchar(50), city varchar(50), total_students int);

