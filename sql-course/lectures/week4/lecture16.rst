Lecture 16 - Teoría del Diseño Relacional: Dependencia Funcional
----------------------------------------------------------------

Dependencia Funcional
~~~~~~~~~~~~~~~~~~~~~

Las dependencias funcionales describen la relación existente entre atributos de una 
relación. Por ejemplo, si A y B son atributos de la relación R, B será funcionalmente 
dependiente de A ó A determina funcionalmente a B (lo que se denota A->B) si cada
valor de A está asociado con exactamente un valor de B.

Las dependencias funcionales son generalmente útiles para:

* Almacenamiento de datos - compresión
* Razonamiento acerca de las consultas - Optimización

Ejemplo 1:
==========

Estudiante(SSN, sNombre, dirección, HScodigo, HSnombre, HSciudad, GPA, prioridad)

Aplicar(SSN, cNombre, estado, fecha, principal)

Supongamos que la prioridad es determinada por GPA

GPA > 3,8 prioridad = 1

3,3 < GPA <= 3,8 prioridad = 2

GPA <= 3,3 prioridad = 3

Dos tuplas con el mismo GPA tienen la misma prioridad

.. math::

 \forall t, u \in Estudiante

 t.GPA = u.GPA \Rightarrow t.priority = u.priority

 GPA \rightarrow prioridad

De forma general sería:

.. math::

 \forall t, u \in R

 t.A = u.A \Rightarrow t.B = u.B

 A \rightarrow B

 \forall t, u \in R

 t.[A_{1}, ..., A_{n}] = u.[A_{1}, ..., A_{n}] => t.[B_{1}, ..., B_{n}] = u.[B_{1}, ..., B_{n}]

 A_{1}, A_{2}, ..., A_{n} \rightarrow B_{1}, B_{2}, ..., B_{n}

 \overline{A} \rightarrow \overline{B}

Ejemplo 2
=========

Considere la posibilidad de una relación R (A, B, C, D, E) con dependencias funcionales:

.. math::

 A,B \rightarrow C

 C,D \rightarrow E.

Supongamos que hay un máximo de 3 valores diferentes para cada uno de A, B y D. 
¿Cuál es el número máximo de valores diferentes para la E?

a) 27
b) 9
c) 3
d) 81

La alternativa correcta es (a), puesto que hay a lo sumo 3 * 3 = 9 combinaciones de 
valores de A, B, así que por A, B -> C como máximo 9 valores diferentes para C con 
un máximo de 3 valores diferentes para D, por C,D -> E hay en la mayoría de 9 * 3 = 27 
valores diferentes para E.

Las dependencias funcionales para las tablas son:

**(SSN, sNombre, dirección, HScodigo, HSnombre, HSciudad, GPA, prioridad)**

SSN `\rightarrow` sNombre

SSN `\rightarrow` dirección

HScodigo `\rightarrow` HSnombre, HSciudad

HSnombre, HSciudad `\rightarrow` HScodigo

SSN `\rightarrow` GPA

GPA `\rightarrow` prioridad

SSN `\rightarrow` prioridad

**Apply(SSN, cNombre, estado, fecha, principal)**

cNombre `\rightarrow` fecha

SSN, cNombre `\rightarrow` principal

SSN `\rightarrow` estado

Ejemplo 3
=========

Para la relación Aplicar(SSN, cNombre, estado, fecha, principal), lo que en el mundo real es capturado por restricción 
SSN,fecha -> cNombre?

a) Un estudiante sólo puede aplicar a un colegio.
b) Un estudiante puede aplicar a cada colegio una sola vez.
c) Un estudiante debe aplicar a todos los colegios en la misma fecha.
d) Toda solicitud de un estudiante a un colegio específico debe estar en la misma fecha.

La alternativa correcta es (d), puesto que cualquiera de las dos tuplas con el mismo 
SSN-cNombre combinación también deben tener la misma fecha. Así que si un estudiante (SSN) se aplica 
a una universidad (cNombre) más de una vez, deben estar en la misma fecha.

Dependencias funcionales y llaves
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

* Relación sin duplicados
* Supongamos `\overline{A}` todos los atributos

Dependencia funcional Trivial

`\overline{A} \righarrow \overline{B}`  `\overline{B} \subseteq A`

Dependencia funcional no Trivial

`\overline{A} \righarrow \overline{B}` `\overline{B} \nosubseteq A`

