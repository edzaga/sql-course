Lecture 8 - Table variables and set operators
--------------------------------------------
.. role:: sql(code)
   :language: sql
   :class: highlight

Table Variables
~~~~~~~~~~~~~~~

.. index:: Table Variables

Consideremos las siguientes tablas::

        College (cName, state, enrollment)
        Student (sID, sName, GPA, sizeHS)
        Apply (sID, cName, major, decision)

las cuales son creadas mediante:

.. code-block:: sql
   
 postgres=# CREATE TABLE College(id serial, cName VARCHAR(20), state VARCHAR(30), enrollment VARCHAR(40), PRIMARY KEY(id));

cuya salida es::

 NOTICE:  CREATE TABLE creará una secuencia implícita «college_id_seq» para la columna serial «college.id»
 NOTICE:  CREATE TABLE / PRIMARY KEY creará el índice implícito «college_pkey» para la tabla «college»
 CREATE TABLE

.. code-block:: sql

  postgres=# CREATE TABLE Student(sID serial, sName VARCHAR(20), GPA INTEGER, sizeHS VARCHAR(40), PRIMARY kEY(sID));

Su salida es::

 NOTICE:  CREATE TABLE creará una secuencia implícita «student_sid_seq» para la columna serial «student.sid»
 NOTICE:  CREATE TABLE / PRIMARY KEY creará el índice implícito «student_pkey» para la tabla «student»
 CREATE TABLE

.. code-block:: sql

 postgres=# CREATE TABLE Apply(sID serial, cName VARCHAR(20), major VARCHAR(30), decision VARCHAR(40), PRIMARY kEY(sID));

Recibiremos como respuesta lo siguiente::

 NOTICE:  CREATE TABLE creará una secuencia implícita «apply_sid_seq» para la columna serial «apply.sid»
 NOTICE:  CREATE TABLE / PRIMARY KEY creará el índice implícito «apply_pkey» para la tabla «apply»
 CREATE TABLE

Ahora se realizará el ingreso de los datos a las tablas:

.. code-block:: sql

 postgres=# INSERT INTO College(cName, state, enrollment) VALUES('Stanford', 'stanford', 'mayor');
 INSERT 0 1

 postgres=# INSERT INTO College(cName, state, enrollment) VALUES('Berkeley', 'miami', 'mayor');
 INSERT 0 1

 postgres=# INSERT INTO College(cName, state, enrollment) VALUES('MIT', 'masachusets', 'minor');
 INSERT 0 1

.. code-block:: sql

 postgres=# INSERT INTO Student(sName, GPA, sizeHS) VALUES('amy', 30, 'A');
 INSERT 0 1

 postgres=# INSERT INTO Student(sName, GPA, sizeHS) VALUES('doris', 40, 'B');
 INSERT 0 1

 postgres=# INSERT INTO Student(sName, GPA, sizeHS) VALUES('edward', 40, 'C');
 INSERT 0 1

.. code-block:: sql

 postgres=# INSERT INTO Apply(cName, major, decision) VALUES('Stanford', 'phd', 'mayor');
 INSERT 0 1

 postgres=# INSERT INTO Apply(cName, major, decision) VALUES('Berkeley', 'pregrado', 'minor');
 INSERT 0 1

 postgres=# INSERT INTO Apply(cName, major, decision) VALUES('MIT', 'ingenieria', 'mayor');
 INSERT 0 1

Ahora realizaremos la siguente consulta de selección de tabla:

.. code-block:: sql
 
 postgres=# SELECT Student.sID, sName, Apply.cName, GPA FROM Student, Apply WHERE Apply.sID = Student.sID;
  sid | sname  |  cname   | gpa 
 -----+--------+----------+-----
   1 | amy    | Stanford |  30
   2 | doris  | Berkeley |  40
   3 | edward | MIT      |  40
 (3 filas)

también es posible realizarla como:

.. code-block:: sql

 postgres=# SELECT S.sID, sName, A.cName, GPA FROM Student S, Apply A WHERE A.sID = S.sID;
  sid | sname  |  cname   | gpa 
 -----+--------+----------+-----
   1 | amy    | Stanford |  30
   2 | doris  | Berkeley |  40
   3 | edward | MIT      |  40
 (3 filas)

