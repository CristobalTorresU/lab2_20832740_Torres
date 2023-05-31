%Clausulas Comunes
insertarCola(E,[],[E]).
insertarCola(E,[H|T],[H|Tout]):-insertarCola(E,T,Tout).

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
getNameSystem([Name,_,_,_,_,_,_,_,_,_],Name).
getFechaSystem([_,Fecha,_,_,_,_,_,_,_,_],Fecha).
getLetraSystem([_,_,Letra_unidad,_,_,_,_,_,_,_],Letra_unidad).
getUsuarioSystem([_,_,_,Usuario_actual,_,_,_,_,_,_],Usuario_actual).
getRutaSystem([_,_,_,_,Ruta_actual,_,_,_,_,_],Ruta_actual).
getDrives([_,_,_,_,_,Drives,_,_,_,_],Drives).
getCarpetas([_,_,_,_,_,_,Carpetas,_,_,_],Carpetas).
getArchivos([_,_,_,_,_,_,_,Archivos,_,_],Archivos).
getUsers([_,_,_,_,_,_,_,_,Users,_],Users).
getPapelera([_,_,_,_,_,_,_,_,_,Papelera],Papelera).

%MODIFICADORES

%OTRAS OPERACIONES


%##############################################################################

%TDA drive
%REPRESENTACIÓN
/**/

%PREDICADOS
/*
*/

%CONSTRUCTORES
%predicado: 
%dominio: 
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

%MODIFICADORES

%OTRAS OPERACIONES
buscar_drive([[Letra,_,_]|_],Letra).
buscar_drive([[_,_,_]|T],Letra):-string(Letra),
	buscar_drive(T,Letra).

%##############################################################################

%TDA user
%REPRESENTACIÓN
/**/

%PREDICADOS
/*
*/

%CONSTRUCTORES
user(Nombre,U):-string(Nombre),
	date(Date),
	U=[Nombre,Date].

%SELECTORES
getNombreUser([Nombre,_],Nombre).

%MODIFICADORES


%OTRAS OPERACIONES
buscar_usuario([[Username,_]|_],Username):-!.
buscar_usuario([[_,_]|T],UserName):-string(UserName),
	buscar_usuario(T,UserName).
no_sesion_iniciada([_,_,_,Usuario,_,_,_,_,_,_],Usuario).

%##############################################################################
%TDA folder

%predicado: 
%dominio: 
folder(Ruta,Nombre_carpeta,Creador,Carpeta):-string(Nombre_carpeta),
	date(Fecha_creacion),
	string_concat(Ruta,Nombre_carpeta,Nombre),
	string_concat(Nombre,"/",Nombre_ruta),
	Carpeta=[Nombre_ruta,Creador,Fecha_creacion,Fecha_creacion].

%SELECTORES
getNombreFolder([Nombre,_,_,_],Nombre).
getCreadorFolder([_,Creador,_,_],Creador).
getFechaCreacionFolder([_,_,Fecha_creacion,_],Fecha_creacion).
getFechaModificacionFolder([_,_,_,Fecha_mod],Fecha_mod).
getPrimeraCarpetaDrive([Carpeta|_],Carpeta).
getRestoCarpetasDrive([_|Carpetas],Carpetas).

%MODIFICADORES
cambiarFechaModificacion(Carpeta,Nueva_carpeta):-getNombreFolder(Carpeta,Nombre),
	getCreadorFolder(Carpeta,Creador),
	getFechaCreacionFolder(Carpeta,Fecha_c),
	date(Fecha_nueva),
	getArchivosFolder(Carpeta,Archivos),
	Nueva_carpeta=[Nombre,Creador,Fecha_c,Fecha_nueva,Archivos].

%OTRAS OPERACIONES
agregar_carpetas(Carpetas_old,Ruta,Creador,Nombre_carpeta,Carpetas_new):-folder(Ruta,Nombre_carpeta,Creador,Carpeta),
	insertarCola(Carpeta,Carpetas_old,Carpetas_new).

buscar_carpeta([[Nombre,_,_,_]|_],Nombre):-!.
buscar_carpeta([[_,_,_,_]|T],Nombre):-string(Nombre),
	buscar_carpeta(T,Nombre).

%##############################################################################
%------------------------------------------------------------------------------

%FUNCIONES PRINCIPALES

%predicado: 
%dominio: Name (string) x System
system(Name,System):-string(Name),
	date(Date),
	System=[Name,Date,"","","",[],[],[],[],[]],
	set_prolog_flag(answer_write_options,[max_depth(0)]),!.

%predicado:
%dominio: System x Letter (String) x Name (String) x Capacity (int) x System
systemAddDrive(SB,Letter,Name,Capacity,SA):-getNameSystem(SB,Name_system),
	getFechaSystem(SB,Fecha),
	getLetraSystem(SB,Letra),
	getUsuarioSystem(SB,Usuario),
	getRutaSystem(SB,Ruta),
	getDrives(SB,Drives),
	getCarpetas(SB,Carpetas),
	getArchivos(SB,Archivos),
	getUsers(SB,Users),
	getPapelera(SB,Papelera),
	string_lower(Letter,Letter_down),
	drive(Letter_down,Name,Capacity,Drive),
	not(buscar_drive(Drives,Letter_down)),
	insertarCola(Drive,Drives,NewDrives),
	folder("",Letter_down,Usuario,Carpeta),
	insertarCola(Carpeta,Carpetas,Carpetas_new),
	SA=[Name_system,Fecha,Letra,Usuario,Ruta,NewDrives,Carpetas_new,Archivos,Users,Papelera],
	set_prolog_flag(answer_write_options,[max_depth(0)]),!.

%predicado: 
%dominio: 
systemRegister(SB,UserName,SA):-getNameSystem(SB,Name_system),
	getFechaSystem(SB,Fecha),
	getLetraSystem(SB,Letra),
	getUsuarioSystem(SB,Usuario),
	getRutaSystem(SB,Ruta),
	getDrives(SB,Drives),
	getCarpetas(SB,Carpetas),
	getArchivos(SB,Archivos),
	getUsers(SB,Users),
	getPapelera(SB,Papelera),
	user(UserName,U),
	not(buscar_usuario(Users,UserName)),
	insertarCola(U,Users,NewUsers),
	SA=[Name_system,Fecha,Letra,Usuario,Ruta,Drives,Carpetas,Archivos,NewUsers,Papelera],
	set_prolog_flag(answer_write_options,[max_depth(0)]),!.

%predicados:
%dominio:
systemLogin(SB,UserName,SA):-getNameSystem(SB,Name_system),
	getFechaSystem(SB,Fecha),
	getLetraSystem(SB,Letra),
	getRutaSystem(SB,Ruta),
	getDrives(SB,Drives),
	getCarpetas(SB,Carpetas),
	getArchivos(SB,Archivos),
	getUsers(SB,Users),
	getPapelera(SB,Papelera),
	buscar_usuario(Users,UserName),
	no_sesion_iniciada(SB,""),
	SA=[Name_system,Fecha,Letra,UserName,Ruta,Drives,Carpetas,Archivos,Users,Papelera],
	set_prolog_flag(answer_write_options,[max_depth(0)]),!.
