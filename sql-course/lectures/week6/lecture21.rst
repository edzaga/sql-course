Lecture 21 - Constraints and triggers: Introduction
-----------------------------------------------------
.. role:: sql(code)
         :language: sql
         :class: highlight

.. Ambos están orientados a Bases de Datos Relacionales o RDB por sus siglas en inglés.Si bien SQL no cuenta con ellos, en las diversas implementaciones del lenguaje se ha corregido este error. Lamentablemente no cuenta con un standar

Las reestricciones, también llamadas reestricciones de integridad, permiten definir 
los estados permitidos dentro de la Base de Datos (BD).

Los triggers, en cambio, monitorean los cambios en la BD, chequean condiciones, e inician
acciones de forma automática. Es por ello que se les considera de naturaleza dinámica, a 
diferencia de las reestricciones de integridad, que son de naturaleza estática.

Ambos se analizarán en detalle en las próximas lecturas.

==============
Reestricciones
==============

Imponen reestricciones de datos permitidos, más alla de aquellos impuestos por la estructura
y los tipos de datos en la BD.


Supongamos que estamos bajo el contexto del sistema de selección de estudiantes, 
visto en algunas lecturas anteriores:

Ejemplo 1
^^^^^^^^^
Para que el estudiante sea aceptado, su promedio debe ser mayor a 50::
 
  Average > 50


Ejemplo 2
^^^^^^^^^
El establecimiento X no puede tener más de 45000 alumnos::
 
  Enrollment < 45000

Ejemplo 3
^^^^^^^^^
El criterio para la decisión es Verdadero, Falso o NULL::
 
  Desicion: 'T', 'F', NULL


Las reestricciones se utilizan para:

1. Evitar errores a la hora de ingresar datos (**INSERT**).
2. Evitar errores a la hora de modificar datos (**UPDATE**). 
3. Forzar consistencia de datos.


Existen diversos tipos de reestricciones. Ellas se clasifican en:

1. **NOT NULL**              : No permiten valores nulos.
2. **Key**                   : Permiten sólo valores únicos, asociados a la llave primaria.
3. **Integridad Referencial**: Relacionados con la llave foránea. (completar)
4. **Basado en atributos**   : Restringe el valor de un atributo.
5. **Basado en tupla**       : Restringe el valor de una tupla. Más especifico que el anterior.
6. **Generales**             : Restringen toda la BD.


Declaraciondo y forzando reestricciones
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Las reestricciones se pueden declarar con el schema original, y todo se chequea al final
de la carga de datos. **ver mejor el otro tipo de declaracion**


Se puede forzar el chequeo despues de cada modificación *peligrosa*, es decir
aquellas que violan una restricción. No es necesario modificar después de un cambio de promedio
en la tabla de Estudiantes, eso sólo ralentizaría el sistema. 

Otra forma de forzar chequeos es despues de cada **transacción**. Este concepto, se verá  más adelante,
pero es posible adelantar que una trasacciones corresponden a un conjunto de operaciones que al finalizar
modifican la BD **revisar esto también**


========
Triggers
========

La lógica del trigger es::
  
  "Cuando pasa algo, se chequea una condición. 
   Si es cierta se realiza una acción"


Como ya se mencionó, a diferencia de las restricciones, un trigger detecta un evento, verifíca 
alguna condición de activación y en caso de ser cierta, realiza una acción.

Contextualizandonos en el sistema de admisión de Estudiantes:

Ejemplo 4
^^^^^^^^^
Si la capacidad de un Establecimiento X, sobrepasa los 30000, el sistema debe  comenzar a rechazar a los nuevos postulantes::
 
    Enrollment > 30000 -> rechazar nuevos postulantes


Ejemplo 5
^^^^^^^^^
Si un alumno tiene promedio mayor a 49.5, queda aceptado::
 
  Student with  Average > 49.5 -> Decision='True'



Los triggers se utilizan para:

1. **Mover la lógica desde la aplicación a Sistema Administrador de la Base de Datos (BDMS)**, lo
   cual permite un sistema más modular y automatizado.

2. **Forzar reestricciones**. Ningun sistema implementado soporta todas las reestricciones de otro, es decir
   no existe un estándar actual. Un caso es el ejemplo 5, en el cual algún DBMS podría redondear hacía abajo
   en lugar de hacia arriba; con el trigger esto se podría resolver. Además existen reestricciones que no se pueden
   escribir de forma directa, pero si utilizando triggers.
   
3. **Forzar reestricciones utilizando lógica reparadora**. Un error se puede detectar y realizar una 
   acción, que puede ser por ejemplo, si existe la reestricción **0 <= Average <= 100**, y alguien por error de tipeo 
   ingresa un promedio -50, un trigger podría cambiar este valor a 0, por ejemplo cualquier valor que no esté en el 
   rango, cambiarlo a 0.


A modo de introducción, un trigger esta definido por

.. code-block:: sql
  
 CREATE TRIGGER name
 BEFORE|AFTER|INSTEAD OF events
 [referencing-variables]
 [FOR EACH ROW]
 WHEN (condition)
 action

Es decir que cada trigger tiene un nombre que es activado por eventos (antes, durante o después).
Se toman ciertas variables y por cada fila se revisa una condición se realiza una acción.


