%MODULOS
:-module(folder_20832740_TorresUndurraga,[folder/4,buscar_carpeta/2,cambiarFechaModificacion/2,modificarRutaCarpeta/3,agregar_carpetas/5,seleccionarCarpeta/3,carpetasPorRuta/3,noCarpetasPorRuta/3,insertarCarpetas/3,modificarRutasCarpetas/4,eliminarCarpeta/3,subdirectoriosDirectos/3]).

%##############################################################################

%TDA folder

%CONSTRUCTOR
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

%cambiarRutaCarpeta(CarpetaOriginal,Ruta,CarpetaSalida).
modificarRutaCarpeta([_,Creador,FC,FM],Ruta,Carpeta):-Carpeta=[Ruta,Creador,FC,FM].

%OTRAS OPERACIONES
%agregar_carpetas().
agregar_carpetas(Carpetas_old,Ruta,Creador,Nombre_carpeta,Carpetas_new):-folder(Ruta,Nombre_carpeta,Creador,Carpeta),
	insertarCola(Carpeta,Carpetas_old,Carpetas_new).

%buscar_carpeta().
buscar_carpeta([[Nombre,_,_,_]|_],Nombre):-!.
buscar_carpeta([[_,_,_,_]|T],Nombre):-string(Nombre),
	buscar_carpeta(T,Nombre).

%seleccionarCarpeta(RutaCarpeta,ListaCarpetas,Carpeta).
seleccionarCarpeta(Ruta,[[Ruta,Creador,Fecha_creacion,Fecha_modificacion]|_],Carpeta):-Carpeta=[Ruta,Creador,Fecha_creacion,Fecha_modificacion],!.
seleccionarCarpeta(Ruta,[_|T],Carpeta):-seleccionarCarpeta(Ruta,T,Carpeta).

%carpetasPorRuta(Ruta,Carpetas,ListaCarpetasNuevas).
carpetasPorRuta(_,[],[]):-!.
carpetasPorRuta(_,[],_):-!.
carpetasPorRuta(Ruta1,[[Ruta2,C,FC,FM]|T],Tout):-split_string(Ruta2,"/","/",ListaRuta),
	not(sublista(Ruta1,ListaRuta)),
	insertarCola([Ruta2,C,FC,FM],Tout,Tin),
	carpetasPorRuta(Ruta1,T,Tin),!.
carpetasPorRuta(Ruta,[H|T],[H|Tout]):-carpetasPorRuta(Ruta,T,Tout).


%noCarpetasPorRuta(Ruta,Carpetas,ListaCarpetasNuevas).
noCarpetasPorRuta(_,[],[]):-!.
noCarpetasPorRuta(_,[],_):-!.
noCarpetasPorRuta(Ruta1,[[Ruta2,C,FC,FM]|T],Tout):-split_string(Ruta2,"/","/",ListaRuta),
	sublista(Ruta1,ListaRuta),
	insertarCola([Ruta2,C,FC,FM],Tout,Tin),
	noCarpetasPorRuta(Ruta1,T,Tin),!.
noCarpetasPorRuta(Ruta,[H|T],[H|Tout]):-noCarpetasPorRuta(Ruta,T,Tout).

%insertarCarpetas(ListaCarpetasNuevas,ListaCarpetasOriginales,ListaCarpetas).
insertarCarpetas(LCN,[],LCN):-!.
insertarCarpetas(LCN,[H|T],[H|Tout]):-insertarCarpetas(LCN,T,Tout).

%modificarRutasCarpetas(ListaRutaNueva,N,ListaCarpetasOriginales,ListaNueva).
modificarRutasCarpetas(_,_,[],[]):-!.
modificarRutasCarpetas(LRN,N,[[Ruta,Creador,FC,FM]|T],[[NewRuta,Creador,FC,FM]|Tout]):-split_string(Ruta,"/","/",LRuta),
	eliminarNelementos(N,LRuta,RutaSinFuente),
	length(LRuta,N),
	atomic_list_concat(RutaSinFuente,"/",Ruta1),
	atom_string(Ruta1,Ruta2),
	atomic_list_concat(LRN,"/",RN1),
	string_concat(RN1,"/",RN2),
	atom_string(RN2,NRN),
	string_concat(NRN,Ruta2,NewRuta),
	modificarRutasCarpetas(LRN,N,T,Tout).
modificarRutasCarpetas(LRN,N,[[Ruta,Creador,FC,FM]|T],[[NewRuta,Creador,FC,FM]|Tout]):-split_string(Ruta,"/","/",LRuta),
	eliminarNelementos(N,LRuta,RutaSinFuente),
	atomic_list_concat(RutaSinFuente,"/",Ruta1),
	atom_string(Ruta1,Ruta2),
	atomic_list_concat(LRN,"/",RN1),
	string_concat(RN1,"/",RN2),
	atom_string(RN2,NRN),
	string_concat(NRN,Ruta2,Ruta3),
	string_concat(Ruta3,"/",NewRuta),
	modificarRutasCarpetas(LRN,N,T,Tout).

%eliminarCarpeta(Ruta,ListaCarpetasEntrante,ListaCarpetasSalida)
eliminarCarpeta(_,[],[]):-!.
eliminarCarpeta(E,[[E,_,_,_]|T],Tout):-eliminarCarpeta(E,T,Tout),!.
eliminarCarpeta(E,[[Ruta,C,FC,FM]|T],[[Ruta,C,FC,FM]|Tout]):-E \= Ruta,eliminarCarpeta(E,T,Tout).

%subdirectoriosDirectos(Carpetas,N,).
subdirectoriosDirectos([],_,[]):-!.
subdirectoriosDirectos([[Ruta,_,_,_]|T],N,[Nombre|Tout]):-split_string(Ruta,"/","/",ListaRuta),
	length(ListaRuta,N1),
	N1 is N + 1,
	ultimoElemento(ListaRuta,Nombre),
	subdirectoriosDirectos(T,N,Tout),!.
subdirectoriosDirectos([_|T],N,Tout):-subdirectoriosDirectos(T,N,Tout).

