Lectura 26 - Transacciones: Propiedades
---------------------------------------

En esta lectura se va a profundizar sobre las propiedades de las transacciones.

Como recordatorio, las transacciones son un concepto que ha sido introducido como una 
solución tanto para el problema de control de concurrecia y fallos de sistemas en las bases 
de datos.

Todo conocedor de bases de datos, sabe que las transacciones soportan lo que se conoce como
las propiedades ACID.

``A``: Atomicidad.
``C``: Consistencia.
``I``: Aislamiento.
``D``: Durabilidad.

A continuación se detallaran estas cuatro propiedades; primero aislamiento, segundo durabilidad, 
tercero atomicidad y finalmente consistencia.

Aislamiento (I)
~~~~~~~~~~~~~~~

Podemos tener una gran cantidad de clientes que operan en una base de datos (como se muestra en la imagen), 
en que cada cliente piensa que está operando por su cuenta.
Así como se comento en la lectura anterior, cada cliente emite en el sistema de base de datos 
una secuencia de transacciones.
Así que un primer cliente podría emitir primero la transacción T1, a continuación, T2, T3, 
y así sucesivamente.
Un segundo cliente podría emitir una transacción T9, T10, T11.

.. image:: ../../../sql-course/src/lectura26/imagen1_semana7.png                               
   :align: center

Como recordatorio, cada transacción en sí puede ser una secuencia de instrucciones.

Por lo tanto estas transacciones, podrían ser una instrucción, dos instrucciones, tres instrucciones y 
así sucesivamente, y finalmente estas instrucciones serán tratadas como una unidad.

De manera que la **propiedad aislante** es implementada de una muy especifica forma normal 
llamada *secuencialización*.

La *secuencialización* quiere decir que las operaciones pueden ser intercaladas entre los clientes, 
pero la ejecución debe ser equivalente a un orden secuencial (serial) de todas las transacciones.

En base a la imagen anterior, el propio sistema puede ejecutar todas las instrucciones 
dentro de cada operación y al mismo tiempo por cada cliente, pero tiene que garantizar 
que el comportamiento de la base de datos es equivalente a una secuencia en orden.

Ejemplo
=======

Supongamos cliente C1 emite T1, T2 transacciones y el cliente C2 T3, T4 transacciones simultáneamente. 
¿Cuantas "ordenes secuenciales equivalentes" distintas hay en estas 4 transacciones?

a) 2
b) 4
c) 6
d) 24

La alternativa correcta es (c), puesto que las combinaciones posibles son las siguientes: 
``T1,T2,T3,T4``; ``T1,T3,T2,T4``; ``T1,T3,T4,T2``; ``T3,T1,T2,T4``; ``T3,T1,T4,T2``; ``T3,T4,T1,T2``.

Ahora, podemos preguntarnos cómo el sistema de base de datos podría garantizar este nivel 
de coherencia manteniendo la "intercomunicación" de las operaciones.
Esto se logra con la utilización de protocolos que se basan en bloquear partes de la base 
de datos.

Volveremos a un ejemplo de la lectura anterior.

.. code-block:: sql

 UPDATE College SET enrollment = enrollment + 500 WHERE cName = 'UTFSM';

concurrente con

.. code-block:: sql

 UPDATE College SET enrollment = enrollment + 1000 WHERE cName = 'UTFSM';

En este ejemplo dos clientes modifican la matricula a la universidad UTFSM.
LLamaremos a la primera instrucción T1 y a la segunda T2, así que cuando realizamos estas
transacciones en el sistema, la secuencialización esta garantizada, desde ahi tendremos 
un comportamiento equivalente ya sea para T1 seguido por T2, o T2 seguido por T1. 

Así que, en este caso, cuando empezamos con nuestra matrícula en 15.000, bien la ejecución 
correcta tendrá una matricula final de 16.500, resolviendo nuestros problemas de concurrencia.

Ahora se explicará otro ejemplo de la lectura anterior.

.. code-block:: sql

 UPDATE Apply SET major = 'history' WHERE sID = 1;

concurrente con

.. code-block:: sql

 UPDATE Apply SET decision = 'Y' WHERE sID = 1;

En este ejemplo, el primer cliente realizó la modificación de *major* del estudiante *sID = 1* 
en la tabla **Apply** y el segundo fue la modificación de *decision* del estudiante *sID = 1*.
Y hemos visto que si permitimos que estas instrucciones se ejecuten de manera intercalada, 
sería posible que sólo uno de las dos modificaciones se realicen.
Una vez más, con la *secuencialización* vamos a obtener un comportamiento que garantiza 
que es equivalente a  T1 seguido por T2 ó T2 seguido por T1.


Y en ambos casos, tanto los cambios se reflejarán en la base de datos que es lo que nos gustaría.

Durabilidad (D)
~~~~~~~~~~~~~~~

Aquí solo debemos mirar un cliente y lo que está sucediendo.

Así que digamos que tenemos a nuestro cliente (como el de la imagen), que está emitiendo 
una secuencia de instrucciones (S1, S2, ..., Sn) a la base de datos.
Y cada transacción (T1, T2, ..., Tn) que realiza el cliente, es una secuencia de instrucciones 
(S) y que al finalizar cada instrucción (S) recibe un "commit" confirmación.

Si el sistema deja de funcionar después de las transacciones "commits", todos los efectos de 
las transacciones quedan en la base de datos. 













