%MODULOS
:-module(file_20832740_TorresUndurraga,[file/3,fileRuta/3,getFilename/2,seleccionarArchivo/4,eliminarArchivo/4,modificarRutaArchivo/3,modificarNombreArchivo/3,buscar_archivo/3,seleccionarArchivosPorRuta/3,nombresArchivosRuta/3,archivosDeCarpetas/3,insertarArchivos/3,oculto/2,archivosPorRuta/3,noArchivosPorRuta/3,modificarRutasArchivos/4,archivosPorRutaTipo/4,buscar_archivos/2,modificarRutaArchivosDirecto/3,actualizarFechaArchivo/2,getFechaCreacionFileRuta/2,modificarFechaArchivo/3]).

%##############################################################################

%TDA file
/*
REPRESENTACIÓN:

*/
/*
Predicados:
file(Filename,Contenido,File).
fileRuta(File,Ruta,FileRuta).
getFilename(File,Filename).
getTipo(File,Tipo).
getContenido(File,Contenido).
getFechaCreacion(File,Fecha).
getFechaCreacionFileRuta(FileRuta,Fecha).
seleccionarArchivo(Name_d,Ruta,Archivos,File).
eliminarArchivo(Nombre,Ruta,Archivos,NewArchivos).
modificarRutaArchivo(File,Ruta,Archivo).
modificarNombreArchivo(File,NewName,NewFile).
buscar_archivo(FileRuta,Ruta,Filename).
seleccionarArchivoPorRuta(Ruta,ListaArchivos,ArchivosSeleccionados).
nombresArchivosRuta(Ruta,Files,Nombres).
archivosDeCarpetas(Carpetas,Archivos,NewArchivos).
insertarArchivos(ListaArchivosNuevos,ListaArchivosOriginales,ListaArchivos).
oculto(Nombres,NombresResultantes).
archivosPorRuta(Ruta,Archivos,ListaArchivosNuevos).
noArchivosPorRuta(Ruta,Archivos,ListaArchivosNuevos).
modificarRutasArchivos(LRN,N,FileEntrada,FilesSalida).
actualizarFechaArchivo(File,Ruta,Archivo).
modificarFechaArchivo().
*/
/*
Metas:
Principales: fileRuta
Secundarias: file,getFilename,getContenido,getFechaCreacion,
	seleccionarArchivo,eliminarArchivo,modificarRutaArchivo,
	modificarNombreArchivo,buscar_archivo,seleccionarArchivoPorRuta,
	nombresArchivosRuta,archivosDeCarpetas,insertarArchivos,oculto,
	archivosPorRuta,noArchivosPorRuta,modificarRutasArchivos,
	actualizarFechaArchivo,modificarFechaArchivo.
*/

%CONSTRUCTORES
%Descripción: Construye un file (archivo).
%Dominios: Filename (String) x Contenido (String) x File
file(Filename,Contenido,File):-string(Filename),
	string(Contenido),
	get_time(Fecha),
	string_lower(Filename,Filename_d),
	split_string(Filename_d,".",".",[_,Tipo]),
	File=[Filename_d,Tipo,Contenido,Fecha].

%Descripción: Construye un file con la una ruta asociada.
%Dominios: File x Ruta (String) x FileRuta
fileRuta(File,Ruta,[Ruta,File]).


%SELECTORES

%Descripción: Selecciona el nombre un archivo.
%Dominios: File x Filename (String).
getFilename([Filename,_,_,_],Filename).

%Descripción: Selecciona el tipo de un archivo.
%Dominios: File x Tipo (String).
getTipo([_,Tipo,_,_],Tipo).

%Descripción: Selecciona el contenido un archivo.
%Dominios: File x Contenido (String).
getContenido([_,_,Contenido,_],Contenido).

%Descripción: Selecciona la fecha de creación de un archivo.
%Dominios: File x Fecha (Number).
getFechaCreacion([_,_,_,Fecha],Fecha).

%Descripción: Selecciona la fecha de creación de un archivo con su ruta.
%Dominios: File x Fecha (Number).
getFechaCreacionFileRuta([_,[_,_,_,Fecha]],Fecha).


%MODIFICADORES

%Descripción: Elimina un archivo desde la lista de archivos.
%Dominios: Nombre (String) x Ruta (String) x Files (Lista de archivos) x NewFiles (Lista de archivos).
eliminarArchivo(_,_,[],[]):-!.
eliminarArchivo(Nombre,Ruta,[[Ruta,[Nombre,_,_,_]]|T],Tout):-eliminarArchivo(Nombre,Ruta,T,Tout),!.
eliminarArchivo(Nombre,Ruta,[H|T],[H|Tout]):-eliminarArchivo(Nombre,Ruta,T,Tout).

