Lectura 32 - Uso de SQL Developer
---------------------------------

.. role:: sql(code)
   :language: sql
   :class: highlight

En esta lectura se explicaran en detalle algunas herramientas importantes del software 
``Oracle SQL Developer`` que se puede descargar `aquí <http://www.oracle.com/technetwork/developer-tools/sql-developer/downloads/index.html>`_.

Si no está instalado **"JDK"**, es necesario instalarlo desde este `link <http://www.oracle.com/technetwork/java/javase/downloads/jdk7-downloads-1880260.html>`_.

Oracle SQL Developer
~~~~~~~~~~~~~~~~~~~~

Oracle SQL Developer es una versión gráfica de SQL * Plus que ofrece a los desarrolladores 
de bases de datos una manera conveniente para llevar a cabo tareas básicas. Puede explorar, 
crear, editar y eliminar los objetos de una base de datos, ejecutar sentencias SQL y scripts.

Puede conectarse a cualquier esquema de base de datos Oracle de destino utilizando autenticación 
estándar de base de datos Oracle. Una vez conectado, puede realizar operaciones sobre los 
objetos de la base de datos.

También puede conectarse a los esquemas seleccionados para terceros (no-Oracle), bases de datos 
como My SQL, Microsoft SQL Server y Microsoft Access.

Instalación
~~~~~~~~~~~

1. Descargar el archivo de la página principal de Oracle.
2. Ejecutar el archivo ``“sqldeveloper.exe”`` del archivo descargado.
3. Aparecerá una ventana pidiendo la ruta de un archivo ``java`` que se encuentra para el caso de Windows en el disco C, ``Archivos de programas->Java->jdk1.7.0_13->bin->java``.  	
4. Realizado lo anterior  de inmediato se empezara a cargar e iniciar Oracle SQL Developer.

Conexión a una base de datos
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Oracle
======

Primero para poder realizar una conexión a la base de datos de Oracle, debemos descargar 
el software ``Oracle Database Express Edition 11g Release 2``, desde este `enlace <http://www.oracle.com/technetwork/products/express-edition/downloads/index.html>`_.

En la instalación de este software deberemos ingresar una contraseña (no debemos olvidarla) 
que será utilizada más adelante. Terminada la instalación ingresamos la dirección `http://127.0.0.1:8080 <http://127.0.0.1:8080>`_ 
en nuestro navegador, apareciendo una pantalla en que deberemos ingresar nuestro ``login: SYSTEM`` 
y la contraseña ingresada en la instalación del software.

Entrará a la sesión ``SYSTEM``, hacemos click en la pestaña ``Application Express`` y 
creamos una nueva base de datos, para este ejemplo será el nombre **COURSESQL** y se debe 
ingresar una password a convenir.

.. image:: ../../../sql-course/src/lectura32/oracle2/imagen1.png                             
   :height: 500 px                                                                   
   :width: 800 px                                                                    
   :scale: 50 %                                                                      
   :align: center   

Luego abrimos el software ``Oracle SQL Developer``, hacemos click derecho en ``Conexiones->
Nueva Conexión...`` 

.. image:: ../../../sql-course/src/lectura32/oracle2/imagen2.png                             
   :height: 500 px                                                                   
   :width: 800 px                                                                    
   :scale: 50 %                                                                      
   :align: center  

Aparecerá una ventana que deberemos ingresar los datos de la página web: ``Nombre de conexión: course_sql``, 
``Usuario: COURSESQL`` (ingresado en la página) y ``PASSWORD: (ingresada en la página)``. Hacemos 
click en **"Probar"**, debiendo aparecer **"Estado: Correcto"**  en la parte izquierda de la ventana 
y si todo está correcto hacemos click en **"Conectar"**.

.. image:: ../../../sql-course/src/lectura32/oracle2/imagen3.png                             
   :height: 500 px                                                                   
   :width: 800 px                                                                    
   :scale: 50 %                                                                      
   :align: center   

Finalmente ya podemos interactuar mediante código con la base de datos creada, haciendo 
click en la ``Hoja de trabajo SQL``, llamada **"course_sql"**.

.. image:: ../../../sql-course/src/lectura32/oracle2/imagen4.png                             
   :height: 500 px                                                                   
   :width: 800 px                                                                    
   :scale: 50 %                                                                      
   :align: center 

Ahora realizaremos las consultas del zoologico de la tarea 4, los datos pueden ser descargados
desde la plataforma claroline.

.. note::

 Los tipos de datos difieren de PostgreSQL con Oracle. El tipo ``serial`` 
 no existe solo se puede crear un trigger para que el entero se autoincremente.

Pegamos los datos en la pantalla y hacemos click en la herramienta **"Ejecutar Script"**.

