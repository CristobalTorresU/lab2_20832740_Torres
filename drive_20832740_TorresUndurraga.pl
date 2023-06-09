%MODULOS
:-module(drive_20832740_TorresUndurraga,[drive/4,getLetraDrive/2,getNombreDrive/2,getCapacidadDrive/2,getPrimerDrive/2,getRestoDrives/2,buscar_drive/2,seleccionarDrive/3,eliminarDrive/3]).

%##############################################################################

%TDA drive
drive(Letra,Nombre_Unidad,Capacidad,D):-string(Letra),
	number(Capacidad),Capacidad>0,
	string(Nombre_Unidad),
	D=[Letra,Nombre_Unidad,Capacidad].

%SELECTORES
getLetraDrive([Letra,_,_],Letra).
getNombreDrive([_,Nombre,_],Nombre).
getCapacidadDrive([_,_,Capacidad],Capacidad).
getPrimerDrive([Drive|_],Drive).
getRestoDrives([_|Drives],Drives).

%OTRAS OPERACIONES
%buscar_drive().
buscar_drive([[Letra,_,_]|_],Letra):-!.
buscar_drive([[_,_,_]|T],Letra):-buscar_drive(T,Letra).

%seleccionarDrive().
seleccionarDrive(E,[[E,Nombre,Capacidad]|_],[E,Nombre,Capacidad]):-!.
seleccionarDrive(E,[_|T],Tout):-seleccionarDrive(E,T,Tout).

%eliminarDrive().
eliminarDrive(_,[],[]):-!.
eliminarDrive(Letra,[[Letra,_,_]|T],Tout):-eliminarDrive(Letra,T,Tout).
eliminarDrive(Letra,[H|T],[H|Tout]):-eliminarDrive(Letra,T,Tout).
