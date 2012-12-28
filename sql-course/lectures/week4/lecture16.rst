Lectura 16 - Teoría del Diseño Relacional: Dependencia Funcional
----------------------------------------------------------------

Dependencia Funcional
~~~~~~~~~~~~~~~~~~~~~

Dados dos atributos A y B de una relación R, se dice que B depende funcionalmente de A,
si cada valor de A tiene asociado un único valor de B. En otras palabras: si en cualquier
instante, conocido el valor de A podemos conocer el valor de B. Tanto A como B pueden
ser conjuntos de atributos. La dependencia funcional se simboliza del siguiente modo:

.. math::

 R.A \rightarrow R.B

Por ejemplo en la relación R(`\underline{Nif}`, Nombre, Dirección), los atributos *Nombre* y
*Dirección* dependen funcionalmente de *Nif*.

.. math::

 Nif \rightarrow (Nombre, Dirección)

Las dependencias funcionales son generalmente útiles para:

* Almacenamiento de datos - compresión
* Razonamiento acerca de las consultas - Optimización

Ejemplo 1:
==========

**Estudiante(SSN, sNombre, dirección, HScodigo, HSnombre, HSciudad, GPA, prioridad)**

**Aplicar(SSN, cNombre, estado, fecha, principal)**

Supongamos que la prioridad es determinada por GPA

.. math::

 \text{GPA > 3,8 prioridad = 1}

 \text{3,3 < GPA <= 3,8 prioridad = 2}

 \text{GPA <= 3,3 prioridad = 3}

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

**Student(SSN, sNombre, dirección, HScodigo, HSnombre, HSciudad, GPA, prioridad)**

.. math::

 SSN \rightarrow sNombre

 SSN \rightarrow dirección

 HScodigo \rightarrow HSnombre, HSciudad

 HSnombre, HSciudad \rightarrow HScodigo

 SSN \rightarrow GPA

 GPA \rightarrow prioridad

 SSN \rightarrow prioridad

**Apply(SSN, cNombre, estado, fecha, principal)**

.. math::

 cNombre \rightarrow fecha

 SSN, cNombre \rightarrow principal

 SSN \rightarrow estado

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

.. math::

 \overline{A} \rightarrow \overline{B} \hspace{1cm}  \overline{B} \subseteq A

Dependencia funcional no Trivial

.. math::

 \overline{A} \rightarrow \overline{B} \hspace{1cm} \overline{B} \not\subseteq A

Dependencia funcional completamente Trivial

.. math::

 \overline{A} \rightarrow \overline{B} \hspace{1cm} \overline{A} \cap \overline{B} = \oslash

Reglas para las dependencias funcionales
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

* Regla de la división

.. math::

 \overline{A} \rightarrow B_{1}, B_{2}, \ldots,B_{n}

 \overline{A} \rightarrow B_{1} \hspace{1cm} \overline{A} \rightarrow B_{2} \ldots

* ¿Se puede también dividir a la izquierda?

.. math::

 A_{1}, A_{2}, \ldots, A_{n} \rightarrow \overline{B}

 A_{1} \rightarrow \overline{B} \hspace{1cm} A_{2} \rightarrow \overline{B} \ldots

No se puede realizar una división a la izquierda

* Combinación de las reglas

.. math::

 \overline{A} \rightarrow B_{1}

 \overline{A} \rightarrow B_{2}

 \overline{A} \rightarrow B_{\ldots}

 \overline{A} \rightarrow B_{n}

 \Rightarrow \overline{A} \rightarrow B_{1}, B_{2}, \ldots, B_{n}

* Reglas de dependencia trivial

.. math::

 \overline{A} \rightarrow \overline{B} \hspace{1cm}  \overline{B} \subseteq A

 \overline{A} \rightarrow \overline{B} \hspace{1cm} \text{entonces} \hspace{1cm} \overline{A} \rightarrow \overline{A} \cup \overline{B}

 \overline{A} \rightarrow \overline{B} \hspace{1cm} \text{entonces} \hspace{1cm} \overline{A} \rightarrow \overline{A} \cap \overline{B}

* Regla transitiva

.. math::

 \overline{A} \rightarrow \overline{B} \hspace{1cm} \overline{B} \rightarrow \overline{A} \hspace{1cm} \text{then} \hspace{1cm}  \overline{A} \rightarrow \overline{C}

Cierre de atributos

* Dada una relación, dependientemente funcional, un conjunto de atributos `\overline{A}`
* Encuentre todos los B de forma que `\overline{A} \rightarrow B`

Ejemplo 4
=========

Un ejemplo de cierre de atributos es:

**Estudiante(SSN, sNombre, dirección, HScodigo, HSnombre, HSciudad, GPA, prioridad)**

.. math::

 \text{SSN} \rightarrow \text{sNombre, dirección, GPA}

 \text{GPA} \rightarrow \text{prioridad}

 \text{HScodigo} \rightarrow \text{HSnombre, HSciudad}

 \text{{SSN, HScodigo}}^{+} \rightarrow \text{(todos los atributos)(llave)}

 \text{{SSN, HScodigo, sNombre, dirección, GPA, prioridad, HSnombre, HSciudad}}

Clausura y llaves
~~~~~~~~~~~~~~~~~

* ¿Es `\overline{A}` una llave para R?

 Calcular `\overline{A^{+}}` Si = todos atributos, entonces `\overline{A}` es una llave.

* ¿Cómo podemos encontrar todas las llaves dado un conjunto de dependencias funcionales?

 Considerar cada subconjunto `\overline{A}` de los atributos.

 `A^{+} \rightarrow` todos los atributos

 **es llave**

Ejemplo 5
=========

Tenga en cuenta la relación R (A, B, C, D, E) y supongamos que tenemos las dependencias funcionales:

.. math::

 AB \rightarrow C

 AE \rightarrow D

 D \rightarrow B

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

S1: {SSN `\rightarrow` GPA, GPA `\rightarrow` prioridad}

.. note::

 Se observa que S1 satisface S2

Ejemplo 6
=========

Consideremos la relación R (A, B, C, D, E) y el conjunto de dependencias funcionales
S1 = {AB `\rightarrow` C, AE `\rightarrow` D, D `\rightarrow` B}.

¿Cuál de los siguientes conjuntos de S2 FD NO se deduce de S1?

a) S2 = {AD `\rightarrow` C}
b) S2 = {AD `\rightarrow` C, AE `\rightarrow` B}
c) S2 = {ABC `\rightarrow` D, D `\rightarrow` B}
d) S2 = {ADE `\rightarrow` BC}

La alternativa correcta es (c), puesto que el uso de las FDs en S1: {AD}+ = {ABCD};
{AE}+ = {ABCDE}; {ABC}+ = {ABC}; {D}+ = {B}; {ADE}+ = {ABCDE}



