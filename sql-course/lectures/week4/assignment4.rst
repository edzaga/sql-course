Tarea 4
=========

Fecha de entrega: lunes 7 de enero 2013 hasta 23:59
-----------------------------------------------------------

.. role:: sql(code)
   :language: sql
   :class: highlight

-------------
Base de datos
-------------

Se tiene una base de datos de zoológicos con el siguiente esquema:

`\text{Zoo}(\underline{\text{nombre}}, \text{ciudad, pais,tamanio, presupuesto})`

Esta tabla almacena los datos de los zoológicos. Su *nombre*, *ciudad* y *pais* en el que se ubica, *tamanio* es el tamaño en hectáreas y *presupuesto* en unidades monetarias.

.. code-block:: sql

		 nombre         |      ciudad      |      pais      | tamanio | presupuesto
	------------------------+------------------+----------------+---------+-------------
	 Metropolitano          | Santiago         | Chile          |     4.8 |         100
	 BuinZoo                | Buin             | Chile          |         |          60
	 San Diego              | San Diego        | Estados Unidos |      14 |       405.5
	 Parque Safari          | Rancagua         | Chile          |         |          50
	 London Zoo             | Londres          | Reino Unido    |       9 |       253.9
	 Chapultepec            | Ciudad de Mexico | Mexico         |      16 |
	 Buenos Aires           | Buenos Aires     | Argentina      |      18 |       253.9
	 Parque de las Leyendas | Peru             | Lima           |         |
	(8 rows)

`\text{Especie}(\underline{\text{nomCient}},\text{nomComun, familia})`

Esta tabla almacena los datos que caracterizan las especies animales. Almacena el nombre científico en *nomcient*, el nombre común con el que se le conoce es guardado en *nomcomun* y la *familia* a la que pertenece la especie.

.. code-block:: sql

		nomcient         |           nomcomun           | familia
	-------------------------+------------------------------+----------
	 Panthera tigris         | Tigre                        | Mammal
	 Aptenodytes patagonicus | Pinguino Rey                 | Ave
	 Ailuropoda melanoleuca  | Oso Panda                    | Mammal
	 Vultur gryphus          | Condor                       | Ave
	 Pongo pygmaeus          | Orangutan                    | Mammal
	 Chelonoidis nigra       | Tortuga gigante de Galapagos | Reptil
	 Balaenoptera musculus   | Ballena Azul                 | Mammal
	 Glaucidium nanum        | Chuncho                      | Ave

	(15 rows)

`\text{Animal}(\underline{\text{numid}},\text{nomZoo, nomEspecie, sexo, anioNacim, pais})`

La tabla animal guarda los datos de los animales que habitan cada zoológico. El atributo *nomZoo* es clave foranea a **Zoo**, se refiere al zoológico en el que se encuentra un animal, *nomEspecie* es clave foranea a **Especie** a la que pertenece cada uno, también se almacenan el *sexo*, año de nacimiento en *anioNacim* y el país de procedencia en *pais*.

.. code-block:: sql

	 numid |         nomzoo         |       nomespecie        |  sexo  | anionacim |   pais
	-------+------------------------+-------------------------+--------+-----------+-----------
	     1 | Metropolitano          | Panthera tigris         | Macho  |           | India
	     2 | San Diego              | Panthera tigris         | Macho  |      2010 | Nepal
	     3 | London Zoo             | Panthera tigris         | Macho  |      2008 | Birmania
	     4 | BuinZoo                | Pongo pygmaeus          | Hembra |      2004 | Indonesia
	     5 | Metropolitano          | Hippocamelus bisulcus   | Hembra |           | Chile
	     6 | Parque Safari          | Panthera tigris         | Macho  |      2009 | India

	(28 rows)

Existen reglas que se especificaron para las claves foráneas, después de haberlas consultado con los encargados de los zoológicos:

* El *nombre* de los zoológicos debe ser un valor conocido.

* Toda especie debe poseer un nombre científico.

* Todo animal tiene *numid* conocido, se encuentra en un zoo conocido y pertenece a una especie conocida.

.. note::
	Las tablas anteriores son solo de referencia. Se creó un archivo assigment4.sql , que posee la información de creación de tablas con valores asignados.

Pregunta 1 (5 puntos):
^^^^^^^^^^^^^^^^^^^^^^^^

Modificar el archivo `assignment4.sql`_ de modo que la creación de tablas cumpla con las 3 reglas descritas anteriormente.

Pregunta 2 (10 puntos):
^^^^^^^^^^^^^^^^^^^^^^^^

Asignarle un valor desconocido (NULL) al año de nacimiento del animal que posee el nombre común 'Leon' y que habita en el 'Parque Safari'.

Pregunta 3 (10 puntos):
^^^^^^^^^^^^^^^^^^^^^^^^

Actualizar los presupuestos que tengan valores nulos asignándoles un valor de presupuesto=0.


Pregunta 4 (10 puntos):
^^^^^^^^^^^^^^^^^^^^^^^^

Seleccionar el “nombre común” (Especie.nomComun), “nombre del zoológico”(Zoo.nombre) y “país”(Animal.pais), de los animales que se conoce su país de origen.

Pregunta 5 (15 puntos):
^^^^^^^^^^^^^^^^^^^^^^^^

Eliminar de la base de datos (de la tabla **Animal**) los animales de la familia de los reptiles(Especie.familia=Reptil) del 'London Zoo'.

-------------------------------
Teoría del diseño Relacional
-------------------------------

Se cuenta con las siguientes vistas:

* VISTA1 (FECHA-INGRESO, FECHA-MUERTE, #ANIMAL, NOMBRE-COMUN, NOMBRE-CIENT, APODO,
  HABITAT, CLASE, LONGITUD, PESO, LONGEVIDAD, FOTO,
  {FECHA-R, #EMP, DIAG, {#REMEDIO, NOM-REMEDIO, DOSIS}, OBSERVACION)

La vista1 permite a un visitante web, conocer sobre los animales del ZooChile.
FECHA-R es la fecha y hora en que se revisó al animal. #REMEDIO se agrega para reducir
redundancia, ya que los mismos remedios pueden ser suministrados a distintos animales.

* VISTA 2 (FECHA, NOM-V, FIRMA-V, {CLASE{#ANIMAL, {TIPO-ALIMENTO, CANT}}})

La vista 2 permite al Director del Zoo, conocer el número de revisiones que realiza
mensualmente cada uno de sus veterinarios.
La FECHA se guarda para saber cuándo y qué un animal comió, de tal forma de poder entregar
información al veterinario ante cualquier enfermedad. Se eliminan entidades intermedias con
atributos como: (FECHA, CLASE) y (FECHA, CLASE, #ANIMAL) dado que no aportan información adicional.

Pregunta 1 (50 puntos):
^^^^^^^^^^^^^^^^^^^^^^^^
Normalizar cada vista a 1FN, 2FN y 3FN.


.. note ::
	La tarea se `entrega`_  en un archivo comprimido .rar , que contenga:

	* archivo `assignment4.sql`_ , con las respuestas a las preguntas de “Base de Datos”.
	* archivo assigment4.doc , .docx o .pdf que incluya la respuesta de “Teoría del diseño Relacional”.

.. _`assignment4.sql`: https://csrg.inf.utfsm.cl/claroline/claroline/backends/download.php?url=L0Fzc2lnbm1lbnQ0L3RhcmVhNC5zcWw%3D&cidReset=true&cidReq=SQL01
.. _`entrega`: https://csrg.inf.utfsm.cl/claroline/claroline/work/work_list.php?assigId=4&cidReset=true&cidReq=SQL01