.. CMA: no entiendo esto...

Como se aprecia, es posible asignar variables a las relaciones "R" y utilizar dichas variables tanto en la lista "L" como en la 
condición "C". El lector se preguntará cuál es la utilidad de esto, más allá de escribir menos (dependiendo del nombre de la variable
utilizada); y la respuesta corresponde a los casos en que se deben comparar múltiples instancias de la misma relación.

.. note::
   El por qué de la nomenclatura "L", "R" y "C" y su significado están explicados en la lectura 7

Así son las variables que se pueden asignar a las tablas. Estas variables en una consulta, se definen en el "FROM"  del 
"SELECT-FROM-WHERE".
.. Eso es, la variable de la tabla?(table variable, no se como traducirlo, pq corresponde más a variable en la consulta).
 La variable en la consulta se define en el "FROM" de la consulta "SELECT-FROM-WHERE"


.. CMA: Se invita al lector alplicado a realizar pruebas, se dejan las siguientes lineas de código a su disposición, con el fin de
.. CMA:probar que efectivamente si se realizan las consultas mencionadas arriba, el resultado es el mismo. Cabe destacar que 

.. CMA:.. code-block:: sql

.. CMA:        INSERT INTO "R"
        (Columna1,    (cName, state, enrollment)
        VALUES
        ('Stanford', 'stanford', 'mayor'),
        ('Berkeley', 'miami', 'mayor'),
        ('MIT', 'masachusets', 'minor');

.. Columna2,..., ColumnaN)
        VALUES
        (Valor Columna1Fila1, Valor Columna2Fila1,..., Valor ColumnaNFila1),
        (Valor Columna2Fila1, Valor Columna2Fila2,..., Valor ColumnaNFila2),
        ...
        (Valor Columna1FilaN, Valor Columna2FilaN,..., Valor ColumnaNFilaN),

.. CMA:corresponde a la sentencia para ingresar datos a una tabla en particular, conociendo su estructura y tipos de datos.
.. CMA El lector puede utilizar los  siguientes valores y realizar modificaciones.

.. CMA: (explicar mejor el contexto)

.. CMA:.. code-block:: sql

.. CMA:        INSERT INTO College
        (cName, state, enrollment)
        VALUES
        ('Stanford', 'stanford', 'mayor'),
        ('Berkeley', 'miami', 'mayor'),
        ('MIT', 'masachusets', 'minor');


.. CMA:        INSERT INTO Student
        (sName, GPA, sizeHS)
        VALUES
        ('amy', 30, 'A'),
        ('doris', 40, 'B'),
        ('edward', 40, 'C');


.. CMA:        INSERT INTO Apply
        (cName, major, decision)VALUES
        ('Stanford', 'phd', 'mayor'),
        ('Berkeley', 'pregrado', 'minor'),
        ('MIT', 'ingenieria', 'mayor');


============================
Cuidado con los duplicados!!
============================

Si el lector se fija en la situación descrita, los nombres de algunos atributos de diferentes relaciones y/o tablas  se repiten, lo cual
podría plantear la interrogante ¿a que tabla se refiere el atributo en cuestión?. Para resolver este pequeño gran problema, se precede al
nombre del atributo con el nombre de la tabla y un punto, es decir:


.. code-block:: sql
        
        "algo_asi."

Concretamente en el ejemplo anterior, el alcance de nombres lo protagonizan sID de la tabla Student y sID de la tabla Apply. 
La diferencia se realiza a través de:

.. code-block:: sql

        Student.sID o S.sID
        Apply.sID o  A.sID


En variadas ocasiones, los nombres de los atributos se repiten, dado que se comparan dos instancias de una tabla. En el siguiente ejemplo, 
se buscan todos los pares de estudiantes con el mismo GPA:

.. code-block:: sql

        SELECT S1.sID, S1.sName, S1.GPA, S2.sID, S2.sName, S2.GPA
        FROM Student S1, Student S2
        WHERE S1.GPA = S2.GPA;

Ojo!!! Al momento de realizar esta consulta (dos instancias de una tabla), el resultado contendrá uno o varios duplicados; por ejemplo, 
consideremos 3 estudantes:

