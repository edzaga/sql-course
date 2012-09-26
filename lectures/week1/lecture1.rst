Lecture 1 - Relational Databases, "The relational model"
--------------------------------------------------------

Base de datos Relacionales
~~~~~~~~~~~~~~~~~~~~~~~~~~

.. index:: Base de datos Relacionales

Permiten establecer interconexiones (relaciones) entre los datos (que están guardados en tablas),
y a través de dichas conexiones relacionar los datos de ambas tablas.

**Ventajas:**

  * Sistemas de bases de datos utilizada por las empresas comerciales más importantes.
  * Modelo simple.
  * Consultas a través de lenguajes de alto nivel.
  * Implementación eficiente

**Características**
  * Se compone de varias tablas o relaciones.
  * No existen dos o más tablas con el mismo nombre.
  * Una tabla es un conjunto de registros (filas o columnas).
  * La relación entre una tabla padre y un hijo se lleva a cabo por medio de claves primarias
    y foráneas.
  * Las claves primarias representan la clave principal de un registro dentro de una tabla y éstas deben
    cumplir con la integridad de los datos.
  * Las claves foráneas se colocan en la tabla hija, contienen el mismo valor que la clave
    primaria del registro padre; por medio de éstas se hacen las relaciones.

Ejemplo:
========

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

La tabla Estudiante posee 3 atributos (ID, Nombre, Nota) y 3 registros (o filas), en el tercer
registro se aprecia que José no posee nota por lo que se agrega el valor "unknown" o "undefined"
que se define como NULL.
Esta tabla posee un atributo cuyo valor es único en cada tupla que es atributo ID y se le llama
llave.

La tabla Colegio posee 3 atributos (Name, Ciudad, Total alumnos) y 3 registros (o filas).
Esta tabla posee un conjunto de atributos cuyos valores son únicos combinados que son name y
Ciudad y se le llama llave compuesta.

Ejemplo en SQL
~~~~~~~~~~~~~~
.. index:: string, text data types, str


.. CMA: Cambié las instrucciones, pues no eran correctas, si es que sólo querían dar un ejemplo que no funciona,
.. pero que sirve para darse cuenta de como es la sintaxis, creo que no es la mejor forma de hacerlo dentro de un "Ejemplo SQL"

La creación de relaciones (tablas) en SQL

.. code-block:: sql

   CREATE TABLE student(ID int, name varchar(50), grade int);
   CREATE TABLE school(name varchar(50), city varchar(50), total_students int);



Motores de bases de datos Relacionales
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. index:: Motores de bases de datos Relacionales

Hoy en día existen muchas empresas y sitios web que necesitan mantener de forma 
eficiente un gran volumen de datos. Muchos de ellos optan por soluciones comerciales 
(Oracle Database o IBM DB2 entre otras ), aunque muchas otras confían en el software 
libre optando por una solución como PostGreSQL o MySQL. 

Es muy común la pregunta, entre las personas que se adentran por primera vez en el mundo 
de las bases de datos libres, ¿Qué motor de bases de datos debo usar? ¿MySQL o PostGreSQL?. 
A continuación se verán algunos detalles de ambos motores.




PostGreSQL
==========

PostGreSQL es un sistema de gestión de bases de datos objeto-relacional (ORDBMS) basado 
en el proyecto POSTGRES, de la universidad de Berkeley. El director de este proyecto es 
el profesor Michael Stonebraker, y fue patrocinado por Defense Advanced Research Projects 
Agency (DARPA), el Army Research Office (ARO), el National Science Foundation (NSF), y ESL, Inc.




**Un poco de historia**


PostGreSQL fue derivado del proyecto Postgres. A sus espaldas, este proyecto lleva más de 
una década de desarrollo, siendo hoy en día, el sistema libre más avanzado con diferencia, 
soportando la gran mayoría de las transacciones SQL, control concurrente, teniendo a su 
disposición varios "language bindings" como por ejemplo C, C++, Java, Python, PHP y muchos más.

La implementación de Postgres DBMS comenzó en 1986, y no hubo una versión operativa hasta 1987. 
La versión 1.0 fue liberada en Junio de 1989 a unos pocos usuarios, tras la cual se liberó la 
versión 2.0 en Junio de 1990 debido a unas críticas sobre el sistema de reglas, que obligó a 
su reimplementación. La versión 3.0 apareció en el año 1991.

