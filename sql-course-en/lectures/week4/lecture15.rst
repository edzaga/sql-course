Lecture 15 - Relational Desing Theory: Overview
-------------------------------------------------

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
 \text{Tabla 1}
                                                                                     
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

 \text{Tabla 2}                                                                           
                                                                                     
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