.. image:: ../../../sql-course/src/lectura32/oracle2/imagen5.png                             
   :height: 500 px                                                                   
   :width: 800 px                                                                    
   :scale: 50 %                                                                      
   :align: center  

Y hacemos click en **"Refrescar"**, para que actualice la base de datos con los comandos 
que ingresamos en el Script.

.. image:: ../../../sql-course/src/lectura32/oracle2/imagen6.png                             
   :height: 500 px                                                                   
   :width: 800 px                                                                    
   :scale: 50 %                                                                      
   :align: center 

También podemos probar consultas como la segunda pregunta de la tarea 4 que dice:

*"Asignarle un valor desconocido (NULL) al año de nacimiento del animal que posee el nombre 
común ‘Leon’ y que habita en el ‘Parque Safari’."*

Realizamos un :sql:`SELECT` para poder visualizar los cambios.

.. image:: ../../../sql-course/src/lectura32/oracle2/imagen7.png                             
   :height: 500 px                                                                   
   :width: 800 px                                                                    
   :scale: 50 %                                                                      
   :align: center 

Ahora la modificación con el comando :sql:`UPDATE` asignando el valor **NULL** al animal que 
posee el nombre común "León" y habita en el "Parque Safari".

.. image:: ../../../sql-course/src/lectura32/oracle2/imagen8.png                             
   :height: 500 px                                                                   
   :width: 800 px                                                                    
   :scale: 50 %                                                                      
   :align: center 

Y ahora volvemos a realizar un :sql:`SELECT`, para verificar la modificación realizada.

.. image:: ../../../sql-course/src/lectura32/oracle2/imagen9.png                             
   :height: 500 px                                                                   
   :width: 800 px                                                                    
   :scale: 50 %                                                                      
   :align: center

Creación de un modelo relacional
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Para comenzar a crear nuestro modelo relacional ingresamos a la pestaña 
``"Ver"->"Data Modeler"->"Explorador"``.

.. image:: ../../../sql-course/src/lectura32/oracle1.png
   :height: 500 px
   :width: 800 px
   :scale: 50 %                               
   :align: center  

Luego nos aparecerá una ventana en la parte izquierda de nuestra pantalla, hacemos un 
click sobre **"Modelo Lógico"**.
Ahora hacemos click en la herramienta **"Nueva entidad"**, que se encuentra en la imagen.
(encerrada de un circulo rojo).

.. image:: ../../../sql-course/src/lectura32/oracle2.png                               
   :height: 500 px                                                                   
   :width: 800 px                                                                    
   :scale: 50 %  
   :align: center 

Dibujamos la entidad y nos saldrá el siguiente cuadro.

.. image:: ../../../sql-course/src/lectura32/oracle3.png                             
   :height: 500 px                                                                   
   :width: 800 px                                                                    
   :scale: 50 %    
   :align: center 

Realizaremos el ejemplo de la tarea 4 del zoologico, entonces en la sección **"general"** 
agregamos el nombre de la tabla que se llamará ``"Zoo"``.

.. image:: ../../../sql-course/src/lectura32/oracle4.png
   :height: 500 px                                                                   
   :width: 800 px                                                                    
   :scale: 50 %                                 
   :align: center   

Ahora agregamos en la sección **"atributos"**, los atributos de la tabla, haciendo un click 
sobre el **"+"**.

.. image:: ../../../sql-course/src/lectura32/oracle5.png                               
   :height: 500 px                                                                   
   :width: 800 px                                                                    
   :scale: 50 %  
   :align: center   

Ingresamos el primer atributo *"name"*, hacemos click en **"UID Primario"** (Primary Key), 
así sucesivamente como se muestra en las siguientes imagenes.

.. image:: ../../../sql-course/src/lectura32/oracle6.png                               
   :height: 500 px                                                                   
   :width: 800 px                                                                    
   :scale: 50 %  
   :align: center    

.. image:: ../../../sql-course/src/lectura32/oracle7.png                               
   :height: 500 px                                                                   
   :width: 800 px                                                                    
   :scale: 50 %  
   :align: center   

Quedando la tabla *"Zoo"* como se muestra en la imagen

.. image:: ../../../sql-course/src/lectura32/oracle8.png                               
   :height: 500 px                                                                   
   :width: 800 px                                                                    
   :scale: 50 %  
   :align: center   

Realizamos lo mismo con la tabla *"Specie"*.

.. image:: ../../../sql-course/src/lectura32/oracle9.png                               
   :height: 500 px                                                                   
   :width: 800 px                                                                    
   :scale: 50 %  
   :align: center 

Para crear la tabla *"Animal"*, se realiza de la misma manera que los anteriores, pero existen 
atributos en esta tabla que son ``NOT NULL``, por lo que es necesario hacer un click en 
el campo **"Obligatorio"** como se muestra en la imagen.