En 1994, Andrew Yu y Jolly Chen añadieron un intérprete de SQL a este gestor. Postgres95, como 
así se llamó fue liberado a Internet como un proyecto libre (OpenSource). Estaba escrito totalmente 
en C, y la primera versión fue un 25% más pequeña que Postgres, y entre un 30 y un 50% más rápida. 
A parte de la corrección de algunos bugs, se mejoró el motor interno, se añadió un nuevo programa 
monitor, y se compiló usando la utilidad GNU Make y el compilador gcc.

En 1996, los desarrolladores decidieron cambiar el nombre a al DBMS, y lo llamaron PostGreSQL 
para reflejar la relación entre Postgres y las versiones recientes de SQL. 




**Características**


  * Implementación del estándar SQL92/SQL99.
  * Licencia BSD.
  * Por su arquitectura de diseño, escala muy bien al aumentar el numero de CPUs y la cantidad de RAM.
  * Soporta transacciones y desde la version 7.0, claves ajenas (con comprobaciones de integridad referencial).
  * Tiene mejor soporte para triggers y procedimientos en el servidor.
  * Incorpora una estructura de datos array.
  * Incluye herencia entre tablas (aunque no entre objetos, ya que no existen), por lo que a este gestor de bases de datos se le incluye entre los gestores objeto-relacionales.
  * Implementa el uso de rollback's, subconsultas y transacciones, haciendo su funcionamiento mucho más eficaz.
 Se pueden realizar varias opreraciones al mismo tiempo sobre la misma tabla sin necesidad de bloquearla. 





MySQL
=====

MySQL es un sistema de gestión de bases de datos relacional, licenciado bajo la GPL de la GNU. 
Su diseño multihilo le permite soportar una gran carga de forma muy eficiente. MySQL fue creada 
por la empresa sueca MySQL AB, que mantiene el copyright del código fuente del servidor SQL, así 
como también de la marca.

Aunque MySQL es software libre, MySQL AB distribuye una versión comercial de MySQL, que no se 
diferencia de la versión libre más que en el soporte técnico que se ofrece, y la posibilidad 
de integrar este gestor en un software propietario, ya que de no ser así, se vulneraría la licencia GPL.




**Un poco de historia**


MySQL surgió como un intento de conectar el gestor mSQL a las tablas propias de MySQL AB, usando 
sus propias rutinas a bajo nivel. Tras unas primeras pruebas, vieron que mSQL no era lo bastante 
flexible para lo que necesitaban, por lo que tuvieron que desarrollar nuevas funciones. Esto 
resultó en una interfaz SQL a su base de datos, con una interfaz totalmente compatible a mSQL.

No se sabe con certeza de donde proviene su nombre. Por un lado dicen que sus librerías han llevado 
el prefijo *'my'*  durante los diez últimos años. Por otro lado, la hija de uno de los desarrolladores 
se llama My. No saben cuál de estas dos causas (aunque bien podrían tratarse de la misma), han dado 
lugar al nombre de este conocido gestor de bases de datos.




**Características**


  * Lo mejor de MySQL es su velocidad a la hora de realizar las operaciones, lo que le hace uno de los gestores que ofrecen mayor rendimiento.
  * Consume muy pocos recursos ya sea de CPU como asi tambien de memoria.
  * Licencia GPL y tambien posee una licencia comercial para aquellas empresas que deseen incluirlo en sus aplicaciones privativas.
  * Dispone de API's en gran cantidad de lenguajes (C, C++, Java, PHP, etc).
  * Soporta hasta 64 índices por tabla, una mejora notable con repecto a la version 4.1.2.
  * Mejor integracion con PHP.
  * Permite la gestión de diferentes usuarios, como también los permisos asignados a cada uno de ellos.
  * Tiene soporte para transacciones y ademas posee una caracteristica unica de MySQL que es poder agrupar transacciones.





Elección
========

Es indispensable tener en cuenta para qué se necesitará. En múltiples foros, se asocia a PostGreSQL a 
estabilidad, bases de datos de gran tamaño y de alta concurrencia. Por otra parte, se asocia MySQL a bases 
de datos de menor tamaño, pero de mayor velocidad de respuesta ante una consulta.

Cada uno de estos gestores poseen características que los convierten en una gran opción en su 
respectivo campo al momento de elegir ya que fueron concebidos para una determinada implementación.
 
