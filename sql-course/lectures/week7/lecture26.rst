Lectura 26 - Transacciones: Propiedades
---------------------------------------

En esta lectura se va a profundizar sobre las propiedades de las transacciones.

Como recordatorio, las transacciones son un concepto que ha sido introducido como una 
solución tanto para el problema de control de concurrecia y fallos de sistemas en las bases 
de datos.

Específicamente una transacción es una secuencia de operaciones que se tratan como una unidad.
Las operaciones parecen ejecutarse de manera aislada, incluso si muchos clientes están 
operando en una base de datos al mismo tiempo.
Y más aún si hay un fallo del sistema en software inesperado, hardware, o fallo de energía cada cambios transacciones que se emitieron a la base de datos son o bien refleja totalmente o en absoluto.

