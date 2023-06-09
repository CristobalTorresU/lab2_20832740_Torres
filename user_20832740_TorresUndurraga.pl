%MODULOS
:-module(user_20832740_TorresUndurraga,[user/2,getNombreUser/2,getPrimerUser/2,getRestoUsers/2,buscar_usuario/2,no_sesion_iniciada/2]).

%##############################################################################

%TDA user

%CONSTRUCTOR
user(Nombre,U):-string(Nombre),
	date(Date),
	U=[Nombre,Date].

%SELECTORES
getNombreUser([Nombre,_],Nombre).
getPrimerUser([_,_,_,_,_,_,[User|_],_],User).
getRestoUsers([_,_,_,_,_,_,[_|Users],_],Users).

%OTRAS OPERACIONES
%buscar_usuario().
buscar_usuario([[Username,_]|_],Username):-!.
buscar_usuario([[_,_]|T],UserName):-string(UserName),
	buscar_usuario(T,UserName).

%no_sesion_iniciada()
no_sesion_iniciada([_,_,_,Usuario,_,_,_,_,_,_],Usuario).
