Lectura 26 - Transacciones: Propiedades
---------------------------------------

En esta lectura se va a profundizar sobre las propiedades de las transacciones.

Como recordatorio, las transacciones son un concepto que ha sido introducido como una
solución tanto para el problema de control de concurrencia y fallos de sistemas en las bases
de datos.

Todo conocedor de bases de datos, sabe que las transacciones soportan lo que se conoce como
las propiedades ACID.

 * ``A``: Atomicidad.
 * ``C``: Consistencia.
 * ``I``: Aislamiento.
 * ``D``: Durabilidad.

A continuación se detallarán estas cuatro propiedades; primero aislamiento, segundo durabilidad,
tercero atomicidad y finalmente consistencia.

Aislamiento (I)
~~~~~~~~~~~~~~~

*"Esta propiedad asegura que no sean afectadas entre sí las transacciones, en otras palabras
esto asegura que la realización de dos o más transacciones sobre la misma información sean independientes
y no generen ningún tipo de error"* [1]_

Podemos tener una gran cantidad de clientes que operan en una base de datos (como se muestra en la imagen),
en que cada cliente piensa que está operando por su cuenta.
Así como se comentó en la lectura anterior, cada cliente emite en el sistema de base de datos
una secuencia de transacciones.
Así que un primer cliente podría emitir primero la transacción T1, a continuación, T2, T3,
y así sucesivamente.
Un segundo cliente podría emitir una transacción T9, T10, T11.

.. image:: ../../../sql-course/src/lectura26/imagen1_semana7.png
   :align: center

Como recordatorio, cada transacción en sí puede ser una secuencia de instrucciones.

Por lo tanto estas transacciones, podrían ser una instrucción, dos instrucciones, tres instrucciones y
así sucesivamente, y finalmente estas instrucciones serán tratadas como una unidad.

De manera que la **propiedad aislante** es implementada de una muy específica forma normal
llamada *secuenciación*.

La *secuenciación* quiere decir que las operaciones pueden ser intercaladas entre los clientes,
pero la ejecución debe ser equivalente a un orden secuencial (serial) de todas las transacciones.

En base a la imagen anterior, el propio sistema puede ejecutar todas las instrucciones
dentro de cada operación y al mismo tiempo por cada cliente, pero tiene que garantizar
que el comportamiento de la base de datos es equivalente a una secuencia en orden.

Ejemplo
=======

Supongamos cliente C1 emite T1, T2 transacciones y el cliente C2 T3, T4 transacciones simultáneamente.
¿Cuántas "ordenes secuenciales equivalentes" distintas hay en estas 4 transacciones?

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
Llamaremos a la primera instrucción T1 y a la segunda T2, así que cuando realizamos estas
transacciones en el sistema, la secuenciación esta garantizada, desde ahí tendremos
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
Una vez más, con la *secuenciación* vamos a obtener un comportamiento que garantiza
que es equivalente a  T1 seguido por T2 ó T2 seguido por T1.


Y en ambos casos, tanto los cambios se reflejarán en la base de datos que es lo que nos gustaría.

Durabilidad (D)
~~~~~~~~~~~~~~~

*"Es la propiedad de las transacciones que asegura que una vez finalizada su ejecución, sus
resultados son permanentes a pesar de otras consecuencias, como por ejemplo, si falla el
disco duro el sistema aún será capaz de recordar todas las transacciones que han sido realizadas
en el sistema"* [1]_

Aquí sólo debemos mirar un cliente y lo que está sucediendo.

Así que digamos que tenemos a nuestro cliente (siguiente imagen), que está emitiendo
una secuencia de instrucciones (S1, S2, ..., Sn) a la base de datos.
Y cada transacción (T1, T2, ..., Tn) que realiza el cliente, es una secuencia de instrucciones
(S) y que al finalizar cada instrucción (S) recibe un "commit" confirmación.

.. image:: ../../../sql-course/src/lectura26/imagen2_semana7.png
   :align: center

Si el sistema deja de funcionar después de las transacciones "commits", todos los efectos de
las transacciones quedan en la base de datos.

Entonces, específicamente, si en algún momento esto ocurre, si hay una falla por cualquier
razón, el cliente puede asegurarse que la base de datos ha sido afectada por la transacción,
y cuando el sistema vuelva a funcionar, los efectos seguirán ahí.

¿Es posible garantizar esto, siendo que los sistemas de base de datos mueven información
entre el disco duro y la memoria y una falla puede ocurrir en cualquier momento?.

Son protocolos no tan complicados que son usados y están basados en el concepto de **logging**.

Atomicidad (A)
~~~~~~~~~~~~~~

*"Cualquier cambio de estado que produce una transacción es atómico, es decir, ocurren
todos o no ocurre ninguno. En otras palabras, esta propiedad asegura que todas las acciones
de la transacción se realizan o ninguna de ellas se lleva a cabo; la atomicidad requiere
que si una transacción se interrumpe por una falla, sus resultados parciales deben ser
deshechos"* [1]_

