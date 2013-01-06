/* Create the schema for our tables */

CREATE TABLE Equipo
  (
    IDeq serial, 
    nombre VARCHAR(50), 
    ciudad VARCHAR(50), 
    titulos int, 
    PRIMARY KEY(IDeq)
);

CREATE TABLE Jugador
  (
    rut int, 
	IDeq int,
    nombre VARCHAR(50), 
    posicion VARCHAR(50), 
    numCamiseta int, 
    PRIMARY KEY(rut),
	FOREIGN KEY(IDeq) REFERENCES Equipo(IDeq)
);

CREATE TABLE Partido
  (
    IDeqL int, 
	IDeqV int,
    golLocal int, 
    golVisita int, 
    PRIMARY KEY(IDeqL,IDeqV),
	FOREIGN KEY(IDeqL) REFERENCES Equipo(IDeq),
	FOREIGN KEY(IDeqV) REFERENCES Equipo(IDeq)
);

INSERT INTO Equipo
(nombre,ciudad,titulos) 
VALUES
('UCH','Santiago',16),
('NUB', 'Chillan',0),
('SW', 'Valparaiso',3),
('CDA', 'Antofagasta', 0),
('COB', 'Calama',8),
('UE', 'Santiago', 6);

INSERT INTO Jugador
(rut,IDeq,nombre,posicion,numCamiseta) 
VALUES
(1760,1,'Diaz','Volante',21),
(1345,1,'Herrera','Arquero',25),
(1313,1,'Rojas','Defensa',13),
(1995,1,'Rivarola','Delantero',7),
(1999,1,'Salas','Delantero',11),
(2343,1,'Vargas','Delantero',17),
(5678,2,'Rodriguez','Volante',6),
(3423,2,'Videla','Volante',2),
(1234,2,'Garces','Arquero',12),
(1235,2,'Gutierrez','Delantero',9),
(1349,2,'Marino','Volante',8),
(9876,2,'Mena','Defensa',3),
(2233,3,'Ponce','Defensa',17),
(1218,3,'Ubilla','Delantero',19),
(6543,3,'Pinto','Arquero',1),
(3020,3,'Aranguiz','Volante',20),
(2223,3,'Martinez','Volante',23),
(2315,3,'Vergara','Defensa',28),
(1907,4,'Inostroza','Delantero',10),
(9839,4,'Campos','Delantero',9),
(1001,4,'Gonzalez','Delantero',18),
(1029,4,'Alamos','Arquero',1),
(8665,4,'Riera','Defensa',2),
(2782,4,'Castaneda','Volante',21),
(9207,5,'Marcos','Delantero',12),
(6075,5,'Sanchez','Delantero',11),
(7057,5,'Fernandes','Delantero',9),
(8610,5,'Conde','Arquero',1),
(3992,5,'Victorino','Defensa',3),
(2036,5,'Musrri','Volante',6),
(7614,6,'Musso','Defensa',3),
(8796,6,'Socias','Defensa',11),
(1906,6,'Alvarez','Delantero',9),
(1996,6,'Caputto','Arquero',1),
(2011,6,'Mardones','Delantero',14),
(1994,6,'Valencia','Delantero',7);

INSERT INTO Partido
(IDeqL,IDeqV,golLocal,golVisita) 
VALUES
(1,2,4,3),
(1,3,3,1),
(1,4,3,2),
(1,5,2,1),
(1,6,3,0),
(2,1,0,0),
(2,3,3,1),
(2,4,1,2),
(2,5,2,2),
(2,6,1,0),
(3,1,0,1),
(3,2,2,3),
(3,4,1,2),
(3,5,3,4),
(3,6,5,3),
(4,1,2,3),
(4,2,2,2),
(4,3,3,4),
(4,5,3,3),
(4,6,2,2),
(5,1,2,4),
(5,2,3,2),
(5,3,1,2),
(5,4,2,2),
(5,6,2,0),
(6,1,0,0),
(6,2,2,3),
(6,3,0,0),
(6,4,4,3),
(6,5,2,1);
