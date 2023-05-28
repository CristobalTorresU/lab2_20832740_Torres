%FUNCIONES PRINCIPALES


%predicado: 
%dominio: Name (string) x System
%recorrido: System
system(Name,System):-string(Name),
					 date(Date),
					 System=[Name,Date,"","","",[],[],[]],
					 set_prolog_flag(answer_write_options,[max_depth(0)]),!.
