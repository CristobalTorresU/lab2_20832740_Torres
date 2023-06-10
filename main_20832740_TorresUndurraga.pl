%MÓDULOS
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

/*
Predicados:
system(SA,Name,SB).
systemAddDrive(SA,Letter,Name,Capacity,SB).
systemRegister(SA,UserName,SB).
systemLogin(SA,UserName,SB).
systemLogout(SA,SB).
systemSwitchDrive(SA,Letter,SB).
systemMkdir(SA,Name,SB).
systemCd(SA,Name,SB).
systemAddFile(SA,File,SB).
systemDel(SA,Name,SB).
systemCopy(SA,Source,TargetPath,SB).
systemMove(SA,Source,TargetPath,SB).
systemRen(SA,CurrentName,NewName,SB).
systemDir(SA,Params,String).
systemFormat(SA,Letter,SB).
get_time(Date).
getNameSystem(System,Name).
getFechaSystem(System,Fecha).
getLetraSystem(System,Letra).
getUsuarioSystem(System,Usuario).
getRutaSystem(System,Ruta).
getDrives(System,Drives).
getCarpetas(System,Carpetas).
getArchivos(System,Archivos).
getUsers(System,Users).
getPapelera(System,Papelera).
drive(Letra,Nombre_Unidad,Capacidad,Drive).
buscar_drive(Drives,Letra).
insertarCola(Elemento,ListaEntrante,ListaSalida).
folder(Ruta,Nombre_carpeta,Creador,Carpeta).
user(Nombre,User).
buscar_usuario(Usuarios,Username).
buscar_carpeta(Carpetas,Nombre).
eliminarUltimoElemento(L1,L2).
formarRuta(ListaNombres,Ruta).
fileRuta(File,Ruta,FileRuta).
carpetasPorRuta(Ruta,Carpetas,ListaCarpetasNuevas).
archivosPorRuta(Ruta,Archivos,ListaArchivosNuevos).
noCarpetasPorRuta(Ruta,Carpetas,ListaCarpetasNuevas).
noArchivosPorRuta(Ruta,Archivos,ListaArchivosNuevos).
insertarCarpetas(ListaCarpetasNuevas,ListaCarpetasOriginales,ListaCarpetas).
insertarArchivos(ListaArchivosNuevos,ListaArchivosOriginales,ListaArchivos).
eliminarArchivo(Nombre,Ruta,Archivos,Archivos).
seleccionarArchivoPorRuta(Ruta,ListaArchivos,ArchivosSeleccionados).
modificarRutasCarpetas(ListaRutaNueva,N,ListaCarpetasOriginales,ListaNueva).
modificarRutasArchivos(LRN,N,FileEntrada,FilesSalida).
seleccionarArchivo(Name_d,Ruta,Archivos,File).
modificarRutaArchivo(File,Ruta,Archivo).
actualizarFechaArchivo(File,Ruta,Archivo).
modificarNombreArchivo(File,NewName,NewFile).
subdirectoriosDirectos(CarpetaOriginales,N,CarpetasSalida).
nombresArchivosRuta(Ruta,Files,Nombres).
insertarLista(L1,L2,LR).
oculto(Nombres,NombresResultantes).
invertir(Lista,ListaInvertida).
getCapacidadDrive(Drive,Capacidad).
eliminarDrive(Letra,Drives,DriveSalida).
*/
/*
Metas:
Principales:system,systemAddDrive,systemRegister,systemLogin,systemLogout,
	systemSwitchDrive,systemMkdir,systemCd,systemAddFile,systemDel,
	systemCopy,systemMove,systemRen,systemDir,systemFormat
Secundarias:get_time,getNameSystem,getFechaSystem,getLetraSystem,getUsuarioSystem,
	getRutaSystem,getDrives,getCarpetas,getArchivos,getUsers,getPapelera,drive,
	buscar_drive,insertarCola,folder,user,buscar_usuario,no_sesion_iniciada,
	buscar_carpeta,eliminarUltimoElemento,formarRuta,fileRuta,carpetaPorRuta,
	archivosPorRuta,noCarpetasPorRuta,noArchivosPorRuta,insertarCarpetas,
	insertarArchivos,eliminarArchivo,seleccionarArchivo,modificarRutasCarpetas,
	modificarRutasArchivos,seleccionarArchivo,modificarRutaArchivo,
	actualizarFechaArchivo,modificarNombreArchivo,subdirectoriosDirectos,
	nombresArchivosRuta,insertarLista,oculto,invertir,getCapacidadDrive,
	eliminarDrive.
*/

