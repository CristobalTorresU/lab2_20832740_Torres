%MODULOS
:-module(system_20832740_TorresUndurraga,[getNameSystem/2,getFechaSystem/2,getLetraSystem/2,getUsuarioSystem/2,getRutaSystem/2,getDrives/2,getCarpetas/2,getArchivos/2,getUsers/2,getPapelera/2]).

%##############################################################################

%TDA system

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
