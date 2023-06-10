%MODULOS
:-module(drive_20832740_TorresUndurraga,[drive/4,getLetraDrive/2,getNombreDrive/2,getCapacidadDrive/2,buscar_drive/2,seleccionarDrive/3,eliminarDrive/3]).

%##############################################################################

%TDA drive
/*
REPRESENTACIÓN:

*/
/*
Predicados:
drive(Letra,Nombre_Unidad,Capacidad,Drive).
getLetraDrive(Drive,Letra).
getNombreDrive(Drive,Nombre).
getCapacidadDrive(Drive,Capacidad).
buscar_drive(Drives,Letra).
seleccionarDrive(Letra,Drives,DriveSalida).
eliminarDrive(Letra,Drives,DriveSalida).
*/
/*
Metas:
Principales: drive
Secundarias: getLetraDrive,getNombreDrive,getCapacidadDrive,
	buscar_drive,seleccionarDrive,eliminarDrive.
*/

%CONSTRUCTOR

%Descripción: Construye un drive (unidad).
%Dominios: Letra (String) x Nombre_Unidad (String) x Capacidad (Number) x Drive
drive(Letra,Nombre_Unidad,Capacidad,Drive):-string(Letra),
	number(Capacidad),Capacidad>0,
	string(Nombre_Unidad),
	Drive=[Letra,Nombre_Unidad,Capacidad].

%SELECTORES

%Descripción: Selecciona la letra de un drive.
%Dominios: Drive x Letra (String).
getLetraDrive([Letra,_,_],Letra).

%Descripción: Selecciona el nombre de un drive.
%Dominios: Drive x Letra (String).
getNombreDrive([_,Nombre,_],Nombre).

%Descripción: Selecciona la capacidad de un drive.
%Dominios: Drive x Letra (String).
getCapacidadDrive([_,_,Capacidad],Capacidad).


%OTRAS OPERACIONES

%Descripción: Busca si existe un drive en una lista de drives.
%Dominios: Drives (Lista de drives) x Letra (String).
buscar_drive([[Letra,_,_]|_],Letra):-!.
buscar_drive([[_,_,_]|T],Letra):-buscar_drive(T,Letra).

%Descripción: Selecciona un drive desde una lista de drives mediante una letra.
%Dominios: Letra (String) x Drives (Lista de drives) x DriveSalida (drive).
seleccionarDrive(Letra,[[Letra,Nombre,Capacidad]|_],[Letra,Nombre,Capacidad]):-!.
seleccionarDrive(Letra,[_|T],Tout):-seleccionarDrive(Letra,T,Tout).

%Descripción: Elimina un drive desde una lista de drives mediante una letra.
%Dominios: Letra (String) x Drives (Lista de drives) x DriveSalida (drive).
eliminarDrive(_,[],[]):-!.
eliminarDrive(Letra,[[Letra,_,_]|T],Tout):-eliminarDrive(Letra,T,Tout).
eliminarDrive(Letra,[H|T],[H|Tout]):-eliminarDrive(Letra,T,Tout).
