%MODULOS
:-use_module(system_20832740_TorresUndurraga).
:-use_module(drive_20832740_TorresUndurraga).
:-use_module(folder_20832740_TorresUndurraga).
:-use_module(user_20832740_TorresUndurraga).
:-use_module(file_20832740_TorresUndurraga).

%##############################################################################

%CLASULAS EXTRAS

%insertarCola(Elemento,ListaEntrante,ListaSalida).
insertarCola(E,[],[E]).
insertarCola(E,[H|T],[H|Tout]):-insertarCola(E,T,Tout).

%eliminarElemento(Elemento,ListaEntrante,ListaSalida)
eliminarElemento(_,[],[]):-!.
eliminarElemento(E,[E|T],Tout):-eliminarElemento(E,T,Tout),!.
eliminarElemento(E,[H|T],[H|Tout]):-eliminarElemento(E,T,Tout).

%eliminarUltimoElemento(L1,L2).
eliminarUltimoElemento([_|[]],[]):-!.
eliminarUltimoElemento([H|T],[H|Tout]):-eliminarUltimoElemento(T,Tout).

%eliminarNelementos(LI,N,LR).
eliminarNelementos(0,T,T):-!.
eliminarNelementos(N,[_|T],Tout):-N > 0,Naux is N - 1,eliminarNelementos(Naux,T,Tout).

%formarRuta(ListaNombres,Ruta).
formarRuta(L,R):-atomic_list_concat(L,"/",S1),string_concat(S1,"/",R).

%sublista(L1,L2).
sublista(_,[]):-false.
sublista([],_):-!.
sublista([R1|T1],[R1|T2]):-sublista(T1,T2).

%insertarLista(L1,L2,LR).
insertarLista([],[],[]):-!.
insertarLista([H1|T1],[],[H1|T3]):-insertarLista(T1,[],T3),!.
insertarLista(L,[H2|T2],[H2|T3]):-insertarLista(L,T2,T3).

%ultimoElemento(Lista,Elemento).
ultimoElemento([T|[]],T):-!.
ultimoElemento([_|T],E):-ultimoElemento(T,E).

%invertir(Lista,ListaInvertida).
invertir([],[]):-!.
invertir(L,[Ultimo|T]):-ultimoElemento(L,Ultimo),eliminarUltimoElemento(L,LSinUltimo),invertir(LSinUltimo,T),!.

%##############################################################################

%REQUERIMIENTOS FUNCIONALES

%predicado: 
%dominio: Name (string) x System
system(Name,System):-string(Name),
	date(Date),
	System=[Name,Date,"","","",[],[],[],[],[]],
	set_prolog_flag(answer_write_options,[max_depth(0)]),!.

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
	Letter_down \= Letra,
	SA=[Name_system,Fecha,Letter_down,Usuario,Ruta,Drives,Carpetas,Archivos,Users,Papelera],
	set_prolog_flag(answer_write_options,[max_depth(0)]),!.

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

%SYSTEMCD
%RETROCEDER ".."
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

%VOLVER A ROOT "/"
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

%SIMPLE ########
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


%SYSTEMDEL

%CARPETAS
systemDel(SB,Name,SA):-getNameSystem(SB,Name_system),
	getFechaSystem(SB,Fecha),
	getLetraSystem(SB,Letra),
	getUsuarioSystem(SB,Usuario),
	getRutaSystem(SB,Ruta),
	getDrives(SB,Drives),
	getCarpetas(SB,Carpetas),
	getArchivos(SB,Archivos),
	getUsers(SB,Users),
	getPapelera(SB,Papelera),
	string_lower(Name,Name_d),
	string_concat(Ruta,Name_d,Ruta1),
	string_concat(Ruta1,"/",Ruta2),
	buscar_carpeta(Carpetas,Ruta2),
	split_string(Ruta2,"/","/",RutaLista),
	carpetasPorRuta(RutaLista,Carpetas,CarpetasPorEliminar),
	archivosPorRuta(RutaLista,Archivos,ArchivosPorEliminar),
	noCarpetasPorRuta(RutaLista,Carpetas,CarpetasDejar),
	noArchivosPorRuta(RutaLista,Archivos,ArchivosDejar),
	insertarCarpetas(CarpetasPorEliminar,Papelera,Papelera2),
	insertarArchivos(ArchivosPorEliminar,Papelera2,Papelera3),
	SA=[Name_system,Fecha,Letra,Usuario,Ruta,Drives,CarpetasDejar,ArchivosDejar,Users,Papelera3],
	set_prolog_flag(answer_write_options,[max_depth(0)]),!.

