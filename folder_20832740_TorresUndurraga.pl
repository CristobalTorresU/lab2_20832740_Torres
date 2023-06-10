%MODULOS
:-module(folder_20832740_TorresUndurraga,[folder/4,buscar_carpeta/2,cambiarFechaModificacion/2,modificarRutaCarpeta/3,seleccionarCarpeta/3,carpetasPorRuta/3,noCarpetasPorRuta/3,insertarCarpetas/3,modificarRutasCarpetas/4,eliminarCarpeta/3,subdirectoriosDirectos/3]).

%##############################################################################

%TDA folder
/*
REPRESENTACIÓN:

*/
/*
Predicados:
folder(Ruta,Nombre_carpeta,Creador,Carpeta).
getNombreFolder(Folder,Nombre).
getCreadorFolder(Folder,Creador).
getFechaCreacionFolder(Folder,FC).
getFechaModificacionFolder(Folder,FM).
cambiarFechaModificacion(Carpeta,Nueva_carpeta).
cambiarRutaCarpeta(Folder,Ruta,Carpeta).
buscar_carpeta(Carpetas,Nombre).
seleccionarCarpeta(Ruta,ListaCarpetas,Carpeta).
carpetasPorRuta(Ruta,Carpetas,ListaCarpetasNuevas).
noCarpetasPorRuta(Ruta,Carpetas,ListaCarpetasNuevas).
insertarCarpetas(ListaCarpetasNuevas,ListaCarpetasOriginales,ListaCarpetas).
modificarRutasCarpetas(ListaRutaNueva,N,ListaCarpetasOriginales,ListaNueva).
eliminarCarpeta(Ruta,ListaCarpetasEntrante,ListaCarpetasSalida).
subdirectoriosDirectos(CarpetaOriginales,N,CarpetasSalida).
*/
/*
Metas:
Principales: folder
Secundarias: getNombreFolder,getCreadorFolder,getFechaCreacionFolder,
	getFechaModificacionFolder,cambiarFechaModificacion,
	cambiarRutaCarpeta,buscar_carpeta,seleccionarCarpeta,
	carpetasPorRuta,noCarpetasPorRuta,insertarCarpetas,
	modificarRutasCarpetas,eliminarCarpeta,subdirectoriosDirectos.
*/

%CONSTRUCTOR

%Descripción: Construye una folder (Carpeta).
%Dominios: Ruta (String) x Nombre_carpeta (String) x Creador (String) x Carpeta (folder)
folder(Ruta,Nombre_carpeta,Creador,Carpeta):-string(Nombre_carpeta),
	date(Fecha_creacion),
	string_concat(Ruta,Nombre_carpeta,Nombre),
	string_concat(Nombre,"/",Nombre_ruta),
	Carpeta=[Nombre_ruta,Creador,Fecha_creacion,Fecha_creacion].


%SELECTORES

%Descripción: Selecciona el nombre (ruta) de una carpeta.
%Dominios: Folder x Nombre (String).
getNombreFolder([Nombre,_,_,_],Nombre).

%Descripción: Selecciona el nombre del creador de una carpeta.
%Dominios: Folder x Creador (String).
getCreadorFolder([_,Creador,_,_],Creador).

%Descripción: Selecciona la fecha de creación de una carpeta.
%Dominios: Folder x Fecha_creacion (Number).
getFechaCreacionFolder([_,_,Fecha_creacion,_],Fecha_creacion).

%Descripción: Selecciona la fecha de modificación de una carpeta.
%Dominios: Folder x Fecha_mod (Number).
getFechaModificacionFolder([_,_,_,Fecha_mod],Fecha_mod).


%MODIFICADORES

%Descripción: Cambia la fecha de modificación de una carpeta.
%Dominios: Carpeta (folder) x Nueva_carpeta (folder).
cambiarFechaModificacion(Carpeta,Nueva_carpeta):-getNombreFolder(Carpeta,Nombre),
	getCreadorFolder(Carpeta,Creador),
	getFechaCreacionFolder(Carpeta,Fecha_c),
	date(Fecha_nueva),
	getArchivosFolder(Carpeta,Archivos),
	Nueva_carpeta=[Nombre,Creador,Fecha_c,Fecha_nueva,Archivos].

%Descripción: Modifica la ruta de una carpeta.
%Dominios: Folder x Ruta (String) x Carpeta (folder).
modificarRutaCarpeta([_,Creador,FC,FM],Ruta,Carpeta):-Carpeta=[Ruta,Creador,FC,FM].


%OTRAS OPERACIONES