%REQUERIMIENTOS FUNCIONALES

%Descripción: Construye un system.
%dominio: Name (string) x System.
system(Name,System):-string(Name),
	date(Date),
	System=[Name,Date,"","","",[],[],[],[],[]],
	set_prolog_flag(answer_write_options,[max_depth(0)]),!.

%Descripción: Crea y agrega un drive a al sistema, siempre y cuando no exista uno con el mismo nombre.
%Dominios: SB (sytem) x SA (System).
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
	string_length(Letter_down,1),
	drive(Letter_down,Name,Capacity,Drive),
	not(buscar_drive(Drives,Letter_down)),
	insertarCola(Drive,Drives,NewDrives),
	string_concat(Letter_down,":",Letter_d),
	folder("",Letter_d,Usuario,Carpeta),
	insertarCola(Carpeta,Carpetas,Carpetas_new),
	SA=[Name_system,Fecha,Letra,Usuario,Ruta,NewDrives,Carpetas_new,Archivos,Users,Papelera],
	set_prolog_flag(answer_write_options,[max_depth(0)]),!.

%Descripción: Crea y registra un usuario en el sistema, siempre y cuando no exista otro usuario con el mismo nombre. Si el usuario ya existe, SB será igual a SA.
%Dominios: SB (sytem) x UserName (String) x SA (System).
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
	buscar_usuario(Users,UserName),
	SA=[Name_system,Fecha,Letra,Usuario,Ruta,Drives,Carpetas,Archivos,Users,Papelera],
	set_prolog_flag(answer_write_options,[max_depth(0)]),!.

%Descripción: Crea y registra un usuario en el sistema, siempre y cuando no exista otro usuario con el mismo nombre.
%Dominios: SB (sytem) x UserName (String) x SA (System).
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

%Descripción: Inicia sesión con el nombre de un usuario, siempre y cuando no exista otro usuario con la sesión iniciada.
%Dominios: SB (sytem) x UserName (String) x SA (System).
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
	SA=[Name_system,Fecha,Letra,UserName,Ruta,Drives,Carpetas,Archivos,Users,Papelera],
	set_prolog_flag(answer_write_options,[max_depth(0)]),!.

%Descripción: Cierra la sesión de un usuario en el sistema. No se puede cerrar sesión si no hay una sesión iniciada.
%Dominios: SB (sytem) x SA (System).
systemLogout(SB,SA):-getNameSystem(SB,Name_system),
	getFechaSystem(SB,Fecha),
	getLetraSystem(SB,Letra),
	getRutaSystem(SB,Ruta),
	getUsuarioSystem(SB,Usuario),
	getDrives(SB,Drives),
	getCarpetas(SB,Carpetas),
	getArchivos(SB,Archivos),
	getUsers(SB,Users),
	getPapelera(SB,Papelera),
	Usuario \= "",
	SA=[Name_system,Fecha,Letra,"",Ruta,Drives,Carpetas,Archivos,Users,Papelera],
	set_prolog_flag(answer_write_options,[max_depth(0)]),!.

%Descripción: Fija la unidad en la que el usuario realizara las acciones. Debe existir una sesión iniciada para ejecutarse.
%Dominios: SB (sytem) x Letter (String) x SA (System).
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

%Descripción: Crea y agrega un directorio al sistema, siempre y cuando no exista otro directorio con el mismo nombre en la misma ruta.
%Dominios: SB (sytem) x Name (String) x SA (System).
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

