Lectura 7 - Sentencia SELECT Básica 
-----------------------------------
.. role:: sql(code)
   :language: sql
   :class: highlight

Corresponde a la forma más simple de hacer una consulta en SQL, la cual sirve para preguntar por aquellas tuplas de una relación
que satisfagan una condición. Es análoga a la selección en álgebra relacional. Esta consulta, al igual que la mayoría
de las realizadas en este lenguaje de programación, utiliza 3 palabras clave: :sql:`SELECT - FROM - WHERE`.

En palabras simples, lo que se busca con esta consulta es seleccionar cierta información (:sql:`SELECT`) de alguna tabla (:sql:`FROM`)
que satisfaga (:sql:`WHERE`) ciertas condiciones. Por ejemplo:

.. code-block:: sql

   Obtener los nombres de los alumnos que hayan nacido en el mes de Noviembre
   SELECT "los nombres" FROM "alumnos" WHERE "hayan nacido en el mes de Noviembre"

Cabe destacar que en este ejemplo, se infiere la existencia de una tabla de nombre **alumnos** que alberga datos personales de ciertos
estudiantes.

Desde el Algebra Relacional
~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. index:: Desde el álgebra relacional

El operador de selección en el Algebra relacional hace uso de la palabra clave  WHERE. Por lo general, las expresiones que siguen
a esta keyword incluyen expresiones condicionales. Podemos construir expresiones mediante la comparación de valores (como por ejemplo
tipos de datos enteros, cadenas de caracteres, etc) utilizando los 6 operadores más comunes de comparación:

  * ``=``   "igual a"
  * ``<>``   "distinto a" o "no igual a"
  * ``<``   "menor que"
  * ``>``   "mayor que"
  * ``<=``   "menor o igual a"
  * ``>=``   "mayor o igual a"

Estos operadores tienen el mismo significado que en el lenguaje C, siendo el único diferente el símbolo "<>" que corresponde a
"distinto a"; el lenguaje C utiliza el símbolo "!=" para este comparador. Siguiendo la comparación entre estos lenguajes, el símbolo de
igualdad en SQL corresponde a "=", mientras que en C es "==".

Estos valores pueden ser comparados incluyendo constantes y atributos de las relaciones nombradas despues de la palabra clave FROM.
En el ejemplo, correspondería al atributo del mes de nacimiento del individuo con el mes de Noviembre.


Algunos ejemplos de comparación:

.. code-block:: sql

        StudioName = 'Ubisoft' : se compara que el atributo studioName sea 'Ubisoft'
        mesesVidaUtil <> 5 : se compara que el atributo mesesVidaUtil no sea igual a 5
        mesNacimiento = 'Noviembre':  se compara que el atributo mesNacimiento sea igual a 'Noviembre'

SELECT-FROM-WHERE
~~~~~~~~~~~~~~~~~

.. index:: SELECT-FROM-WHERE

Trabajemos bajo el siguiente ejemplo, el cual consiste en *seleccionar* toda la 
información de la relación (o tabla) **Empleados** cuyos atributos *departamento* sea 
'Informatica' y que su atributo *ano_ingreso* sea mayor o igual al año  2005.

Para comenzar a realizar este ejemplo, primero debemos *crear* la tabla **Empleados** 
de la siguiente manera.

.. code-block:: sql

 postgres=# CREATE TABLE Empleados(id_empleado serial, nombre_empleado VARCHAR(30),  departamento VARCHAR(30), ano_ingreso INTEGER);

retornando lo siguiente PostgreSQL.::

 NOTICE:  CREATE TABLE creará una secuencia implícita «empleados_id_empleado_seq» para la columna serial «empleados.id_empleado»
 CREATE TABLE

Ahora *insertaremos* algunos datos en la tabla **Empleados**.

.. code-block:: sql

 postgres=# INSERT INTO Empleados(nombre_empleado, departamento, ano_ingreso) VALUES('Edgar', 'Administracion', 2000);
 INSERT 0 1
 postgres=# INSERT INTO Empleados(nombre_empleado, departamento, ano_ingreso) VALUES('Andrew', 'Comercial', 2009);
 INSERT 0 1
 postgres=# INSERT INTO Empleados(nombre_empleado, departamento, ano_ingreso) VALUES('Valerie', 'Informatica', 2000);
 INSERT 0 1
 postgres=# INSERT INTO Empleados(nombre_empleado, departamento, ano_ingreso) VALUES('Karl', 'Informatica', 2008);
 INSERT 0 1
 postgres=# INSERT INTO Empleados(nombre_empleado, departamento, ano_ingreso) VALUES('Kevin', 'Finanzas', 2010);
 INSERT 0 1

Finalmente podemos realizar la consulta que nos interesa.

