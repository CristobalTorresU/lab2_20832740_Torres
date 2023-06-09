%MODULOS
:-module(file_20832740_TorresUndurraga,[file/3,fileRuta/3,getFilename/2,seleccionarArchivo/4,eliminarArchivo/4,modificarRutaArchivo/3,modificarNombreArchivo/3,buscar_archivo/3,seleccionarArchivosPorRuta/3,nombresArchivosRuta/3,archivosDeCarpetas/3,insertarArchivos/3,oculto/2,archivosPorRuta/3,noArchivosPorRuta/3,modificarRutasArchivos/4]).

%##############################################################################

%TDA file

%CONSTRUCTORES

file(Filename,Contenido,File):-string(Filename),
	string(Contenido),
	date(Fecha),
	File=[Filename,Contenido,Fecha].

fileRuta(File,Ruta,[Ruta,File]).

%SELECTORES

getFilename([Filename,_,_],Filename).
getContenido([_,Contenido,_],Contenido).
getFechaCreacion([_,_,Fecha],Fecha).


%seleccionarArchivo(Name_d,Ruta,Archivos,File).
seleccionarArchivo(Nombre,Ruta,[[Ruta,[Nombre,Contenido,Fecha]]|_],Archivo):-Archivo=[Ruta,[Nombre,Contenido,Fecha]],!.
seleccionarArchivo(Nombre,Ruta,[_|T],Archivo):-seleccionarArchivo(Nombre,Ruta,T,Archivo).


%MODIFICADORES

%eliminarArchivo(Nombre,Ruta,Archivos,Archivos?).
eliminarArchivo(_,_,[],[]):-!.
eliminarArchivo(Nombre,Ruta,[[Ruta,[Nombre,_,_]]|T],Tout):-eliminarArchivo(Nombre,Ruta,T,Tout),!.
eliminarArchivo(Nombre,Ruta,[H|T],[H|Tout]):-eliminarArchivo(Nombre,Ruta,T,Tout).

%modificarRutaArchivo
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

%nombresArchivosRuta().
nombresArchivosRuta(_,[],[]):-!.
nombresArchivosRuta(_,[],_):-!.
nombresArchivosRuta(Ruta,[[Ruta,[Nombre,_,_]]|T],[Nombre|Tout]):-nombresArchivosRuta(Ruta,T,Tout),!.
nombresArchivosRuta(Ruta,[_|T],Tout):-nombresArchivosRuta(Ruta,T,Tout).

%archivosDeCarpetas(Carpetas,Archivos,NewArchivos).
archivosDeCarpetas([],_,_):-!.
archivosDeCarpetas([[Ruta,_,_,_]|T],Archivos,Tin):-seleccionarArchivosPorRuta(Ruta,Archivos,ArchivosSeleccionados),
	insertarLista(ArchivosSeleccionados,Tin,Tout),archivosDeCarpetas(T,Archivos,Tout),!.
%archivosDeCarpetas([_|T],Archivos,Tout):-archivosDeCarpetas(T,Archivos,Tout).


%insertarArchivos(ListaArchivosNuevos,ListaArchivosOriginales,ListaArchivos).
insertarArchivos(LCN,[],LCN):-!.
insertarArchivos(LCN,[H|T],[H|Tout]):-insertarArchivos(LCN,T,Tout).

%oculto(Nombres,NombresResultantes).
oculto([],[]):-!.
oculto([H|T],[H|Tout]):-atom_chars(H,Caracteres),
	getCabeza(Caracteres,NTipo),
	atom_string(NTipo,Tipo),
	Tipo \= ".",
	oculto(T,Tout),!.
oculto([_|T],Tout):-oculto(T,Tout).

%archivosPorRuta(Ruta,Archivos,ListaArchivosNuevos).
archivosPorRuta(_,[],[]):-!.
archivosPorRuta(_,[],_):-!.
archivosPorRuta(Ruta1,[[Ruta2,[Nombre,Contenido,FC]]|T],Tout):-split_string(Ruta2,"/","/",ListaRuta),
	not(sublista(Ruta1,ListaRuta)),
	insertarCola([Ruta2,[Nombre,Contenido,FC]],Tout,Tin),
	archivosPorRuta(Ruta1,T,Tin),!.
archivosPorRuta(Ruta,[H|T],[H|Tout]):-archivosPorRuta(Ruta,T,Tout).

%noArchivosPorRuta(Ruta,Archivos,ListaArchivosNuevos).
noArchivosPorRuta(_,[],[]):-!.
noArchivosPorRuta(_,[],_):-!.
noArchivosPorRuta(Ruta1,[[Ruta2,[Nombre,Contenido,FC]]|T],Tout):-split_string(Ruta2,"/","/",ListaRuta),
	sublista(Ruta1,ListaRuta),
	insertarCola([Ruta2,[Nombre,Contenido,FC]],Tout,Tin),
	noArchivosPorRuta(Ruta1,T,Tin),!.
noArchivosPorRuta(Ruta,[H|T],[H|Tout]):-noArchivosPorRuta(Ruta,T,Tout).

%modificarRutasArchivos().
modificarRutasArchivos(_,_,[],[]):-!.
modificarRutasArchivos(LRN,N,[[Ruta,[Nombre,Contenido,FC]]|T],[[NewRuta,[Nombre,Contenido,FC]]|Tout]):-split_string(Ruta,"/","/",LRuta),
	eliminarNelementos(N,LRuta,RutaSinFuente),
	length(LRuta,N),
	atomic_list_concat(RutaSinFuente,"/",Ruta1),
	atom_string(Ruta1,Ruta2),
	atomic_list_concat(LRN,"/",RN1),
	string_concat(RN1,"/",RN2),
	atom_string(RN2,NRN),
	string_concat(NRN,Ruta2,NewRuta),
	modificarRutasArchivos(LRN,N,T,Tout).
modificarRutasArchivos(LRN,N,[[Ruta,[Nombre,Contenido,FC]]|T],[[NewRuta,[Nombre,Contenido,FC]]|Tout]):-split_string(Ruta,"/","/",LRuta),
	eliminarNelementos(N,LRuta,RutaSinFuente),
	atomic_list_concat(RutaSinFuente,"/",Ruta1),
	atom_string(Ruta1,Ruta2),
	atomic_list_concat(LRN,"/",RN1),
	string_concat(RN1,"/",RN2),
	atom_string(RN2,NRN),
	string_concat(NRN,Ruta2,Ruta3),
	string_concat(Ruta3,"/",NewRuta),
	modificarRutasArchivos(LRN,N,T,Tout).
