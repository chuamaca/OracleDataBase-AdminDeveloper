/*Indicaciones:
 Todos los pasos ejecutados para la resolución de la práctica deben ser grabados en un archivo SPOOL por pregunta con el formato NAPELLIDO_P#_SOL.txt, donde N representa la primera letra de su nombre, APELLIDO su apellido paterno y # el número de pregunta.
 Las respuestas deberán ejecutarse con SQL*Plus y adjuntar a la respuesta los archivos de SPOOL necesarios.
Ejecute las consultas necesarias que muestren el estado y el ID de la nueva PDB.

*/

/*
#######	Pregunta 1: Database – PDB (2.00 puntos)

Siga las siguientes instrucciones: 1. Ejecute el comando para crear una PDB llamada PDB_XX utilizando la semilla (seed) como plantilla.
2. Ejecute las consultas necesarias que muestren el estado y el ID de la nueva PDB.
3. Configure la PDB para que se inicie de manera automática.
4. Conéctese a la pdb PDB_XX y ejecutar los comandos que:
a. muestre el usuario con el que se ha conectado; y
b. que muestre la base de datos a donde está conectado.

Dónde: XX es la primera letra de su primer nombre y la siguiente equis es la primera letra de su apellido paterno. Por ejemplo, para mi nombre: CESAR HIJAR la PDB se llamará: PDB_CH
*/

/*
######	Pregunta 2: Redo (2.00 puntos)
Siga las siguientes instrucciones:
1. Cree un nuevo grupo de Redo Log con 2 miembros
2. Usar las mejores prácticas para determinar la ubicación de los archivos.
3. El nombre de los archivos debe tener la nomenclatura “pc01_redo00_#.log” donde # representa el número de miembro.
4. Ejecutar las consultas a las vistas respectivas para validar la creación y para que luego pueda ser utilizado por la base de datos.

*/





/*
#####	Pregunta 3: Controlfile (2.00 puntos)
a) Crear dos archivos controlfile adicionales:
a. CONTROL_PC01_01.CTL
b. CONTROL_PC01_02.CTL
b) Use las mejores prácticas para determinar la ubicación de los archivos.
c) Ejecute las consultas necesarias para validar que la base de datos utilice el nuevo archivo de control.

*/






sho pdbs