.. code-block:: sql

 postgres=# SELECT * FROM Empleados WHERE departamento='Informatica' AND ano_ingreso>=2005;
  id_empleado | nombre_empleado | departamento | ano_ingreso 
 -------------+-----------------+--------------+-------------
            4 | Karl            | Informatica  |        2008
 (1 fila)

.. note::

 Podemos notar que la consulta retorna el registro que se cumplian las dos 
 condiciones.

Podemos realizar la siguiente consulta, encontrar en la tabla **Empleados** el registro de la(s)
personas que sean del departamento de 'Informática' o que su año de ingreso sea mayor o igual
al año 2005.

.. code-block:: sql

 postgres=# SELECT * FROM Empleados WHERE departamento='Informatica' OR ano_ingreso>=2005;
  id_empleado | nombre_empleado | departamento | ano_ingreso 
 -------------+-----------------+--------------+-------------
            2 | Andrew          | Comercial    |        2009
            3 | Valerie         | Informatica  |        2000
            4 | Karl            | Informatica  |        2008
            5 | Kevin           | Finanzas     |        2010
 (4 filas)

.. note::

 Podemos observar que la consulta realizada retorna los registros que cumplen con una 
 de las dos condiciones o cuando se cumplen las dos al mismo tiempo.

Esta consulta presentó un ejemplo básico de una consulta SELECT-FROM-WHERE de la 
mayoría de las consultas SQL. La palabra clave FROM entrega la relación o relaciones
de donde se obtiene la información (tablas). En estos ejemplos, se utilizaron dos comparaciones 
unidas por la condición "AND" y "OR". 

El atributo *departamento* de la tabla **Empleados** es probada por igualdad contra la 
constante 'Informática'. Esta constante corresponde a una cadena de caracteres de largo 
variable que en SQL como se detalló en la lectura anterior se denomina como VARCHAR(n) y 
que al momento del *ingreso* de los datos a las tablas se escribe entre comillas simples.

Como se mencionó anteriormente, la consulta del tipo SELECT-FROM-WHERE busca la 
información de una o más relaciones que cumplan con ciertas condiciones. Hasta ahora 
sólo se ha visto qué pasa si se comparan atributos de las relaciones con constantes. 
Pero ¿cómo se pueden comparar los valores almacenados de  atributos que están en varias relaciones?.

El ejemplo anterior se podría realizar de otra manera para poder combinar dos relaciones 
(tablas) a la hora de realizar la consulta, pero primero debemos realizar la *creación* de la 
tabla **Empleados** y **Departamentos**.

.. warning::

 Antes de realizar la *creación* de las tablas, hay que borrar la tabla **Empleados**
 con un :sql:`DROP TABLE Empleados`.

Para poder realizar el ejemplo debemos crear la tabla de **Departamentos**.

.. code-block:: sql

 postgres=# CREATE TABLE Departamentos(id_departamento serial, departamento VARCHAR(30), PRIMARY KEY(id_departamento));

retornando PostgreSQL que la tabla **Departamentos** ha sido correctamente creada.::

 NOTICE:  CREATE TABLE creará una secuencia implícita «departamentos_id_departamento_seq» para la columna serial «departamentos.id_departamento»
 NOTICE:  CREATE TABLE / PRIMARY KEY creará el índice implícito «departamentos_pkey» para la tabla «departamentos»
 CREATE TABLE

Y ahora creamos la tabla **Empleados**.

.. code-block:: sql

 postgres=# CREATE TABLE Empleados(id_empleados serial, nombre_empleado VARCHAR(30), id_departamento INTEGER, ano_ingreso INTEGER, PRIMARY KEY(id_empleados), FOREIGN KEY(id_departamento) REFERENCES Departamentos(id_departamento));

retornando PostgreSQL que la tabla **Empleados** ha sido correctamente creada.::

 NOTICE:  CREATE TABLE creará una secuencia implícita «empleados_id_empleados_seq» para la columna serial «empleados.id_empleados»
 NOTICE:  CREATE TABLE / PRIMARY KEY creará el índice implícito «empleados_pkey» para la tabla «empleados»
 CREATE TABLE

ahora debemos *ingresar* los datos en la tabla **Departamentos** y **Empleados**.

