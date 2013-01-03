Lecture 21 - Constraints and triggers: Introduction
-----------------------------------------------------

.. Ambos están orientados a Bases de Datos Relacionales o RDB por sus siglas en inglés.Si bien SQL no cuenta con ellos, en las diversas implementaciones del lenguaje se ha corregido este error. Lamentablemente no cuenta con un standar

Las reestricciones, también llamadas reestricciones de integridad, permiten definir 
los estados permitidos dentro de la Base de Datos (BD).

Los triggers, en cambio, monitorean los cambios en la BD, chequean condiciones, e inician
acciones de forma automática. Es por ello que se les considera de naturaleza dinámica, a 
diferencia de las reestricciones de integridad, que son de naturaleza estática.

==============
Reestricciones
==============

Imponen reestricciones de datos permitidos, más alla de aquellos impuestos por la estructura
y los tipos de datos en la BD.


Ejemplos
^^^^^^^^

Supongamos que estamos bajo el contexto del sistema de selección de estudiantes, 
visto en algunas lecturas anteriores:

1. Para que el estudiante sea aceptado, su promedio debe ser mayor a 50: **Average > 50**
2. El establecimiento X no puede tener más de 45000 alumnos: **Enrollment < 45000**
3. El criterio para la decisión es Verdadero, Falso o NULL: **Desicion: 'T', 'F', NULL**


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


========
Triggers
========





