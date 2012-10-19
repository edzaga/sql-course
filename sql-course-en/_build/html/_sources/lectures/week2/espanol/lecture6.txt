Lecture 6 - Data Types
-------------------------------

En SQL se tienen varios tipos de datos. Cuando creamos una tabla con la instrucción create table, tenemos que especificar el tipo de dato de cada columna.

1. Character strings of fixed or varying length. The type CHAR(n) denotes a fixed-length string of n characters. That is, if an attribute has type CHAR(n), then in any tuple the component for this attribute will be a string of n characters. VARCHAR(n) denotes a string of up to n characters. Components for an attribute of this type will be strings of between 0 and n characters. SQL permits reasonable coercions between values of character-string types. Normally, a string is padded by trailing blanks if it becomes the value of a component that is a fixed-length string of greater length. For example, the string "foo", if it became the value of a component for an attribute of type CHAR(5), would assume the value "foo  ", (with two blanks following the second o). The padding blanks can then be ignored if the value of this component were compared with another string.

2. Bit strings of fixed or varying length. These strings are analogous to fixed and varying-length character strings, but their values are strings of bits rather than characters. The type BIT(n) denotes bit strings of length n, while BIT VARYING(n) denotes bit strings of length up to n.

3. The type BOOLEAN denotes an attribute whose value is logical. The possible values of such an attribute are TRUE, FALSE, and - although it would surprise George Boole - UNKNOWN.

4. The type INT or INTEGER (these names are synonyms) denotes typical integer values. The type SHORTINT also denotes integers, but the number of bits permitted may be less, depending on the implementation (as with the types int and short int in C).

5. Floating-point numbers can be represented in a variety of ways. We may use the type FLOAT or REAL (these are synonyms) for typical floating-point numbers. A higher precision can be obtained with the type DOUBLE PRECISION; again the distinction between these types is as in C. SQL also has types that are real numbers with a fixed decimal point. For example, DECIMAL(n,d) allows values that consist of n decimal digits, with the decimal point assumed to be d positions from the right. Thus, 0123.45 is a possible value of type DECIMAL(6,2). NUMERIC is almost a synonym for DECIMAL, although there are possible implementation-dependent differences.

6. Dates and times can be represented by the data types DATE and TIME, respectively. These values are essentially character strings of a special form. We may, in fact, coerce dates and times to string types, and we may do the reverse if the string "makes sense" as a date or time.

Simple Table Declarations
~~~~~~~~~~~~~~~~~~~~~~~~~ 

The simplest form of declaration of a relation schema consists of the keyrwords CREATE TABLE followed by the name of the relation and a parenthesized list of the attribute names and their types.

-------
Example
-------

The first two attributes, name and address , have each been declared to be character strings. However, with the name, we have made the decision to use a fixed-length string of 30 characters: padding a name out with blanks at the end if necessary and truncating a name to 30 characters if it is longer. In contrast, we have declared addresses to be variable-length character strings of up to 255 characters. It is not clear that these two choices are the best possible, but we use them to illustrate two kinds of string data types.
The gender attribute has values that are a single letter, M or F. Thus we can safely use a single character as the type of this attribute. Finally, the birthdate attribute naturally deserves the data type DATE. If this type were not available in a system that did not conform to the SQL standard, we could use CHAR(10) instead, since all DATE values are actually strings of 10 characters eight digits and two hyphens.

::

   CREATE TABLE Person (

          name CHAR(30),

          address VARCHAR(255),

          gender CHAR(1),

          birthdate DATE

   );