%Descripción: Cambia la ruta de un fileRuta.
%Dominios: File x Ruta (String) x Archivo (File).
modificarRutaArchivo([_,[Nombre,Tipo,Contenido,_]],Ruta,Archivo):-get_time(Date),Archivo=[Ruta,[Nombre,Tipo,Contenido,Date]].

%Descripción: Modifica la fecha de un archivo.
%Dominios: Fecha (Number) x FileEntrada x FileSalida (File).
modificarFechaArchivo(Fecha,[Nombre,Tipo,Contenido,_],[Nombre,Tipo,Contenido,Fecha]).

%Descripción: Modifica la fecha de un archivo.
%Dominios: FileEntrada x FileSalida.
actualizarFechaArchivo([Ruta,[Nombre,Tipo,Contenido,_]],Archivo):-get_time(D),
	Archivo=[Ruta,[Nombre,Tipo,Contenido,D]].
	
%Descripción: Cambia la ruta de una lista de archivos por una ruta especificada.
%Dominios: Ruta (String) x FilesEntrada (Lista de files) x FilesSalida (Lista de files)
modificarRutaArchivosDirecto(_,[],[]):-!.
modificarRutaArchivosDirecto(_,[],_):-!.
modificarRutaArchivosDirecto(Ruta,[[_,[Nombre,Tipo,Contenido,Fecha]]|T],[[Ruta,[Nombre,Tipo,Contenido,Fecha]]|Tout]):-modificarRutaArchivosDirecto(Ruta,T,Tout),!.

%Descripción: Modifica el nombre de un archivo.
%Dominios: File x NewName (String) X Archivo (File).
modificarNombreArchivo([Ruta,[_,Tipo,Contenido,Fecha]],NewName,Archivo):-Archivo=[Ruta,[NewName,Tipo,Contenido,Fecha]].

%OTRAS OPERACIONES

%Descripción: Selecciona un archivo desde una lista de archivos.
%Dominios: Nombre (String) x Ruta (String) x File x Archivo (File)
seleccionarArchivo(Nombre,Ruta,[[Ruta,[Nombre,Tipo,Contenido,Fecha]]|_],Archivo):-Archivo=[Ruta,[Nombre,Tipo,Contenido,Fecha]],!. 
seleccionarArchivo(Nombre,Ruta,[_|T],Archivo):-seleccionarArchivo(Nombre,Ruta,T,Archivo).

%Descripción: Busca si existe un archivo en una lista de archivos.
%Dominios: Files x Ruta (String) x Filename (String).
buscar_archivo([[Ruta,[Filename,_,_,_]]|_],Ruta,Filename):-!.
buscar_archivo([[_,[_,_,_,_]]|T],Ruta,Filename):-buscar_archivo(T,Ruta,Filename).

%Descripción: Selecciona todos los archivos que pertenecen a una ruta.
%Dominios: Ruta (String) x Files (Liste de files) x FilesSalida (Lista de files)
seleccionarArchivosPorRuta(_,[],[]):-!.
seleccionarArchivosPorRuta(Ruta1,[[Ruta2,_]|T],Tout):-Ruta1 \= Ruta2,seleccionarArchivosPorRuta(Ruta1,T,Tout),!.
seleccionarArchivosPorRuta(Ruta,[H|T],[H|Tout]):-seleccionarArchivosPorRuta(Ruta,T,Tout).

%Descripción: Selecciona los nombres de los archivos que estén en una ruta específica.
%Dominios: Ruta (String) x Files (Lista de files) x Nombres (Lista de strings).
nombresArchivosRuta(_,[],[]):-!.
nombresArchivosRuta(_,[],_):-!.
nombresArchivosRuta(Ruta,[[Ruta,[Nombre,_,_,_]]|T],[Nombre|Tout]):-nombresArchivosRuta(Ruta,T,Tout),!.
nombresArchivosRuta(Ruta,[_|T],Tout):-nombresArchivosRuta(Ruta,T,Tout).

%Descripción: 
%Dominios: 
archivosDeCarpetas([],_,_):-!.
archivosDeCarpetas([[Ruta,_,_,_]|T],Archivos,Tin):-seleccionarArchivosPorRuta(Ruta,Archivos,ArchivosSeleccionados),
	insertarLista(ArchivosSeleccionados,Tin,Tout),archivosDeCarpetas(T,Archivos,Tout),!.

%Descripción: inserta un archivo en la cola de una lista de archivos.
%Dominios: LCN (file) x FilesEntrada (Lista de files) x FilesSalida (Lista de files)
insertarArchivos(LCN,[],LCN):-!.
insertarArchivos(LCN,[H|T],[H|Tout]):-insertarArchivos(LCN,T,Tout).

%Descripción: Quita todas las carpetas que estén ocultas (inician con un punto).
%Dominios: NombresEntrada (Lista de strings) x NombresSalida (Lista de strings).
oculto([],[]):-!.
oculto([H|T],[H|Tout]):-atom_chars(H,Caracteres),
	getCabeza(Caracteres,NTipo),
	atom_string(NTipo,Tipo),
	Tipo \= ".",
	oculto(T,Tout),!.
