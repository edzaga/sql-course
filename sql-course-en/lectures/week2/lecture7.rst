Lecture 7 - Basic SELECT Statement
-----------------------------------
.. role:: sql(code)
   :language: sql
   :class: highlight

It corresponds to the simplest form of doing a query in SQL, which is used to ask for those tuples of a relation that 
satisfies a condition. It is analogous to the selection in relational algebra. This query, like most of those carried 
out in this programming language, use 3 keywords: :sql:`SELECT` - :sql:`FROM` - :sql:`WHERE`.

In simple words, what is sought with this query is to select certain information (:sql:`SELECT`) of any table (:sql:`FROM`)
that satisfies (:sql:`WHERE`) certain conditions: For example:

.. code-block:: sql

   Get the names of the students that were born in the month of November 
   SELECT "the names" FROM "students" WHERE "that were born in the month of November"c

Note that in this example, it is inferred the existence of a table named “students” which holds personal data of certain students. 

From the Relational Algebra
~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. index:: From the Relational Algebra

The operator of selection in Relational Algebra make used of the keyword :sql:`WHERE`. Generally, these expressions that
follow this keyword include conditional expressions. We can build expressions by comparing the values (such as data 
integer data types, strings of characters, etc) using the 6 operators most common of comparison:

  * ``=``   “equal to”
  * ``<>``  “different to” or “not equal”
  * ``<``   “less than”
  * ``>``   “greater than”
  * ``<=``  "less than or equal to”
  * ``>=``  “greater than or equal to”

These operators have the same meaning as in C language, and the only difference is the symbol “<>” which corresponds 
to “different to”; the C language uses the symbol “!=” for this comparison. Following the comparison between these
languages, the symbol of equality in SQL correspond to “=”, while in C is “==.”

These values can be compared including constants and attributes of the realtions named after the keyword :sql:`FROM`. 
In the example, would correspond to the attribute of the individual’s birth month with the month of November. 

Some examples of comparison:


.. code-block:: sql

	StudioName = 'Ubisoft' : it is compare that the attribute studioName is 'Ubisoft'
	mesesVidaUtil <> 5 : it is compared that the attribute monthsServiceLife is not equal to 5
	monthBirth = 'November':  it is compared that the attribute monthBirth is equal to 'November'

        
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
 (4 rows)

.. note::

 Podemos observar que la consulta realizada retorna los registros que cumplen con una 
 de las dos condiciones o cuando se cumplen las dos al mismo tiempo.

This query exhibits the typical :sql:`SELECT` - :sql:`FROM` - :sql:`WHERE` of the majority of the SQL queries.
La palabra clave FROM entrega la relación o relaciones
de donde se obtiene la información (tablas). En estos ejemplos, se utilizaron dos comparaciones 
unidas por la condición "AND" y "OR". 

El atributo *departamento* de la tabla **Empleados** es probada por igualdad contra la 
constante 'Informática'. Esta constante corresponde a una cadena de caracteres de largo 
variable que en SQL como se detalló en la lectura anterior se denomina como VARCHAR(n) y 
que al momento del *ingreso* de los datos a las tablas se escribe entre comillas simples.

As it was mentioned before, the query of the :sql:`SELECT` - :sql:`FROM` - :sql:`WHERE` type
search the information of one or more relations that meets with certain conditions. So far we
have only seen what happens if we compare attributes of the relations with constants. Nevertheless, 
how can you compare the stored values of attributes which are in several relations?  


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
 (5 rows)

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
 (4 rows)

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
 (5 rows)

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
 (5 rows)

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
 (5 rows)

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
 (5 rows)

