Lecture 27 - Views: Defining and using views
--------------------------------------------


.. role:: sql(code)
        :language: sql
        :class: highlight

The views are based in a vision of databases in 3 layers which are:

* *Physical Layer:** The lowest layer, is the data actually stored in the disk.
* **Concept Layer:** Is the abstraction of the relations (or tables) of the data stored in the disk.
* **Logic Layer:** the top layer is an abstraction above the relations and is known as **views**
.. image:: ../../../sql-course/src/view.png                              
  :align: center

Definition
~~~~~~~~~~~
**A view is a virtual table derived from the real tables** of a database. The views are not stored in the database, 
only a query definition is stored, in other words, a view must contain the instruction  :sql:`SELECT` to be created. 
The result of this is a table that contains data from the database or other views. This guarantees that the data is 
coherent when using the data stored in the tables. If the data from the relations change, the view that uses this data 
also changes. Is because of this that views use little to none disk space.
As a view is defined a as query on the relation, it belongs to the relational data model.
To define a view **V**, a view query is specified in SQL, through a set of existing tables **(R1, R2, …,Rn)

``View V= QuerySQL(R1, R2, …, Rn)``

The **V** view, can be viewed as a table of the query results. Let’s suppose we wish to execute a query **Q** in the 
database. This is not a view query; it’s just a query as seen before in the course. The query **Q** makes reference 
to **V**.

``V := ViewQuery(R1,R2,…,Rn)``

``Evaluate Q``

What really is doing Q is querying or editing the relation R1, R2… Rn in V. the DBMS makes the rewriting process 
automatically over these relations.

Views and its uses
~~~~~~~~~~~~~~~~~~~

Views are used for:
**accomplish complex query easily:** the views allows for the division of the query in many parts.
**Generate tables with specific data:** views allow to be seen as tables that show all the data, but also 
allow to hide some data. This is useful when a detail doesn’t correspond to the relations.

**Access modularity to the database:** the views can worked as modules that allows us to access certain parts of the database.
Real applications usually have lots of views, so as the application gets bigger modularity is needed more and more 
to facilitate some queries or to hide some data. The views are the mechanism to achieve these objectives.

View Creation
~~~~~~~~~~~~~~~~~~~~~~~

* :sql:`CREATE VIEW` : Defines a logical table from one or more existing tables or views.
* :sql:`DROP VIEW` : Eliminates a view definition and any view definition derived from it.

.. code-block:: sql

           Create View Vname(A1,A2,…,An) As <QuerySQLstandar>

*Vname* is the name assigned to the view, A1, A2,. …, An are the names to the new attributes the table will have.

Example 1
^^^^^^^^^^^^
Using a database with the following relations:

`\text{Specie}(\underline{\text{sName}},\text{comName,family})`

This table stores the data that characterizes the animal species. The store the scientific name in *sName* , the 
common name in *comName* and the family in *family.

`\text{Zoo}(\underline{\text{zID}},\text{zooName,size, budget})`

The Zoo relation stores the data from the Zoos. A *zID* is the primary key, the name is *zooName*, *size* is the size in 
hectares and the budget is *budget* in monetary units.

`\text{Animal}(\underline{\text{zID, sName, aName}},\text{country})`
The *animal* table stores the data about the animals that each zoo keeps. The *zID* is the foreing key from 
*Zoo*, and refers to in what zoo the animal lives. *sName* is the foreing key from *Specie* and the origin 
country is *country*.

The creation of the values that are used in this example are stored in the following file
.. (INSERTAR LINK).

We create a view:

.. code-block:: sql

           CREATE VIEW View1 AS
           SELECT zID, sName
           FROM Animal
           WHERE aName = 'Tony' and country = 'China';

As we already mentioned, to create a view we use the keywords :sql:`CREATE VIEW` specifying the name of the 
*view1*. Then we declare the query in SQL standard. That query selects *zID* y *sName* from the animals 
called “Tony” and come from “China”.

PostgreSQL returns:

.. code-block:: sql

           CREATE VIEW

When issuing a :sql:`SELECT`from the view, PostgreSQL shows it as any other relation.

