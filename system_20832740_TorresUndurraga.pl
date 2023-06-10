%MODULOS
:-module(system_20832740_TorresUndurraga,[getNameSystem/2,getFechaSystem/2,getLetraSystem/2,getUsuarioSystem/2,getRutaSystem/2,getDrives/2,getCarpetas/2,getArchivos/2,getUsers/2,getPapelera/2]).

%##############################################################################

%TDA system
/*
REPRESENTACIÓN:

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
*/
/*
METAS:
Principales: getNameSystem,getFechaSystem,getLetraSystem,getUsuarioSystem,getRutaSystem,
	getDrives,getCarpetas,getArchivos,getUsers,getPapelera.
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
