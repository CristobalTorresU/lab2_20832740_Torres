%Clausulas Comunes
insertarCola(E,[],[E]).
insertarCola(E,[H|T],[H|Tout]):-insertarCola(E,T,Tout).

%eliminarElemento(Elemento,ListaEntrante,ListaSalida)
eliminarElemento(_,[],[]):-!.
eliminarElemento(E,[E|T],Tout):-eliminarElemento(E,T,Tout),!.
eliminarElemento(E,[H|T],[H|Tout]):-eliminarElemento(E,T,Tout).

%eliminarUltimoElemento(L1,L2).
eliminarUltimoElemento([_|[]],[]):-!.
eliminarUltimoElemento([H|T],[H|Tout]):-eliminarUltimoElemento(T,Tout).

%formarRuta(ListaNombres,Ruta).
formarRuta(L,R):-atomic_list_concat(L,"/",S1),string_concat(S1,"/",R).


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
%FILE

%constructor
file(Filename,Contenido,File):-string(Filename),
	string(Contenido),
	date(Fecha),
	File=[Filename,Contenido,Fecha].

fileRuta(File,Ruta,[Ruta,File]).

%selectores
getFilename([Filename,_,_],Filename).
getContenido([_,Contenido,_],Contenido).
getFechaCreacion([_,_,Fecha],Fecha).


%seleccionarArchivo(Name_d,Ruta,Archivos,File).

seleccionarArchivo(Nombre,Ruta,[[Ruta,[Nombre,Contenido,Fecha]]|_],Archivo):-Archivo=[Ruta,[Nombre,Contenido,Fecha]],!.
seleccionarArchivo(Nombre,Ruta,[_|T],Archivo):-seleccionarArchivo(Nombre,Ruta,T,Archivo).


%modificadores
%eliminarArchivo(Nombre,Ruta,Archivos,Archivos?).

eliminarArchivo(_,_,[],[]):-!.
eliminarArchivo(Nombre,Ruta,[[Ruta,[Nombre,_,_]]|T],Tout):-eliminarArchivo(Nombre,Ruta,T,Tout),!.
eliminarArchivo(Nombre,Ruta,[H|T],[H|Tout]):-eliminarArchivo(Nombre,Ruta,T,Tout).

modificarRutaArchivo([_,[Nombre,Contenido,Fecha]],Ruta,Archivo):-Archivo=[Ruta,[Nombre,Contenido,Fecha]].
actualizarFechaArchivo([Ruta,[Nombre,Contenido,_]],Archivo):-date(D),
	Archivo=[Ruta,[Nombre,Contenido,D]].

%modificarNombreArchivo(File,NewName,NewFile).
modificarNombreArchivo([Ruta,[_,Contenido,Fecha]],NewName,Archivo):-Archivo=[Ruta,[NewName,Contenido,Fecha]].

%otras_operaciones
buscar_archivo([[Ruta,[Filename,_,_]]|_],Ruta,Filename):-!.
buscar_archivo([[_,[_,_,_]]|T],Ruta,Filename):-string(Filename),
	string(Ruta),
	buscar_archivo(T,Ruta,Filename).

%seleccionarArchivoPorRuta(Ruta,ListaArchivos,ArchivosSeleccionados).

seleccionarArchivosPorRuta(_,[],[]):-!.
seleccionarArchivosPorRuta(Ruta1,[[Ruta2,_]|T],Tout):-Ruta1 \= Ruta2,seleccionarArchivosPorRuta(Ruta1,T,Tout),!.
seleccionarArchivosPorRuta(Ruta,[H|T],[H|Tout]):-seleccionarArchivosPorRuta(Ruta,T,Tout).

nombresArchivosRuta(_,[],_):-!.
nombresArchivosRuta(Ruta1,[[Ruta2,[Nombre,_,_]]|T],Tout):-Ruta1 \= Ruta2,insertarCola(Nombre,Tout,Tin),nombresArchivosRuta(Ruta1,T,Tin),!.
nombresArchivosRuta(Ruta,[H|T],[H|Tout]):-nombresArchivosRuta(Ruta,T,Tout).

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
	string_concat(Letter_down,":",Letter_d),
	folder("",Letter_d,Usuario,Carpeta),
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

%dominios:
%predicados:
systemLogout(SB,SA):-getNameSystem(SB,Name_system),
	getFechaSystem(SB,Fecha),
	getLetraSystem(SB,Letra),
	getRutaSystem(SB,Ruta),
	getDrives(SB,Drives),
	getCarpetas(SB,Carpetas),
	getArchivos(SB,Archivos),
	getUsers(SB,Users),
	getPapelera(SB,Papelera),
	SA=[Name_system,Fecha,Letra,"",Ruta,Drives,Carpetas,Archivos,Users,Papelera],
	set_prolog_flag(answer_write_options,[max_depth(0)]),!.

