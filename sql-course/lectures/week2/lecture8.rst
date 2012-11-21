Lectura 8 - Table variables and set operators
------------------------------------------------
.. role:: sql(code)
   :language: sql
   :class: highlight

Table Variables
~~~~~~~~~~~~~~~

.. index:: Table Variables

Consideremos las siguientes tablas::

        College (cName, state, enrollment)
        Student (sID, sName, Average)
        Apply (sID, cName, major, decision)

las cuales representar un sistema simple de postulación de estudiantes a establecimientos educacionales, y son creadas mediante:

.. code-block:: sql

 CREATE TABLE College(id serial, cName VARCHAR(20), state VARCHAR(30), enrollment INTEGER, PRIMARY KEY(id));
 CREATE TABLE Student(sID serial, sName VARCHAR(20), Average INTEGER, PRIMARY kEY(sID));
 CREATE TABLE Apply(sID INTEGER, cName VARCHAR(20), major VARCHAR(30), decision BOOLEAN, PRIMARY kEY(sID, cName, major));

Se utilizarán 4 establecimientos educacionales:

.. code-block:: sql
        
 INSERT INTO College (cName, state, enrollment) VALUES ('Stanford','CA',15000);
 INSERT INTO College (cName, state, enrollment) VALUES ('Berkeley','CA',36000);
 INSERT INTO College (cName, state, enrollment) VALUES ('MIT','MA',10000);
 INSERT INTO College (cName, state, enrollment) VALUES ('Harvard','CM',23000);

4 estudiantes: 

.. code-block:: sql
        
 INSERT INTO Student (sName, Average) Values ('Amy', 60);
 INSERT INTO Student (sName, Average) Values ('Edward', 65);
 INSERT INTO Student (sName, Average) Values ('Craig', 50);
 INSERT INTO Student (sName, Average) Values ('Irene', 49);

y 6 postulaciones:

.. code-block:: sql

 INSERT INTO Apply (sID, cName, major, decision) VALUES (1, 'Stanford', 'science', True);
 INSERT INTO Apply (sID, cName, major, decision) VALUES (1, 'Stanford', 'engineering', False);
 INSERT INTO Apply (sID, cName, major, decision) VALUES (2, 'Berkeley', 'natural hostory', False);
 INSERT INTO Apply (sID, cName, major, decision) VALUES (3, 'MIT', 'math', True);
 INSERT INTO Apply (sID, cName, major, decision) VALUES (3, 'Harvard', 'science', False);
 INSERT INTO Apply (sID, cName, major, decision) VALUES (4, 'Stanford', 'marine biology', True);


Ejemplo 1
^^^^^^^^^
En este ejemplo se busca la información del nombre e id de los  alumnos, que postulan a uno o más establecimientos educacionales con 
determinado Average:

.. code-block:: sql

  SELECT Student.sID, sName, Apply.cName, Average FROM Student, Apply WHERE Apply.sID = Student.sID;
  
cuya salida es::

  sid | sname  |  cname   | Average
  ----+--------+----------+-----
   1 | Amy     | Stanford |  60
   1 | Amy     | Stanford |  60
   2 | Edward  | Berkeley |  65
   3 | Craig   | MIT      |  50
   3 | Craig   | Harvard  |  50
   4 | Irene   | Stanford |  49

.. note::
  
   Notese que existe un supuesto duplicado en las primeras filas. Esto es debido a que Amy postuló a "science" y a "engineering" en Stanford. Esto
   puede evitarse utilizando **SELECT DISTINCT** en lugar de **SELECT**.

también es posible realizarla como:

.. code-block:: sql

 SELECT S.sID, sName, A.cName, Average FROM Student S, Apply A WHERE A.sID = S.sID;

cuya salida es::

   sid | sname  |  cname   | Average
   ----+--------+----------+-----
   1 | Amy     | Stanford |  60
   1 | Amy     | Stanford |  60
   2 | Edward  | Berkeley |  65
   3 | Craig   | MIT      |  50
   3 | Craig   | Harvard  |  50
   4 | Irene   | Stanford |  49

.. note::

   Al igual que en la consulata anterior, es posible evitar el valor duplicado utilizando **SELECT DISTINCT** en lugar de **SELECT**.

.. CMA: no entiendo esto...

Como se aprecia, es posible asignar variables a las relaciones "R" y utilizar dichas variables tanto en la lista "L" como en la
condición "C". ¿Cuál es la utilidad de esto?, más allá de escribir menos (dependiendo del nombre de la variable
utilizada); en los casos en que se deben comparar múltiples instancias de la misma relación, como se verá en el ejemplo 2.

