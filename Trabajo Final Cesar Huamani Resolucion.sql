-- Pregunta 1: Database – PDB (2.00 puntos)
/*
#D:\Curso Oracle Oracle Database18c\Modulo 1\s03\LABORATORIO SESION 03.pdf

*/

sqlplus / as sysdba

-- Base de Datos contenedoa
sho con_name

-- Cuantas DB tengo en mi DB contenedora. con UNA DB de SEMILLA, nunca de escritura
show pdbs

--Para STOP de una PDB
alter pluggable database <nombre_pdb> stop;
alter pluggable database recursos stop;

--Sintaxis para iniciar una PDB:
alter pluggable database nombre_pdb > start
alter pluggable database contabilidad start

--Sintaxis para iniciar todas las PDBs
alter pluggable database all open;

--COMANDO PARA SUBIR UNA PDB de MOUNT A READ WRITE
alter pluggable database PDB_CH open;

--Sintaxis para detener todas las PDBs
alter pluggable database all close

--Grabar el estado de una PDB.
alter pluggable database PDBXX save state;


--Bajar Toda la Instancia
shut immediate

--La ultima Opcion no se va hacer rollback. EN PRODUCCION NO SE HACE.
shut abort

--Para Levantar la INSTANCIA
startup

--COmanods para Crear UNA PDB.
--Se puede crear PDB de forma manual, ejemplos:

CREATE PLUGGABLE DATABASE PDB_0101
ADMIN USER pdb0101 IDENTIFIED BY pdb0101 ROLES=(CONNECT)
file_name_convert = ('pdbseed', 'pdb_0101')

CREATE PLUGGABLE DATABASE test
ADMIN USER test IDENTIFIED BY test ROLES=(CONNECT)
file_name_convert = ('pdbseed','test')

--Despues de Instalkar Debemos asegurarnos que vamos a conecatr. Pero debemos verificar los TSM names. 
--1. REvision De los Servicio Registrados en el Listener.
LSNRCTL
status listener
--2. Configurados el TNSNames.ora

--3. Conexiones y estados de las DB PDB YCDB

-- Verifcar stus de PDB
select file_name, tablespace_name, file_id, con_id from cdb_data_files order by tablespace_name;

--Realizar las Conexxiones
connect sys/oracle@PDB_CH as sysdba;

--Con que USUARIO ESTOY CONECTADO.
show USER

-- Grabar los comandos
SPOOL filename


--para conectarme a XEPDB
conn sys/oracle@xepdb1 as sysdba;

--como se en que DB estoy
SHOW CON_NAME

--Para conectarse a la nueba DB
conn sys/oracle@PBD_CH as sysdba;

--PARA COENCTARSE CON EL USUARIO SYS. Pero hay un problema de los usuarios puedan conectarse, Debes configurar el TNSNAMES.ora

CONN SYS AS SYSDBA

--Para cambiar de DB
alter session set container=PDB_CH;

--Para Desconectarse
DISC

------  Las maneras de poner en LINEA/READ ONLY, READ WRITE TIENEN uqe hacerse desde CDB$ROOT
alter session set container=cdb$root



/* PREGUNTA 01
Nombre de La PDB
PDB_CH

D:\Curso Oracle Oracle Database18c\Tarea Final

SPOOL filename

SPOOL CHUAMANI_P1_SOL.txt

*/

sqlplus / as sysdba;

CONN SYS AS SYSDBA

show pdbs
--sqlplus / as sysdba alter system set db_create_file_dest='C:\app\Cesar\product\18.0.0\oradata\XE\PDB_CH';

CREATE PLUGGABLE DATABASE PDB_CH
ADMIN USER pdbch IDENTIFIED BY pdbch ROLES=(CONNECT)
file_name_convert = ('pdbseed','PDB_CH');


alter pluggable database PDB_CH open;

alter pluggable database PDB_CH save state;

alter session set container=PDB_CH;

connect pdbch/pdbch@PDB_CH as sysdba;

set line 150
col file_name format a60
select file_name, tablespace_name, file_id, con_id from cdb_data_files order by tablespace_name;

show USER

show con_name

/* PREGUNTA 02
--Nombre de Archivo RedoLog
pc01_redo00_1.log
pc01_redo00_2.log

--SPOOL filename
SPOOL CHUAMANI_P2_SOL.txt
*/
-- RUTA DE REDO
-- C:\APP\CESAR\PRODUCT\18.0.0\ORADATA\XE\
-- D:\REDOXE

-- Para pasar un Redo a otro Redo de un GRUPO a otro.
alter system SWITCH LOGFILE;

--Agregamos el miembro de al grupo 4
alter database add logfile
member 'C:\APP\ORACLE\ORADATA\CDB\pc01_redo00_4a.LOG'
to group 4;

