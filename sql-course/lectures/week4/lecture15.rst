Lectura 15 - Teoría del diseño Relacional: Información General
--------------------------------------------------------------

Diseñar un esquema de base de datos
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

* Por lo general existen *muchos* diseños posibles.
* Algunos son (mucho) mejor que otros.
* ¿Cómo elegir?.

El diseño de una base de datos relacional puede abordarse de dos formas:

* **Obteniendo el esquema relacional directamente:** Objetos y reglas captadas del análisis del mundo real, representadas por un conjunto de esquemas de relación, sus atributos y restricciones de integridad.
* **Diseño del esquema conceptual:** realizando el diseño del esquema "conceptual" de la BD (modelo E/R) y transformándolo a esquema relacional.

En los esquemas de bases de datos es posible encontrar anomalías que serán eliminadas
gracias al proceso de normalización.

Estas anomalías son:

* **La redundancia de los datos:** repetición de datos en un sistema.
* **Anomalías de actualización:** inconsistencias de los datos como resultado de datos redundantes y actualizaciones parciales.
* **Anomalías de eliminación:** pérdidas no intencionadas de datos debido a que se han borrado otros datos.
* **Anomalías de inserción:** imposibilidad de adicionar datos en la base de datos debido a la ausencia de otros datos.

A continuación se muestra una tabla y luego el detalle de los problemas que presenta:

.. math::

   \begin{array}{|c|c|c|c|c|c|}
    \hline
    \textbf{Nombre_autor} & \textbf{País} & \textbf{Cod_libro} & \textbf{Titulo_libro} & \textbf{Editor} & \textbf{Dirección_editorial}\\
    \hline
    \text{Cortázar, Julio} & \text{Arg} & \text{9786071110725} & \text{Cuentos Completos 1 Julio Cortazar}  & \text{Alfaguara} & \text{Padre Mariano 82}\\
    \hline
    \text{Rosasco, José Luis}  & \text{Chi} & \text{9789561224056} & \text{Donde Estas, Constanza} & \text{Zig-Zag} & \text{Los Conquistadores 1700} \\
    \hline
    \text{Rosasco, José Luis}  & \text{Chi} & \text{9561313669} & \text{Hoy Día es Mañana} & \text{Andrés Bello} & \text{Ahumada 131}\\
    \hline
    \text{Coloane, Francisco} & \text{Chi} & \text{9789563473308} & \text{Golfo De Penas} & \text{Alfaguara} & \text{Padre Mariano 82}\\
    \hline
   \end{array}

* **Redundancia:** cuando un autor tiene varios libros, se repite su país de origen.
* **Anomalías de modificación:** Si se cambia la dirección de la editorial "Alfaguara", se deben modificar dos filas. A priori no se puede saber cuántos autores tiene un libro. Los errores son frecuentes al olvidar la modificación de un autor.
* **Anomalías de inserción:** Se desea ingresar a un autor sin libros. "Nombre_autor" y "Cod_libro" son campos claves, por lo que las claves no pueden ser valores nulos.

Al eliminar estas anomalías se asegura:

* **Integridad entre los datos:** consistencia de la información.

Otro ejemplo se muestra en la siguiente tabla:

**Aplicar(SSN, sNombre, cNombre, HS, HSciudad, hobby)**

.. note::
 La notación que se utiliza en la tabla es:

 HS = high school (escuela secundaria).


*123 Ann de PAHS (P.A) y GHS (P.A) juega tenis y toca la trompeta y postuló a Stanford, Berkeley y al MIT*

Los datos ingresados en la tabla podrían ser los que se muestran a continuación:

.. math::

   \begin{array}{|c|c|c|c|}
    \hline
    \text{123} & \text{Ann} & \text{Stanford} & \text{PAHS} & \textbf{P.A} & \text{tenis} \\
    \hline
    \text{123} & \text{Ann} & \text{Berkeley} & \text{PAHS}  & \text{P.A} & \text{tenis}\\
    \hline
    \text{123}  & \text{Ann} & \text{Berkeley} & \text{PAHS} & \text{P.A}  & \text{trompeta}\\
    \hline
    \text{.}  & \text{.} & \text{.} & \text{GHS} & \text{.} & \text{.}\\
    \hline
    \text{.} & \text{.} & \text{.} & \text{.} & \text{.} & \text{.}\\
    \hline
   \end{array}

