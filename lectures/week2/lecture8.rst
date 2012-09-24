Lecture 8 - Table variable and set operators
--------------------------------------------

Table Variables
~~~~~~~~~~~~~~~

.. index:: Table Variables

Consideremos el siguiente schema::

        College (cName, state, enrollment)
        Student (sID, sName, GPA, sizeHS)
        Apply (sID, cName, major, decision)

Ahora consideremos la  siguente consulta::

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
\textbf{cName y sID}. En las consultas se aprecia que la diferencia se realiza a través de::

        Student.sID ó S.sID
        Apply.sID ó A.sID

Es decir, se antepone el nombre de la tabla o su respectiva variable definida en el FROM.

En variadas ocasiones,los nombres de los atributos se repiten, dado que se comparan dos instancias de una tabla. En el siguiente ejemplo, se buscan
todos los pares de estudiantes con el mismo GPA::

        SELECT S1.sID, S1.sName, S1.GPA, S2.sID, S2.sName, S2.GPA
        FROM Student S1, Student S2
        WHERE S1.GPA = S2.GPA and S1.sID < S2.sID;

Set Operators
~~~~~~~~~~~~~~~

.. index:: Set Operators

Los Set Operators son 3:

  * Unión
  * Intersección
  * Excepción

======
Unión
======