%ARCHIVOS
systemDel(SB,Name,SA):-getNameSystem(SB,Name_system),
	getFechaSystem(SB,Fecha),
	getLetraSystem(SB,Letra),
	getUsuarioSystem(SB,Usuario),
	getRutaSystem(SB,Ruta),
	getDrives(SB,Drives),
	getCarpetas(SB,Carpetas),
	getArchivos(SB,Archivos),
	getUsers(SB,Users),
	getPapelera(SB,Papelera),
	string_lower(Name,Name_d),
	buscar_archivo(Archivos,Ruta,Name_d),
	eliminarArchivo(Name_d,Ruta,Archivos,NewArchivos),
	seleccionarArchivo(Name_d,Ruta,Archivos,File),
	insertarCola(File,Papelera,NewPapelera),
	SA=[Name_system,Fecha,Letra,Usuario,Ruta,Drives,Carpetas,NewArchivos,Users,NewPapelera],
	set_prolog_flag(answer_write_options,[max_depth(0)]),!.

%SYSTEMCOPY

%CARPETAS
systemCopy(SB,Source,TargetPath,SA):-getNameSystem(SB,Name_system),
	getFechaSystem(SB,Fecha),
	getLetraSystem(SB,Letra),
	getUsuarioSystem(SB,Usuario),
	getRutaSystem(SB,Ruta),
	getDrives(SB,Drives),
	getCarpetas(SB,Carpetas),
	getArchivos(SB,Archivos),
	getUsers(SB,Users),
	getPapelera(SB,Papelera),
	string_lower(Source,Source_d),
	string_lower(TargetPath,TargetPath_d),
	string_concat(Ruta,Source_d,RutaSource1),
	string_concat(RutaSource1,"/",RutaSource2),
	buscar_carpeta(Carpetas,RutaSource2),
	buscar_carpeta(Carpetas,TargetPath_d),
	string_concat(TargetPath_d,Source_d,TPD),
	string_concat(TPD,"/",Target),
	not(buscar_carpeta(Carpetas,Target)),
	split_string(RutaSource2,"/","/",RutaLista),
	carpetasPorRuta(RutaLista,Carpetas,CarpetasPorCopiar),
	archivosPorRuta(RutaLista,Archivos,ArchivosPorCopiar),
	split_string(Target,"/","/",TargetLista),
	length(RutaLista,N),
	modificarRutasCarpetas(TargetLista,N,CarpetasPorCopiar,CarpetasListas),
	modificarRutasArchivos(TargetLista,N,ArchivosPorCopiar,ArchivosListos),
	insertarCarpetas(CarpetasListas,Carpetas,NewCarpetas),
	insertarArchivos(ArchivosListos,Archivos,NewArchivos),
	SA=[Name_system,Fecha,Letra,Usuario,Ruta,Drives,NewCarpetas,NewArchivos,Users,Papelera],
	set_prolog_flag(answer_write_options,[max_depth(0)]),!.

%ARCHIVOS
systemCopy(SB,Source,TargetPath,SA):-getNameSystem(SB,Name_system),
	getFechaSystem(SB,Fecha),
	getLetraSystem(SB,Letra),
	getUsuarioSystem(SB,Usuario),
	getRutaSystem(SB,Ruta),
	getDrives(SB,Drives),
	getCarpetas(SB,Carpetas),
	getArchivos(SB,Archivos),
	getUsers(SB,Users),
	getPapelera(SB,Papelera),
	string_lower(Source,Source_d),
	string_lower(TargetPath,TargetPath_d),
	buscar_archivo(Archivos,Ruta,Source_d),
	buscar_carpeta(Carpetas,TargetPath_d),
	not(buscar_archivo(Archivos,TargetPath_d,Source_d)),
	seleccionarArchivo(Source_d,Ruta,Archivos,File),
	modificarRutaArchivo(File,TargetPath_d,File2),
	actualizarFechaArchivo(File2,File3),
	insertarCola(File3,Archivos,NewArchivos),
	SA=[Name_system,Fecha,Letra,Usuario,Ruta,Drives,Carpetas,NewArchivos,Users,Papelera],
	set_prolog_flag(answer_write_options,[max_depth(0)]),!.

