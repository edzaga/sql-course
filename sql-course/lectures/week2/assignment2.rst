Tarea 2 
=======

Fecha de entrega: Lunes 10 de Diciembre 2012 hasta 23:59
-----------------------------------------------------------

.. role:: sql(code)
   :language: sql
   :class: highlight

-------------
Base de datos
-------------

Se tiene una página que maneja base de datos de series de televisión con el siguiente esquema:

* `\text{Serie}(\underline{\text{sID}},\text{titulo, creador, año, audiencia, genero, temp, final})`
	La tabla **Serie** posee *sID* que es un id único y es primary key de la relación,
	además se almacena el *titulo* de la serie, el *creador*, *año* es el año de estreno
	de la primera temporada, la *audiencia* promedio anual, *genero* de la serie y
	finalmente el atributo *temp* que contiene el número de temporadas emitidas hasta
	el 2012, *final* es un atributo que dice si la serie se sigue emitiendo o terminó.

* `\text{Evaluador}(\underline{\text{eID}},\text{nombre})`
	El evaluador es quien califica la serie, la relación **Evaluador** tiene un atributo
	*eID* (id único) que es clave primaria (primary key) y tiene otro atributo *nombre*
	que almacena el nombre del evaluador.

* `\text{Calificación}(\underline{\text{eID,sID}},\text{nota,fecha})`
	Luego que el evaluador califica una serie se guarda en la tabla **Calificacion** que
	tiene dos claves foráneas *eID* que es el id del evaluador y *sID* que es el id de
	algunas de las series almacenadas. Ambas claves foráneas (juntas) conforman la clave
	primaria de **Calificación** También contiene la *nota* puesta por el evaluador
	y la *fecha* que calificó dicha serie.

.. math::

  \textbf{Serie} \\

	\begin{array}{|c|c|c|c|c|c|c|c|}
        \hline
	\textbf{sID} & \textbf{titulo} & \textbf{creador} & \textbf{año} & \textbf{audiencia} & \textbf{genero}& \textbf{temp}& \textbf{final} \\
	\hline
	1 & \text{The Big Bang Theory} & \text{Bill Prady} & 2007 & 45.99 & \text{comedia} & 6 & false\\
	\hline
	2 & \text{Grey’s Anatomy} & \text{Shonda Rhimes} & 2005 & 40.35 & \text{drama} & 9 & false \\
	\hline
	3 & \text{Dexter} & \text{James Manos} & 2006 & 50.24	& \text{crimen} & 7 & false\\
	\hline
	4 & \text{Bones} & \text{Hart Hanson} & 2005 & 30.61 & \text{crimen} &	8 & false \\
	\hline
	5 & \text{Glee} & \text{Ryan Murphy} & 2009 &	39.67 & \text{musical} &	4 & false\\
	\hline
	6 & \text{The Walking Dead} &	\text{Frank Darabont}  & 2010 &	34.78 &	\text{horror} & 3 & false \\
	\hline
	7 & \text{Lost} & \text{Jeffrey Lieber} & 2004 & 49.32	& \text{fantasia} & 6 & true \\
	\hline
	8 & \text{Spartacus} & \text{Steven S. DeKnight} & 2010 & 38.51 &	\text{accion} & 2 & false \\
	\hline
	9 & \text{The Simpsons} & \text{Matt Groening} & 1989 & 55.82	& \text{comedia} & 25 & false\\
	\hline
	 \end{array}

.. math::

	\textbf{ Evaluador} \\

	\begin{array}{|c|c|}
	\hline
	\textbf{eID} & \textbf{nombre}  \\
	\hline
	1	& \text{Nancy Cartwright} \\
	\hline
	2	& \text{Harry Shearer} \\
	\hline
	3	& \text{Frank Welker} \\
	\hline
	4	& \text{Jon Lovitz} \\
	\hline
	5	& \text{Charles Napier} \\
	\hline
	6	& \text{Glenn Sloan} \\
	\hline
	7	& \text{Stacy Keach} \\
	\hline
	8	& \text{David Crosby} \\
	\hline
	9	& \text{Keley Jones} \\
	\hline
	\end{array}

