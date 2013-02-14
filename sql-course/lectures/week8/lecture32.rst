Lectura 32 - Uso de SQL Developer
---------------------------------

En esta lectura se explicaran en detalle algunas herramientas importantes del software 
``Oracle SQL Developer`` que se puede descargar `aquí <http://www.oracle.com/technetwork/developer-tools/sql-developer/downloads/index.html>`_.

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


