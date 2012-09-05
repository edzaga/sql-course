Lecture 1 - Relational Databases: The relational model
-------------------------------
**Base de datos Relacionales**

  * Sistemas de base de datos utilizada por las empresas comerciales más importantes.
  * Modelo simple.
  * Consultas a través de lenguajes de alto nivel.
  * Implementación eficiente

Una base de datos es un conjunto de relaciones con nombre (o tablas), que tiene un conjunto de atributos con nombre (o columnas) y cada tupla (o fila) 
tiene un valor para cada atributo que tiene un tipo de dato (o dominio) estos pueden ser enteros, string, etc.

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

.. index:: string, text data types, str

**La creación de relaciones (tablas) en SQL**
:: 
         Create Table Estudiante(ID, Nombre, Nota)
         Create Table Colegio(Name string, Ciudad string, Total alumnos integer)
	 