.. math::

	\textbf{Calificacion} \\

	\begin{array}{|c|c|}
	\hline
	\textbf{eID} & \textbf{sID} & \textbf{nota} & \textbf{fecha}  \\
	\hline
	1 &	6&	5	&2012-06-08 \\
	\hline
	1 &	4&	6	&2011-04-13 \\
	\hline
	1 &	1&	8	&2012-01-22 \\
	\hline
	2	&6&	7	&2012-02-23 \\
	\hline
	3	&3&	8&	2011-11-20\\
	\hline
	3	&8&	4	&2011-11-12\\
	\hline
	4	&1&	9&	2012-01-09\\
	\hline
	5	&3	&8	&2012-09-27\\
	\hline
	5&	4&	8&	2012-07-22\\
	\hline
	5	&8&	4	&2012-03-17\\
	\hline
	6	&7&	7	&2012-07-15 \\
	\hline
	6	&6&	5	&2012-05-19 \\
	\hline
	7	&7&	5	&2011-09-20\\
	\hline
	7	&2&	6	&2011-12-08\\
	\hline
	8	&4&	9&	2011-10-02\\
	\hline
	\end{array}


Pregunta 1:
^^^^^^^^^^^

* Cree, una base de datos de nombre tarea2.
* Crear las 3 tablas de la base de datos dada, con sus respectivos atributos.

Elija el tipo de datos que más se acomode para cada atributo según los valores dados.

Pregunta 2:
^^^^^^^^^^^

Inserte los datos dados en las tablas que se mostraron anteriormente.


Pregunta 3:
^^^^^^^^^^^

Realice la consulta en SQL que encuentre los títulos de todas las series que sean del
género de comedia.

Resultado esperado de la consulta:

.. code-block:: sql

 titulo
 ---------------------
  The Big Bang Theory
  The Simpsons

Pregunta 4:
^^^^^^^^^^^

Buscar los títulos y audiencias de las series y ordenarlas en de forma descendente.

Resultado esperado de la consulta:

.. code-block:: sql

          titulo        | audiencia
   ---------------------+-----------
    The Simpsons        |     55.82
    Dexter              |     50.24
    Lost                |     49.32
    The Big Bang Theory |     45.99
    Greys Anatomy       |     40.35
    Glee                |     39.67
    Spartacus           |     38.51
    The Walking Dead    |     34.78
    Bones               |     30.61


Pregunta 5:
^^^^^^^^^^^
Buscar los títulos (sin que se repitan)  de las series con nota mayor a 7.

Resultado esperado de la consulta:

.. code-block:: sql

       titulo
 ---------------------
  Lost
  Dexter
  The Walking Dead
  The Big Bang Theory
  Bones



Pregunta 6:
^^^^^^^^^^^
Buscar todos los años de estreno(sin que se repitan) que tiene una serie que recibió una calificación de 5 ó 6, y clasificarlos en orden descendentes.

Resultado esperado de la consulta:

.. code-block:: sql

 año
 ------
  2004
  2005
  2010


Pregunta 7:
^^^^^^^^^^^
Buscar el nombre de los evaluadores(sin que se repitan), que calificaron alguna serie que tenga más de 7 temporadas o haya finalizado.

Resultado esperado de la consulta:

.. code-block:: sql

  nombre
 ------------------
  Glenn Sloan
  Charles Napier
  Stacy Keach
  Nancy Cartwright
  David Crosby


Pregunta 8:
^^^^^^^^^^^
Escriba una consulta para devolver: nombre del evaluador, título de la serie, la nota, y la fecha de clasificación. Ordenar los datos, en primer lugar por el nombre del evaluador, y luego por título de la serie, y por último por la nota.

Resultado esperado de la consulta:

.. code-block:: sql

       nombre      |       titulo        | nota |   fecha
 ------------------+---------------------+------+------------
  Charles Napier   | Bones               |    8 | 2012-07-22
  Charles Napier   | Dexter              |    8 | 2012-09-27
  Charles Napier   | Spartacus           |    4 | 2012-01-27
  David Crosby     | Bones               |    9 | 2011-10-02
  Frank Welker     | Dexter              |    8 | 2011-11-20
  Frank Welker     | Spartacus           |    4 | 2011-11-12
  Glenn Sloan      | Lost                |    7 | 2012-07-15
  Glenn Sloan      | The Walking Dead    |    5 | 2012-05-19
  Harry Shearer    | The Walking Dead    |    7 | 2012-02-23
  Jon Lovitz       | The Big Bang Theory |    9 | 2012-01-09
  Nancy Cartwright | Bones               |    6 | 2011-04-13
  Nancy Cartwright | The Big Bang Theory |    8 | 2012-01-22
  Nancy Cartwright | The Walking Dead    |    5 | 2012-06-08
  Stacy Keach      | Greys Anatomy       |    6 | 2011-12-08
  Stacy Keach      | Lost                |    5 | 2011-09-20


Pregunta 9:
^^^^^^^^^^^
El evaluador de eID=4 se equivocó al ingresar la nota de la serie con sID=1, por lo que quiere cambiar la calificación tiene de 9 a 8. Realizar la sentencia necesaria para cumplir con el ajuste requerido.