De nuevo, sólo veremos un cliente que haya dado a conocer una serie de transacciones a
la base de datos.
Y vamos a ver la transacción T2 que a su vez es una secuencia de instrucciones seguidas
por una confirmación (commit).

El caso que la atomicidad trabaja, es donde existe una falla durante la ejecución de la transacción,
después que se ha sido "enviado".

Lo que la propiedad quiere decir que, incluso en presencia de fallos del sistema, cada
transacción se ejecuta todo o nada en la base de datos.

También se utiliza un mecanismo de log-in, específicamente, cuando el sistema se recupera
de un accidente y hay un proceso por el cual los efectos parciales de las transacciones
que se estaban ejecutando al momento de la falla, se "deshacen/descartan".

Ejemplo
=======

Considere la posibilidad de una relación R (A) que contiene {(5), (6)} y dos transacciones:
T1: UPDATE R SET A = A + 1; T2: UPDATE R SET A = 2 * A. Supongamos que ambas transacciones
se presentan bajo la propiedad de aislamiento y atomicidad. ¿Cuál de los siguientes NO
es un posible estado final de R?

a) {(10,12)}
b) {(11,13)}
c) {(11,12)}
d) {(12,14)}

La respuesta correcta es (c), puesto que la alternativa (a) se produce si no se completa T1.
La alternativa (b) se produce si T2 se realiza antes que T1. La alternativa (d) se produce
cuando T1 se realiza después que T2.

Deshacer (Rollback) Transacción
===============================

* Deshace los efectos parciales de una transacción.
* Puede ser iniciada por el sistema o por el cliente.

Ahora realizaremos un ejemplo práctico en postgreSQL.

Ejemplo
^^^^^^^

Tenemos la tabla **colors**, con sus respectivos atributos *id* y *color*, pero antes de
comenzar debemos definir algunos conceptos:

* **begin:** Inicio de una transacción. Al ingresar esta clausula es posible recuperar errores que puedan ocurrir.
* **savepoint:** Con esta sentencia se realiza un *commit* hasta el punto que se está seguro que no posee errores. La diferencia con *commit* es que no se finaliza la transacción.
* **rollback:** Deshace todos los cambios que se hayan realizado desde la sentencia *begin* ó hasta donde se haya confirmado con *savepoint*.
* **commit:** Confirma y termina la transacción con los cambios establecidos.

.. code-block:: sql

 SELECT * FROM colors;
 id | color
 ----+--------
   1 | yellow
   2 | blue
   3 | red
   4 | green
 (4 rows)

Ahora comenzamos la transacción con *commit*.

.. code-block:: sql

 begin;

Retornando postgreSQL como resultado *BEGIN*.

Realizamos una modificación en los colores *yellow* por *black*.

.. code-block:: sql

 UPDATE colors SET color='black' WHERE color='yellow';

 SELECT * FROM colors;
 id | color
 ----+-------
   2 | blue
   3 | red
   4 | green
   1 | black
 (4 rows)

Ahora confirmaremos que hasta aquí está todo bien.

.. code-block:: sql

 savepoint b;

Retornando postgreSQL como resultado *SAVEPOINT*.

Volvemos a modificar un color de la tabla *blue* por *orange*.

.. code-block:: sql

 UPDATE colors SET color='orange' WHERE color='blue';

 SELECT * FROM colors;
 id | color
 ----+--------
   3 | red
   4 | green
   1 | black
   2 | orange
 (4 rows)

Pero nos damos cuenta nos equivocamos y no era *orange* el color que deseábamos, entonces
volvemos al punto que guardamos anteriormente.

.. code-block:: sql

 rollback TO b;

Retornando postgreSQL como resultado *ROLLBACK*.

Volviendo al punto anterior.

.. code-block:: sql

 SELECT * FROM colors;
 id | color
 ----+-------
   2 | blue
   3 | red
   4 | green
   1 | black
 (4 rows)

Consistencia (C)
~~~~~~~~~~~~~~~~

*"Esta propiedad establece que solo los valores o datos válidos serán escritos en la base
de datos; si por algún motivo una transacción que es ejecutada viola esta propiedad, se
aplicará un rollback a toda transacción dejando a las bases de datos en su estado de consistencia
anterior. En caso de que la transacción sea ejecutada con éxito, la base de datos pasará de
su estado de consistencia anterior a un nuevo estado de consistencia."* [1]_

La propiedad de *consistencia* habla de cómo las transacciones interactúan con las restricciones
de integridad que pueden existir en una base de datos.

En concreto, cuando tenemos varios clientes que interactúan con la base de datos de manera
concurrente, podemos tener una configuración en la que cada cliente puede asumir que cuando
comienza a operar sobre una base de datos, satisfaga todas las restricciones de integridad.

.. [1] http://www.slideshare.net/W4L73R/bases-de-datos-acid-reglas-de-codd-e-integridad-de-datos