.. image:: ../../../sql-course/src/lectura32/oracle10.png                               
   :height: 500 px                                                                   
   :width: 800 px                                                                    
   :scale: 50 %  
   :align: center 

Finalmente las tablas quedan de la siguiente manera:

.. image:: ../../../sql-course/src/lectura32/oracle11.png                               
   :height: 500 px                                                                   
   :width: 800 px                                                                    
   :scale: 50 %  
   :align: center  

Ahora se realiza la relación entre las tablas haciendo click en el icono de la herramienta 
**"Nueva relación 1:N"** (para este ejemplo) y se unen la tabla *"Animal"* con *"Zoo"* y *"Animal"* 
con *"Specie"*.

.. image:: ../../../sql-course/src/lectura32/oracle12.png                               
   :height: 500 px                                                                   
   :width: 800 px                                                                    
   :scale: 50 %  
   :align: center  

.. image:: ../../../sql-course/src/lectura32/oracle13.png                               
   :height: 500 px                                                                   
   :width: 800 px                                                                    
   :scale: 50 %  
   :align: center  

Se ha terminado el modelo lógico, ahora necesitamos pasarlo a modelo relacional, entonces 
hacemos click en el icono de las herramientas que dice **"Realizar Ingeniería a modelo relacional"**. 

.. image:: ../../../sql-course/src/lectura32/oracle14.png                               
   :height: 500 px                                                                   
   :width: 800 px                                                                    
   :scale: 50 %  
   :align: center 

Saldrá una ventana como la que sale en la imagen y hacemos click en **"Realizar Ingeniería"**.

.. image:: ../../../sql-course/src/lectura32/oracle15.png                               
   :height: 500 px                                                                   
   :width: 800 px                                                                    
   :scale: 50 %  
   :align: center 

Podremos ver las tablas del modelo relacional, pero falta arreglar las claves foráneas de la tabla 
*"Animal"*, entonces hacemos click derecho sobre la tabla.

.. image:: ../../../sql-course/src/lectura32/oracle16.png                               
   :height: 500 px                                                                   
   :width: 800 px                                                                    
   :scale: 50 %  
   :align: center 

Aparecerá la ventana en que se podrá modificar las claves foráneas de la tabla *"Animal"*.
Entonces hacemos click en la sección **"Claves Ajenas"**, luego click en la fila 1 que dice 
``Nombre->Relation_1`` y ``Tabla de Referencia->Zoo``, apareciendo abajo ``Columna referencia->name`` 
(que es atributo de la tabla *"Zoo"*) y aquí nosotros cambiamos el atributo que es clave 
foránea siendo esta *"zooName"*.
Se realiza el mismo procedimiento con la fila 2 que dice ``Nombre->Relation_2`` y ``Tabla de 
Referencia->Specie``, apareciendo abajo ``Columna referencia->cientName`` (que es atributo de 
la tabla *"Specie"*) y aquí nosotros cambiamos el atributo que es clave foránea siendo 
esta *"specieName"*.

.. image:: ../../../sql-course/src/lectura32/oracle17.png                               
   :height: 500 px                                                                   
   :width: 800 px                                                                    
   :scale: 50 %  
   :align: center  

.. image:: ../../../sql-course/src/lectura32/oracle18.png                               
   :height: 500 px                                                                   
   :width: 800 px                                                                    
   :scale: 50 %  
   :align: center  

Quedando el modelo relacional de la siguiente manera:

.. image:: ../../../sql-course/src/lectura32/oracle19.png                               
   :height: 500 px                                                                   
   :width: 800 px                                                                    
   :scale: 50 %  
   :align: center  

Es posible llevar este modelo a código SQL, por lo que hacemos click en la herramienta 
**"Generar DDL"**.

.. image:: ../../../sql-course/src/lectura32/oracle20.png                               
   :height: 500 px                                                                   
   :width: 800 px                                                                    
   :scale: 50 %  
   :align: center  

En la siguiente ventana hacemos click en **"Generar"** y **"Aceptar"**.

.. image:: ../../../sql-course/src/lectura32/oracle21.png                               
   :height: 500 px                                                                   
   :width: 800 px                                                                    
   :scale: 50 %  
   :align: center  

.. image:: ../../../sql-course/src/lectura32/oracle22.png                               
   :height: 500 px                                                                   
   :width: 800 px                                                                    
   :scale: 50 %  
   :align: center  

Y finalmente **"Guardamos"** el código.

.. image:: ../../../sql-course/src/lectura32/oracle23.png                               
   :height: 500 px                                                                   
   :width: 800 px                                                                    
   :scale: 50 %  
   :align: center  


