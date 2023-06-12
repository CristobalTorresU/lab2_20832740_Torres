%MODULOS
:-module(user_20832740_TorresUndurraga,[user/2,getNombreUser/2,buscar_usuario/2,no_sesion_iniciada/2]).

%##############################################################################

%TDA user
/*
REPRESENTACIÓN:
User se representa por una lista con 2 elementos. El 1ero es el nombre de usuario y
el 2do es la fecha en que se registró.

*/
/*
Predicados:
user(Nombre,User).
getNombreUser(User,Nombre).
buscar_usuario(Usuarios,Username).
no_sesion_iniciada(System,Usuario).
*/
/*
Metas:
Principales: user
Secundarias: getNombreUser,buscar_usuario,no_sesion_iniciada.
*/

%CONSTRUCTOR

%Descripción: Construye un user (usuario).
%Dominios: Nombre (String) x User
user(Nombre,User):-string(Nombre),
	get_time(Date),
	User=[Nombre,Date].

%SELECTORES

%Descripción: Selecciona el nombre de un user.
%Dominios: User x Nombre (String).
getNombreUser([Nombre,_],Nombre).


%OTRAS OPERACIONES

%Descripción: Busca si existe un usuario en una lista de usuarios mediante el nombre de usuario.
%Dominios: Users (Lista de users) x Username (String).
buscar_usuario([[Username,_]|_],Username):-!.
buscar_usuario([[_,_]|T],UserName):-string(UserName),
	buscar_usuario(T,UserName).

%Descripción: Verifica que no exista una sesión iniciada.
%Dominios: System x Usuario (user).
no_sesion_iniciada([_,_,_,Usuario,_,_,_,_,_,_],Usuario).
