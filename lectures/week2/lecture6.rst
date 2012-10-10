Lecture 6 - Data Types
-------------------------------

.. role:: sql(code)
   :language: sql
   :class: highlight

En SQL se tienen varios tipos de datos. Cuando creamos una tabla con la instrucción create table, tenemos que especificar el tipo de dato de cada columna.

1. Character strings of fixed or varying length: The type CHAR(n) denotes a fixed-length string of n characters. That is, if an attribute has type CHAR(n), then in any tuple the component for this attribute will be a string of n characters. VARCHAR(n) denotes a string of up to n characters. Components for an attribute of this type will be strings of between 0 and n characters. SQL permits reasonable coercions between values of character-string types. Normally, a string is padded by trailing blanks if it becomes the value of a component that is a fixed-length string of greater length. For example, the string "foo", if it became the value of a component for an attribute of type CHAR(5), would assume the value "foo  ", (with two blanks following the second o). The padding blanks can then be ignored if the value of this component were compared with another string.

2. Bit strings of fixed or varying length. These strings are analogous to fixed and varying-length character strings, but their values are strings of bits rather than characters. The type BIT(n) denotes bit strings of length n, while BIT VARYING(n) denotes bit strings of length up to n.

3. The type BOOLEAN denotes an attribute whose value is logical. The possible values of such an attribute are TRUE, FALSE, and - although it would surprise George Boole - UNKNOWN.

4. The type INT or INTEGER (these names are synonyms) denotes typical integer values. The type SHORTINT also denotes integers, but the number of bits permitted may be less, depending on the implementation (as with the types int and short int in C).


5. Floating-point numbers can be represented in a variety of ways. We may use the type FLOAT or REAL (these are synonyms) for typical floating-point numbers. A higher precision can be obtained with the type DOUBLE PRECISION; again the distinction between these types is as in C. SQL also has types that are real numbers with a fixed decimal point. For example, DECIMAL(n,d) allows values that consist of n decimal digits, with the decimal point assumed to be d positions from the right. Thus, 0123.45 is a possible value of type DECIMAL(6,2). NUMERIC is almost a synonym for DECIMAL, although there are possible implementation-dependent differences.

6. Dates and times can be represented by the data types DATE and TIME, respectively. These values are essentially character strings of a special form. We may, in fact, coerce dates and times to string types, and we may do the reverse if the string "makes sense" as a date or time.

.. math::

 \begin{array}{|c|c|}
  \hline
  \textbf{Tipo} & \textbf{Descripción} \\
  \hline
  \mbox{BOOL} & \mbox{Booleano valores "true o false".} \\
  \hline
  \mbox{CHAR} & \mbox{Un solo carácter.} \\
  \hline
  \mbox{DATE} & \mbox{Fecha ANSI SQL "aaaa-mm-dd".} \\
  \hline
  \mbox{DATETIME} & \mbox{Fecha y hora "aaaa-mm-dd hh:mm:ss".} \\
  \hline
  \mbox{TIME} & \mbox{Hora ANSI SQL "hh:mm:ss".} \\
  \hline
  \mbox{UNKNOWN} & \mbox{Tipo desconocido.} \\
  \hline
  \mbox{VARCHAR} & \mbox{Cadena de carácteres sin espacios al final, longitud especificada al momento de creación.} \\
  \hline
 \end{array}

Ejemplo práctico
~~~~~~~~~~~~~~~~ 

A continuación se mostrarán ejemplos realizados con PostgreSQL de los tipos de datos nombrados anteriormente.

Este ejemplo trata del juego adivina quien y se realizan preguntas como: tu personaje tiene gafas, es rubio, es alto. La tabla queda de la siguiente manera utilizando los valores booleanos para crear las tablas:::
  
 postgres=# CREATE TABLE Adivina_quien(Personaje VARCHAR(30), GAFAS BOOL, RUBIO BOOL, ALTO BOOL);
 CREATE TABLE
 postgres=# INSERT INTO Adivina_quien(Personaje,GAFAS,RUBIO,ALTO) VALUES('Tomas',true,false,true);
 INSERT 0 1
 postgres=# SELECT*FROM Adivina_quien;
 personaje | gafas | rubio | alto 
 -----------+-------+-------+------
 Tomas     | t     | f     | t
 (1 fila)


