Assignment 1
============

Ideas para la tarea1:

Tema: algebra relacional

Realizar una introduccion (su historia loca, como en las tareas del departamento)

1) traducir
  * Poner consultas gformuladas y pedir que las expresen en algebra relacional
  * POner consultas en algebra relacional y pedir que las expresen en lenguaje natural

2) formular
  * Solicitar cierta informacion de las tablas de la BD, en algebra relacional y lenguaje natural

3) alternativas?
  * en la videolectura 4 aparece una pregunta asi (solo al verla online, al bajarla no)
No se me ocurre agregar algo respecto a las lecturas 1 y 2, que son mas introductorias.

Sería bueno agregar http://www.cs.duke.edu/~junyang/ra/, un interprete en java de algebra relacional???

--------------------------
Questions of alternatives:
--------------------------

Question 1:

Suppose relation R(A,B,C) has the following tuples

= = =
A B C
= = =
1 2 3
= = =
4 2 3
= = =
4 5 6
= = = 
2 5 3
= = =
1 2 6
= = =

and relation S(A,B,C) has the following tuples:

= = =
A B C
= = =
2 5 3
= = =
2 5 4
= = =
4 5 6
= = = 
1 2 3
= = =

Compute the intersection of the relations R and S. Which of the following tuples is in the result?

a) (4,5,6)
b) (1,2,6)
c) (4,2,3)
d) (2,4,3)


Question 2:

Suppose relation R(A,B,C) has the following tuples:

= = =
A B C
= = =
1 2 3
= = =
4 2 3
= = =
4 5 6
= = = 
2 5 3
= = =
1 2 6
= = =

and relation S(A,B,C) has the following tuples:

= = =
A B C
= = =
2 5 3
= = =
2 5 4
= = =
4 5 6
= = = 
1 2 3
= = =

Compute (R - S) union (S - R) often called the "symmetric difference" of R and S. Which of the following tuples is in the result?

a) (2,2,3)
b) (4,2,3)
c) (4,5,6)
d) (4,5,3)

Question 3:

Suppose relation R(A,B,C) has the following tuples:

= = =
A B C
= = =
1 2 3
= = =
4 2 3
= = =
4 5 6
= = = 
2 5 3
= = =
1 2 6
= = =

and relation S(A,B,C) has de following tuples:

= = =
A B C
= = =
2 5 3
= = =
2 5 4
= = =
4 5 6
= = = 
1 2 3
= = =

Compute the union of R and S. Which of the following tuples DOES NOT appear in the result?

a) (2,5,3)
b) (2,5,4)
c) (4,5,6)
d) (1,5,4)