%Descripción: Cambia la ruta actual del sistema por medio de un nombre. Esta regla devuelve al sistema a la carpeta padre.
%Dominios: SB (sytem) x Name (String) x SA (System).
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

%Descripción: Cambia la ruta actual del sistema por medio de un nombre. Esta regla devuelve al sistema a la carpeta root del drive.
%Dominios: SB (sytem) x Name (String) x SA (System).
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

%Descripción: Cambia la ruta actual del sistema por medio de un nombre.
%Dominios: SB (sytem) x Name (String) x SA (System).
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

/*
HACER CLAUSULA QUE BUSQUE EL NOMBRE DEL ARCHIVO Y VERIFIQUE SI TIENE EL MISMO NOMBRE
%Descripción: Añade un archivo al sistema, siempre y cuando el nombre del archivo no exista en la misma ruta.
%Dominios: SB (sytem) x File x SA (System).
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
	buscar_archivo(Archivos,Ruta,Filename),
	seleccionarArchivo(Filename,Ruta,Archivos,FileOld),
	eliminarArchivo(Filename,Ruta,Archivos,ArchivosSinEliminado),
	insertarCola(FileRuta,Archivos,Archivos_new),
	SA=[Name_system,Fecha,Letra,Usuario,Ruta,Drives,Carpetas,Archivos_new,Users,Papelera],
	set_prolog_flag(answer_write_options,[max_depth(0)]),!.
*/

%Descripción: Añade un archivo al sistema, siempre y cuando el nombre del archivo no exista en la misma ruta.
%Dominios: SB (sytem) x File x SA (System).
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

%Descripción: 
%Dominios: SB (sytem) x Name (String) x SA (System).
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

%Descripción: 
%Dominios: SB (sytem) x Name (String) x SA (System).
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

%Descripción: Copia un archivo o carpeta desde una ruta origen a una ruta destino. Esta regla funciona para carpetas.
%Dominios: SB (sytem) x Source (String) x TargetPath (String) x SA (System).
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

%Descripción: Copia un archivo o carpeta desde una ruta origen a una ruta destino. Esta regla funciona solo para archivos.
%Dominios: SB (sytem) x Source (String) x TargetPath (String) x SA (System).
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

%Descripción: Mueve un archivo o carpeta desde una ruta origen a una ruta destino. Esta regla funciona para carpetas.
%Dominios: SB (sytem) x Source (String) x TargetPath (String) x SA (System).
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

%Descripción: Mueve un archivo o carpeta desde una ruta origen a una ruta destino. Esta regla funciona solo para archivos.
%Dominios: SB (sytem) x Source (String) x TargetPath (String) x SA (System).
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

%Descripción: Renombra una carpeta o archivo que no viole la restricción de unicidad. Esta regla funciona para carpetas.
%Dominios: SB (sytem) x CurrentName (String) x NewName (String) x SA (System).
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

%Descripción: Renombra una carpeta o archivo que no viole la restricción de unicidad. Esta regla funciona solo para archivos.
%Dominios: SB (sytem) x CurrentName (String) x NewName (String) x SA (System).
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

%Descripción: 
%Dominios: SB (sytem) x 
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

%Descripción: 
%Dominios: SB (sytem) x 
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
%Descripción: 
%Dominios: SB (sytem) x 
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
%Descripción: 
%Dominios: SB (sytem) x
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
%Descripción: 
%Dominios: SB (sytem) x 
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
%Descripción: 
%Dominios: SB (sytem) x 
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

%Descripción: Formatea una unidad dada su letra y cambia su nombre. Esta regla es cuando se formatea una unidad que es la actual.
%Dominios: SB (sytem) x Letter (String) x Name (String) x SA (System).
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

%Descripción: Formatea una unidad dada su letra y cambia su nombre. Esta regla es cuando se formatea una unidad que no es la actual.
%Dominios: SB (sytem) x Letter (String) x Name (String) x SA (System).
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