%SYSTEMMOVE

%ARREGLAR MOVERLA A SI MISMA

%CARPETAS
systemMove(SB,Source,TargetPath,SA):-getNameSystem(SB,Name_system),
	getFechaSystem(SB,Fecha),
	getLetraSystem(SB,Letra),
	getUsuarioSystem(SB,Usuario),
	getRutaSystem(SB,Ruta),
	getDrives(SB,Drives),
	getCarpetas(SB,Carpetas),
	getArchivos(SB,Archivos),
	getUsers(SB,Users),
	getPapelera(SB,Papelera),
	string_lower(Source,Source_d),
	string_lower(TargetPath,TargetPath_d),
	string_concat(Ruta,Source_d,RutaSource1),
	string_concat(RutaSource1,"/",RutaSource2),
	buscar_carpeta(Carpetas,RutaSource2),
	buscar_carpeta(Carpetas,TargetPath_d),
	string_concat(TargetPath_d,Source_d,TPD),
	string_concat(TPD,"/",Target),
	not(buscar_carpeta(Carpetas,Target)),
	split_string(RutaSource2,"/","/",RutaLista),
	carpetasPorRuta(RutaLista,Carpetas,CarpetasPorMover),
	archivosPorRuta(RutaLista,Archivos,ArchivosPorMover),
	split_string(Target,"/","/",TargetLista),
	length(RutaLista,N),
	noCarpetasPorRuta(RutaLista,Carpetas,CarpetasPorUsar),
	noArchivosPorRuta(RutaLista,Archivos,ArchivosPorUsar),
	modificarRutasCarpetas(TargetLista,N,CarpetasPorMover,CarpetasListas),
	modificarRutasArchivos(TargetLista,N,ArchivosPorMover,ArchivosListos),
	insertarCarpetas(CarpetasListas,CarpetasPorUsar,NewCarpetas),
	insertarArchivos(ArchivosListos,ArchivosPorUsar,NewArchivos),
	SA=[Name_system,Fecha,Letra,Usuario,Ruta,Drives,NewCarpetas,NewArchivos,Users,Papelera],
	set_prolog_flag(answer_write_options,[max_depth(0)]),!.

%ARCHIVOS
systemMove(SB,Source,TargetPath,SA):-getNameSystem(SB,Name_system),
	getFechaSystem(SB,Fecha),
	getLetraSystem(SB,Letra),
	getUsuarioSystem(SB,Usuario),
	getRutaSystem(SB,Ruta),
	getDrives(SB,Drives),
	getCarpetas(SB,Carpetas),
	getArchivos(SB,Archivos),
	getUsers(SB,Users),
	getPapelera(SB,Papelera),
	string_lower(Source,Source_d),
	string_lower(TargetPath,TargetPath_d),
	buscar_archivo(Archivos,Ruta,Source_d),
	buscar_carpeta(Carpetas,TargetPath_d),
	not(buscar_archivo(Archivos,TargetPath_d,Source_d)),
	seleccionarArchivo(Source_d,Ruta,Archivos,File),
	modificarRutaArchivo(File,TargetPath_d,File2),
	actualizarFechaArchivo(File2,File3),
	eliminarArchivo(Source_d,Ruta,Archivos,Archivos_eliminado),
	insertarCola(File3,Archivos_eliminado,NewArchivos),
	SA=[Name_system,Fecha,Letra,Usuario,Ruta,Drives,Carpetas,NewArchivos,Users,Papelera],
	set_prolog_flag(answer_write_options,[max_depth(0)]),!.


%SYSTEMREN

