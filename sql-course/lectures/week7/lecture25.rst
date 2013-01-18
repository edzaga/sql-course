Lectura 25 - Transacciones: Introducción
----------------------------------------

En esta lectura se presentarán los conceptos de *transacciones* e acciones de interacción 
con los sistemas de base de datos.

El concepto de *transacciones* está realmente motivada por dos cuestiones totalmente 
independientes.

Uno tiene que ver con el **acceso concurrente** de varios clientes a la base de datos y el 
otro tiene que ver con tener un **sistema que es resistente** a los fallos de sistema.

Primero vamos a ver como funciona la estructura de los sistemas de bases de datos y la 
interacción con los clientes.

En la siguiente imagen podemos observar que los datos son almacenados en el disco, que 
tiene comunicación con el sistema de gestión de base de datos, o DBMS, que controla las 
interacciones con los datos.
A menudo hay software adicional por encima del DBMS, tal vez un servidor de aplicaciones 
o servidor web, que luego interactuan con los que podrían ser usuarios a través de comandos 
de selección, actualización, creación de tablas, comandos de borrado, etc. Y es aquí 
finalmente donde ocurre el problema que es la interacción concurrente de multiples usuarios. 

.. image:: ../../../sql-course/src/lectura25/imagen1_semana7.png                               
   :align: center


Integridad de las transacciones
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

* Una *transacción* es un conjunto de operaciones (u órdenes) que se ejecutan en forma 
indivisible (atómica) sobre una base de datos.
* El DBMS debe mantener la integridad de los datos, haciendo que estas *transacciones* no 
puedan finalizar en un estado intermedio.
* Si por algún motivo se debe cancelar la *transacción*, el DBMS empieza a deshacer las 
órdenes ejecutadas hasta dejar la base de datos en su estado inicial (llamado punto de 
integridad), como si la órden de la transacción nunca se hubiese realizado.

Ahora se mostrarán ejemplos de dificultades que puede ocurrir cuando múltiples clientes 
están interactuando con la base de datos.

Atributo de nivel de incosistencia
==================================

.. code-block:: sql

 UPDATE College SET enrollment = enrollment + 500 WHERE cName = 'UTFSM';

concurrente con

.. code-block:: sql

 UPDATE College SET enrollment = enrollment + 1000 WHERE cName = 'UTFSM';

En el ejemplo anterior se puede observar como en un solo atributo en el que varios clientes 
están trabajando. 

    