* **Redundancia:** captura información muchas veces como por ejemplo "123 Ann", "PAHS", "tenis" o "MIT".
* **Anomalía de actualización:** actualizar datos de diferente manera como "corneta" por "trompeta".
* **Anomalía de eliminación:** eliminación inadvertida de datos.

Una correcta forma de realizar la tabla anterior sin anomalías es:

* Estudiante(SSN, sNombre);
* Aplicar(SSN, cNombre);
* Escuela_secundaria(SSN, HS);
* Ubicado(HS, HSciudad);
* Aficiones(SSN, hobby);

Ejercicio
=========

Considere la posibilidad de una base de datos que contiene información sobre los cursos
tomados por los estudiantes. Los estudiantes tienen un ID único de estudiante y nombre;
cursos tienen un número único de curso y título, los estudiantes toman un curso de un año determinado y reciben una
calificación.

¿Cuál de los siguientes esquemas recomiendan?

a) Tomo(SID, nombre, cursoNum, título, año, calificación)

b) Curso(cursoNum, título, año), Tomó(SID, cursoNum, calificación)

c) Estudiante(SID, nombre), Curso(cursoNum, título), Tomo(SID, cursoNum, año, calificación)

d) Estudiante(SID, nombre), Curso(cursoNum, título), Tomo(nombre, título, año, calificación)

La alternativa correcta es la letra (c), puesto que en el enunciado se dice que existen
estudiantes con un ID único, que en este caso será "SID" y un "nombre"; los cursos tienen
un ID único que es "cursoNum" y un "titulo", además que los estudiantes toman un curso en un
año determinado "año" y reciben una calificación "grado", pero el atributo "cursoNum" actúa como
clave foránea de la tabla *Curso* con la cual se podrá obtener el titulo del curso y también debe
poseer una clave primaria para poder identificar el curso tomado que será "SID".

Diseño por descomposición
~~~~~~~~~~~~~~~~~~~~~~~~~

* Comienza con las *"mega" relaciones* que contienen todo.
* *Descomponer* en partes más pequeñas, se obtienen mejores relaciones con la misma información.
* ¿Se puede *descomponer automáticamente*?

Descomposición automática:

    * "Mega" relaciones + propiedades de los datos.
    * El sistema descompone basándose en las propiedades.
    * Conjunto final de relaciones satisface la forma normal.
       * no hay anomalías, hay pérdida de información.

Normalización
~~~~~~~~~~~~~

Proceso que analiza las dependencias entre los atributos de una relación de tal manera de
combinar los atributos, en entidades y asociaciones menos complejas y más pequeñas. Consiste
en un conjunto de reglas denominadas Formas Normales (FN), las cuales establecen las
propiedades que deben cumplir los datos para alcanzar una representación normalizada.
En este paso se toma cada relación, se convierte en una entidad (relación o tabla)
no normalizada y se aplican las reglas definidas para 1FN, 2FN, 3FN, Boyce Codd y 4FN.


Formas normales
===============

La siguiente imagen muestra los tres principales niveles que se utilizan en el diseño
de esquemas de bases de datos.

.. image:: ../../../sql-course/src/formas_normales.png
   :align: center

El proceso de normalización es fundamental para obtener un diseño de base de datos
eficiente.
En una entidad no normalizada generalmente expresada en forma plana (como una tabla),
es muy probable que existan uno o más grupos repetitivos, no pudiendo en ese caso ser
un atributo simple su clave primaria.

A continuación se dará una definición y un ejemplo de las formas normales:


Primera formal normal (1FN)
^^^^^^^^^^^^^^^^^^^^^^^^^^^

Una tabla está normalizada o en 1FN, si contiene sólo valores atómicos en la intersección
de cada fila y columna, es decir, no posee grupos repetitivos.
Para poder cumplir con esto, se deben pasar a otra tabla aquellos **grupos repetitivos**
generándose dos tablas a partir de la tabla original. Las tablas resultantes deben
tener algún atributo en común, en general una de las tablas queda con una clave primaria
compuesta. Esta forma normal genera tablas con problemas de redundancia, y por ende,
anomalías de inserción, eliminación o modificación; la razón de esto es la existencia
de lo que se denomina **dependencias parciales**.

Ejemplo
"""""""

Se dice que una tabla está encuentra en primera forma normal (1FN) si y solo si cada uno
de los campos contiene un único valor para un registro determinado.
Supongamos que deseamos realizar una tabla para guardar los cursos que están realizando
los estudiantes de informática de la USM, podríamos considerar el siguiente diseño.

.. math::

 \begin{array}{|c|c|c|}
    \hline
    \textbf{Código} & \textbf{Nombre} & \textbf{Cursos} \\
    \hline
    \text{1} & \text{Patricia} & \text{Estructura de datos} \\
    \hline
    \text{2}  & \text{Margarita} & \text{Bases de datos, Teoría de sistemas} \\
    \hline
    \text{3}  & \text{Joao} & \text{Estructura de datos, Bases de datos} \\
    \hline
   \end{array}

Se puede observar que el registro 1 cumple con la primera forma normal, puesto que cada
campo cumple con la condición de tener solo un dato, pero esta condición no se cumple con
el registro 2 y 3, en el campo de *Cursos*, ya que en ambos existen dos datos.
La solución a este problema es crear dos tablas del siguiente modo.

.. math::
 \textbf{Tabla 1}

 \begin{array}{|c|c|}
    \hline
    \textbf{Código} & \textbf{Nombre}  \\
    \hline
    \text{1} & \text{Patricia}  \\
    \hline
    \text{2}  & \text{Margarita} \\
    \hline
    \text{3}  & \text{Joao} \\
    \hline
   \end{array}

 \textbf{Tabla 2}

 \begin{array}{|c|c|}
    \hline
    \textbf{Código} & \textbf{Cursos} \\
    \hline
    \text{1} & \text{Estructura de datos} \\
    \hline
    \text{2}  & \text{Bases de datos} \\
    \hline
    \text{2}  & \text{Teoría de sistemas} \\
    \hline
    \text{3}  & \text{Estructura de datos} \\
    \hline
    \text{3}  & \text{Bases de datos} \\
    \hline
  \end{array}

Como se puede comprobar, ahora todos los registros de las dos tablas cumplen con la condición
de tener en todos sus campos un solo dato, por lo tanto la *Tabla 1* y *Tabla 2* están en
primera forma normal.


Segunda forma normal (2FN)
^^^^^^^^^^^^^^^^^^^^^^^^^^

Una tabla está en 2FN, si está en 1FN y se han eliminado las dependencias parciales
entre sus atributos. Una dependencia parcial se da cuando uno o más atributos que no
son clave primaria, son sólo dependientes de parte de la clave primaria compuesta,
o en otras palabras, cuando parte de la clave primaria determina a un atributo no clave.
Este tipo de dependencia se elimina creando varias tablas a partir de la tabla con
problemas: una con los atributos que son dependientes de la clave primaria completa
y otras con aquellos que son dependientes sólo de una parte. Las tablas generadas deben
quedar con algún atributo en común para representar la asociación entre ellas.
Al aplicar esta forma normal, aún se siguen teniendo problemas de anomalías
pues existen **dependencias transitivas**.

Ejemplo
"""""""

La segunda forma normal compara todos y cada uno de los campos de la tabla con la clave
definida. Si todos los campos dependen directamente de la clave se dice que la tabla está
en segunda forma normal.

Se construye una tabla con los años que cada profesor ha estado trabajando en cada departamento
de la USM.

