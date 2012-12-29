Lecture 19 - Unified Modeling Language: UML data modeling
---------------------------------------------------------

<agregar algo de introducción>

Existen diversas formas de modelar bases de datos (BD), ya sea a través de Modelos Relacionales (lo cual se verá
en esta lectura) o XML (relativamente nuevo), entre otras.

En lugar de crear las relaciones de forma directa en la BD, el diseñador realiza un modelado de 
alto nivel, de modo que la situación que se está enfrentando con la BD pueda verse en su totalidad.
Posteriormente el diseñador, una vez que valida su modelo, procede a su traducción al lenguaje de la BD.

Esta situación no presenta trabajo innecesario (correspondiente al modelado y a la posterior creación
de relaciones en la BD), pues afortunadamente la gran mayoría de estas herramientas permiten realizar 
una traducción al lenguaje de la BD.
 
.. mejorar la idea previa.

Dentro del modelado de BD Relacionales, los métodos más conocidos son los diagramas de Entidad-Relación
(ER), vistos en la primera semana, y el Lenguaje de Modelado Unificado (UML, por sus siglas en inglés).
Ambos comparten la característica de ser gráficos; es decir que UML al igual que ER está compuesto por
"simbolos" bajo una serie de reglas. Además, ambos comparten la cualidad de que pueden ser traspasados
a lenguaje de BD de forma relativamente autónoma.

Por otro lado, cabe destacar que ER es mucho más antiguo que UML, superandole en edad en el orden de 
décadas. UML es un lenguaje más amplio, es decir, no solo se utiliza para modelar BD, sino que es utilizado
para modelar programas también. De hecho UML define 9 tipos de diagramas. **(Agregar lo de los diagramas que
aparece más abajo con una breve explicacion.)**

.. note::

  Existen variadas herramientas a la hora de gráficar diagramas UML. Algunas de ellas son: 
  DIA, StarUML o Umbrello entre otras. 
  
  

Existen 5 conceptos claves en UML:

 1) Clases
 2) Asociaciones
 3) Asociaciones entre clases
 4) Subclases
 5) Composiciones y agregaciones


Clases
~~~~~~

Las clases se componen de: un nombre, atributos y métodos. Para quienes hayan experimentado alguna 
vez con la programación orientada a objetos probablemente se sientan algo familiarizados.

A la hora de realizar modelos de BD, es necesario agregar un identificador de que atributo corresponde a
la clave primaria, además de un método de eliminación. **Revisar si hay que agregar sobre drop cascade en el video o no**
No obstante en está lectura se pondrá énfasis a los atributos, pues está enfocada más al  modelado de datos
que a su operación a través de sus métodos.

Ejemplo 1
^^^^^^^^^
Retomemos el caso de los Estudiantes y Establecimientos Educacionales. Dibujemos ambas relaciones como
clases en UML:

.. agregar la captura de pantalla con el modelado.



Asociaciones
~~~~~~~~~~~~

Asociaciones entre Clases
~~~~~~~~~~~~~~~~~~~~~~~~~

Subclases
~~~~~~~~~

Composiciones y Agregaciones
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


La razón de crear estos modelos correspond


Pauta a seguir y completar

* Data Modeling
* Modelado de datos de alto nivel (ER (de las primeras lecturas), UML)

* 5 conceptos de UML:
 1) Clases
 2) Asociaciones
 3) Asociaciones entre clases
 4) Subclases
 5) Composiciones y agregaciones

Multiplicidad
Tipos de relaciones (1-1, muchos - 1 , muchos - muchos)

Ejemplos por cada concepto.

Parrafo inicial con algo como: "en esta lectura se utilizará X herramienta para trabajar en el modelado UML. Sin
embargo existen muchas otras herramientas, tales como... *Cabe destacar que el uso de cualquiera de ellas no implica
descuentos o bnificaciones en la tarea*"   **Preguntarle a la andrea esto ultimo**


UML define 9 tipos de  diagramas::
 class (package)
 object
 use case
 sequence 
 collaboration
 statechart
 activity
 component
 deployment

El curso está oreintado a diagramas de objeto.

Consejos para realizar un buen diagrama UML

Estimacion inicial... mucha imagen, nada de sql, lectura larga
