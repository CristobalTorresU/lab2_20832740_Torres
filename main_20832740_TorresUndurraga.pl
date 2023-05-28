%Clausulas Comunes
insertarCola(E,[],[E]).
insertarCola(E,[H|T],[H,Tout]):-insertarCola(E,T,Tout).

%TDAs

%##############################################################################

%TDA system
%REPRESENTACIÓN
/**/
%PREDICADOS
/*
system(Name,S)
getNameSystem(S,Name)
getFechaSystem(S,Fecha)
getLetraSystem(S,Letra_unidad)
getUsuarioSystem(S,Usuario_actual)
getRutaSystem(S,Ruta_actual)
getDrives(S,Drives)
getUsers(S,Users)
getPapelera(S,Papelera)
*/

%CONSTRUCTORES
%El constructor se encuentra entre las funciones prinpales

%SELECTORES
getNameSystem([Name,_,_,_,_,_,_,_],Name).
getFechaSystem([_,Fecha,_,_,_,_,_,_],Fecha).
getLetraSystem([_,_,Letra_unidad,_,_,_,_,_],Letra_unidad).
getUsuarioSystem([_,_,_,Usuario_actual,_,_,_,_],Usuario_actual).
getRutaSystem([_,_,_,_,Ruta_actual,_,_,_],Ruta_actual).
getDrives([_,_,_,_,_,Drives,_,_],Drives).
getUsers([_,_,_,_,_,_,Users,_],Users).
getPapelera([_,_,_,_,_,_,_,Papelera],Papelera).

%MODIFICADORES

%OTRAS OPERACIONES


%##############################################################################

%TDA drive
%REPRESENTACIÓN
/**/

%PREDICADOS

%CONSTRUCTORES
%predicado: 
%dominio: 
%recorrido: 
drive(Letra,Nombre_Unidad,Capacidad,D):-string(Letra),
										number(Capacidad),Capacidad>0,
										string(Nombre_Unidad),
										D=[Letra,Nombre_Unidad,Capacidad,[]].

%SELECTORES

%MODIFICADORES

%OTRAS OPERACIONES
buscar_drive([[Letra,_,_,_]|_],Letra).
buscar_drive([[_,_,_,_]|T],Letra):-string(Letra),
								buscar_drive(T,Letra).

%##############################################################################
%##############################################################################
%##############################################################################
%------------------------------------------------------------------------------

%FUNCIONES PRINCIPALES

%predicado: 
%dominio: Name (string) x System
%recorrido: System
system(Name,System):-string(Name),
					 date(Date),
					 System=[Name,Date,"","","",[],[],[]],
					 set_prolog_flag(answer_write_options,[max_depth(0)]),!.

%predicado:
%dominio: System x Letter (String) x Name (String) x Capacity (int) x System
%recorrido: System
systemAddDrive(SB,Letter,Name,Capacity,SA):-getNameSystem(SB,Name_system),
										getFechaSystem(SB,Fecha),
										getLetraSystem(SB,Letra),
										getUsuarioSystem(SB,Usuario),
										getRutaSystem(SB,Ruta),
										getDrives(SB,Drives),
										getUsers(SB,Users),
										getPapelera(SB,Papelera),
										drive(Letter,Name,Capacity,Drive),
										not(buscar_drive(Drives,Letter)),
										insertarCola(Drive,Drives,NewDrives),
										SA=[Name_system,Fecha,Letra,Usuario,Ruta,NewDrives,Users,Papelera],
										set_prolog_flag(answer_write_options,[max_depth(0)]),!.
