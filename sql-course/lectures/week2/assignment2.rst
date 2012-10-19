Tarea2
============

-------------------
Base de datos
-------------------

Se tiene una página que maneja base de datos de series siguiente esquema:

  * Serie: (**sID**, titulo, creador, año, audiencia, genero, temporadas)
La tabla **Serie** posee **sID** que es un id único y es primary key de la relación, además se almacena el **titulo** de la serie, el **creador**, el **año** de estreno de la primera temporada,  la **audiencia** promedio anual, genero de la serie y finalmente el atributo **temporadas** contiene el números de temporadas emitidas hasta el 2012. 

  * Evaluador: (**eID**, nombre)
El evaluador es quien califica la serie, la relación **Evaluador** tiene un atributo **eID** (id único) que es primary key y tiene otro atributo **nombre** que almacena el nombre del evaluador. 

  * Calificacion: (eID,sID,nota,fecha) 
Luego que el evaluador califica una serie se guarda en la tabla **Calificacion** que tiene dos claves foráneas **eID** que es el id del evaluador y **sID** que es el id de algunas de las series almacenadas.  También contiene la **nota** puesta por el evaluador y la **fecha** que calificó dicha serie.

.. math::

  \textbf{ Serie} \\

	\begin{array}{|c|c|c|c|c|c|c|}
        \hline
	\textbf{sID} & \textbf{titulo} & \textbf{creador} & \textbf{año} & \textbf{audiencia} & \textbf{genero}& \textbf{temporadas} \\	
	\hline
	101 &	The Big Bang Theory & Bill Prady & 2007 & 4599 &	comedia	& 6 \\
	\hline
	102	& Grey’s Anatomy & Shonda Rhimes & 2005 & 4035 & drama	& 9 \\
	\hline
	103	& Dexter &	James Manos	& 2006 &	5024	& crimen &	7 \\
	\hline
	104	& Bones &	Hart Hanson & 2005 &	3061	& crimen &	8 \\
	\hline
	105	& Glee &	Ryan Murphy & 2009 &	3967	& musical &	4 \\
	\hline
	106	& The Walking Dead &	Frank Darabont  & 2010 &	3478 &	horror	& 3 \\
	\hline
	107	& Lost	& Jeffrey Lieber & 2004 &	4932	& fantasia	& 6 \\
	\hline
	108	& Spartacus &	Steven S. DeKnight  & 2010	& 3851 &	accion	& 2 \\
	\hline
	109	& The Simpsons& Matt Groening & 1989 & 5582	& comedia	& 25 \\
	\hline
	 \end{array}

.. math::

	\textbf{ Evaluador} \\

	\begin{array}{|c|c|}
	\hline
	\textbf{eID} & \textbf{nombre}  \\
	\hline
	201	& Nancy Cartwright \\
	\hline
	202	& Harry Shearer \\
	\hline
	203	& Frank Welker \\
	\hline
	204	& Jon Lovitz \\
	\hline
	205	& Charles Napier \\
	\hline
	206	& Glenn Close \\
	\hline
	207	& Stacy Keach \\
	\hline
	208	& David Crosby \\
	\hline
	\end{array}

.. math::

	\textbf{Calificacion} \\
	 
	\begin{array}{|c|c|}
	\hline
	\textbf{eID} & \textbf{sID} & \textbf{nota} & \textbf{fecha}  \\
	\hline			
	201 &	101&	8	&2012-01-22 \\
	\hline
	201	&101	&9	&2012-01-27 \\
	\hline
	202	&106&	7	&<null> \\
	\hline
	203	&103&	8&	2011-11-20\\
	\hline
	203	&108&	4	&2011-11-12\\
	\hline
	203	&108&	6	&2012-04-30\\
	\hline
	204	&101&	9&	2012-01-09\\
	\hline
	205	&103	&8	&2012-09-27\\
	\hline
	205&	104&	8&	2012-07-22\\
	\hline
	205	&108&	4	&<null>\\
	\hline
	206	&107&	7	&2012-07-15 \\
	\hline
	206	&106&	5	&2012-05-19 \\
	\hline
	207	&107&	5	&2011-09-20\\
	\hline
	208	&104&	9&	2011-10-02\\
	\hline
	\end{array}


^^^^^^^^^^^
Pregunta 1:
^^^^^^^^^^^
Cree las 3 tablas necesarias para la base de datos dada, con sus respectivos atributos. Elija el tipo de datos que más se acomode para cada atributo según los valores dados.
Inserte los datos dados en las tablas que se mostraron anteriormente.


^^^^^^^^^^^
Pregunta 2:
^^^^^^^^^^^
Realizace la consulta en sql que encuentre los títulos de todas las series que sean del género de comedia.
Resultado esperado de la consulta:

.. math::
	\begin{array}{|c|}
	\hline
	\textbf{titulo}  \\
	\hline
	The Big Bang Theory \\
	\hline
	 The Simpsons\\
	\hline
	\end{array}


^^^^^^^^^^^
Pregunta 3:
^^^^^^^^^^^
Buscar los títulos y audiencias de las series y ordenarlas en de forma decreciente. 


^^^^^^^^^^^
Pregunta 4:
^^^^^^^^^^^
Buscar los títulos de las series con nota mayor a 7.

^^^^^^^^^^^
Pregunta 5:
^^^^^^^^^^^
Buscar todos los años (sin que se repitan) que tienen una serie que recibió una calificación de 5 ó 6, y clasificarlos en orden decreciente. 

^^^^^^^^^^^
Pregunta 6:
^^^^^^^^^^^
Encuentra los títulos de todas las series que no tienen calificaciones, es decir que no se encuentran en la tabla Clasificacion.


^^^^^^^^^^^
Pregunta 7:
^^^^^^^^^^^
Algunos evaluadores olvidaron poner una fecha con su clasificación. Se pide encontrar los nombres de todos los encuestados que tienen calificaciones con un valor NULL para la fecha.

^^^^^^^^^^^
Pregunta 8:
^^^^^^^^^^^
Escriba una consulta para devolver: nombre del evaluador, título de la serie, la nota, y la fecha de clasificación. Ordenar los datos, en primer lugar por el nombre del evaluador, y luego por título de la serie, y por último por la nota.

^^^^^^^^^^^
Pregunta 9:
^^^^^^^^^^^
Los evaluadores no están dispuestos a volver a evaluar una serie que tenga menos de 4000 de audiencia. Por lo que se le pide que elimine de la tabla `serie` todas aquellas que no cumplan con esta condición. 

^^^^^^^^^^^^
Pregunta 10:
^^^^^^^^^^^^
El evaluador de eID=204 se equivocó al ingresar la nota de la serie con sID=101, por lo que quiere cambiar la calificación de 9 a 8. Realice la sentencia necesaria para cumplir con el ajuste requerida. 

