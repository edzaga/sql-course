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
 3) Clases de asociación
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

Las Asociaciones corresponden a como se relacionan 2 clases.

Ejemplo 2
^^^^^^^^^
El ejemplo 1 terminó con 2 clases separadas, es decir, Estudiantes y Establecimientos Educacionales.
Sin embargo, y como ya se ha visto en ejemplos de lecturas anteriores, los estudiantes postulan a estos 
establecimientos, por lo tanto la relacion es **postular**, por lo tanto:

.. agregar imagen sin relacion direccionada.

Es decir que el **Estudiante** **postula** a un **Establecimiento**. Es posible direccionar esta 
relación para lograr mayor claridad a la hora de ver los diagramas: 

.. agregar imagen con relacion direccionada

Sin embargo no marca la diferencia a la hora de traducir a relaciones.

=============
Multiplicidad
=============

Es necesario determinar cuantas veces un objeto de una clase puede relacionarse con objetos de otra clase. 
Supongamos que se han creado las clases **C1** y **C2**, la multiplicidad apunta a::

 "Cada objeto de la clase C1 está asociado (a través de la relación A)a al menos 
  'm' y a lo más 'n' objetos de la clase C2"

La notación para ello corresponde a *m..n*, es decir que el valor mínimo es *m* y el máximo *n*. Ambos
valores van separados por *..* (dos puntos).

.. agregar imagen.

Cabe mencionar que estas relaciones pueden ser bidirecciones

Algunos casos especiales son::
 
 m..*   -> a lo menos 'm' a lo más cualquier valor superior a 'm'
 0..n   -> a lo menos '0' a lo más 'n'
 0..*   -> a lo menos '0' a lo más cualquier valor superior a '0', es decir , sin reestricción.
 1..1   -> sólo 1 valor.

Existen varios tipos de multiplicidad, con su respectiva notación. Ellos son:

1. uno a uno: **0..1 - 0..1**
2. muchos a uno: **0..* - 0..1**
3. muchos a muchos:  **0..* - 0..*** 
4. completa: **1..* - 1..1** o **1..1 - 1..*** o **1..* - 1..***

.. agregar imagen explicativa de cada uno.

..note::
  En la multiplicidad completa, no deben quedar objetos sin relacionarse.

Ejemplo 3
^^^^^^^^^
Supongamos que cada Estudiante debe postular a lo menos a 1 Establecimientos y a lo más a 3. Por otro lado
Cada establecimiento puede recibir a lo más 50000 postulaciones.

.. agregar imagen


Ejemplo 4
^^^^^^^^^
Con el fin de diversificar y bajo el siguiente contexto, supongamos que tenemos personas que realizan
giros en bancos. Dependiendo del tipo de cuenta, supongamos que existe una cuenta que permite a lo más
3 giros por mes. Por su parte el banco no tiene reestricción de giros que puede recibir.

.. agregar imagen.

Clase de asociación
~~~~~~~~~~~~~~~~~~~~~~

Cuando la multiplicidad de las relaciones impide definir con exactitud que objeto de la clase **C1** esta asociado 
a que objeto de la clase **C2**.

Ejemplo 5
^^^^^^^^^

Supongamos que tenemos a varios  Estudiantes que desean postular a diferentes Establecimientos Educacionales.

.. agregar imagen.

No obstante no hay información que permita definir que estyudiante realiza la postulación, es por ello que se 
crea una clase de asociación, en este caso postulación (Apply).

.. agregar imagen

.. note::

 Cabe recordar que si no se especifica la multiplicidad de la relación, 
 se define **1..1** por defecto.

Sin embargo en este modelo no se permite el caso de que un Estudiante postule multiples veces a un
mismo Establecimiento Educacional. Es por ello que es una buena práctica que, en caso de utilizar este
tipo de clases, se utilice como Clave Primaria (PK), las PK de las clases que están relacionadas. 


El siguiente diagrama clarificará la idea:

.. agregar imagen

Como se puede observar, se han modificado las clases Student, College y Apply. 


==========================================
Eliminar clases de asociación innecesarias
==========================================

Usando las clases genéricas C1, C2 de atributos A1 y A2 respectivamente. Supongamos que la relación entre 
ellas es de multiplicidad (* - 1..1) o (* - 0..1). Supongamos que existe una clase de asociación AC de atributos
A3 y A4. Todo ordenado de acuerdo a la siguiente imagen:

.. agregar imagen

Es posible mover los atributos A3 y A4 a la clase C1, pues dada la multiplicidad un objeto de la clase C1 está
asociado a 1 objeto de la clase C2. Por lo tanto la clase de asociación se puede eliminar.

.. note::

  La clase de asociación se puede eliminar cuando hay multiplicidad 
  (* - 1..1) o (* - 0..1). De hecho está pensada para dejar en claro que
  la asociación entre objetos en caso de que la multiplicidad sea m, n o * en
  ambos lados de la relación.


================
Autoasociaciones
================

Corresponden a asociaciones entre una clase y si misma.

Ejemplo 6
^^^^^^^^^

Supongamos que se desea modelar en UML a la Universidad Técnica Federico Santa María (UTFSM), su Casa
Central y Campus. Supongamos que existen los atributos *NumAlumnos, Dirección, Nombre, Campus*. 
.. En lugar de realizar dos clases diferentes, se utiliza el atributo campu para realizar la asicación. 
Existe una sola Casa Central, pero varios Campus, supongamos que por temas de presupuesto, solo existen
7 campus.
.. agregar imagen

En UML, es posible agregar una etiqueta a la relación y a cada lado.



Subclases
~~~~~~~~~

Composiciones y Agregaciones
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~




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