.. math::

 \begin{array}{|c|c|c|c|c|}
    \hline
    \textbf{Código_profesor} & \textbf{Código_departamento} & \textbf{Nombre} & \textbf{Departamento} & \textbf{Años_trabajados} \\                                  \hline
    \text{1} & \text{6} & \text{Javier} & \text{Electrónica} & 3\\
    \hline
    \text{2}  & \text{3} & \text{Luis} & \text{Eléctrica} & 15\\
    \hline
    \text{3}  & \text{2} & \text{Cecilia} & \text{Informática} & 8\\
    \hline
    \text{4}  & \text{3} & \text{Nora} & \text{Eléctrica} & 2\\
    \hline
    \text{2}  & \text{6} & \text{Luis} & \text{Electrónica} & 20\\
    \hline
  \end{array}

La clave de esta tabla está conformada por el *Código_profesor* y *Código_departamento*, además
se puede decir que está en primera forma normal, por lo que ahora la transformaremos a
segunda forma normal.

* El campo *Nombre* no depende funcionalmente de toda la clave, solo depende de la clave *Código_profesor*.
* El campo *Departamento* no depende funcionalmente de toda la clave, solo depende de la clave *Código_departamento*.
* El campo *Años_trabajados* si depende funcionalmente de las claves *Código_profesor* y *Código_departamento* (representa los años trabajados de cada profesor en el departamento de la universidad).

Por lo tanto al no depender funcionalmente *todos* los campos de la tabla anterior no está
en segunda forma normal, entonces la solución es la siguiente:

.. math::

 \textbf{Tabla A}

 \begin{array}{|c|c|}
    \hline
    \textbf{Código_profesor} & \textbf{Nombre} \\
    \hline
    \text{1} & \text{Javier} \\
    \hline
    \text{2}  & \text{Luis} \\
    \hline
    \text{3}  & \text{Cecilia} \\
    \hline
    \text{4}  & \text{Nora} \\
    \hline
  \end{array}

 \textbf{Tabla B}

 \begin{array}{|c|c|}
    \hline
    \textbf{Código_departamento} & \textbf{Departamento} \\
    \hline
    \text{2} & \text{Informática} \\
    \hline
    \text{3}  & \text{Eléctrica} \\
    \hline
    \text{6}  & \text{Electrónica} \\
    \hline
  \end{array}

 \textbf{Tabla C}

  \begin{array}{|c|c|c|}
    \hline
    \textbf{Código_empleado} & \textbf{Código_departamento} & \textbf{Años_trabajados} \\
    \hline
    1 & 6 & 3 \\
    \hline
    2  & 3 & 15\\
    \hline
    3  & 2 & 8\\
    \hline
    4  & 3 & 2\\
    \hline
    2  & 6 & 20\\
    \hline
  \end{array}

Se puede observar que la *Tabla A* tiene como índice la clave *Código_empleado*, *Tabla B*
tiene como clave *Código_departamento* y la *Tabla C* que tiene como clave compuesta *Código_empleado*
y *Código_departamento*, encontrándose finalmente estas tablas en segunda forma normal.

Tercera forma normal (3FN)
^^^^^^^^^^^^^^^^^^^^^^^^^^

Una tabla está en 3FN, si está en 2FN y **no contiene dependencias transitivas**. Es decir,
cada atributo no primario depende solo de la clave primaria, no existiendo dependencias
entre atributos que no son clave primaria. Este tipo de dependencia se elimina creando una nueva
tabla con el o los atributo(s) no clave que depende(n) de otro atributo no clave, y
con la tabla inicial, la cual además de sus propios atributos, debe contener el atributo
que hace de clave primaria en la nueva tabla generada; a este atributo se le denomina
clave foránea dentro de la tabla inicial (por clave foránea se entiende entonces, a
aquel atributo que en una tabla no es clave primaria, pero sí lo es en otra tabla).

Ejemplo
"""""""

Se dice que una tabla está en tercera forma normal si y solo si los campos de la tabla
dependen únicamente de la clave, dicho en otras palabras los campos de las tablas no dependen
unos de otros. Tomando como referencia el ejemplo de la primera forma normal, un alumno
solo puede tomar un curso a la vez y se desea guardar en que sala se imparte el curso.

