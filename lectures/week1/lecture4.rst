Lecture 4 - Relation algebra: Set operators, renaming, notation
---------------------------------------------------------------

En el video se consideran 3 tablas: college, student y apply
college: cName, state, enr
student: sID, sName, GPA, HS
apply: sID, cName, major, dec

Set operators
~~~~~~~~~~~~~~

.. index:: set operators

**union**
Lista de nombres de colegios y estudiantes

agregar ejeplos...


**difference**
ID de los estudiantes who didnt aplly anywhere

ID y el nombre de los estudiantes who didnt aplly anywhere

agregar ejemplos...

**intersection**
Nombres q son de colegios y alumnos

no agrega poder expresivo, pues se puede reemplezar por otra operación
1)e1 intersectado con e2 equivale a e1- (e1-e2)
2) e1 intersectado con e2 equivale a join

Para intersectar, se debe tener el mismo esquema

agregar ejemplos:

**rename**

1) ro (griega)_{R(a{1},...a_{n})}(E) -> general
2) ro(griega _{r} (e)
3) ro griega _{a{1},...a_{n}}

sirve para unificar esquemas para set operators
sirve para desambiguar en los "self joins"
        ejemplo: pares de colegios en el mismo estado


**sumario**
:
