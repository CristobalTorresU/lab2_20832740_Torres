%TDA System
%Predicados:
/*
system(Name,S)
getNameSystem(S,Name)
getFechaSystem(S,Fecha)
getLetraSystem(S,Letra_unidad)
getUsuarioSystem(S,Usuario_actual)
getRutaSystem(S,Ruta_actual)
getDrives(S,Drives)
getUsers(S,Users)
getPapelera([S,Papelera)
*/

%CONSTRUCTORES
%El constructor se encuentra en el archivo main_20832740_TorresUndurraga

%SELECTORES
getNameSystem([Name,_,_,_,_,_,_,_],Name).
getFechaSystem([_,Fecha,_,_,_,_,_,_],Fecha).
getLetraSystem([_,_,Letra_unidad,_,_,_,_,_],Letra_unidad).
getUsuarioSystem([_,_,_,Usuario_actual,_,_,_,_],Usuario_actual).
getRutaSystem([_,_,_,_,Ruta_actual,_,_,_],Ruta_actual).
getDrives([_,_,_,_,_,Drives,_,_],Drives).
getUsers([_,_,_,_,_,_,Users,_],Users).
getPapelera([_,_,_,_,_,_,_,Papelera],Papelera).

%MODIFICADORES

%OTRAS OPERACIONES