%CARPETAS
systemRen(SB,CurrentName,NewName,SA):-getNameSystem(SB,Name_system),
	getFechaSystem(SB,Fecha),
	getLetraSystem(SB,Letra),
	getUsuarioSystem(SB,Usuario),
	getRutaSystem(SB,Ruta),
	getDrives(SB,Drives),
	getCarpetas(SB,Carpetas),
	getArchivos(SB,Archivos),
	getUsers(SB,Users),
	getPapelera(SB,Papelera),
	string_lower(CurrentName,CurrentName_d),
	string_lower(NewName,NewName_d),
	string_concat(Ruta,CurrentName_d,Ruta1),
	string_concat(Ruta1,"/",Ruta2),
	buscar_carpeta(Carpetas,Ruta2),
	string_concat(Ruta,NewName_d,NewName2),
	string_concat(NewName2,"/",NewName3),
	not(buscar_carpeta(Carpetas,NewName3)),
	split_string(Ruta2,"/","/",RutaLista),
	carpetasPorRuta(RutaLista,Carpetas,CarpetasPorModificar),
	archivosPorRuta(RutaLista,Archivos,ArchivosPorModificar),
	split_string(NewName3,"/","/",ListaNewName),
	length(RutaLista,N),
	noCarpetasPorRuta(RutaLista,Carpetas,CarpetasPorUsar),
	noArchivosPorRuta(RutaLista,Archivos,ArchivosPorUsar),
	modificarRutasCarpetas(ListaNewName,N,CarpetasPorModificar,CarpetasListas),
	modificarRutasArchivos(ListaNewName,N,ArchivosPorModificar,ArchivosListos),
	insertarCarpetas(CarpetasListas,CarpetasPorUsar,NewCarpetas),
	insertarArchivos(ArchivosListos,ArchivosPorUsar,NewArchivos),
	SA=[Name_system,Fecha,Letra,Usuario,Ruta,Drives,NewCarpetas,NewArchivos,Users,Papelera],
	set_prolog_flag(answer_write_options,[max_depth(0)]),!.

%ARCHIVOS
systemRen(SB,CurrentName,NewName,SA):-getNameSystem(SB,Name_system),
	getFechaSystem(SB,Fecha),
	getLetraSystem(SB,Letra),
	getUsuarioSystem(SB,Usuario),
	getRutaSystem(SB,Ruta),
	getDrives(SB,Drives),
	getCarpetas(SB,Carpetas),
	getArchivos(SB,Archivos),
	getUsers(SB,Users),
	getPapelera(SB,Papelera),
	string_lower(CurrentName,CurrentName_d),
	string_lower(NewName,NewName_d),
	buscar_archivo(Archivos,Ruta,CurrentName_d),
	not(buscar_archivo(Archivos,Ruta,NewName_d)),
	seleccionarArchivo(CurrentName_d,Ruta,Archivos,File),
	modificarNombreArchivo(File,NewName_d,NewFile),
	eliminarArchivo(CurrentName_d,Ruta,Archivos,Archivos_eliminado),
	insertarCola(NewFile,Archivos_eliminado,NewArchivos),
	SA=[Name_system,Fecha,Letra,Usuario,Ruta,Drives,Carpetas,NewArchivos,Users,Papelera],
	set_prolog_flag(answer_write_options,[max_depth(0)]),!.


%SYSTEMDIR

%VERSIÓN_SIMPLE
systemDir(Sys,[],String):-getRutaSystem(Sys,Ruta),
	getCarpetas(Sys,Carpetas),
	getArchivos(Sys,Archivos),
	split_string(Ruta,"/","/",RutaLista),
	length(RutaLista,N),
	carpetasPorRuta(RutaLista,Carpetas,CarpetasSeleccionadas),
	subdirectoriosDirectos(CarpetasSeleccionadas,N,ListaNombresCarpetas),
	nombresArchivosRuta(Ruta,Archivos,ListaNombresArchivos),
	insertarLista(ListaNombresArchivos,ListaNombresCarpetas,ListaNombres),
	oculto(ListaNombres,ListaNoOcultos),
	atomic_list_concat(ListaNoOcultos,"\n",String_atomo1),
	atom_string(String_atomo1,StringN),
	string_concat("\n",StringN,String),
	set_prolog_flag(answer_write_options,[max_depth(0)]),!.