alter database add logfile
member 'C:\APP\ORACLE\ORADATA\CDB\pc01_redo00_4b.LOG'
to group 4;


--Eliminamos el miembro de al grupo 1
alter database
drop logfile
member 'C:\APP\ORACLE\ORADATA\CDB\REDO04.LOG';

--------RESUELTO
--Agregar grupos redo log, Se puede PONER EN Diferentes RUtas
ALTER DATABASE ADD LOGFILE GROUP 4 ('C:\APP\CESAR\PRODUCT\18.0.0\ORADATA\XE\pc01_redo00_1.log',
'D:\REDOXE\pc01_redo00_2.log')
SIZE 30M;

--RUTA DE LOS GRUPOS CON SUS REDO.LOG
col group# format 999999
col member format a60
select group#,status,member from v$logfile;

--STATUS DE GRUPO REDO.LOG
col group# format 999999
col sequence format a50
select group#,sequence#,status from v$log;

/* PREGUNTA 03
--Nombre de Archivo Controlfile
a.	CONTROL_PC01_01.CTL 
b.	CONTROL_PC01_02.CTL 


--SPOOL filename
SPOOL CHUAMANI_P3_SOL.txt

Pregunta 3: Controlfile (2.00 puntos) 
a)	Crear dos archivos controlfile adicionales: 
a.	CONTROL_PC01_01.CTL 
b.	CONTROL_PC01_02.CTL 
b)	Use las mejores prácticas para determinar la ubicación de los archivos. 
c)	Ejecute las consultas necesarias para validar que la base de datos utilice el nuevo archivo de control. 

*/

--Ver los ControlFiles
col name format a55
select status,name from v$controlfile;

--Otra manera de ver las vistas.
show parameter control_files;

-- Multiplexar es Crear Otro archivo.

alter system set control_files =
'C:\APP\CESAR\PRODUCT\18.0.0\ORADATA\XE\CONTROL01.CTL',
'C:\APP\CESAR\PRODUCT\18.0.0\ORADATA\XE\CONTROL02.CTL',
'D:\CONTROLFILES\CONTROL_PC01_01.CTL',
'D:\CONTROLFILES\CONTROL_PC01_02.CTL'
scope=SPFILE;

/*------- Test
alter system set control_files =
'C:\app\Cesar\product\18.0.0\oradata\XE\CONTROL01.CTL',
'C:\app\Cesar\product\18.0.0\oradata\XE\CONTROL02.CTL',
'C:\app\Cesar\product\18.0.0\oradata\XE\CONTROL_PC01_01.CTL'
scope=SPFILE;*/

-- Bajamos La Instancia
shutdown immediate

-- *********** Copiamos De la RUTA. C:\APP\CESAR\PRODUCT\18.0.0\ORADATA\XE\CONTROL01.CTL ---->hacia----> Hacia la RUTA: D:\CONTROLFILES

startup

--Para ver los Control Files.
show parameter control_files

--Modificamos los Nuevos Control Files.
alter system set control_files =
'D:\CONTROLFILES\CONTROL_PC01_01.CTL',
'D:\CONTROLFILES\CONTROL_PC01_02.CTL'
scope=SPFILE;

/*------ Test(*************
--'C:\app\Cesar\product\18.0.0\oradata\XE\CONTROL02.CTL',   -- ELIMINAR
alter system set control_files =
'C:\app\Cesar\product\18.0.0\oradata\XE\CONTROL01.CTL',
'C:\app\Cesar\product\18.0.0\oradata\XE\CONTROL_PC01_01.CTL'
scope=SPFILE;
*/

-- Bajamos La Instancia
shutdown immediate

-- *********** Elimnar El Control CONTROL01.CTL y CONTROL02.CTL

--Iniciamos lA INSTANCIA de LA DB
startup

--Hacemos la Consulta De la Instancia
select instance_name,status from v$instance;

--Hacemos la Consulta Del DATABASE
select name, open_mode from v$database;

--Listamos los Nuevos ControlFiles.
col name format a55
select status,name from v$controlfile;


