Tarea 7
=======

Fecha de entrega: miércoles 20 de Febrero 2013 hasta 23:59
-----------------------------------------------------------

.. role:: sql(code)
   :language: sql
   :class: highlight


-----------------
Transacciones 
-----------------

Pregunta 1:
^^^^^^^^^^^

Considere la relación R(x) que contiene números enteros.  Se ejecutan 3 transacciones:

* **Sentencia 1:**

	.. code-block:: sql

	 SELECT sum(x) FROM R;
	 commit; 

* **Sentencia 2:** 

	.. code-block:: sql

	 INSERT INTO R VALUES (10);
	 INSERT INTO R VALUES (20);
	 INSERT INTO R VALUES (30);
	 commit;  

* **Sentencia 3:**

	.. code-block:: sql

	 DELETE FROM R WHERE x=30;
	 DELETE FROM R WHERE x=20;
	 commit;  

Antes de ejecutar cualquiera de estas transacciones, la suma de los enteros en R es 1000, y no contiene los enteros 10, 20 y 30. Si las tres transacciones se ejecutan casi al mismo tiempo y en aislamiento. Escribir 3 resultados de la suma que podría mostrar la sentencia 1. Explicar brevemente como se obtienen dichos resultados.

Pregunta 2:
^^^^^^^^^^^

Considere la relación R(x) que contiene {3, 4, 8, 6, 20}. Se ejecutan 3 transacciones:

* **Sentencia 1:**

	.. code-block:: sql

	 SELECT * FROM R;
	 commit;  

* **Sentencia 2:** 

	.. code-block:: sql

	 UPDATE R SET x = x*2 + 1;
	 commit;

* **Sentencia 3:**

	.. code-block:: sql

	 UPDATE R SET x = 100- x;
	 commit;
   
Si las tres transacciones se ejecutan casi al mismo tiempo y se presentan bajo la propiedad de aislamiento y atomicidad. Escribir 3 posibles resultados que podría mostrar la sentencia 1. Explicar brevemente como se obtienen dichos resultados.

-------------
Vistas
-------------

Se tiene una base de datos de series de televisión con el siguiente esquema:

* `\text{Series}(\underline{\text{sID}},\text{title, creator, year, audience, genre, season, final})`
	La tabla **Series** posee *sID* que es un id único y es primary key de la relación,
	además se almacena el titulo de la serie *title*, el creador *creator*, *year* es el año de estreno
	de la primera temporada, la audiencia promedio anual *audience*, *genre* el genero de la serie 
        *season* que contiene el número de temporadas emitidas hasta
	el 2012, *final* es un atributo que dice si la serie se sigue emitiendo o terminó.

* `\text{Evaluator}(\underline{\text{eID}},\text{name})`
	El evaluador es quien califica la serie, la relación **Evaluator** tiene un atributo
	*eID* (id único) que es clave primaria y tiene otro atributo *name*
	que almacena el nombre del evaluador.

* `\text{Grade}(\underline{\text{eID,sID}},\text{score, dateg})`
	Luego que el evaluador califica una serie se guarda en la tabla **Grade** que
	tiene dos claves foráneas *eID* que es el id del evaluador y *sID* que es el id de
	algunas de las series almacenadas. Ambas claves foráneas (juntas) conforman la clave
	primaria de **Grade** También contiene la nota *score* puesta por el evaluador
	y la fecha que calificó dicha serie *dateg*.

El archivo con los datos se descarga aquí

Pregunta 1:
^^^^^^^^^^^

Crear la **Vista LateGrade:** contiene clasificaciones de películas a partir del 20 de enero del 2012. La vista contiene el *sID* de serie, su título (*title*), la nota(*score*) y la fecha de calificación (*dateg*).

.. code-block:: sql

	postgres=# SELECT * FROM LateGrade;

	 sid |        title        | score |   dateg    
	-----+---------------------+-------+------------
	   4 | Bones               |     8 | 2012-07-22
	   6 | The Walking Dead    |     5 | 2012-05-19
	   1 | The Big Bang Theory |     8 | 2012-01-22
	   3 | Dexter              |     8 | 2012-09-27
	   6 | The Walking Dead    |     5 | 2012-06-08
	   7 | Lost                |     7 | 2012-07-15
	   1 | The Big Bang Theory |     7 | 2012-02-23
	   8 | Spartacus           |     4 | 2012-03-17
	(8 rows)


Pregunta 2:
^^^^^^^^^^^

Crear la**Vista NoGrade:** contiene series sin clasificación en la base de datos, es decir que *score* sea NULL. La vista contiene el *sID* de la serie y su título (*title*).

.. code-block:: sql

	postgres=# SELECT * FROM NoGrade;

	 sid |    title     
	-----+--------------
	   5 | Glee
	   9 | The Simpsons
	(2 rows)


Pregunta 3:
^^^^^^^^^^

Crear la **Vista HighlyGrade:** contiene series con al menos una nota (*score*) mayor a 5. La vista contiene el sID de la serie y título de la serie.

.. code-block:: sql

	postgres=# SELECT * FROM HighlyGrade;

	 sid |        title        
	-----+---------------------
	   1 | The Big Bang Theory
	   2 | Greys Anatomy
	   3 | Dexter
	   4 | Bones
	   6 | The Walking Dead
	   7 | Lost
	   8 | Spartacus
	(7 rows)


Pregunta 4:
^^^^^^^^^^

Crear la **Vista nullDate:** contiene los nombres de los evaluadores que no ingresaron la fecha de calificación.

.. code-block:: sql

	postgres=# SELECT * FROM nullDate;

	     name      
	---------------
	 Harry Shearer
	 Jon Lovitz
	 David Crosby
	(3 rows)


Pregunta 5:
^^^^^^^^^^^

Crear la **Vista TotalGrade:** contiene el titulo (*title*) de cada serie y su promedio de nota (*score*). La vista se encuentra ordenada por el promedio de nota de forma decendente y con titulo de columna *total_score*. 

.. code-block:: sql

	postgres=# SELECT * FROM TotalGrade;

		title        |    total_score     
	---------------------+--------------------
	 The Big Bang Theory | 8.0000000000000000
	 Dexter              | 8.0000000000000000
	 Bones               | 7.6666666666666667
	 Lost                | 7.0000000000000000
	 Greys Anatomy       | 6.0000000000000000
	 The Walking Dead    | 5.6666666666666667
	 Spartacus           | 5.6666666666666667
	(7 rows)


.. note::

     La tarea se `entrega`_ en un archivo assignment7.doc , .txt, .docx o .pdf que incluya la respuesta de todas las preguntas. Cuide bien el formato de entrega. Otros formatos no serán aceptados.
        * Existirá un descuento de 10 puntos por enviar tareas al mail del profesor.
        * Si posea problemas con la entrega, escribir al mail del profesor con la excusa pertinente, antes del plazo de entrega (miércoles 20 febrero 2013).

.. _`entrega`: https://csrg.inf.utfsm.cl/claroline/