.. code-block:: sql
 
 postgres=# INSERT INTO Departamentos(departamento) VALUES('Administracion');
 INSERT 0 1
 postgres=# INSERT INTO Departamentos(departamento) VALUES('Informatica');
 INSERT 0 1
 postgres=# INSERT INTO Departamentos(departamento) VALUES('Finanzas');
 INSERT 0 1
 postgres=# INSERT INTO Departamentos(departamento) VALUES('Comercial');
 INSERT 0 1

 postgres=# INSERT INTO Empleados(nombre_empleado, id_departamento, ano_ingreso) VALUES('Edgar', 1, 2000);
 INSERT 0 1
 postgres=# INSERT INTO Empleados(nombre_empleado, id_departamento, ano_ingreso) VALUES('Andrew', 4, 2009);
 INSERT 0 1
 postgres=# INSERT INTO Empleados(nombre_empleado, id_departamento, ano_ingreso) VALUES('Valerie', 2, 2000);
 INSERT 0 1
 postgres=# INSERT INTO Empleados(nombre_empleado, id_departamento, ano_ingreso) VALUES('Karl', 2, 2008);
 INSERT 0 1
 postgres=# INSERT INTO Empleados(nombre_empleado, id_departamento, ano_ingreso) VALUES('Kevin', 3, 2010);
 INSERT 0 1

Ahora realizamos la siguiente consulta, encontrar en la tabla **Empleados** el registro
de la(s) personas que sean del departamento de 'Informatica' y que su año de ingreso 
sea mayor o igual al año 2005.

.. code-block:: sql

 postgres=# SELECT * FROM Empleados, Departamentos WHERE Empleados.id_departamento=Departamentos.id_departamento AND Empleados.ano_ingreso>=2005 AND Departamentos.departamento='Informatica';
  id_empleados | nombre_empleado | id_departamento | ano_ingreso | id_departamento | departamento 
 --------------+-----------------+-----------------+-------------+-----------------+--------------
             4 | Karl            |               2 |        2008 |               2 | Informatica
 (1 fila)

.. note::

 Es posible dar referencia a un atributo de cada tabla con **nombre_tabla.atributo**, para 
 realizar las condiciones. 

Independientemente del tipo de consulta, el resultado de una comparación es un valor booleano, es decir retorna valores TRUE o FALSE, los
cuales se pueden combinar con sus operadores AND, OR y NOT, con sus respectivos significados.

A modo de repaso, los operadores lógicos mencionados son:

    * :sql:`AND`: Retorna TRUE siempre y cuando TODOS los atributos a comparar sean TRUE. Si hay AL MENOS UN valor FALSE, retornará FALSE.
            Su tabla de verdad es:

      .. math::

       \begin{array}{|c|c|c|}
        \hline
        \textbf{P} & \textbf{Q} & \textbf{AND} \\
        \hline
        \text{True}       & \text{True}       &  \text{True}   \\
        \text{True}       & \text{False}      &  \text{False}  \\
        \text{False}      & \text{True}       &  \text{False}  \\
        \text{False}      & \text{False}      &  \text{False}  \\
        \hline
       \end{array}

    * :sql:`OR`: Retorna TRUE siempre y cuando AL MENOS UNO de los atributos a comparar sea TRUE. Si TODOS los valores son FALSE, retornará FALSE.
            Su tabla de verdad es:

      .. math::

       \begin{array}{|c|c|c|}
        \hline
        \textbf{P} & \textbf{Q} & \textbf{OR} \\
        \hline
        \text{True}       & \text{True}       &  \text{True}  \\
        \text{True}       & \text{False}      &  \text{True}  \\
        \text{False}      & \text{True}       &  \text{True}  \\
        \text{False}      & \text{False}      &  \text{False}  \\
        \hline
       \end{array}

    * :sql:`NOT`: Retorna el valor contrario al valor actual, es decir que si el valor es TRUE, retorna FALSE y vice versa.
            Su tabla de verdad es

      .. math::

       \begin{array}{|c|c|c|}
        \hline
        \textbf{P} & \textbf{NOT P} \\
        \hline
        \text{True}       & \text{False}  \\
        \text{False}      & \text{True}   \\
        \hline
       \end{array}

.. note::

 SQL no distingue entre mayúsculas y minúsculas.    
 Por ejemplo, :sql:`FROM` (palabra reservada) es equivalente a :sql:`from`,           
 inclusive a :sql:`From`.                                                             
 Para los nombres de atributos, relaciones, etc., también ocurre lo mismo.       
 El único caso en que se distingue entre mayúsculas y minúsculas es al momento de     
 encerrar un string entre *' '*. Por ejemplo *'PALABRA'* es diferente a *'palabra'*.  
                                                                                    

Resultados Repetidos
~~~~~~~~~~~~~~~~~~~~~

Al realizar una consulta SELECT, no hay omisión de resultados repetidos, este "problema" se soluciona agregando DISTINCT a la consulta.

.. code-block:: sql

        SELECT FROM WHERE
        SELECT DISTINCT FROM WHERE

En el ejemplo anterior también es posible eliminar los resultados repetidos, puesto que
existen muchas personas que trabajan en el mismo departamento, pero si eliminamos las 
repeticiones solo nos retornaran los departamentos que existen.


Primero mostraremos un resultado con una consulta con repeticiones.