.. note::
   El por qué de la nomenclatura "L", "R" y "C" y su significado están explicados en la lectura 7

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
        (sName, Average, sizeHS)
        VALUES
        ('amy', 30, 'A'),
        ('doris', 40, 'B'),
        ('edward', 40, 'C');


.. CMA:        INSERT INTO Apply
        (cName, major, decision)VALUES
        ('Stanford', 'phd', 'mayor'),
        ('Berkeley', 'pregrado', 'minor'),
        ('MIT', 'ingenieria', 'mayor');



Ejemplo 2
^^^^^^^^^

Cuidado con los duplicados!!

Si el lector se fija en la situación descrita, los nombres de algunos atributos de diferentes relaciones y/o tablas  se repiten, lo cual
podría plantear la interrogante ¿a que tabla se refiere el atributo en cuestión?. Para resolver este pequeño gran problema, se precede al
nombre del atributo con el nombre de la tabla y un punto, es decir::

  "NombreTabla.atributo"

Concretamente en el ejemplo anterior, el alcance de nombres lo protagonizan *sID* de la tabla Student y *sID* de la tabla Apply.
La diferencia se realiza a través de:

.. code-block:: sql

        Student.sID o S.sID
        Apply.sID o  A.sID



Para la realización de este ejemplo, supongase que al último momento, llegan los papeles de un postulante más, por lo que el administrador
de la base de datos deberá agregar la información necesaria, es decir:

.. code-block:: sql

 INSERT INTO Student (sName, Average) Values ('Tim', 60);


En variadas ocasiones, los nombres de los atributos se repiten, dado que se comparan dos instancias de una tabla. En el este ejemplo,
se buscan todos los pares de estudiantes con el mismo Average:

.. code-block:: sql

        SELECT S1.sID, S1.sName, S1.Average, S2.sID, S2.sName, S2.Average
        FROM Student S1, Student S2
        WHERE S1.Average = S2.Average;


Al momento de realizar esta consulta (dos instancias de una tabla), el resultado contendrá uno o varios duplicados; por ejemplo,
consideremos a los 5 estudantes::


   sid | sname  | Average
   ----+--------+----- 
   1 | Amy      |  60
   2 | Edward   |  65
   3 | Craig    |  50
   4 | Irene    |  49
   5 | Tim      |  60

.. note::
   La tabla de arriba se obtuvo realizando la consulta :SQL: 'SELECT * FROM Student;'    

Los pares de estudiantes serán::

         Amy    -       Tim

pero la salida muestra::

        sid | sname  | Average | sid | sname  | Average
        ----+--------+-----+-----+--------+-----
        1   | Amy    |  60 |   5 | Tim    | 60
        1   | Amy    |  60 |   1 | Amy    | 60
        2   | Edward |  65 |   2 | Edward | 65
        3   | Craig  |  50 |   3 | Craig  | 50
        4   | Irene  |  49 |   4 | Irene  | 49
        5   | Tim    |  60 |   5 | Tim    | 60
        5   | Tim    |  60 |   5 | Amy    | 60



lo cual se puede evitar modificando la cosulta

.. code-block:: sql

        SELECT S1.sID, S1.sName, S1.Average, S2.sID, S2.sName, S2.Average
        FROM Student S1, Student S2
        WHERE S1.Average = S2.Average and S1.sID <> S2.sID;

es decir, que el id del estudiante S1 sea diferente al id del estudiante S2; en cuyo caso la salida de la consulta es::

        sid | sname  | Average | sid | sname  | Average
        ----+--------+-----+-----+--------+-----
        1   | Amy    |  60 |   5 | Tim    | 60
        5   | Tim    |  60 |   1 | Amy    | 60
    

Set Operators
~~~~~~~~~~~~~~~

.. index:: Set Operators

Los Operadores de conjunto son 3:

  * Unión
  * Intersección
  * Excepción


A continuación se explicará cada uno con un ejemplo:


Unión
^^^^^^

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


y pobladas con los datos mostrados a continuación:

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


Hay que tener en cuenta que existe en ambas tablas un empleado con el mismo nombre "Svendson, Stephen". Sin embargo en la
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
   En el ejemplo anterior, se utiliza "as name" en ambos SELECT. Es un hecho curioso que, si se utilizan diferentes nombres junto al "as",
   digamos "as nombre1" y "as nombre2", queda como nombre de la tabla UNION el primero en ser declarado, en este caso nombre1. 


Intersección
^^^^^^^^^^^^^

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

Excepción
^^^^^^^^^^

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

Hay que tener en cuenta que, a diferencia de los operadores anteriores, la salida de este no es conmutativa, pues si se ejecuta la 
consulta de forma inversa,es decir:

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