.. code-block:: sql

            DBviews=# SELECT * FROM View1;
            
            zid |         sname         
           -----+------------------------
              5 | Ailuropoda melanoleuca
              1 | Panthera leo
              3 | Panthera tigris
           (3 rows)

However, the view doesn’t store data, as it’s stored in the relation *Animal*. Observe what happen when more data is inserted into *Animal*.

.. code-block:: sql

           INSERT INTO Animal
           (zID, sName, aName, country)
           VALUES
           (4,'Ailuropoda melanoleuca', 'Tony', 'China'),
           (3,'Panthera leo', 'Tony', 'China'),
           (1,'Loxodonta africana', 'Tony', 'China');

*View1* is updated automatically:

.. code-block:: sql

            DBviews=# SELECT * FROM View1;

            zid |         sname         
           -----+------------------------
              5 | Ailuropoda melanoleuca
              1 | Panthera leo
              3 | Panthera tigris
              4 | Ailuropoda melanoleuca
              3 | Panthera leo
              1 | Loxodonta africana
           (6 rows)

Example 2
^^^^^^^^^^^^
If we want to rename the attributes of a view, the sentence must be:

.. code-block:: sql

           CREATE VIEW Viewt(IDzoo,specieName) as
           SELECT zID, sName
           FROM Animal
           WHERE aName = 'Tony' and country = 'China';

PostgreSQL returns:

.. code-block:: sql

           CREATE VIEW

The view *Viewt* was the defined in the same way *View1*, but this time the selected atributes are renamed, 
*zID* is now *IDzoo* and *sName* is *specieName*

.. code-block:: sql

           DBviews=# SELECT * FROM Viewt;

            idzoo |       speciename      
           -------+------------------------
                5 | Ailuropoda melanoleuca
                1 | Panthera leo
                3 | Panthera tigris
                4 | Ailuropoda melanoleuca
                3 | Panthera leo
                1 | Loxodonta africana
           (6 rows)

To select an attribute from *Viewt*, you must use the new assigned name:

.. code-block:: sql

           DBviews=# SELECT zID FROM viewt;
           ERROR:  column "zid" does not exist
           LÍNEA 1: select zid from viewt;

           DBviews=# SELECT idzoo FROM viewt;
            idzoo
           -------
                5
                1
                3
                4
                3
                1
           (6 rows)


Example 3
^^^^^^^^^^^^
Even though the view doesn’t store any values, it only references them, it can be worked as a real relation. 
The following query selects *Zoo.zID, zooName and size* from the *Zoo* table,  and from the view *View1* 
where  *zID* from the table *Zoo* matches *zID*  from *View1*, remembering that  *View1*  and *sName* from 
*View1* is  'Ailuropoda melanoleuca' and that *size* of *Zoo* is less than 10.

.. code-block:: sql

           SELECT Zoo.zID, zooName, size
           FROM Zoo, View1
           WHERE Zoo.zID = View1.zID and sName = 'Ailuropoda melanoleuca' and size < 10;

           zid |  zooname   | size
           -----+------------+------
              4 | London Zoo |    9
           (1 row)

Example 4
^^^^^^^^^^^^
**a view can also reference another view**. For this we create a view called *View2*, that refers the 
table *Zoo* and the view *View1*.

.. code-block:: sql

           CREATE view View2 as
           SELECT Zoo.zID, zooName, size
           FROM Zoo, View1
           WHERE Zoo.zID = View1.zID and sName = 'Panthera leo' and  budget > 80;

The sentence creates a view contains data from *Zoo* that possess animals “Panthera leo”, the search 
is done within the data of *View1* and the budged of the *Zoo* must be greater than 80. It must be 
noted that this command only creates the view, but doesn’t shows the result.

The View2 can be used in sentences :sql:`SELECT` in the same way as other tables:

.. code-block:: sql

           DBviews=# SELECT * FROM View2;
            
            zid |    zooname    | size
           -----+---------------+------
              1 | Metropolitano |    4
              3 | San Diego     |   14
           (2 rows)

           DBviews=# SELECT * FROM View2 WHERE size > 5;

            zid |  zooname  | size
           -----+-----------+------
              3 | San Diego |   14
           (1 row)