.. math::

  \begin{array}{|c|c|c|c|}
    \hline
    \textbf{Código} & \textbf{Nombre} & \textbf{Curso} & \textbf{Sala} \\
    \hline
    1 & \text{Patricia} & \text{Estructura de datos} & \text{A}\\
    \hline
    2  & \text{Margarita} & \text{Teoría de sistemas} & \text{B}\\
    \hline
    3  & \text{Joao} & \text{Bases de datos} & \text{C}\\
    \hline
  \end{array}

Veamos las dependencias de cada campo respecto a la clave:

* *Nombre* depende directamente del *Código*.
* *Curso* depende de igual manera del *Código*.
* La *Sala* depende del *Código*, pero está más ligado al *Curso* que el alumno está realizando.

Es por este último punto que se dice que la tabla no está en 3FN, pero a continuación se
muestra la solución:

.. math::

  \textbf{Tabla A}

  \begin{array}{|c|c|c|}
    \hline
    \textbf{Código} & \textbf{Nombre} & \textbf{Curso} \\
    \hline
    1 & \text{Patricia} & \text{Estructura de datos} \\
    \hline
    2  & \text{Margarita} & \text{Teoría de sistemas} \\
    \hline
    3  & \text{Joao} & \text{Bases de datos} \\
    \hline
  \end{array}

  \textbf{Tabla B}

  \begin{array}{|c|c|}
    \hline
    \textbf{Curso} & \textbf{Sala} \\
    \hline
    \text{Estructura de datos} & \text{A} \\
    \hline
    \text{Teoría de sistemas} & \text{B}\\
    \hline
    \text{Bases de datos} & \text{C}\\
    \hline
  \end{array}

Boyce-Codd forma normal (FNBC)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Es una versión ligeramente más fuerte de la Tercera forma normal (3FN). La forma normal de
Boyce-Codd requiere que **no existan dependencias funcionales no triviales** de los atributos
que no sean un conjunto de la clave candidata. En una tabla en 3FN, todos los atributos dependen
de una clave. Se dice que una tabla está en FNBC si y solo si está en 3FN y cada dependencia
funcional no trivial tiene una clave candidata como determinante.

Dependencias funcionales y FNBC
"""""""""""""""""""""""""""""""

**Aplicar(SSN, sNombre, cNombre)**

* Redundancia, anomalías de actualización y eliminación.
* Almacenamiento del SSN-sNombre para una vez por cada universidad.

**Dependencia funcional SSN-> sNombre**

* SSN siempre tiene el mismo sNombre
* En caso de almacenar sNombre cada SSN sólo una vez

**Boyce-Codd forma normal si a-> b entonces a es una clave**

Descomponer: Estudiante(SSN, sNombre) Aplicar(SSN, cNombre)

siendo finalmente SSN una clave primaria.

Ejemplo
"""""""

Tenga en cuenta la relación Tomo(SID, nombre, cursoNum, título). Los estudiantes tienen
el carné de estudiante y un nombre único, los cursos tienen un número único curso y título.
Cada tupla de la relación codifica el hecho de que un estudiante dado tomó el curso. ¿Cuáles son todas las
dependencias funcionales para la relación tomó?

a) sID → cursoNum
b) sID → nombre, cursoNum → titulo
c) nombre → sID, titulo → cursoNum
d) cursoNum → sID

La respuesta correcta es la alternativa (b), puesto que un id de estudiante que único "sID", está
asignado a solo un estudiante y un id del curso que es único "cursoNum" tiene asignado un título. Las
otras alternativas no son porque, la alternativa (a) dice un estudiante sólo puede tomar un curso, la
alternativa (c) dice que los nombres de los estudiantes y los títulos de los cursos son únicos y
la alternativa (d) dice que los cursos sólo pueden ser tomados por un estudiante.

Cuarta forma normal (4FN)
^^^^^^^^^^^^^^^^^^^^^^^^^

La 4NF se asegura de que las dependencias multivaluadas independientes estén correcta
y eficientemente representadas en un diseño de base de datos. La 4NF es el siguiente
nivel de normalización después de la forma normal de Boyce-Codd (BCNF).
Una tabla está en 4NF si y solo si esta en Tercera forma normal o en BCNF y no posee
dependencias multivaluadas no triviales. La definición de la 4NF confía en la noción
de una dependencia multivaluada. Una tabla con una dependencia multivaluada es donde
hay una existencia de dos o más relaciones independientes de muchos a muchos que causa
redundancia; que es suprimida por la cuarta forma normal.

