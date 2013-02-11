Lectura 30 – Mantenimiento de la Base de Datos
---------------------------------------------------------------



Hay una serie de actividades que el administrador de un sistema gestor de bases
de datos debe tener presentes constantemente, y que deberá realizar periódicamente.
En el caso de PostgreSQL, éstas se limitan a un mantenimiento y
limpieza de los identificadores internos y de las estadísticas de planificación de
las consultas, a una reindexación periódica de las tablas, y al tratamiento de los
ficheros de registro.

**vacuum**

El proceso que realiza la limpieza de la base de datos en PostgreSQL se llama
vacuum. La necesidad de llevar a cabo procesos de vacuum periódicamente se
justifica por los siguientes motivos:

* Recuperar el espacio de disco perdido en borrados y actualizaciones de datos.

* Actualizar las estadísticas de datos utilizados por el planificador de consultas
SQL.

* Protegerse ante la pérdida de datos por reutilización de identificadores de
transacción.

Para llevar a cabo un vacuum, deberemos ejecutar periódicamente las sentencias
vacuum y analyze. En caso de que haya algún problema o acción adicional
a realizar, el sistema nos lo indicará:
demo=# VACUUM;
WARNING: some databases have not been vacuumed in 1613770184 transactions
HINT: Better vacuum them within 533713463 transactions, or you may have a wraparound failure.

**Reindexación**

La reindexación completa de la base de datos no es una tarea muy habitual,
pero puede mejorar sustancialmente la velocidad de las consultas complejas
en tablas con mucha actividad.

demo=# reindex database demo;

**Ficheros de registro**

Es una buena práctica mantener archivos de registro de la actividad del servidor.
Por lo menos, de los errores que origina. Durante el desarrollo de aplicaciones
puede ser muy útil disponer también de un registro de las consultas
efectuadas, aunque en bases de datos de mucha actividad, disminuye el rendimiento
del gestor y no es de mucha utilidad.
En cualquier caso, es conveniente disponer de mecanismos de rotación de los ficheros
de registro; es decir, que cada cierto tiempo (12 horas, un día, una semana...),
se haga una copia de estos ficheros y se empiecen unos nuevos, lo que nos
permitirá mantener un histórico de éstos (tantos como ficheros podamos almacenar
según el tamaño que tengan y nuestras limitaciones de espacio en disco).
PostgreSQL no proporciona directamente utilidades para realizar esta rotación,
pero en la mayoría de sistemas Unix vienen incluidas utilidades como
logrotate que realizan esta tarea a partir de una planificación temporal.
VACUUM
demo=# VACUUM VERBOSE ANALYZE;
INFO: haciendo vacuum a “public.ganancia”
INFO: “ganancia”: se encontraron 0 versiones de filas eliminables y 2 no eliminables en 1 páginas
DETAIL: 0 versiones muertas de filas no pueden ser eliminadas aún.
Hubo 0 punteros de ítem sin uso.
0 páginas están completamente vacías.
CPU 0.00s/0.00u sec elapsed 0.00 sec.
INFO: analizando “public.ganancia”
INFO: “ganancia”: 1 páginas, 2 filas muestreadas, se estiman 2 filas en total
VACUUM