/* Ejercio 04 
CHUAMANI_P4_SOL.txt


Crear el tablespace cobranzas_data en “PDB_XX” el cual deberá contener 2 datafiles  llamados “cobranza_data_01” y “cobranza_data_02”. Considerar lo siguiente:

a) El espacio disponible del tablespace será de 50MB.  
b)	Cada datafile deberá usar el estándar para las extensiones de los archivos. 
c)	La ubicación de los datafiles deberá cumplir con las buenas prácticas establecidas.  
 
Crear el tablespace cobranzas_index en “PDB_XX” el cual deberá contener en total un tamaño de 24 MB.
  (el nombre de los datafiles queda a su criterio) 
  
d)	Asegúrese de que los datafiles que conforman deberá usar el estándar para las extensiones de los archivos. 
e)	Debe de contener un total de 3 datafiles de igual tamaño. 
f)	La ubicación de los datafiles deberá cumplir con las buenas prácticas establecidas.  

DB: PDB_CH
TableSpace: cobranzas_data
datafiles 50MB: cobranza_data_01, cobranza_data_02
extensiones

DB: PDB_CH de 24 MB
TableSpace: cobranzas_index
datafiles: cobranzas_index_d1, cobranzas_index_d2, cobranzas_index_d3

Todos en la RUTA D:


alter session set container=PDB_CH;
*/



/*
select tablespace_name,status from dba_tablespaces;


*/

/*
--probar
CREATE TABLESPACE cobranzas_data
DATAFILE 'C:\app\Cesar\product\18.0.0\oradata\XE\PDB_CH\cobranza_data_01.dbf'
SIZE 25M
autoextend on next 1M
--maxsize 50M
EXTENT MANAGEMENT LOCAL;

CREATE TABLESPACE cobranzas_data
DATAFILE 'C:\app\Cesar\product\18.0.0\oradata\XE\PDB_CH\cobranza_data_01.dbf'
SIZE 25M
AUTOEXTEND OFF
maxsize 50M
EXTENT MANAGEMENT LOCAL;
--



CREATE TABLESPACE cobranzas_data
DATAFILE 'C:\app\Cesar\product\18.0.0\oradata\XE\PDB_CH\cobranza_data_01.dbf'
SIZE 25M
EXTENT MANAGEMENT LOCAL
UNIFORM SIZE 100K;

--Agregar un Arhcivo Data fILE a UN Table Space
ALTER TABLESPACE cobranzas_data
ADD DATAFILE 'C:\app\Cesar\product\18.0.0\oradata\XE\PDB_CH\cobranza_data_02.dbf'
SIZE 50M;

--resice de un Archivo DataFile
ALTER DATABASE DATAFILE
'D: ORADAT data02.dbf' RESIZE 1500K;

ALTER TABLESPACE cobranzas_data RESIZE 50M;

--Para Borrar Un DataFile.
ALTER TABLESPACE cobranzas_data DROP DATAFILE 'C:\app\Cesar\product\18.0.0\oradata\XE\PDB_CH\cobranza_data_03.DBF';

--Para Borrar un TableSpcae incluyendo sus DataFiles.
drop tablespace cobranzas_data including contents and datafiles;

--Que no Ex autoExtendible
CREATE TABLESPACE omf_ts2 DATAFILE AUTOEXTEND OFF;
*/

conn /@PDB_CH as sysdba;


CREATE TABLESPACE cobranzas_data
DATAFILE 'D:\TABLESPACE\DATA\cobranza_data_01.dbf' SIZE 50M,
'D:\TABLESPACE\DATA\cobranza_data_02.dbf' SIZE 50M;

CREATE TABLESPACE cobranzas_data
DATAFILE 'C:\app\Cesar\product\18.0.0\oradata\XE\PDB_CH\cobranza_data_01.dbf' SIZE 50M,
'C:\app\Cesar\product\18.0.0\oradata\XE\PDB_CH\cobranza_data_02.dbf' SIZE 50M;



set line 180
col TABLESPACE_NAME format a15
col FILE_NAME format a60
select tablespace_name,file_name,bytes from dba_data_files;


select * from v$tablespace;

--Consulta de TableSpcae
--select tablespace_name,status,max_size, block_size from dba_tablespaces;


CREATE TABLESPACE cobranzas_index
DATAFILE 'D:\TABLESPACE\INDEX\cobranzas_index_d1.dbf' SIZE 8M,
'D:\TABLESPACE\INDEX\cobranzas_index_d2.dbf' SIZE 8M,
'D:\TABLESPACE\INDEX\cobranzas_index_d3.dbf' SIZE 8M
EXTENT MANAGEMENT LOCAL;


set line 180
col TABLESPACE_NAME format a15
col FILE_NAME format a60
select tablespace_name,file_name,bytes from dba_data_files;


select * from v$tablespace;



/*
Pregunta 5: (1.00 puntos) 
Crear el usuario COBRANZAS con las siguientes características; 
•	La contraseña será Lima1234 
•	Asignar como tablespace por defecto al tablespace cobranzas _data. 

*/

create user cobranzas IDENTIFIED by Lima1234
DEFAULT TABLESPACE cobranzas_data;

GRANT CONNECT TO cobranzas;

connect cobranzas/Lima1234@PDB_CH;

select username from DBA_users;

