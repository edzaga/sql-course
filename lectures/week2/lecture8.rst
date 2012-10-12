Lecture 8 - Table variable and set operators
--------------------------------------------

Table Variables
~~~~~~~~~~~~~~~

.. index:: Table Variables

Consideremos el siguiente schema::

        College (cName, state, enrollment)
        Student (sID, sName, GPA, sizeHS)
        Apply (sID, cName, major, decision)

Ahora consideremos la siguente consulta::

        SELECT Student.sID, sName, Apply.cName, GPA
        FROM Student, Apply
        WHERE Apply.sID = Student.sID

es posible realizarla como::

        SELECT S.sID, sName, A.cName, GPA
        FROM Student S, Apply A
        WHERE A.sID = S.sID

Eso es, la variable de la tabla?(table variable, no se como traducirlo, pq corresponde más a variable en la consulta).
La variable en la consulta se define en el "FROM" de la consulta "SELECT-FROM-WHERE"

============================
Cuidado con los duplicados!!
============================

Si el lector se fija en el esquema, hay ciertos atributos cuyos nombres se repiten en las diferentes tablas. Tal es el caso de
**cName y sID**. En las consultas se aprecia que la diferencia se realiza a través de::

        Student.sID ó S.sID
        Apply.sID ó A.sID

Es decir, se antepone el nombre de la tabla o su respectiva variable definida en el FROM.

En variadas ocasiones, los nombres de los atributos se repiten, dado que se comparan dos instancias de una tabla. En el siguiente ejemplo, se buscan
todos los pares de estudiantes con el mismo GPA::

        SELECT S1.sID, S1.sName, S1.GPA, S2.sID, S2.sName, S2.GPA
        FROM Student S1, Student S2
        WHERE S1.GPA = S2.GPA

Ojo!!! Al momento de realizar esta consulta (dos instancias de una tabla),  el resultado contendrá uno o varios duplicados; por ejemplo, consideremos
4 estudantes::

        sName   sID     GPA
        Amy     123     4.0
        Doris   456     4.0
        Edward  567     4.1

Los pares de estudiantes serán::

         Amy    -       Doris

pero también::

         Amy    -       Amy
         Doris  -       Doris

lo cual se puede evitar modificando la cosulta::

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

El operador "UNION", permite combinar el resultado de dos o más sentencias SELECT. Es necesario que estas tengan el mismo número de columnas, y que
éstas tengan los mismos tipos de datos, por ejemplo::

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

El resultado de la consulta::

        SELECT E_Name FROM Employees_Norway
        UNION
        SELECT E_Name FROM Employees_USA


es::

        E_Name
        Hansen, Ola
        Svendson, Tove
        Svendson, Stephen
        Pettersen, Kari
        Turner, Sally
        Kent, Clark
        Scott, Stephen


Ojo, existen dos empleados con el mismo nombre en ambas tablas. Sin embargo en la salida sólo se nombra uno. Para evitar esto, se utliza "UNION ALL"::

        SELECT E_Name as name FROM Employees_Norway
        UNION ALL
        SELECT E_Name as name FROM Employees_USA

Utilizando "as" es posible cambiar el nombre de la columna resultado::

        name
        Hansen, Ola
        Svendson, Tove
        Svendson, Stephen
        Pettersen, Kari
        Turner, Sally
        Kent, Clark
        Svendson, Stephen
        Scott, Stephen



============
Intersección
============

Muy similar al operador UNION, INTERSECT también opera con dos sentencias SELECT. La diferencia consiste en que UNION actua como un OR, e INTERSECT
lo hace como AND. Es decir que INTERSECT devuelve los valores repetidos. Consideremos el sigueinte esquema::

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


Al realizar la consulta::

        SELECT Date FROM Store_Information
        INTERSECT
        SELECT Date FROM Internet_Sales

Su resultado esperado es::

        Date
        Jan-07-1999


Duda: agregar lo de que ciertos motores de bases de datos no soportan este operador(buscar cuales en particular y nombrarlos),
pero que puede escribirse como otra consulta (agregarla)

=========
Excepción
=========

Similar a los operadores anteriores, su estructura se compone de dos o mas sentencias SELECT, y el operador EXCEPT. Es equivalente a la diferencia
en el álgebra relacional.

Utilizando el esquema del ejemplo anterior, y realizando la siguiente consulta::

        SELECT Date FROM Store_Information
        EXCEPT
        SELECT Date FROM Internet_Sales

Su resultado esperado es::

        Date
        Jan-10-1999
        Jan-11-1999
        Jan-12-1999

Duda: agregar lo de que ciertos motores de bases de datos no soportan este operador(buscar cuales en particular y nombrarlos),
pero que puede escribirse como otra consulta (agregarla)