Dependencia funcional completamente Trivial

`\overline{A} \righarrow \overline{B}` `\overline{A} \cap \overline{B} = \oslash`

Reglas para las dependencias funcionales

* Regla de la división

`\overline{A} \righarrow B_{1}, B_{2},...,B_{n}`

`\overline{A} \righarrow B_{1}` `\overline{A} \righarrow B_{2}` `...`

* ¿Se puede también dividir a la izquierda?

`A_{1}, A_{2}, ..., A_{n} \righarrow \overline{B}`

`A_{1} \righarrow \overline{B}` `A_{2} \righarrow \overline{B}` `...`

No se puede realizar una división a la izquierda

* Combinación de las reglas

`\overline{A} \righarrow B_{1}`

`\overline{A} \righarrow B_{2}` 

`\overline{A} \righarrow B_{.}` 

`\overline{A} \righarrow B_{n}`

`\Righarrow` `\overline{A} \righarrow B_{1}, B_{2}, ..., B_{n}` 

* Reglas de dependencia trivial

`\overline{A} \righarrow \overline{B}`  `\overline{B} \subseteq A` 

`\overline{A} \righarrow \overline{B}` entonces `\overline{A} \righarrow \overline{A} \cup \overline{B}`

`\overline{A} \righarrow \overline{B}` entonces `\overline{A} \righarrow \overline{A} \cap \overline{B}`

* Regla transitiva

`\overline{A} \righarrow \overline{B}` `\overline{B} \righarrow \overline{A}` entonces `\overline{A} \righarrow \overline{C}`

Cierre de atributos

* Dada una relación, dependientemente funcional, un conjunto de atributos `\overline{A}`
* Encuentre todos los B de forma que `\overline{A} \righarrow B`

Ejemplo 4
=========

Estudiante(SSN, sNombre, dirección, HScodigo, HSnombre, HSciudad, GPA, prioridad)

SSN `\righarrow` sNombre, dirección, GPA

GPA `\righarrow` prioridad

HScodigo `\righarrow` HSnombre, HSciudad

{SSN, HScodigo} `^{+}` `\righarrow` (todos los atributos)(llave)

{SSN, HScodigo, sNombre, dirección, GPA, prioridad, HSnombre, HSciudad}

Clausura y llaves
~~~~~~~~~~~~~~~~~

* ¿Es `\overline{A}` una llave para R?

Calcular `\overline{A^{+}}` Si = todos atributos, entonces `\overline{A}` es una llave.
 
* ¿Cómo podemos encontrar todas las llaves dado un conjunto de dependencias funcionales?

Considerar cada subconjunto `\overline{A}` de los atributos.

`A^{+} \righarrow` todos los atributos 

es llave

Ejemplo 5
=========

Tenga en cuenta la relación R (A, B, C, D, E) y supongamos que tenemos las dependencias funcionales:

.. math::

 AB \righarrow C
 
 AE \righarrow D
 
 D \righarrow B

¿Cuál de los siguientes pares de atributos es una clave para R?

a) AB
b) AC
c) AD
d) AE

La alternativa correcta es (d), puesto que {AB}+ = {ABC}; {AC}+ = {AC}; {AD}+ = {ABCD}; 
{AE}+ = {ABCDE}.

Especificación funcionalmente dependiente para una relación
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

S1 y S2 conjunto funcionalmente dependiente.
 
S2 "sigue de" S1 si cada instancia de relación satisfacer S1 si también satisface S2

S2: {SSN, prioridad}

S1: {SSN `\righarrow` GPA, GPA `\righarrow` prioridad}

.. note::

 Se observa que S1 satisface S2 

Ejemplo 6
=========

Consideremos la relación R (A, B, C, D, E) y el conjunto de dependencias funcionales 
S1 = {AB `\righarrow` C, AE `\righarrow` D, D `\righarrow` B}.

¿Cuál de los siguientes conjuntos de S2 FD NO se deduce de S1?

a) S2 = {AD `\righarrow` C}
b) S2 = {AD `\righarrow` C, AE `\righarrow` B}
c) S2 = {ABC `\righarrow` D, D `\righarrow` B}
d) S2 = {ADE `\righarrow` BC}

La alternativa correcta es (c), puesto que Using the FDs in S1: {AD}+ = {ABCD}; 
{AE}+ = {ABCDE}; {ABC}+ = {ABC}; {D}+ = {B}; {ADE}+ = {ABCDE}