oculto([_|T],Tout):-oculto(T,Tout).


%Descripción: Selecciona todos los archivos que estén en la carpeta o sea un subdirectorio de una ruta específica.
%Dominios: Ruta (String) x FilesEntrada (Lista de files) x FilesSalida (Lista de files).
archivosPorRuta(_,[],[]):-!.
archivosPorRuta(_,[],_):-!.
archivosPorRuta(Ruta1,[[Ruta2,[Nombre,Tipo,Contenido,FC]]|T],Tout):-split_string(Ruta2,"/","/",ListaRuta),
	not(sublista(Ruta1,ListaRuta)),
	insertarCola([Ruta2,[Nombre,Tipo,Contenido,FC]],Tout,Tin),
	archivosPorRuta(Ruta1,T,Tin),!.
archivosPorRuta(Ruta,[H|T],[H|Tout]):-archivosPorRuta(Ruta,T,Tout).

%Descripción: Selecciona todos los archivos que no estén en la carpeta o no sean un subdirectorio de una ruta específica.
%Dominios: Ruta (String) x FilesEntrada (Lista de files) x FilesSalida (Lista de files).
noArchivosPorRuta(_,[],[]):-!.
noArchivosPorRuta(_,[],_):-!.
noArchivosPorRuta(Ruta1,[[Ruta2,[Nombre,Tipo,Contenido,FC]]|T],Tout):-split_string(Ruta2,"/","/",ListaRuta),
	sublista(Ruta1,ListaRuta),
	insertarCola([Ruta2,[Nombre,Tipo,Contenido,FC]],Tout,Tin),
	noArchivosPorRuta(Ruta1,T,Tin),!.
noArchivosPorRuta(Ruta,[H|T],[H|Tout]):-noArchivosPorRuta(Ruta,T,Tout).

%Descripción: Modifica la ruta de los archivos de una lista
%Dominios: LRN (Lista de strings) x N (Number) x FilesEntrada (Lista de files) x FilesSalida (Lista de files)
modificarRutasArchivos(_,_,[],[]):-!.
modificarRutasArchivos(LRN,N,[[Ruta,[Nombre,Tipo,Contenido,FC]]|T],[[NewRuta,[Nombre,Tipo,Contenido,FC]]|Tout]):-split_string(Ruta,"/","/",LRuta),
	eliminarNelementos(N,LRuta,RutaSinFuente),
	length(LRuta,N),
	atomic_list_concat(RutaSinFuente,"/",Ruta1),
	atom_string(Ruta1,Ruta2),
	atomic_list_concat(LRN,"/",RN1),
	string_concat(RN1,"/",RN2),
	atom_string(RN2,NRN),
	string_concat(NRN,Ruta2,NewRuta),
	modificarRutasArchivos(LRN,N,T,Tout).
modificarRutasArchivos(LRN,N,[[Ruta,[Nombre,Tipo,Contenido,FC]]|T],[[NewRuta,[Nombre,Tipo,Contenido,FC]]|Tout]):-split_string(Ruta,"/","/",LRuta),
	eliminarNelementos(N,LRuta,RutaSinFuente),
	atomic_list_concat(RutaSinFuente,"/",Ruta1),
	atom_string(Ruta1,Ruta2),
	atomic_list_concat(LRN,"/",RN1),
	string_concat(RN1,"/",RN2),
	atom_string(RN2,NRN),
	string_concat(NRN,Ruta2,Ruta3),
	string_concat(Ruta3,"/",NewRuta),
	modificarRutasArchivos(LRN,N,T,Tout).

%Descripción: Selecciona todos los archivos que estén en la carpeta o sea un subdirectorio de una ruta específica.
%Dominios: Ruta (String) x FilesEntrada (Lista de files) x FilesSalida (Lista de files).
archivosPorRutaTipo(_,_,[],[]):-!.
archivosPorRutaTipo(_,_,[],_):-!.
archivosPorRutaTipo(Ruta1,Tipo1,[[Ruta2,[Nombre,Tipo2,Contenido,FC]]|T],Tout):-
	not(Ruta1 = Ruta2),
	Tipo1 = Tipo2,
	insertarCola([Ruta1,[Nombre,Tipo1,Contenido,FC]],Tout,Tin),
	archivosPorRutaTipo(Ruta1,Tipo1,T,Tin),!.
archivosPorRutaTipo(Ruta,Tipo,[H|T],[H|Tout]):-archivosPorRutaTipo(Ruta,Tipo,T,Tout).

%Descripción:
%Dominios:
buscar_archivos([[Ruta,[Filename,_,_,_]]|_],Archivos):-buscar_archivo(Archivos,Ruta,Filename),!.
buscar_archivos([_|T],Archivos):-buscar_archivos(T,Archivos).