%Opción: "/a"
systemDir(Sys,["/a"],String):-getRutaSystem(Sys,Ruta),
	getCarpetas(Sys,Carpetas),
	getArchivos(Sys,Archivos),
	split_string(Ruta,"/","/",RutaLista),
	length(RutaLista,N),
	carpetasPorRuta(RutaLista,Carpetas,CarpetasSeleccionadas),
	subdirectoriosDirectos(CarpetasSeleccionadas,N,ListaNombresCarpetas),
	nombresArchivosRuta(Ruta,Archivos,ListaNombresArchivos),
	insertarLista(ListaNombresArchivos,ListaNombresCarpetas,ListaNombres),
	atomic_list_concat(ListaNombres,"\n",String_atomo1),
	atom_string(String_atomo1,StringN),
	string_concat("\n",StringN,String),
	set_prolog_flag(answer_write_options,[max_depth(0)]),!.

/*
%Opción: "/s"
systemDir(Sys,["/s"],String):-getRutaSystem(Sys,Ruta),
	getCarpetas(Sys,Carpetas),
	getArchivos(Sys,Archivos),
	
	split_string(Ruta,"/","/",RutaLista),
	length(RutaLista,N),
	carpetasPorRuta(RutaLista,Carpetas,CarpetasSeleccionadas),
	%archivosPorRuta(RutaLista,Archivos,ArchivosPorMover),

	subdirectoriosDirectos(CarpetasSeleccionadas,N,ListaNombresCarpetas),

	nombresArchivosRuta(Ruta,Archivos,ListaNombresArchivos),
	insertarLista(ListaNombresArchivos,ListaNombresCarpetas,ListaNombres),
	atomic_list_concat(ListaNombres,"\n",String_atomo1),
	atom_string(String_atomo1,StringN),
	string_concat("\n",StringN,String),
	
	%String = [Carpetas1],
	set_prolog_flag(answer_write_options,[max_depth(0)]),!.

*/
/*
%Opción: "/s /a"
systemDir(Sys,["/s"],String):-getRutaSystem(Sys,Ruta),
	getCarpetas(Sys,Carpetas),
	getArchivos(Sys,Archivos),
	
	split_string(Ruta,"/","/",RutaLista),
	length(RutaLista,N),
	carpetasPorRuta(RutaLista,Carpetas,CarpetasSeleccionadas),
	%archivosPorRuta(RutaLista,Archivos,ArchivosPorMover),

	subdirectoriosDirectos(CarpetasSeleccionadas,N,ListaNombresCarpetas),

	nombresArchivosRuta(Ruta,Archivos,ListaNombresArchivos),
	insertarLista(ListaNombresArchivos,ListaNombresCarpetas,ListaNombres),
	atomic_list_concat(ListaNombres,"\n",String_atomo1),
	atom_string(String_atomo1,StringN),
	string_concat("\n",StringN,String),
	
	%String = [Carpetas1],
	set_prolog_flag(answer_write_options,[max_depth(0)]),!.
*/

%Opción: "/o N"
systemDir(Sys,["/o N"],String):-getRutaSystem(Sys,Ruta),
	getCarpetas(Sys,Carpetas),
	getArchivos(Sys,Archivos),
	split_string(Ruta,"/","/",RutaLista),
	length(RutaLista,N),
	carpetasPorRuta(RutaLista,Carpetas,CarpetasSeleccionadas),
	subdirectoriosDirectos(CarpetasSeleccionadas,N,ListaNombresCarpetas),
	nombresArchivosRuta(Ruta,Archivos,ListaNombresArchivos),
	insertarLista(ListaNombresArchivos,ListaNombresCarpetas,ListaNombres),
	oculto(ListaNombres,ListaNoOcultos),
	sort(ListaNoOcultos,ListaNombresFinal),
	atomic_list_concat(ListaNombresFinal,"\n",String_atomo1),
	atom_string(String_atomo1,StringN),
	string_concat("\n",StringN,String),
	set_prolog_flag(answer_write_options,[max_depth(0)]),!.

