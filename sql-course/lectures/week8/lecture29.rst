Lectura 29 - Vistas: Vistas materializadas
-------------------------------------------

.. role:: sql(code)
         :language: sql
         :class: highlight

Introducción
~~~~~~~~~~~~~~~

En las lecturas anteriores se vio la vista virtual que es el tipo usual de vista que se define como una consulta de la base de datos. En esta lectura se verán las **vistas materializadas**, que **almacena el resultado de la consulta en una tabla caché real**. Es una solución muy utilizada en entornos de almacenes de datos (datawarehousing), donde el acceso frecuente a las tablas básicas resulta demasiado costoso.


Definición
~~~~~~~~~~~~~

Una vista materializada **almacena físicamente los datos** resultantes de ejecutar la consulta definida en la vista. Inicialmente se almacenan los datos de las tablas base al ejecutar la consulta y se actualiza periódicamente a partir de las tablas originales.  Las vistas materializadas constituyen datos redundantes, en el sentido de que su contenido puede deducirse de la definición de la vista y del resto del contenido de la base de datos. 

Se define una vista especificando una consulta de Vista en SQL, a través de un conjunto de tablas existentes **(R1, R2,…Rn)**.

``Vista V= ConsultaSQL(R1, R2, …, Rn)``

De esta forma se crea en realidad una tabla física V con el esquema del resultado de la consulta. Puede referirse a V como si fuese una relación, ya que en realidad es una tabla almacenada en una base de datos.

Ventaja
=========

Poseen las mismas ventajas de visitas virtuales. La diferencia radica en que las vistas materializadas mejoran el rendimiento de consultas sobre la base de datos, pues  proporciona un acceso mucho más eficiente. Con la utilización de vistas materializadas se logra aumentar el rendimiento de las consultas SQL además de ser un método de optimización a nivel físico en modelos de datos muy complejos y/o con muchos datos.

Desventajas
==============

* Incrementa el tamaño de la base de datos

* Posible falta de sincronía, es decir, que los datos de la vista pueden estar potencialmente desfasados con respecto a los datos reales. Al contener físicamente los datos de las tablas base, si cambian los datos de estas tablas no se reflejarán en la vista materializada. 


Mantenimiento de las vistas
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Como se mencionó anteriormente un problema que poseen las vistas materializadas es que hay que mantenerlas actualizadas cuando se modifican los datos de las tablas bases que emplea la vista. La tarea de actualizar una vista se denomina **mantenimiento de la vista materializada**. También hay que tener presente que al modificar una vista debe actualizarse la(s) tabla(s) de origen(es), pues las vistas y las relaciones deben estar sincronizadas.

Una manera de realizar mantenimiento es utilizando :sql:`Triggers` para la inserción, la eliminación y la actualización de cada relación de la definición de la vista. Los :sql:`Triggers` deben modificar todo el contenido de la vista materializada.

Una mejor opción es editar sólo la parte modificada de la vista materializada, lo que se conoce como **mantenimiento incremental de la vista**. 

Los sistemas modernos de bases de datos proporcionan más soporte directo para el mantenimiento incremental de las vistas. Los programadores de bases de datos ya no necesitan definir :sql:`Triggers` para el mantenimiento de las vistas. Por el contrario, una vez que se ha declarado materializada una vista, el sistema de bases de datos calcula su contenido y actualiza de manera incremental el contenido cuando se modifican los datos subyacentes.