Dependencias multivaluadas y 4FN
""""""""""""""""""""""""""""""""

**Aplicar(SSN, cNombre, HS)**

* Redundancia, anomalías de actualización y eliminación.
* Efecto multiplicativo: C colegios o H escuelas secundarias, por lo que se generarán "C * H" ó "C + H" tuplas.
* No es dirigida por BCNF: No hay dependencias funcionales.

**La dependencia multivalor SSN->>cNombre ó SSN->>HS**

* SSN cuenta todas las combinaciones de cNombre con HS.
* En caso de almacenar cada cName y HS, para obtener una vez un SSN.

.. note::

 La flecha ->> significa muchos

**Cuarta Forma Normal si A->>B entonces A es una clave**

Descomponer: Aplicar(SSN, cNombre) Escuela_secundaria(SSN, HS)

Ejemplo 1
"""""""""

Tenga en cuenta la relación Informacion_estudiante(SID, dormitorio, cursoNum). Los estudiantes
suelen vivir en varios dormitorios y tomar muchos cursos en la universidad. Supongamos
que los datos no capta en que dormitorio(s) un estudiante estaba en la hora de tomar
un curso específico, es decir, todas las combinaciones de cursos dormitorio se registran
para cada estudiante. ¿Cuáles son todas las dependencias para la relación Informacion_estudiante?

a) sID->>dormitorio
b) sID->>cursoNum
c) sID->>dormitorio, sID->>cursoNum
d) sID->>dormitorio, sID->>cursoNum, dormitorio->>cursoNum

La alternativa correcta es (c), puesto que para un estudiante hay muchos dormitorios y
un estudiante puede tomar muchos cursos. La alternativa (a) y (b) ambos omiten una dependencia,
la alternativa (d) dice que todos los estudiantes de cada dormitorio toman el mismo conjunto de cursos.


Ejemplo 2
"""""""""

Una tabla está en cuarta forma normal si y sólo si para cualquier combinación clave-campo
no existen valores duplicados.

.. math::

 \textbf{Geometría}

 \begin{array}{|c|c|c|}
    \hline
    \textbf{Figura} & \textbf{Color} & \textbf{Tamaño} \\
    \hline
    \text{Cuadrado} & \text{Rojo} & \text{Grande} \\
    \hline
    \text{Cuadrado} & \text{Azul} & \text{Grande}\\
    \hline
    \text{Cuadrado} & \text{Azul} & \text{Mediano}\\
    \hline
    \text{Círculo} & \text{Blanco} & \text{Mediano}\\
    \hline
    \text{Círculo} & \text{Azul} & \text{Pequeño}\\
    \hline
    \text{Círculo} & \text{Azul} & \text{Mediano}\\
    \hline
  \end{array}

Vamos a comparar el atributo clave *Figura* con  *Tamaño*, se puede notar que Cuadrado
Grande está repetido; de igual manera Círculo Azul, entre otros registros. Son estas
repeticiones que se deben evitar para tener una tabla en 4FN.

La solución a la tabla anterior es la siguiente:

.. math::

 \textbf{Tamaño}

 \begin{array}{|c|c|}
    \hline
    \textbf{Figura} & \textbf{Tamaño} \\
    \hline
    \text{Cuadrado} & \text{Grande} \\
    \hline
    \text{Cuadrado} & \text{Mediano}\\
    \hline
    \text{Círculo} & \text{Mediano}\\
    \hline
    \text{Círculo} & \text{Pequeño}\\
    \hline
  \end{array}

 \textbf{Color}

 \begin{array}{|c|c|}
    \hline
    \textbf{Figura} & \textbf{Color}  \\
    \hline
    \text{Cuadrado} & \text{Rojo} \\
    \hline
    \text{Cuadrado} & \text{Azul} \\
    \hline
    \text{Círculo} & \text{Blanco} \\
    \hline
    \text{Círculo} & \text{Azul} \\
    \hline
  \end{array}