%Opción: "/o -N"
systemDir(Sys,["/o -N"],String):-getRutaSystem(Sys,Ruta),
	getCarpetas(Sys,Carpetas),
	getArchivos(Sys,Archivos),
	split_string(Ruta,"/","/",RutaLista),
	length(RutaLista,N),
	carpetasPorRuta(RutaLista,Carpetas,CarpetasSeleccionadas),
	subdirectoriosDirectos(CarpetasSeleccionadas,N,ListaNombresCarpetas),
	nombresArchivosRuta(Ruta,Archivos,ListaNombresArchivos),
	insertarLista(ListaNombresArchivos,ListaNombresCarpetas,ListaNombres),
	oculto(ListaNombres,ListaNoOcultos),
	sort(ListaNoOcultos,ListaOrdenada),
	invertir(ListaOrdenada,ListaInvertida),
	atomic_list_concat(ListaInvertida,"\n",String_atomo1),
	atom_string(String_atomo1,StringN),
	string_concat("\n",StringN,String),
	set_prolog_flag(answer_write_options,[max_depth(0)]),!.


%SYSTEMFORMAT

%Formatea la unidad actual
systemFormat(SB,Letter,Name,SA):-getNameSystem(SB,Name_system),
	getFechaSystem(SB,Fecha),
	getLetraSystem(SB,Letra),
	getUsuarioSystem(SB,Usuario),
	getDrives(SB,Drives),
	getCarpetas(SB,Carpetas),
	getArchivos(SB,Archivos),
	getUsers(SB,Users),
	getPapelera(SB,Papelera),
	string_lower(Letter,Letra),
	buscar_drive(Drives,Letra),
	string_concat(Letra,":/",Root),
	split_string(Root,"/","/",RutaLista),
	noCarpetasPorRuta(RutaLista,Carpetas,CarpetasSinUnidad),
	noArchivosPorRuta(RutaLista,Archivos,NewArchivos),
	seleccionarDrive(Letra,Drives,Unidad),
	getCapacidadDrive(Unidad,Size),
	eliminarDrive(Letra,Drives,UnidadesSinSeleccionado),
	drive(Letra,Name,Size,NuevaUnidad),
	folder(Letra,":",Usuario,RootFolder),
	insertarCola(NuevaUnidad,UnidadesSinSeleccionado,NewDrives),
	insertarCola(RootFolder,CarpetasSinUnidad,NewCarpetas),
	SA=[Name_system,Fecha,Letra,Usuario,Root,NewDrives,NewCarpetas,NewArchivos,Users,Papelera],
	set_prolog_flag(answer_write_options,[max_depth(0)]),!.

%Formatea otra unidad
systemFormat(SB,Letter,Name,SA):-getNameSystem(SB,Name_system),
	getFechaSystem(SB,Fecha),
	getLetraSystem(SB,Letra),
	getUsuarioSystem(SB,Usuario),
	getRutaSystem(SB,Ruta),
	getDrives(SB,Drives),
	getCarpetas(SB,Carpetas),
	getArchivos(SB,Archivos),
	getUsers(SB,Users),
	getPapelera(SB,Papelera),
	string_lower(Letter,Letter_d),
	Letter_d \= Letra,
	buscar_drive(Drives,Letter_d),
	string_concat(Letter_d,":/",Root),
	split_string(Root,"/","/",RutaLista),
	noCarpetasPorRuta(RutaLista,Carpetas,CarpetasSinUnidad),
	noArchivosPorRuta(RutaLista,Archivos,NewArchivos),
	seleccionarDrive(Letter_d,Drives,Unidad),
	getCapacidadDrive(Unidad,Size),
	eliminarDrive(Letter_d,Drives,UnidadesSinSeleccionado),
	drive(Letter_d,Name,Size,NuevaUnidad),
	folder(Letter_d,":",Usuario,RootFolder),
	insertarCola(NuevaUnidad,UnidadesSinSeleccionado,NewDrives),
	insertarCola(RootFolder,CarpetasSinUnidad,NewCarpetas),
	SA=[Name_system,Fecha,Letra,Usuario,Ruta,NewDrives,NewCarpetas,NewArchivos,Users,Papelera],
	set_prolog_flag(answer_write_options,[max_depth(0)]),!.
