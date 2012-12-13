Lectura 15 - Teoría del diseño Relacional: Información General
--------------------------------------------------------------

Diseño Relacional
~~~~~~~~~~~~~~~~~

Diseñar un esquema de base de datos

* Por lo general existen *muchos* diseños posibles.
* Algunos son (mucho) mejor que otros.
* ¿Cómo elegir?.

El diseño de una base de datos relacional puede abordarse de dos formas:
* **Obteniendo el esquema relacional directamente:** Objetos y reglas captadas del 
   análisis del mundo real, representadas por un conjunto de esquemas de relación, 
   sus atributos y restricciones de integridad.

* **Realizando el diseño del esquema "conceptual" de la BD (modelo E/R) y transformándolo 
   a esquema relacional**.

En los esquemas de bases de datos es posible encontrar anomalias que serán eliminadas
gracias al proceso de normalización.

Estas anomalias son:

* **La redundancia de los datos:** repetición de datos en un sistema.

* **Anomalías de actualización:** inconsistencias de los datos como resultado de datos
redundantes y actualizaciones parciales.

* **Anomalías de borrado:** pérdidas no intencionadas de datos debido a que se han borrado
otros datos.

* **Anomalías de inserción:** imposibilidad de adicionar datos en la base de datos debido
a la ausencia de otros datos.

A continuación se muestra una tabla y luego el detalle de los problemas que presenta:

.. math::

   \begin{array}{|c|c|c|}
    \hline
    \textbf{Nombre_autor} & \textbf{País} & \textbf{Cod_libro} & \textbf{Titulo_libro} & \textbf{Editor} \\
    \hline
    \text{Cortázar, Julio} & \text{Arg} & text{9786071110725} & \text{Cuentos Completos 1 Julio Cortazar}  & \text{Alfaguara}\\
    \hline                                                                           
    \text{Rosasco, José Luis}  & \text{Chi} & \text{9789561224056} & \text{Donde Estas, Constanza} & \text{Zig-Zag}  \\
    \hline                                                                           
    \text{Rosasco, José Luis}  & \text{Chi} & \text{9561313669} & \text{Hoy Día es Mañana} & \text{Andrés Bello} \\
    \hline
    \text{Coloane, Francisco} & \text{Chi} & \text{9789563473308} & \text{Golfo De Penas} & \text{Alfaguara} \\
    \hline
   \end{array}

* **Redundancia:** cuando un autor tiene varios libros, se repite de la nacionalidad.

* **Anomalias de modificación:** Si el autor "Julio Cortázar" y "José Luis Rosasco", desean 
cambiar de editor, se modificará en los dos lugares. A priori no se puede saber cuandos
autores tiene un libro. Los errores son frecuentes al olvidar la modificación de un autor.

* **Anomalias de inserción:** Se desea ingresar a un autor sin libros. "Nombre_autor" y "Cod_libro"
son campos claves, por lo que las claves no pueden ser valores nulos.

Al eliminar estas anomalias se asegura:

* **Integridad entre los datos:** consistencia de la información.

Normalización
~~~~~~~~~~~~~

Por todas las anomalias descritas anteriormente nace el proceso de normalizacion en el 
cual se transforman datos complejos a un conjunto de estructuras de datos más pequeñas, 
que además de ser más simples y más estables, son más fáciles de mantener.
También consiste en un conjunto de reglas denominadas Formas Normales (FN), las cuales 
establecen las propiedades que deben cumplir los datos para alcanzar una representación 
normalizada.

Grados de normalización
~~~~~~~~~~~~~~~~~~~~~~~

Existen básicamente tres niveles de normalización: Primera Forma Normal (1NF), 
Segunda Forma Normal (2NF) y Tercera Forma Normal (3NF). Cada una de estas formas 
tiene sus propias reglas.

La siguiente imagen muestra los grados de normalización que se utilizan en el diseño
de esquemas de bases de datos.

.. image:: ../../../sql-course/src/formas_normales.jpg
   :align: center

El proceso de normalización es fundamental para obtener un diseño de base de datos
eficiente. Durante las siguientes lecturas se analizará cada una de las formas normales 
a través de ejemplos.
Una entidad no normalizada generalmente expresados en forma plana (como una tabla). 
Es muy probable que existan uno o más grupos repetitivos, no pudiendo en ese caso ser 
un atributo simple su clave primaria. Las tres primeras formas normales se definen de 
la siguiente manera:

Primera formal normal (1FN)
===========================

Una tabla está normalizada o en 1FN, si contiene sólo valores atómicos en la intersección 
de cada fila y columna, es decir, no posee grupos repetitivos.
Para poder cumplir con esto, se deben pasar a otra tabla aquellos grupos repetitivos 
generándose dos tablas a partir de la tabla original. Las tablas resultantes deben 
tener algún atributo en común, en general una de las tablas queda con una clave primaria 
compuesta. Esta forma normal genera tablas con problemas de redundancia, y por ende, 
anomalías de inserción, eliminación o modificación; la razón de esto es la existencia 
de lo que se denomina dependencias parciales.

Segunda forma normal (2FN)
==========================

Una tabla está en 2FN, si está en 1FN y se han eliminado las dependencias parciales 
entre sus atributos. Una dependencia parcial se da cuando uno o más atributos que no 
son clave primaria, son sólo dependientes de parte de la clave primaria compuesta, 
o en otras palabras, cuando parte de la clave primaria determina a un atributo no clave. 
Este tipo de dependencia se elimina creando varias tablas a partir de la tabla con 
problemas: una con los atributos que son dependientes de la clave primaria completa 
y otras con aquellos que son dependientes sólo de una parte. Las tablas generadas deben
quedar con algún atributo en común para representar la asociación entre ellas.
Al aplicar esta forma normal, aún se siguen teniendo problemas de anomalías
pues existen dependencias transitivas.

Tercera forma normal (3FN)
==========================

Una tabla está en 3FN, si está en 2FN y no contiene dependencias transitivas. Es decir, 
cada atributo no clave primaria no depende de otros atributos no claves primarias, sólo 
depende de la clave primaria. Este tipo de dependencia se elimina creando una nueva 
tabla con el o los atributo(s) no clave que depende(n) de otro atributo no clave, y 
con la tabla inicial, la cual además de sus propios atributos, debe contener el atributo 
que hace de clave primaria en la nueva tabla generada; a este atributo se le denomina 
clave foránea dentro de la tabla inicial (por clave foránea se entiende entonces, a
aquel atributo que en una tabla no es clave primaria, pero sí lo es en otra tabla).

Integración de Vistas
~~~~~~~~~~~~~~~~~~~~~

Este paso consiste en combinar las tablas generadas en base a un criterio común: igual clave primaria, 
formando un conjunto de tablas en 3FN. Con esto se obtiene el modelo de datos conceptual 
expresado como un conjunto de tablas o relaciones normalizadas.
La integración basada en juntar aquellas tablas que tienen la misma clave primaria,
permite agrupar los datos referidos a una misma entidad. Debe revisarse la tabla resultante pues
es posible que al realizar la integración se introduzcan dependencias transitivas (es decir, la
tabla quede en 2FN) que deben ser eliminadas.

Generación del Modelo de Datos Conceptual
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Para una mejor comprensión del usuario es deseable transformar las tablas obtenidas en
el paso previo a una representación gráfica. Como por ejemplo, a un Modelo E/R.
