%MODULOS
:-module(system_20832740_TorresUndurraga,[getNameSystem/2,getFechaSystem/2,getLetraSystem/2,getUsuarioSystem/2,getRutaSystem/2,getDrives/2,getCarpetas/2,getArchivos/2,getUsers/2,getPapelera/2,getCabeza/2,insertarCola/3,eliminarElemento/3,eliminarUltimoElemento/2,eliminarNelementos/3,formarRuta/2,sublista/2,insertarLista/3,ultimoElemento/2,invertir/2]).

%##############################################################################

%TDA system
/*
REPRESENTACIÓN:
System se reprenta con una lista de 10 elementos: En la 1era posición está el nombre
del sistema, en 2da la fecha de creación del sistema, en 3ra la letra de la unidad
actual, en 4ta el nombre del usuario actual, en 5ta la ruta actual, en 6ta los drives,
en 7ma las carpetas, en 8va los archivos, en 8va los usuarios y en la última la papelera.


*/
/*
PREDICADOS:
getNameSystem(System,Name).
getFechaSystem(System,Fecha).
getLetraSystem(System,Letra_unidad).
getUsuarioSystem(System,Usuario_actual).
getRutaSystem(System,Ruta_actual).
getDrives(System,Drives).
getCarpetas(System,Carpetas).
getArchivos(System,Archivos).
getUsers(System,Users).
getPapelera(System,Papelera).
getCabeza(Lista,Elemento).
insertarCola(Elemento,ListaEntrada,ListaSalida).
eliminarElemento(Elemento,ListaEntrante,ListaSalida).
eliminarUltimoElemento(L1,L2).
eliminarNelementos(LE,N,LS).
formarRuta(ListaNombres,Ruta).
insertarLista(L1,L2,LR).
sublista(L1,L2).
ultimoElemento(Lista,Elemento).
invertir(Lista,ListaInvertida).
*/
/*
METAS:
Secundarias: getNameSystem,getFechaSystem,getLetraSystem,getUsuarioSystem,getRutaSystem,
	getDrives,getCarpetas,getArchivos,getUsers,getPapelera,getCabeza,insertarCola,
	eliminarElemento,eliminarUltimoElemento,eliminarNelementos,formarRuta,
	insertarLista,sublista,ultimoElemento,invertir.
*/

%CONSTRUCTOR
%Se encuentra en el archivo main_20832740_TorresUndurraga.pl

%SELECTORES

%Descripción: Selecciona el nombre de un sistema.
%Dominios: System x Name (String).
getNameSystem([Name,_,_,_,_,_,_,_,_,_],Name).

%Descripción: Selecciona la fecha de creación de un sistema.
%Dominios: System x Fecha (Number).
getFechaSystem([_,Fecha,_,_,_,_,_,_,_,_],Fecha).

%Descripción: Selecciona la letra de la unidad actual del sistema.
%Dominios: System x Letra_unidad (String).
getLetraSystem([_,_,Letra_unidad,_,_,_,_,_,_,_],Letra_unidad).

%Descripción: Selecciona el usuario actual de un sistema.
%Dominios: System x Usuario (String).
getUsuarioSystem([_,_,_,Usuario_actual,_,_,_,_,_,_],Usuario_actual).

%Descripción: Selecciona la ruta actual de un sistema.
%Dominios: System x Ruta (String).
getRutaSystem([_,_,_,_,Ruta_actual,_,_,_,_,_],Ruta_actual).

%Descripción: Selecciona los drives de un sistema.
%Dominios: System x Drives (Lista de drives).
getDrives([_,_,_,_,_,Drives,_,_,_,_],Drives).

%Descripción: Selecciona las carpetas de un sistema.
%Dominios: System x Carpetas (Lista de carpetas).
getCarpetas([_,_,_,_,_,_,Carpetas,_,_,_],Carpetas).

%Descripción: Selecciona los archivos de un sistema.
%Dominios: System x Archivos (Lista de files).
getArchivos([_,_,_,_,_,_,_,Archivos,_,_],Archivos).

%Descripción: Selecciona los usuarios registrados de un sistema.
%Dominios: System x Users (Lista de users).
getUsers([_,_,_,_,_,_,_,_,Users,_],Users).

%Descripción: Selecciona los elementos (carpetas y archivos) eliminados de un sistema.
%Dominios: System x Papelera (Lista de folders y files).
getPapelera([_,_,_,_,_,_,_,_,_,Papelera],Papelera).

%OTRAS OPERACIONES

%Descripción: 
%Dominios: Lista x Elemento
getCabeza([E|_],E).

%Descripción: 
%Dominios: Elemento x ListaEntrada x ListaSalida
insertarCola(E,[],[E]).
insertarCola(E,[H|T],[H|Tout]):-insertarCola(E,T,Tout).

%Descripción: 
%Dominios: Elemento x ListaEntrada x ListaSalida
eliminarElemento(_,[],[]):-!.
eliminarElemento(E,[E|T],Tout):-eliminarElemento(E,T,Tout),!.
eliminarElemento(E,[H|T],[H|Tout]):-eliminarElemento(E,T,Tout).

%Descripción: 
%Dominios: ListaEntrada x ListaSalida
eliminarUltimoElemento([_|[]],[]):-!.
eliminarUltimoElemento([H|T],[H|Tout]):-eliminarUltimoElemento(T,Tout).

%Descripción: Elimina los N primeros elementos de una lista.
%Dominios: ListaEntrada x N (Number) x ListaSalida
eliminarNelementos(0,T,T):-!.
eliminarNelementos(N,[_|T],Tout):-N > 0,Naux is N - 1,eliminarNelementos(Naux,T,Tout).

%Descripción: Forma una ruta en base a una lista de strings.
%Dominios: Lista (Lista de strings) x StringSalida
formarRuta(L,R):-atomic_list_concat(L,"/",S1),string_concat(S1,"/",R).

%Descripción: Determina si una Lista1 es una sublista de Lista2
%Dominios: Lista1 x Lista2
sublista(_,[]):-false.
sublista([],_):-!.
sublista([R1|T1],[R1|T2]):-sublista(T1,T2).

%Descripción: Inserta los elementos de una lista en la cola de otra lista.
%Dominios: L1 (Lista1) x L2 (Lista2) x LR (ListaResultante)
insertarLista([],[],[]):-!.
insertarLista([H1|T1],[],[H1|T3]):-insertarLista(T1,[],T3),!.
insertarLista(L,[H2|T2],[H2|T3]):-insertarLista(L,T2,T3).

%Descripción: Selecciona el último elemento de una lista.
%Dominios: Lista x Elemento
ultimoElemento([T|[]],T):-!.
ultimoElemento([_|T],E):-ultimoElemento(T,E).

%Descripción: Invierte la posición de los elementos de una lista.
%Dominios: ListaEntrada x ListaInvertida
invertir([],[]):-!.
invertir(L,[Ultimo|T]):-ultimoElemento(L,Ultimo),eliminarUltimoElemento(L,LSinUltimo),invertir(LSinUltimo,T),!.