.. math::

 \begin{array}{|c|c|c|}
  \hline
  \textbf{sID} & \textbf{sName} & \textbf{GPA} \\
  \hline
  1         & amy      &  30   \\
  2         & doris      &  40  \\
  3         & edward     &  40  \\ 
  \hline  
 \end{array}

.. sName   sID     GPA
   Amy     123     4.0
   Doris   456     4.0
   Edward  567     4.1

Los pares de estudiantes serán::

         doris    -       edward

pero la salida muestra::

        sid | sname  | gpa | sid | sname  | gpa
        ----+--------+-----+-----+--------+-----
        1   | amy    |  30 |   1 | amy    | 30   
        2   | doris  |  40 |   2 | doris  | 40  
        2   | doris  |  40 |   2 | doris  | 40 
        3   | edward |  40 |   3 | edward | 40
        3   | edward |  30 |   3 | edward | 40  
 

lo cual se puede evitar modificando la cosulta

.. code-block:: sql

        SELECT S1.sID, S1.sName, S1.GPA, S2.sID, S2.sName, S2.GPA
        FROM Student S1, Student S2
        WHERE S1.GPA = S2.GPA and S1.sID <> S2.sID;

es decir, que el id del estudiante S1 sea diferente al id del estudiante S2; en cuyo caso la salida de la consulta es::

        sid | sname  | gpa | sid | sname  | gpa
        ----+--------+-----+-----+--------+-----
        2   | doris  |  40 |   2 | doris  | 40 
        3   | edward |  40 |   3 | edward | 40


Set Operators
~~~~~~~~~~~~~~~

.. index:: Set Operators

Los Operadores de conjunto son 3:

  * Unión
  * Intersección
  * Excepción

=====
Unión
=====

El operador "UNION", permite combinar el resultado de dos o más sentencias SELECT. Es necesario que estas tengan el mismo número de columnas, 
y que, además tengan los mismos tipos de datos, por ejemplo, si se tienen las siguientes tablas:

.. code-block:: sql

     Employees_Norway:
        E_ID    E_Name
        1      Hansen, Ola
        2      Svendson, Tove
        3      Svendson, Stephen
        4      Pettersen, Kari

        Employees_USA:
        E_ID    E_Name
        1      Turner, Sally
        2      Kent, Clark
        3      Svendson, Stephen
        4      Scott, Stephen

Que se pueden crear mediante el comando CREATE TABLE:

.. code-block:: sql

    CREATE TABLE Employees_Norway (E_ID serial, E_Name varchar(50), PRIMARY KEY(E_ID));

    CREATE TABLE Employees_USA ( E_ID serial, E_Name varchar(50), PRIMARY KEY(E_ID));
    

y pobladas  con los datos mostrados a continuación:

.. code-block:: sql

        INSERT INTO Employees_Norway (E_Name)
        VALUES
        ('Hansen, Ola'),
        ('Svendson, Tove'),
        ('Svendson, Stephen'),
        ('Pettersen, Kari');
        
        INSERT INTO Employees_USA (E_Name)
        VALUES
        ('Turner, Sally'),
        ('Kent, Clark'),
        ('Svendson, Stephen'),
        ('Scott, Stephen');

El resultado de la siguiente consulta que incluye el operador UNION:

.. code-block:: sql

        SELECT E_Name FROM Employees_Norway
        UNION
        SELECT E_Name FROM Employees_USA;


es:

.. code-block:: sql

        e_name
      --------------
        Turner, Sally       
        Svendson, Tove
        Svendson, Stephen
        Pettersen, Kari
        Hansen, Ola
        Kent, Clark
        Scott, Stephen


Ojo, hay que tener en cuenta que existe en ambas tablas un empleado con el mismo nombre "Svendson, Stephen". Sin embargo en la
salida sólo se nombra uno. Si se desea que aparezcan "UNION ALL":

.. code-block:: sql

        SELECT E_Name as name FROM Employees_Norway
        UNION ALL
        SELECT E_Name as name FROM Employees_USA;

Utilizando "as" es posible cambiar el nombre de la columna donde quedará resultado:

.. code-block:: sql

        name
      ---------------
        Hansen, Ola
        Svendson, Tove
        Svendson, Stephen
        Pettersen, Kari
        Turner, Sally
        Kent, Clark
        Svendson, Stephen
        Scott, Stephen

se aprecia que la salida contiene los nombres de los empleados duplicados:

.. note::
   En el ejemplo anterior, se utiliza "as name" en ambos SELECT. Como hecho curioso, si se utilizan diferentes nombres junto al "as"
   como por ejemplo, "as name" y "as lala", queda como nombre de la tabla UNION el primero en ser declarado.


============
Intersección
============

Muy similar al operador UNION, INTERSECT también opera con dos sentencias SELECT. La diferencia consiste en que UNION actúa como un OR, 
e INTERSECT lo hace como AND. 

.. note::
   Las tablas de verdad de estos OR y AND se encuentran en la lectura 7.

Es decir que INTERSECT devuelve los valores repetidos.

Utilizando el ejemplo de los empleados, y ejecutando la consulta:

..         Table Store_Information
        store_name      Sales   Date
        Los Angeles     $1500   Jan-05-1999
        San Diego       $250    Jan-07-1999
        Los Angeles     $300    Jan-08-1999
        Boston  $700    Jan-08-1999
        Table Internet_Sales
        Date    Sales
        Jan-07-1999     $250
        Jan-10-1999     $535
        Jan-11-1999     $320
        Jan-12-1999     $750

.. Para llegar a esta situación, el lector puede crear las tablas
 code-block:: sql
    CREATE TABLE Store_Information
        (
     id int auto_increment primary key, 
     store_name varchar(20), 
     Sales integer,
     Date date
    );
    CREATE TABLE Internet_Sales
        (
     id int auto_increment primary key, 
     Date date,
     Sales integer
    );
.. y llenarlas con los siguientes datos
 ..code-block:: sql 
        INSERT INTO Store_Information
        (store_name, Sales, Date)
        VALUES
        ('Los Angeles', 1500, '1999-01-05'),
        ('San Diego', 250, '1999-01-07'),
        ('Los Angeles', 300, '1999-01-08');
        INSERT INTO Internet_Sales
        (Date, Sales)
        VALUES
        ('1999-01-07', 250),
        ('1999-01-10', 535),
        ('1999-01-11', 320),
        ('1999-01-12', 750);

.. Al realizar la consulta

.. code-block:: sql

        SELECT E_Name as name FROM Employees_Norway
        INTERSECT
        SELECT E_Name as name FROM Employees_USA;


su salida es::

        e_name
        ----------
        Svendson, Stephen

.. Duda: agregar lo de que ciertos motores de bases de datos no soportan este operador(buscar cuales en particular y nombrarlos),
   pero que puede escribirse como otra consulta (agregarla)

=========
Excepción
=========

Similar a los operadores anteriores, su estructura se compone de dos o mas sentencias SELECT, y el operador EXCEPT. Es equivalente a la diferencia
en el álgebra relacional.

Utilizando las mismas tablas de los empleados, y realizando la siguiente consulta:

.. code-block:: sql
        
        SELECT E_Name as name FROM Employees_Norway
        EXCEPT
        SELECT E_Name as name FROM Employees_USA;

Su salida es::

        e-name
        -----------
        Pettersen, Kari
        Svedson, Tove
        Hansen, Ola

Es decir, devuelve los resultados no repetidos en ambas tablas.

Ojo, a diferencia de los operadores anteriores, la salida de este no es conmutativa, pues si se ejecuta la consulta de forma inversa,
es decir:

.. code-block:: sql
        
        SELECT E_Name as name FROM Employees_USA
        EXCEPT
        SELECT E_Name as name FROM Employees_Norway;

su salida será:

.. code-block:: sql
        e-name
        ------------
        Turner, Sally
        Kent, Clark
        Scott, Stephen


.. Es decir devuelve los resultados que no se repiten.

.. Duda: agregar lo de que ciertos motores de bases de datos no soportan este operador(buscar cuales en particular y nombrarlos),
  pero que puede escribirse como otra consulta (agregarla)
