Tarea 3
============

Fecha de entrega: Lunes  de Diciembre 2012 hasta 23:59
-----------------------------------------------------------

.. role:: sql(code)
   :language: sql
   :class: highlight

-------------
Base de datos
-------------

Se tiene una base de datos de equipos de futbol con el siguiente esquema:

* `\text{Equipo}(\underline{\text{ideq}},\text{nombre, ciudad, titulos})`
	La tabla **Equipo** posee *ideq* que es un id único y es primary key de la relación.
	Se almacena el *nombre* del equipo, la *ciudad* que corresponde a la sede donde el equipo juega de local y finalmente
        el atributo *titulos* es un número entero que hace referencia a la cantidad de veces que el equipo ha salido campeón.

.. code-block:: sql

  ideq | nombre |   ciudad    | titulos 
 ------+--------+-------------+---------
     1 | UCH    | Santiago    |      16
     2 | ÑUB    | Chillan     |       0
     3 | SW     | Valparaiso  |       3
     4 | CDA    | Antofagasta |       0
     5 | COB    | Calama      |       8
     6 | UE     | Santiago    |       6
	(6 filas)

* `\text{Jugador}(\underline{\text{rut}},\text{ideq,nombre,posicion,numcamiseta})`
	La relación **Jugador** tiene un atributo *rut* que es único y es clave primaria (primary key), 
        el atributo ideq es una clave foranea que hace referencia a la tabla equipo, *nombre*
	que almacena el nombre del jugador, también se almacena la *posicion* en la que se desempeña el 
	jugador y *numcamiseta* guarda el número de camiseta que ocupa cada jugador.

.. code-block:: sql

  rut  | ideq |  nombre   | posicion  | numcamiseta 
 ------+------+-----------+-----------+-------------
  1760 |    1 | Diaz      | Volante   |          21
  1345 |    1 | Herrera   | Arquero   |          25
  1313 |    1 | Rojas     | Defensa   |          13
  1995 |    1 | Rivarola  | Delantero |           7
  1999 |    1 | Salas     | Delantero |          11
  2343 |    1 | Vargas    | Delantero |          17
  5678 |    2 | Rodriguez | Volante   |           6
  3423 |    2 | Videla    | Volante   |           2
  1234 |    2 | Garces    | Arquero   |          12
  1235 |    2 | Gutierrez | Delantero |           9
  1349 |    2 | Marino    | Volante   |           8
    (36 filas)


* `\text{Partido}(\underline{\text{ideql,ideqv}},\text{golLocal,golVisita})`
	La tabla **Partido** almacena los resultados de los partidos entre dos equipos, 
        de esta forma *ideql* corresponde al id del equipo local, ideqv es el id del equipo
        visitante, *golLocal* son los goles que marca el equipo que juega de local, *golVisita* 
        son los goles marcados por el equipo visitante.

.. code-block:: sql

  ideql | ideqv | golLocal | golVisita 
 -------+-------+----------+-----------
      1 |     2 |        4 |         3
      1 |     3 |        3 |         1
      1 |     4 |        3 |         2
      1 |     5 |        2 |         1
      1 |     6 |        3 |         0
      2 |     1 |        0 |         0
      2 |     3 |        3 |         1
      2 |     4 |        1 |         2
      (30 filas)

.. note::
	Las tablas anteriores son solo de referencia. El archivo con los valores se encuenta en la sección de documentos en la plataforma del curso.


Pregunta 1:
^^^^^^^^^^^


