Lecture 8 - Table variable and set operators
--------------------------------------------
.. role:: sql(code)
   :language: sql
   :class: highlight

Table Variables
~~~~~~~~~~~~~~~

.. index:: Table Variables

Consideremos la siguiente situación ::

        College (cName, state, enrollment)
        Student (sID, sName, GPA, sizeHS)
        Apply (sID, cName, major, decision)

la cual es posible replicar mediante

.. code-block:: sql
   
    CREATE TABLE College
        (
     id int auto_increment primary key, 
     cName varchar(20), 
     state varchar(30),
     enrollment varchar(40)
    );

    CREATE TABLE Student
        (
     sID int auto_increment primary key, 
     sName varchar(20), 
     GPA integer,
     sizeHS varchar(40)
    );

   CREATE TABLE Apply
        (
     sID int auto_increment primary key, 
     cName varchar(20), 
     major varchar(30),
     decision varchar(40)
    );


.. joao: agregar el contexto del ejercicio y los INSERT INTO con valores utiles

Ahora consideremos la siguente consulta

.. code-block:: sql
        
        SELECT Student.sID, sName, Apply.cName, GPA
        FROM Student, Apply
        WHERE Apply.sID = Student.sID;

es posible realizarla como

.. code-block:: sql

        SELECT S.sID, sName, A.cName, GPA
        FROM Student S, Apply A
        WHERE A.sID = S.sID;

En cualquier caso la salida será la misma.

Como se aprecia, es posible asignar valores variables a las relaciones "R" y utilizar dichas variables tanto en la lista "L" como en la 
condición "C". El lector se preguntará cuál es la utilidad de esto, más allá de escribir menos (dependiendo del nombre de la variable
utilizada); y la respuesta corresponde a los casos en que se deben comparar múltiples instancias de la misma relación, como se verá a más 
adelante en esta misma lectura.

.. note::
   El por qué de la nomenclatura "L", "R" y "C" y su significado están explicados en la lectura 7


Eso es, la variable de la tabla?(table variable, no se como traducirlo, pq corresponde más a variable en la consulta).
La variable en la consulta se define en el "FROM" de la consulta "SELECT-FROM-WHERE"


Se invita al lector alplicado a realizar pruebas, se dejan las siguientes lineas de código a su disposición, con el fin de
probar que efectivamente si se realizan las consultas mencionadas arriba, el resultado es el mismo. Cabe destacar que 

.. code-block:: sql

        INSERT INTO "R"
        (Columna1, Columna2,..., ColumnaN)
        VALUES
        (Valor Columna1Fila1, Valor Columna2Fila1,..., Valor ColumnaNFila1),
        (Valor Columna2Fila1, Valor Columna2Fila2,..., Valor ColumnaNFila2),
        ...
        (Valor Columna1FilaN, Valor Columna2FilaN,..., Valor ColumnaNFilaN),

corresponde a la sentencia para ingresar datos a una tabla en particular, conociendo su estructura y tipos de datos.
El lector puede utilizar los  siguientes valores y realizar modificaciones.

.. code-block:: sql

        INSERT INTO College
        (cName, state, enrollment)
        VALUES
        ('Stanford', 'stanford', 'lalalla'),
        ('Berkeley', 'miami', 'mayor'),
        'MIT', 'masachusets', 'minor');


        INSERT INTO Student
        (sName, GPA, sizeHS)
        VALUES
        ('lala', 30, 'hjkljk'),
        ('lolo', 60, 'asads'),
        ('lele', 40, 'qweqwe');


        INSERT INTO Apply
        (cName, major, decision)E        VALUES
        ('Stanford', 'phd', 'zxczcx'),
        ('Berkeley', 'pregrado', 'sdfsd'),
        ('MIT', 'ingenieria', 'rtert');


============================
Cuidado con los duplicados!!
============================

Si el lector se fija en la situación descrita, los nombres de algunos atributos de diferentes relaciones y/o tablas  se repiten, lo cual
podría plantear la interrogante ¿a que tabla se refiere el atributo en cuestión?. Para resolver este pequeño gran problema, se precede al
nombre del atributo con el nombre de la tabla y un punto, es decir, 


.. code-block:: sql
        
        "algo_asi."

Concretamente en el ejemplo anterior, el alcance de nombres lo protagonizan sID de la tabla Student y sID de la tabla Apply. 
La diferencia se realiza a través de

.. code-block:: sql

        Student.sID ó S.sID
        Apply.sID ó A.sID


En variadas ocasiones, los nombres de los atributos se repiten, dado que se comparan dos instancias de una tabla. En el siguiente ejemplo, 
se buscan todos los pares de estudiantes con el mismo GPA

.. code-block:: sql

        SELECT S1.sID, S1.sName, S1.GPA, S2.sID, S2.sName, S2.GPA
        FROM Student S1, Student S2
        WHERE S1.GPA = S2.GPA;

Ojo!!! Al momento de realizar esta consulta (dos instancias de una tabla), el resultado contendrá uno o varios duplicados; por ejemplo, 
consideremos 3 estudantes

.. math::

 \begin{array}{|c|c|c|}
  \hline
  \textbf{sName} & \textbf{sID} & \textbf{GPA} \\
  \hline
  Amy         & 123      &  4.0   \\
  Doris       & 456      &  4.0  \\
  Edward      & 567      &  4.1  \\ 
  \hline  
 \end{array}