.. code-block:: sql

 postgres=# SELECT Departamentos.departamento, Empleados.id_departamento FROM Empleados, Departamentos WHERE Empleados.id_departamento=Departamentos.id_departamento;     departamento  | id_departamento 
 ----------------+-----------------
  Administracion |               1
  Comercial      |               4
  Informatica    |               2
  Informatica    |               2
  Finanzas       |               3
 (5 filas)

.. note::

 Según los datos que se ingresaron en la tabla **Empleados** existe más de una persona
 en el departamento de 'Informática'.

Y ahora realizamos una consulta sin repeticiones.

.. code-block:: sql

 postgres=# SELECT DISTINCT Departamentos.departamento, Empleados.id_departamento FROM Empleados, Departamentos WHERE Empleados.id_departamento=Departamentos.id_departamento;
   departamento  | id_departamento 
 ----------------+-----------------
  Administracion |               1
  Informatica    |               2
  Comercial      |               4
  Finanzas       |               3
 (4 filas)

.. note::

 Se puede notar que solo nos retorna los departamentos que existen.
 
SELECT-BY-ORDER
~~~~~~~~~~~~~~~

.. index:: SELECT-BY-ORDER

Hasta este momento, es posible obtener datos de una tabla utilizando los comandos SELECT y WHERE. Sin embargo, muchas veces es
necesario enumerar el resultado en un orden particular. Esto podría ser en orden ascendente, en orden descendente, o podría basarse en
valores numéricos o de texto. En tales casos, podemos utilizar la palabra clave ORDER BY para lograr esto.

.. code-block:: sql

        SELECT "L"
        FROM "R"
        WHERE "C"
        ORDER BY "O" [ASC, DESC];

donde:

  * "L" corresponde a la lista de atributos que se requieren, por lo general se asocia a una(s) columna(s).
  * "R" corresponde al nombre de la relación, que por lo general se asocia a una tabla.
  * "C" corresponde a la condición de la selección.
  * "O" corresponde a cómo será ordenada la lista "L".
  * ASC corresponde a un orden ascendente (corresponde a la opción por defecto)
  * DESC corresponde a uno descendente.

Estrictamente, su sintaxis corresponde a ORDER BY y luego una lista de atributos que definirán los campos a ordenar:

.. code-block:: sql

        SELECT atributo1, atributo2 ...
        FROM Clientes ORDER BY atributo_ordenar_primero, atributo_ordenar_segundo...

Como se puede apreciar, con la sentencia ORDER BY se pueden ordenar las consultas a través de múltiples atributos. En este caso todos los
campos estarían ordenados de forma ascendente (ASC).

Podemos utilizar los mismos ejemplos que creamos anteriormente ordenando los nombres
de los empleados de la tabla **Empleados**.

.. code-block:: sql

 postgres=# SELECT * FROM Empleados ORDER BY nombre_empleado;
  id_empleados | nombre_empleado | id_departamento | ano_ingreso 
 --------------+-----------------+-----------------+-------------
             2 | Andrew          |               4 |        2009
             1 | Edgar           |               1 |        2000
             4 | Karl            |               2 |        2008
             5 | Kevin           |               3 |        2010
             3 | Valerie         |               2 |        2000
 (5 filas)

Que es lo mismo que escribir.

.. code-block:: sql

 postgres=# SELECT * FROM Empleados ORDER BY nombre_empleado ASC;
  id_empleados | nombre_empleado | id_departamento | ano_ingreso 
 --------------+-----------------+-----------------+-------------
             2 | Andrew          |               4 |        2009
             1 | Edgar           |               1 |        2000
             4 | Karl            |               2 |        2008
             5 | Kevin           |               3 |        2010
             3 | Valerie         |               2 |        2000
 (5 filas)

Y de forma descendiente sería de la siguiente manera.

.. code-block:: sql

 postgres=# SELECT * FROM Empleados ORDER BY nombre_empleado DESC;
  id_empleados | nombre_empleado | id_departamento | ano_ingreso 
 --------------+-----------------+-----------------+-------------
             3 | Valerie         |               2 |        2000
             5 | Kevin           |               3 |        2010
             4 | Karl            |               2 |        2008
             1 | Edgar           |               1 |        2000
             2 | Andrew          |               4 |        2009
 (5 filas)

También es posible realizarlo con números o fechas.

.. code-block:: sql

 postgres=# SELECT * FROM Empleados ORDER BY ano_ingreso DESC;
  id_empleados | nombre_empleado | id_departamento | ano_ingreso 
 --------------+-----------------+-----------------+-------------
             5 | Kevin           |               3 |        2010
             2 | Andrew          |               4 |        2009
             4 | Karl            |               2 |        2008
             1 | Edgar           |               1 |        2000
             3 | Valerie         |               2 |        2000
 (5 filas)

