Lectura 6 - Tipo de Datos
-------------------------

.. role:: sql(code)
   :language: sql
   :class: highlight

DESCRIPCIÓN
~~~~~~~~~~~

En SQL se tienen varios tipos de datos. Cuando creamos una tabla con la instrucción
create table, tenemos que especificar el tipo de dato de cada columna.[1]_

1. **Cadenas de carácteres de largo fijo y variable:** Un atributo de una tabla de tipo *CHAR(n)* denota una cadena de longitud fija de n caracteres. Es decir, si un atributo es de tipo *CHAR(n)*, entonces en cualquier tupla el componente para este atributo será una cadena de n caracteres. *VARCHAR(n)* denota una cadena de hasta n caracteres.

2. **Cadenas de bits de longitud fija o variable:** Estas cadenas son análogas a las cadenas de caracteres fijos y variables de longitud, pero sus valores son cadenas de bits en lugar de caracteres. El tipo *BIT(n)* denota cadenas de bits de longitud n.

3. **Tipo de dato booleanos:** *BOOL* denota un atributo cuyo valor es lógico. Los valores posibles de este tipo de atributo es TRUE, FALSE, y UNKNOWN.

4. **Tipo de dato entero:** *INTEGER* denota típicos valores enteros. El tipo *SMALLINT* también denota números enteros, pero el número de bits permitidos puede ser menor.

5. **Tipo de dato flotante:** Podemos utilizar el tipo *FLOAT* para los típicos números de punto flotante. 

6. **Tipo de dato Fecha/Hora:** Pueden ser representados por *DATE* y *TIME*. Estos valores son esencialmente cadenas de caracteres de una forma especial. Además existe un tipo de dato llamado *TIMESTAMP*. El formato que deben tener se muestra en la siguiente tabla:

.. math::

 \begin{array}{|c|l|}
  \hline
  \textbf{Tipo} & \textbf{Descripción} \\
  \hline
  \text{DATE} & \text{Fecha ANSI SQL "aaaa-mm-dd".} \\
  \hline
  \text{TIMESTAMP} & \text{Fecha y hora "aaaa-mm-dd hh:mm:ss".} \\
  \hline
  \text{TIME} & \text{Hora ANSI SQL "hh:mm:ss".} \\
  \hline
 \end{array}

Ejemplo práctico
^^^^^^^^^^^^^^^^

A continuación se mostrarán ejemplos realizados con PostgreSQL de los tipos de datos nombrados anteriormente.

* Este ejemplo trata del juego adivina quien y se realizan preguntas como: tu personaje tiene gafas, es rubio, es alto. La tabla queda de la siguiente manera utilizando los valores booleanos para crear las tablas:

.. code-block:: sql

 postgres=# CREATE TABLE Adivina_quien(Personaje VARCHAR(30), GAFAS BOOL, RUBIO BOOL, ALTO BOOL);
 CREATE TABLE
 postgres=# INSERT INTO Adivina_quien(Personaje,GAFAS,RUBIO,ALTO) VALUES('Tomas',true,false,true);
 INSERT 0 1
 postgres=# SELECT*FROM Adivina_quien;
 personaje | gafas | rubio | alto
 -----------+-------+-------+------
 Tomas     | t     | f     | t
 (1 fila)

* Se mostrará a continuación un ejemplo en que se utilicen los tipos de datos *VARCHAR*, *CHAR* y *DATETIME*.

*Creamos* la tabla persona con el id de tipo serial, nombre y apellido de tipo *VARCHAR* con un largo variable hasta 25 carácteres, genero de tipo *CHAR* con solo un carácter y la fecha de nacimiento que es un tipo de dato *DATETIME*.

.. code-block:: sql

 postgres=# CREATE TABLE persona(id serial, nombre VARCHAR(25), apellido VARCHAR(25), genero CHAR(1), fecha_nac DATE);

Retornando lo siguiente PostgreSQL::

 NOTICE:  CREATE TABLE creará una secuencia implícita «persona_id_seq» para la columna serial «persona.id»
 CREATE TABLE

Ahora *ingresamos* un dato

.. code-block:: sql

 postgres=# INSERT INTO persona(nombre,apellido,genero,fecha_nac) VALUES('Paul','Anderson','M','1983-02-12');
 INSERT 0 1

Finalmente *seleccionamos* la tabla para ver los datos que se ingresaron

.. code-block:: sql

 postgres=# SELECT * FROM persona;
  id | nombre | apellido | genero | fecha_nac  
 ----+--------+----------+--------+------------
  1 | Paul   | Anderson | M      | 1983-02-12
 (1 fila)

* Supongamos que en el siguiente ejemplo un alumno esta registrando las notas de sus ramos de la universidad en una tabla llamada **notas**, ingresando el nombre del ramo como *VARCHAR* de un largo de 30 carácteres, nota_1 y nota_2 del tipo *INTEGER* y finalmente su promedio de notas que es del tipo *FLOAT*.

.. code-block:: sql

 postgres=# CREATE TABLE notas(id serial, ramo VARCHAR(30), nota_1 INTEGER, nota_2 INTEGER, promedio FLOAT); 

Retornando PostgreSQL::

 NOTICE:  CREATE TABLE creará una secuencia implícita «notas_id_seq» para la columna serial «notas.id»
 CREATE TABLE

*Ingresando* datos

.. code-block:: sql

 postgres=# INSERT INTO notas(ramo,nota_1,nota_2,promedio) VALUES('Base de datos', 57, 36, 46.5);
 INSERT 0 1
   
.. warning::

 Para ingresar un dato tipo *FLOAT*, el valor no lleva una **"coma"**, sino que un **"punto"**

REFERENCIA
~~~~~~~~~~
.. [1] http://www.postgresql.org/docs/8.1/static/datatype.html