%Descripción: Busca si existe una carpeta en una lista de carpetas.
%Dominios: Carpetas (Lista de folders) x Nombre (String).
buscar_carpeta([[Nombre,_,_,_]|_],Nombre):-!.
buscar_carpeta([[_,_,_,_]|T],Nombre):-string(Nombre),
	buscar_carpeta(T,Nombre).

%Descripción: Selecciona una carpeta de una lista de carpetas a partir de una ruta.
%Dominios: Ruta (String) x ListaCarpetas (Lista de folders) x Carpeta (folder).
seleccionarCarpeta(Ruta,[[Ruta,Creador,Fecha_creacion,Fecha_modificacion]|_],Carpeta):-Carpeta=[Ruta,Creador,Fecha_creacion,Fecha_modificacion],!.
seleccionarCarpeta(Ruta,[_|T],Carpeta):-seleccionarCarpeta(Ruta,T,Carpeta).

%Descripción: Selecciona todas las carpetas que sean la carpeta o subdirectorios desde una ruta.
%Dominios: Ruta (String) x Carpetas (Lista de folders) x ListaCarpetasNueva (Lista de folders).
carpetasPorRuta(_,[],[]):-!.
carpetasPorRuta(_,[],_):-!.
carpetasPorRuta(Ruta1,[[Ruta2,C,FC,FM]|T],Tout):-split_string(Ruta2,"/","/",ListaRuta),
	not(sublista(Ruta1,ListaRuta)),
	insertarCola([Ruta2,C,FC,FM],Tout,Tin),
	carpetasPorRuta(Ruta1,T,Tin),!.
carpetasPorRuta(Ruta,[H|T],[H|Tout]):-carpetasPorRuta(Ruta,T,Tout).

%Descripción: Selecciona todas las carpetas que no sean la carpeta o no sean subdirectorios desde una ruta.
%Dominios: Ruta (String) x Carpetas (Lista de folders) x ListaCarpetasNuevas (Lista de folders).
noCarpetasPorRuta(_,[],[]):-!.
noCarpetasPorRuta(_,[],_):-!.
noCarpetasPorRuta(Ruta1,[[Ruta2,C,FC,FM]|T],Tout):-split_string(Ruta2,"/","/",ListaRuta),
	sublista(Ruta1,ListaRuta),
	insertarCola([Ruta2,C,FC,FM],Tout,Tin),
	noCarpetasPorRuta(Ruta1,T,Tin),!.
noCarpetasPorRuta(Ruta,[H|T],[H|Tout]):-noCarpetasPorRuta(Ruta,T,Tout).

%Descripción: Inserta en la cola de una lista una lista de carpetas
%Dominios: ListaCarpetasNuevas (Lista de folders) x ListaCarpetasOriginales (Lista de folders) x ListaCarpetas (Lista de folders).
insertarCarpetas(LCN,[],LCN):-!.
insertarCarpetas(LCN,[H|T],[H|Tout]):-insertarCarpetas(LCN,T,Tout).

%Descripción: Modifica la ruta de las carpetas de una lista de carpetas.
%Dominios: ListaRutaNueva (Lista de strings) x N (Number) x ListaCarpetasOriginales (Lista de folders) x ListaNueva (Lista de folders).
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

%Descripción: Elimina una carpeta de una lista de carpetas a partir de una ruta.
%Dominios: Ruta (String) x ListaCarpetasEntrante (Lista de folders) x ListaCarpetasSalida (Lista de folders).
eliminarCarpeta(_,[],[]):-!.
eliminarCarpeta(E,[[E,_,_,_]|T],Tout):-eliminarCarpeta(E,T,Tout),!.
eliminarCarpeta(E,[[Ruta,C,FC,FM]|T],[[Ruta,C,FC,FM]|Tout]):-E \= Ruta,eliminarCarpeta(E,T,Tout).

%Descripción: Selecciona los subdirectorios directos de una ruta desde una lista de carpetas.
%Dominios: CarpetasOriginales (Lista de folders) x N (Number) x CarpetasSalida (Lista de folders).
subdirectoriosDirectos([],_,[]):-!.
subdirectoriosDirectos([[Ruta,_,_,_]|T],N,[Nombre|Tout]):-split_string(Ruta,"/","/",ListaRuta),
	length(ListaRuta,N1),
	N1 is N + 1,
	ultimoElemento(ListaRuta,Nombre),
	subdirectoriosDirectos(T,N,Tout),!.
subdirectoriosDirectos([_|T],N,Tout):-subdirectoriosDirectos(T,N,Tout).