%dominios:
%predicados:
systemSwitchDrive(SB,Letter,SA):-getNameSystem(SB,Name_system),
	getFechaSystem(SB,Fecha),
	getLetraSystem(SB,Letra),
	getUsuarioSystem(SB,Usuario),
	getDrives(SB,Drives),
	getCarpetas(SB,Carpetas),
	getArchivos(SB,Archivos),
	getUsers(SB,Users),
	getPapelera(SB,Papelera),
	string_lower(Letter,Letter_down),
	string_concat(Letter_down,":/",Ruta),
	buscar_drive(Drives,Letter_down),
	not(buscar_drive(Drives,Letra)),
	SA=[Name_system,Fecha,Letter_down,Usuario,Ruta,Drives,Carpetas,Archivos,Users,Papelera],
	set_prolog_flag(answer_write_options,[max_depth(0)]),!.

%dominios:
%predicados:
systemMkdir(SB,Name,SA):-getNameSystem(SB,Name_system),
	getFechaSystem(SB,Fecha),
	getLetraSystem(SB,Letra),
	getUsuarioSystem(SB,Usuario),
	getRutaSystem(SB,Ruta),
	getDrives(SB,Drives),
	getCarpetas(SB,Carpetas),
	getArchivos(SB,Archivos),
	getUsers(SB,Users),
	getPapelera(SB,Papelera),
	string_lower(Name,Name_down),
	string_concat(Ruta,Name_down,Nombre_carpeta),
	string_concat(Nombre_carpeta,"/",Name_ruta),
	not(buscar_carpeta(Carpetas,Name_ruta)),
	folder(Ruta,Name_down,Usuario,Carpeta),
	insertarCola(Carpeta,Carpetas,Carpetas_new),
	SA=[Name_system,Fecha,Letra,Usuario,Ruta,Drives,Carpetas_new,Archivos,Users,Papelera],
	set_prolog_flag(answer_write_options,[max_depth(0)]),!.

%dominios:
%predicados:

%Para devolverse
systemCd(SB,"..",SA):-getNameSystem(SB,Name_system),
	getFechaSystem(SB,Fecha),
	getLetraSystem(SB,Letra),
	getUsuarioSystem(SB,Usuario),
	getRutaSystem(SB,Ruta),
	getDrives(SB,Drives),
	getCarpetas(SB,Carpetas),
	getArchivos(SB,Archivos),
	getUsers(SB,Users),
	getPapelera(SB,Papelera),
	split_string(Ruta,"/","/",Ruta2),
	length(Ruta2,LargoRuta),
	LargoRuta > 1,
	eliminarUltimoElemento(Ruta2,Ruta3),
	formarRuta(Ruta3,Ruta4),
	SA=[Name_system,Fecha,Letra,Usuario,Ruta4,Drives,Carpetas,Archivos,Users,Papelera],
	set_prolog_flag(answer_write_options,[max_depth(0)]),!.

%Para devolverse a Root
systemCd(SB,"/",SA):-getNameSystem(SB,Name_system),
	getFechaSystem(SB,Fecha),
	getLetraSystem(SB,Letra),
	getUsuarioSystem(SB,Usuario),
	getDrives(SB,Drives),
	getCarpetas(SB,Carpetas),
	getArchivos(SB,Archivos),
	getUsers(SB,Users),
	getPapelera(SB,Papelera),
	string_concat(Letra,":/",NewRuta),
	SA=[Name_system,Fecha,Letra,Usuario,NewRuta,Drives,Carpetas,Archivos,Users,Papelera],
	set_prolog_flag(answer_write_options,[max_depth(0)]),!.

%VERSIÓN_SIMPLE
systemCd(SB,Name,SA):-getNameSystem(SB,Name_system),
	getFechaSystem(SB,Fecha),
	getLetraSystem(SB,Letra),
	getUsuarioSystem(SB,Usuario),
	getRutaSystem(SB,Ruta),
	getDrives(SB,Drives),
	getCarpetas(SB,Carpetas),
	getArchivos(SB,Archivos),
	getUsers(SB,Users),
	getPapelera(SB,Papelera),
	string_lower(Name,Name_down),
	string_concat(Ruta,Name_down,Nombre_carpeta),
	string_concat(Nombre_carpeta,"/",Name_ruta),
	buscar_carpeta(Carpetas,Name_ruta),
	SA=[Name_system,Fecha,Letra,Usuario,Name_ruta,Drives,Carpetas,Archivos,Users,Papelera],
	set_prolog_flag(answer_write_options,[max_depth(0)]),!.

%dominios:
%predicados:
systemAddFile(SB,File,SA):-getNameSystem(SB,Name_system),
	getFechaSystem(SB,Fecha),
	getLetraSystem(SB,Letra),
	getUsuarioSystem(SB,Usuario),
	getRutaSystem(SB,Ruta),
	getDrives(SB,Drives),
	getCarpetas(SB,Carpetas),
	getArchivos(SB,Archivos),
	getUsers(SB,Users),
	getPapelera(SB,Papelera),
	getFilename(File,Filename),
	not(buscar_archivo(Archivos,Ruta,Filename)),
	fileRuta(File,Ruta,FileRuta),
	insertarCola(FileRuta,Archivos,Archivos_new),
	SA=[Name_system,Fecha,Letra,Usuario,Ruta,Drives,Carpetas,Archivos_new,Users,Papelera],
	set_prolog_flag(answer_write_options,[max_depth(0)]),!.