.. sName   sID     GPA
   Amy     123     4.0
   Doris   456     4.0
   Edward  567     4.1

Los pares de estudiantes serán::

         Amy    -       Doris

pero también::

         Amy    -       Amy
         Doris  -       Doris

lo cual se puede evitar modificando la cosulta

.. code-block:: sql

        SELECT S1.sID, S1.sName, S1.GPA, S2.sID, S2.sName, S2.GPA
        FROM Student S1, Student S2
        WHERE S1.GPA = S2.GPA and S1.sID <> S2.sID

es decir, que el id del estudiante S1 sea diferente al id del estudiante S2.

Set Operators
~~~~~~~~~~~~~~~

.. index:: Set Operators

Los Set Operators son 3:

  * Unión
  * Intersección
  * Excepción

=====
Unión
=====

El operador "UNION", permite combinar el resultado de dos o más sentencias SELECT. Es necesario que estas tengan el mismo número de columnas, 
y que, además tengan los mismos tipos de datos, por ejemplo:

.. code-block:: sql

     Employees_Norway":
        E_ID    E_Name
        01      Hansen, Ola
        02      Svendson, Tove
        03      Svendson, Stephen
        04      Pettersen, Kari

        "Employees_USA":
        E_ID    E_Name
        01      Turner, Sally
        02      Kent, Clark
        03      Svendson, Stephen
        04      Scott, Stephen

Que se puede crear mediante la creación de las tablas

.. code-block:: sql

    CREATE TABLE Employees_Norway
        (
     E_ID int auto_increment primary key, 
     E_Name varchar(50)
    );

    CREATE TABLE Employees_USA
        (
     E_ID int auto_increment primary key, 
     E_Name varchar(50) 
    );



y el relleno con los datos mostrados en el ejemplo

.. code-block:: sql

        INSERT INTO Employees_Norway
        (E_Name)
        VALUES
        ('Hansen, Ola'),
        ('Svendson, Tove'),
        ('Svendson, Stephen'),
        ('Pettersen, Kari');
        
        INSERT INTO Employees_USA
        (E_Name)
        VALUES
        ('Turner, Sally'),
        ('Kent, Clark'),
        ('Svendson, Stephen'),
        ('Scott, Stephen');

El resultado de la consulta

.. code-block:: sql

        SELECT E_Name FROM Employees_Norway
        UNION
        SELECT E_Name FROM Employees_USA;


es

.. code-block:: sql

        E_Name
        Hansen, Ola
        Svendson, Tove
        Svendson, Stephen
        Pettersen, Kari
        Turner, Sally
        Kent, Clark
        Scott, Stephen


Ojo, existen dos empleados con el mismo nombre en ambas tablas. Sin embargo en la
salida sólo se nombra uno. Para evitar esto, se utliza "UNION ALL"

.. code-block:: sql

        SELECT E_Name as name FROM Employees_Norway
        UNION ALL
        SELECT E_Name as name FROM Employees_USA;

Utilizando "as" es posible cambiar el nombre de la columna resultado

.. code-block:: sql

        NAME
        Hansen, Ola
        Svendson, Tove
        Svendson, Stephen
        Pettersen, Kari
        Turner, Sally
        Kent, Clark
        Svendson, Stephen
        Scott, Stephen

se aprecia que la salida contiene los nombres de ambos empleados.

.. note::
   En el ejemplo anterior, se utilizaba "as name" en ambos SELECT. Como hecho curioso, si se utilizan diferentes nombres junto al "as"
   como por ejemplo, "as name" y "as lala", queda como nombre de la tabla UNION el primero en ser declarado.


============
Intersección
============

Muy similar al operador UNION, INTERSECT también opera con dos sentencias SELECT. La diferencia consiste en que UNION actua como un OR, e INTERSECT
lo hace como AND. 

.. note::
   Las tablas de verdad de estos OR y AND se encuentran en la lectura 7.

Es decir que INTERSECT devuelve los valores repetidos.

Consideremos el sigueinte esquema::

        Table Store_Information
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

Para llegar a esta situación, el lector puede crear las tablas

.. code-block:: sql


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
y llenarlas con los siguientes datos

.. code-block:: sql 

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


Al realizar la consulta

.. code-block:: sql

        SELECT Date FROM Store_Information
        INTERSECT
        SELECT Date FROM Internet_Sales;

Su resultado esperado es::

        Date
        Jan-07-1999


.. Duda: agregar lo de que ciertos motores de bases de datos no soportan este operador(buscar cuales en particular y nombrarlos),
   pero que puede escribirse como otra consulta (agregarla)

=========
Excepción
=========

Similar a los operadores anteriores, su estructura se compone de dos o mas sentencias SELECT, y el operador EXCEPT. Es equivalente a la diferencia
en el álgebra relacional.

Utilizando la misma situación del ejemplo anterior, y realizando la siguiente consulta

.. code-block:: sql

        SELECT Date FROM Store_Information
        EXCEPT
        SELECT Date FROM Internet_Sales;

Su resultado esperado es::

        Date
        Jan-10-1999
        Jan-11-1999
        Jan-12-1999

Es decir devuelve los resultados que no se repiten.

.. Duda: agregar lo de que ciertos motores de bases de datos no soportan este operador(buscar cuales en particular y nombrarlos),
  pero que puede escribirse como otra consulta (agregarla)
