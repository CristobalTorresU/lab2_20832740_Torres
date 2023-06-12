%MÓDULOS
:-use_module(main_20832740_TorresUndurraga).
:-use_module(system_20832740_TorresUndurraga).
:-use_module(drive_20832740_TorresUndurraga).
:-use_module(folder_20832740_TorresUndurraga).
:-use_module(user_20832740_TorresUndurraga).
:-use_module(file_20832740_TorresUndurraga).

%EJEMPLOS DE USO

% creación de un sistema
%system(S1,"newSystem").

% creación de 2 sistemas, los cuales son independientes entre si.
%system(S1,"sistema1"),system(S2,"sistema2").

% se crean dos sistemas con el mismo nombre, lo cual se permite porque son independientes entre si, y nunca se relacionan.
%system(S1,"newSystem"),system(S2,"newSystem").

% se puede realizar con cuantos sistemas se estime conveniente
%system(S1,"newSystem"),system(S2,"newSystem"),system(S3,"newSystem").

%systemAddDrive
% Agregar un drive al sistema
%system("newSystem",S1),systemAddDrive(S1,"C","OS",10000000000,S2).

% se permite agregar otro drive con la mismo nombre y capacidad, pero distinta letra. Si la letra se ingresa como mayúscula, la propia regla la transformara en minúscula.
%system("newSystem",S1),systemAddDrive(S1,"c","OS",8192,S2),systemAddDrive(S2,"D","OS",8192,S3).

% se agregan 2 drives distintos.
%system("newSystem",S1),systemAddDrive(S1,"c","Debian",8192,S2), systemAddDrive(S2,"D","Mint",8192,S3).

% si se intenta añadir una unidad con una letra que ya existe, retorna false.
%system("newSystem", S1), systemRegister(S1, "user1", S2), systemAddDrive(S2, "C", "OS", 1000000000, S3), systemAddDrive(S3, "C", "otra etiqueta", 1000000000, S4).

% en el caso de que la letra no sea un único caracter, se retorna false.
%system("newSystem",S1),systemAddDrive(S1,"Unidad","Void",256,S2).


% se registra un usuario en el sistema.
%system("newSystem", S1), systemAddDrive(S1, "C", "OS", 10000000000, S2), systemRegister(S2, "user1", S3).

% se intenta registrar un usuario que ya existe, por lo que S4 será igual a S3.
%system("newSystem",S1),systemAddDrive(S1,"C","OS",10000000000,S2),systemRegister(S2,"user1",S3),systemRegister(S3,"user1",S4).

% se registran varios usuarios.
%system("newSystem",S1),systemAddDrive(S1,"C","OS",10000000000,S2),systemRegister(S2,"user1",S3),systemRegister(S3,"user2",S4),systemRegister(S4,"user3",S5).


% se inicia sesión con un usuario ya registrado.
%system("newSystem", S1), systemAddDrive(S1, "C", "OS", 10000000000, S2), systemRegister(S2, "user1", S3), systemRegister(S3, "user2", S4), systemLogin(S4, "user1", S5).

% se intenta iniciar otra sesión cuando ya existe una activa, retorna false.
%system("newSystem", S1), systemAddDrive(S1, "C", "OS", 10000000000, S2), systemRegister(S2, "user1", S3), systemRegister(S3, "user2", S4), systemLogin(S4, "user1", S5),systemLogin(S5,"user2",S6).

% se intenta iniciar sesión con un nombre de usuario que no está registrado, retorna false.
%system("newSystem", S1), systemAddDrive(S1, "C", "OS", 10000000000, S2), systemRegister(S2, "user1", S3), systemRegister(S3, "user2", S4), systemLogin(S4, "guest", S5).

% se intenta iniciar sesión con el usuario ya activo, no hay cambios y S6 es igual a S5.
%system("newSystem", S1), systemAddDrive(S1, "C", "OS", 10000000000, S2), systemRegister(S2, "user1", S3), systemRegister(S3, "user2", S4), systemLogin(S4, "user1", S5),systemLogin(S5,"user1",S6).


% se cierra la sesión previamente iniciada.
%system("newSystem", S1), systemAddDrive(S1, "C", "OS", 10000000000, S2), systemRegister(S2, "user1", S3), systemRegister(S3, "user2", S4), systemLogin(S4, "user1", S5),systemLogout(S5,S6).

% se intenta cerrar sesión cuando no hay una iniciada, retorna false
%system("newSystem", S1), systemAddDrive(S1, "C", "OS", 10000000000, S2), systemRegister(S2, "user1", S3), systemRegister(S3, "user2", S4), systemLogin(S4, "user1", S5),systemLogout(S5,S6),systemLogout(S6,S7).

% se inicia y cierra sesiòn de forma seguida.
%system("newSystem", S1), systemAddDrive(S1, "C", "OS", 10000000000, S2), systemRegister(S2, "user1", S3), systemRegister(S3, "user2", S4), systemLogin(S4, "user1", S5),systemLogout(S5,S6),systemLogin(S6,"user2",S7),systemLogout(S7,S8).


% se cambia el drive actual.
%system("newSystem", S1), systemAddDrive(S1, "C", "OS", 10000000000, S2), systemRegister(S2, "user1", S3), systemRegister(S3, "user2", S4), systemLogin(S4, "user1", S5), systemSwitchDrive(S5, "C", S6).

% se intenta cambiar a un drive que no existe, retorna false.
%system("newSystem", S1), systemAddDrive(S1, "C", "OS", 10000000000, S2), systemRegister(S2, "user1", S3), systemRegister(S3, "user2", S4), systemLogin(S4, "user1", S5), systemSwitchDrive(S5, "E", S6).

% se intenta cambiar al drive en el cual ya es está trabajando, retorna false.
%system("newSystem", S1), systemAddDrive(S1, "C", "OS", 10000000000, S2), systemRegister(S2, "user1", S3), systemRegister(S3, "user2", S4), systemLogin(S4, "user1", S5), systemSwitchDrive(S5, "C", S6),systemSwitchDrive(S6,"C",S7).

% se intenta cambiar a un drive sin una sesión iniciada, retorna false.
%system("newSystem", S1), systemAddDrive(S1, "C", "OS", 10000000000, S2), systemRegister(S2, "user1", S3), systemRegister(S3, "user2", S4),systemSwitchDrive(S5, "C", S6).


% se crea una carpeta en el directorio actual.
%system("newSystem", S1), systemAddDrive(S1, "C", "OS", 10000000000, S2), systemRegister(S2, "user1", S3), systemRegister(S3, "user2", S4), systemLogin(S4, "user1", S5), systemSwitchDrive(S5, "C", S6), systemMkdir(S6, "folder1", S7).

% se intenta crear una carpeta que ya existe en el directorio, retorna false.
%system("newSystem", S1), systemAddDrive(S1, "C", "OS", 10000000000, S2), systemRegister(S2, "user1", S3), systemRegister(S3, "user2", S4), systemLogin(S4, "user1", S5), systemSwitchDrive(S5, "C", S6), systemMkdir(S6, "folder1", S7), systemMkdir(S7, "folder1", S8).

% se crean varias carpetas para en el directorio actual.
%system("newSystem", S1), systemAddDrive(S1, "C", "OS", 10000000000, S2), systemRegister(S2, "user1", S3), systemRegister(S3, "user2", S4), systemLogin(S4, "user1", S5), systemSwitchDrive(S5, "C", S6), systemMkdir(S6, "folder1", S7), systemMkdir(S7, "folder2", S8),systemMkdir(S8,"folder3",S9).

% se crean carpetas con caracteres en mayúsculas, lo cual se transforma en minúscula que es una carpeta que ya existe, retorna false.
%system("newSystem",S1),systemAddDrive(S1,"C","OS",10000000000,S2), systemRegister(S2,"user1",S3),systemRegister(S3,"user2",S4), systemLogin(S4,"user1",S5),systemSwitchDrive(S5,"C",S6),systemMkdir(S6,"folder1",S7), systemMkdir(S7,"folder2",S8),systemMkdir(S8,"FOLDER2",S9).


% se cambia el directorio actual a "folder1"
%system("newSystem", S1), systemAddDrive(S1, "C", "OS", 10000000000, S2), systemRegister(S2, "user1", S3), systemRegister(S3, "user2", S4), systemLogin(S4, "user1", S5), systemSwitchDrive(S5, "C", S6), systemMkdir(S6, "folder1", S7), systemMkdir(S7, "folder2", S8), systemCd(S8, "folder1", S9).

% se intenta cambiar el directorio actual a uno inexistente, retorna false.
%system("newSystem", S1), systemAddDrive(S1, "C", "OS", 10000000000, S2), systemRegister(S2, "user1", S3), systemRegister(S3, "user2", S4), systemLogin(S4, "user1", S5), systemSwitchDrive(S5, "C", S6), systemMkdir(S6, "folder1", S7), systemMkdir(S7, "folder2", S8), systemCd(S8, "Videos", S9).

% se intenta retroceder a la carpeta padre, pero el directorio actual es la raíz, se retorna false.
%system("newSystem", S1), systemAddDrive(S1, "C", "OS", 10000000000, S2), systemRegister(S2, "user1", S3), systemRegister(S3, "user2", S4), systemLogin(S4, "user1", S5), systemSwitchDrive(S5, "C", S6), systemMkdir(S6, "folder1", S7), systemMkdir(S7, "folder2", S8), systemCd(S8, "..", S9).

% se ingresa en la carpeta "folder2", dentro de está se crea la carpeta "folder21", y también se ingresa, para posteriormente devolverse a la carpeta raíz.
%system("newSystem", S1), systemAddDrive(S1, "C", "OS", 10000000000, S2), systemRegister(S2, "user1", S3), systemRegister(S3, "user2", S4), systemLogin(S4, "user1", S5), systemSwitchDrive(S5, "C", S6), systemMkdir(S6, "folder1", S7), systemMkdir(S7, "folder2", S8), systemCd(S8, "folder2", S9),systemMkdir(S9,"folder21",S10),systemCd(S10,"folder21",S11),systemCd(S11,"/",S12).

% se ingresa a la ruta "c:/folder2/folder21/" directamente desde la raíz.
%system("newSystem", S1), systemAddDrive(S1, "C", "OS", 10000000000, S2), systemRegister(S2, "user1", S3), systemRegister(S3, "user2", S4), systemLogin(S4, "user1", S5), systemSwitchDrive(S5, "C", S6), systemMkdir(S6, "folder1", S7), systemMkdir(S7, "folder2", S8), systemCd(S8, "folder2", S9),systemMkdir(S9,"folder21",S10),systemCd(S10,"folder21",S11),systemCd(S11,"/",S12),systemCd(S12,"c:/folder2/folder21/",S13).


% se crea el archivo F1 y se agrega en el directorio
%system("newSystem", S1), systemAddDrive(S1, "C", "OS", 10000000000, S2), systemRegister(S2, "user1", S3), systemRegister(S3, "user2", S4), systemLogin(S4, "user1", S5), systemSwitchDrive(S5, "C", S6), systemMkdir(S6, "folder1", S7), systemMkdir(S7, "folder2", S8), systemCd(S8, "folder1", S9), systemMkdir(S9, "folder11", S10), systemLogout(S10, S11), systemLogin(S11, "user2", S12), file( "foo.txt", "hello world", F1), systemAddFile(S12, F1, S13), systemCd(S13, "/folder2", S14),  file( "ejemplo.txt", "otro archivo", F2), systemAddFile(S14, F2, S15).

% se agrega un archivo con un nombre que ya existe en el directorio, por lo que se reemplaza el contenido.
%system("newSystem", S1), systemAddDrive(S1, "C", "OS", 10000000000, S2), systemRegister(S2, "user1", S3), systemRegister(S3, "user2", S4), systemLogin(S4, "user1", S5), systemSwitchDrive(S5, "C", S6), systemMkdir(S6, "folder1", S7), systemMkdir(S7, "folder2", S8), systemCd(S8, "folder1", S9), systemMkdir(S9, "folder11", S10), systemLogout(S10, S11), systemLogin(S11, "user2", S12), file( "foo.txt", "hello world", F1), systemAddFile(S12, F1, S13),file("foo.txt","Esto es un archivo",F2),systemAddFile(S13,F2,S14).

% se agregan varios archivos.
%system("newSystem", S1), systemAddDrive(S1, "C", "OS", 10000000000, S2), systemRegister(S2, "user1", S3), systemRegister(S3, "user2", S4), systemLogin(S4, "user1", S5), systemSwitchDrive(S5, "C", S6), systemMkdir(S6, "folder1", S7), systemMkdir(S7, "folder2", S8), systemCd(S8, "folder1", S9), systemMkdir(S9, "folder11", S10), systemLogout(S10, S11), systemLogin(S11, "user2", S12), file( "foo.txt", "hello world", F1), systemAddFile(S12, F1, S13),file("foo.txt","Esto es un archivo",F2),systemAddFile(S13,F2,S14).


% se elimina un archivo del directorio y se envía a la papelera.
%system("newSystem",S1),systemAddDrive(S1,"C","OS",10000000000,S2),systemRegister(S2,"user1",S3),systemRegister(S3,"user2",S4),systemLogin(S4, "user1",S5),systemSwitchDrive(S5,"C",S6),systemMkdir(S6,"folder1",S7),systemMkdir(S7,"folder2",S8),systemCd(S8,"folder1",S9),systemMkdir(S9,"folder11", S10),systemLogout(S10, S11),systemLogin(S11,"user2",S12),file("foo.txt","hello world",F1),systemAddFile(S12,F1,S13),systemCd(S13,"/folder2",S14), file("ejemplo.txt","otro archivo",F2),systemAddFile(S14,F2,S15),systemDel(S15,"ejemplo.txt",S16).

% se elimina una carpeta con todos sus subdirectorios y archivos, se envían a la papelera.
%system("newSystem",S1),systemAddDrive(S1,"C","OS",10000000000,S2),systemRegister(S2,"user1",S3),systemRegister(S3,"user2",S4),systemLogin(S4, "user1",S5),systemSwitchDrive(S5,"C",S6),systemMkdir(S6,"folder1",S7),systemMkdir(S7,"folder2",S8),systemCd(S8,"folder1",S9),systemMkdir(S9,"folder11", S10),systemLogout(S10, S11),systemLogin(S11,"user2",S12),file("foo.txt","hello world",F1),systemAddFile(S12,F1,S13),systemCd(S13,"/folder2",S14), file("ejemplo.txt","otro archivo",F2),systemAddFile(S14,F2,S15),systemCd(S15,"/",S16),systemDel(S16,"folder1",S17).

% se intenta eliminar una carpeta que no existe, retorna false.
%system("newSystem",S1),systemAddDrive(S1,"C","OS",10000000000,S2),systemRegister(S2,"user1",S3),systemRegister(S3,"user2",S4),systemLogin(S4, "user1",S5),systemSwitchDrive(S5,"C",S6),systemMkdir(S6,"folder1",S7),systemMkdir(S7,"folder2",S8),systemCd(S8,"folder1",S9),systemMkdir(S9,"folder11", S10),systemLogout(S10, S11),systemLogin(S11,"user2",S12),file("foo.txt","hello world",F1),systemAddFile(S12,F1,S13),systemCd(S13,"/folder2",S14), file("ejemplo.txt","otro archivo",F2),systemAddFile(S14,F2,S15),systemDel(S15,"folder3",S16).

% se intenta eliminar un archivo que no existe, retorna false.
%system("newSystem",S1),systemAddDrive(S1,"C","OS",10000000000,S2),systemRegister(S2,"user1",S3),systemRegister(S3,"user2",S4),systemLogin(S4, "user1",S5),systemSwitchDrive(S5,"C",S6),systemMkdir(S6,"folder1",S7),systemMkdir(S7,"folder2",S8),systemCd(S8,"folder1",S9),systemMkdir(S9,"folder11", S10),systemLogout(S10, S11),systemLogin(S11,"user2",S12),file("foo.txt","hello world",F1),systemAddFile(S12,F1,S13),systemCd(S13,"/folder2",S14), file("ejemplo.txt","otro archivo",F2),systemAddFile(S14,F2,S15),systemDel(S15,"ayuda.docs",S16).


% se copia el archivo "ejemplo.txt" a otra ruta.
%system("newSystem", S1), systemAddDrive(S1, "C", "OS", 10000000000, S2), systemRegister(S2, "user1", S3), systemRegister(S3, "user2", S4), systemLogin(S4, "user1", S5), systemSwitchDrive(S5, "C", S6), systemMkdir(S6, "folder1", S7), systemMkdir(S7, "folder2", S8), systemCd(S8, "folder1", S9), systemMkdir(S9, "folder11", S10), systemLogout(S10, S11), systemLogin(S11, "user2", S12), file( "foo.txt", "hello world", F1), systemAddFile(S12, F1, S13), systemCd(S13, "/folder2", S14),  file( "ejemplo.txt", "otro archivo", F2), systemAddFile(S14, F2, S15),systemCopy(S15,"ejemplo.txt","c:/folder1/folder11/",S16).

% se copia la carpeta "folder1" y su contenido a la raíz otra unidad.
%system("newSystem", S1), systemAddDrive(S1, "C", "OS", 10000000000, S2), systemRegister(S2, "user1", S3), systemRegister(S3, "user2", S4), systemLogin(S4, "user1", S5), systemSwitchDrive(S5, "C", S6), systemMkdir(S6, "folder1", S7), systemMkdir(S7, "folder2", S8), systemCd(S8, "folder1", S9), systemMkdir(S9, "folder11", S10), systemLogout(S10, S11), systemLogin(S11, "user2", S12), file( "foo.txt", "hello world", F1), systemAddFile(S12, F1,S13),systemCd(S13, "/folder2", S14),  file("ejemplo.txt","otro archivo",F2),systemAddFile(S14,F2,S15),systemAddDrive(S15,"d","MEDIA",40000,S16),systemCd(S16,"..",S17),systemCopy(S17,"folder1","d:/",S18).

% se intenta copiar una carpeta a un directorio en que ya existe una carpeta con el mismo nombre, ya que se copió previamente, retorna false.
%system("newSystem", S1), systemAddDrive(S1, "C", "OS", 10000000000, S2), systemRegister(S2, "user1", S3), systemRegister(S3, "user2", S4), systemLogin(S4, "user1", S5), systemSwitchDrive(S5, "C", S6), systemMkdir(S6, "folder1", S7), systemMkdir(S7, "folder2", S8), systemCd(S8, "folder1", S9), systemMkdir(S9, "folder11", S10), systemLogout(S10, S11), systemLogin(S11, "user2", S12), file( "foo.txt", "hello world", F1), systemAddFile(S12, F1,S13),systemCd(S13, "/folder2", S14),  file("ejemplo.txt","otro archivo",F2),systemAddFile(S14,F2,S15),systemAddDrive(S15,"d","MEDIA",40000,S16),systemCd(S16,"..",S17),systemCopy(S17,"folder1","d:/",S18),systemCopy(S18,"folder1","d:/",S19).

% se copian todos los archivos que sean del tipo "txt" en el directorio a la ruta especificada.
%system("newSystem", S1), systemAddDrive(S1, "C", "OS", 10000000000, S2), systemRegister(S2, "user1", S3), systemRegister(S3, "user2", S4), systemLogin(S4, "user1", S5), systemSwitchDrive(S5, "C", S6), systemMkdir(S6, "folder1", S7), systemMkdir(S7, "folder2", S8), systemCd(S8, "folder1", S9), systemMkdir(S9, "folder11", S10), systemLogout(S10, S11), systemLogin(S11, "user2", S12), file( "foo.txt", "hello world", F1), systemAddFile(S12, F1,S13),systemCd(S13, "/folder2", S14),  file("ejemplo.txt","otro archivo",F2),systemAddFile(S14,F2,S15),systemAddDrive(S15,"d","MEDIA",40000,S16),file("prueba.txt","123",F3),systemAddFile(S16,F3,S17),systemCopy(S17,"*.txt","d:/",S18).


% se mueve el archivo "ejemplo.txt" a la ruta especificada.
%system("newSystem", S1), systemAddDrive(S1, "C", "OS", 10000000000, S2), systemRegister(S2, "user1", S3), systemRegister(S3, "user2", S4), systemLogin(S4, "user1", S5), systemSwitchDrive(S5, "C", S6), systemMkdir(S6, "folder1", S7), systemMkdir(S7, "folder2", S8), systemCd(S8, "folder1", S9), systemMkdir(S9, "folder11", S10), systemLogout(S10, S11), systemLogin(S11, "user2", S12), file( "foo.txt", "hello world", F1), systemAddFile(S12, F1, S13), systemCd(S13, "/folder2", S14),  file( "ejemplo.txt", "otro archivo", F2), systemAddFile(S14, F2, S15),systemMove(S15,"ejemplo.txt","c:/folder1/folder11/",S16).

% se mueve la carpeta "folder1" y su contenido a la raíz del drive "D".
%system("newSystem", S1), systemAddDrive(S1, "C", "OS", 10000000000, S2), systemRegister(S2, "user1", S3), systemRegister(S3, "user2", S4), systemLogin(S4, "user1", S5), systemSwitchDrive(S5, "C", S6), systemMkdir(S6, "folder1", S7), systemMkdir(S7, "folder2", S8), systemCd(S8, "folder1", S9), systemMkdir(S9, "folder11", S10), systemLogout(S10, S11), systemLogin(S11, "user2", S12), file( "foo.txt", "hello world", F1), systemAddFile(S12, F1,S13),systemCd(S13, "/folder2", S14),  file("ejemplo.txt","otro archivo",F2),systemAddFile(S14,F2,S15),systemAddDrive(S15,"d","MEDIA",40000,S16),systemCd(S16,"..",S17),systemMove(S17,"folder1","d:/",S18).

% se mueve el archivo "foo.txt" a un directorio que ya tiene un archivo con el mismo nombre, por lo que se sobreescribe.
%system("newSystem", S1), systemAddDrive(S1, "C", "OS", 10000000000, S2), systemRegister(S2, "user1", S3), systemRegister(S3, "user2", S4), systemLogin(S4, "user1", S5), systemSwitchDrive(S5, "C", S6), systemMkdir(S6, "folder1", S7), systemMkdir(S7, "folder2", S8), systemCd(S8, "folder1", S9), systemMkdir(S9, "folder11", S10), systemLogout(S10, S11), systemLogin(S11, "user2", S12), file( "foo.txt", "hello world", F1), systemAddFile(S12, F1,S13),systemCd(S13, "/folder2", S14),  file("foo.txt","este contenido fue reemplazado",F2),systemAddFile(S14,F2,S15),systemMove(S15,"foo.txt","c:/folder1/",S16).

% se intenta mover una carpeta inexistente, retorna false.
%system("newSystem", S1), systemAddDrive(S1, "C", "OS", 10000000000, S2), systemRegister(S2, "user1", S3), systemRegister(S3, "user2", S4), systemLogin(S4, "user1", S5), systemSwitchDrive(S5, "C", S6), systemMkdir(S6, "folder1", S7), systemMkdir(S7, "folder2", S8), systemCd(S8, "folder1", S9), systemMkdir(S9, "folder11", S10), systemLogout(S10, S11), systemLogin(S11, "user2", S12), file( "foo.txt", "hello world", F1), systemAddFile(S12, F1,S13),systemCd(S13, "/folder2", S14),  file("ejemplo.txt","456",F2),systemAddFile(S14,F2,S15),systemMove(S15,"folder5","c:/folder1/",S16).

% se intenta mover una carpeta a un destino inexistente, retorna false.
%system("newSystem", S1), systemAddDrive(S1, "C", "OS", 10000000000, S2), systemRegister(S2, "user1", S3), systemRegister(S3, "user2", S4), systemLogin(S4, "user1", S5), systemSwitchDrive(S5, "C", S6), systemMkdir(S6, "folder1", S7), systemMkdir(S7, "folder2", S8), systemCd(S8, "folder1", S9), systemMkdir(S9, "folder11", S10), systemLogout(S10, S11), systemLogin(S11, "user2", S12), file( "foo.txt", "hello world", F1), systemAddFile(S12, F1,S13),systemCd(S13, "/folder2", S14),  file("ejemplo.txt","456",F2),systemAddFile(S14,F2,S15),systemCd(S15,"/",S16),systemMove(S16,"folder1","c:/folder14/",S17).


% se cambia el nombre del archivo "ejemplo.txt" a "numeros.txt"
%system("newSystem", S1), systemAddDrive(S1, "C", "OS", 10000000000, S2), systemRegister(S2, "user1", S3), systemRegister(S3, "user2", S4), systemLogin(S4, "user1", S5), systemSwitchDrive(S5, "C", S6), systemMkdir(S6, "folder1", S7), systemMkdir(S7, "folder2", S8), systemCd(S8, "folder1", S9), systemMkdir(S9, "folder11", S10), systemLogout(S10, S11), systemLogin(S11, "user2", S12), file( "foo.txt", "hello world", F1), systemAddFile(S12, F1,S13),systemCd(S13, "/folder2", S14),  file("ejemplo.txt","456",F2),systemAddFile(S14,F2,S15),systemRen(S15,"ejemplo.txt","numeros.txt",S16).

% se cambia el nombre y tipo del archivo "ejemplo.txt" a "documento.docx"
%system("newSystem", S1), systemAddDrive(S1, "C", "OS", 10000000000, S2), systemRegister(S2, "user1", S3), systemRegister(S3, "user2", S4), systemLogin(S4, "user1", S5), systemSwitchDrive(S5, "C", S6), systemMkdir(S6, "folder1", S7), systemMkdir(S7, "folder2", S8), systemCd(S8, "folder1", S9), systemMkdir(S9, "folder11", S10), systemLogout(S10, S11), systemLogin(S11, "user2", S12), file( "foo.txt", "hello world", F1), systemAddFile(S12, F1,S13),systemCd(S13, "/folder2", S14),  file("ejemplo.txt","456",F2),systemAddFile(S14,F2,S15),systemRen(S15,"ejemplo.txt","documento.docx",S16).

% se intenta cambiar el nombre de un archivo inexistente, retorna false.
%system("newSystem", S1), systemAddDrive(S1, "C", "OS", 10000000000, S2), systemRegister(S2, "user1", S3), systemRegister(S3, "user2", S4), systemLogin(S4, "user1", S5), systemSwitchDrive(S5, "C", S6), systemMkdir(S6, "folder1", S7), systemMkdir(S7, "folder2", S8), systemCd(S8, "folder1", S9), systemMkdir(S9, "folder11", S10), systemLogout(S10, S11), systemLogin(S11, "user2", S12), file( "foo.txt", "hello world", F1), systemAddFile(S12, F1,S13),systemCd(S13, "/folder2", S14),  file("ejemplo.txt","456",F2),systemAddFile(S14,F2,S15),systemRen(S15,"ejemplo2.txt","documento.docx",S16).

% se cambia el nombre de una carpeta
%system("newSystem", S1), systemAddDrive(S1, "C", "OS", 10000000000, S2), systemRegister(S2, "user1", S3), systemRegister(S3, "user2", S4), systemLogin(S4, "user1", S5), systemSwitchDrive(S5, "C", S6), systemMkdir(S6, "folder1", S7), systemMkdir(S7, "folder2", S8), systemCd(S8, "folder1", S9), systemMkdir(S9, "folder11", S10), systemLogout(S10, S11), systemLogin(S11, "user2", S12), file( "foo.txt", "hello world", F1), systemAddFile(S12, F1,S13),systemCd(S13, "/folder2", S14),  file("ejemplo.txt","456",F2),systemAddFile(S14,F2,S15),systemCd(S15,"..",S16),systemRen(S16,"folder1","NewFolder1",S17).


% se lista el contenido del directorio actual
%system("newSystem", S1), systemAddDrive(S1, "C", "OS", 10000000000, S2), systemRegister(S2, "user1", S3), systemRegister(S3, "user2", S4), systemLogin(S4, "user1", S5), systemSwitchDrive(S5, "C", S6), systemMkdir(S6, "folder1", S7), systemMkdir(S7, "folder2", S8), systemCd(S8, "folder1", S9), systemMkdir(S9, "folder11", S10), systemLogout(S10, S11), systemLogin(S11, "user2", S12), file( "foo.txt", "hello world", F1), systemAddFile(S12, F1,S13),systemCd(S13, "/folder2", S14),  file("ejemplo.txt","456",F2),systemAddFile(S14,F2,S15),systemCd(S15,"/folder1",S16),systemMkdir(S16,"carpeta",S17),systemMkdir(S17,"Botellas",S18),file("ayudas.csv","7,7,7,1",F3),systemAddFile(S18,F3,S19),systemMkdir(S19,".escondido",S20),systemDir(S20,[],Str).

% se lista el contenido del directorio actual con las carpetas ocultas
%system("newSystem", S1), systemAddDrive(S1, "C", "OS", 10000000000, S2), systemRegister(S2, "user1", S3), systemRegister(S3, "user2", S4), systemLogin(S4, "user1", S5), systemSwitchDrive(S5, "C", S6), systemMkdir(S6, "folder1", S7), systemMkdir(S7, "folder2", S8), systemCd(S8, "folder1", S9), systemMkdir(S9, "folder11", S10), systemLogout(S10, S11), systemLogin(S11, "user2", S12), file( "foo.txt", "hello world", F1), systemAddFile(S12, F1,S13),systemCd(S13, "/folder2", S14),  file("ejemplo.txt","456",F2),systemAddFile(S14,F2,S15),systemCd(S15,"/folder1",S16),systemMkdir(S16,"carpeta",S17),systemMkdir(S17,"Botellas",S18),file("ayudas.csv","7,7,7,1",F3),systemAddFile(S18,F3,S19),systemMkdir(S19,".escondido",S20),systemDir(S20,["/a"],Str).

% se lista el contenido del directorio actual en orden alfabético
%system("newSystem", S1), systemAddDrive(S1, "C", "OS", 10000000000, S2), systemRegister(S2, "user1", S3), systemRegister(S3, "user2", S4), systemLogin(S4, "user1", S5), systemSwitchDrive(S5, "C", S6), systemMkdir(S6, "folder1", S7), systemMkdir(S7, "folder2", S8), systemCd(S8, "folder1", S9), systemMkdir(S9, "folder11", S10), systemLogout(S10, S11), systemLogin(S11, "user2", S12), file( "foo.txt", "hello world", F1), systemAddFile(S12, F1,S13),systemCd(S13, "/folder2", S14),  file("ejemplo.txt","456",F2),systemAddFile(S14,F2,S15),systemCd(S15,"/folder1",S16),systemMkdir(S16,"carpeta",S17),systemMkdir(S17,"Botellas",S18),file("ayudas.csv","7,7,7,1",F3),systemAddFile(S18,F3,S19),systemMkdir(S19,".escondido",S20),systemDir(S20,["/o N"],Str).

% se muestra el panel de ayuda de la clásula "systemDir"
%system("newSystem", S1), systemAddDrive(S1, "C", "OS", 10000000000, S2), systemRegister(S2, "user1", S3), systemRegister(S3, "user2", S4), systemLogin(S4, "user1", S5), systemSwitchDrive(S5, "C", S6), systemMkdir(S6, "folder1", S7), systemMkdir(S7, "folder2", S8), systemCd(S8, "folder1", S9), systemMkdir(S9, "folder11", S10), systemLogout(S10, S11), systemLogin(S11, "user2", S12), file( "foo.txt", "hello world", F1), systemAddFile(S12, F1,S13),systemCd(S13, "/folder2", S14),  file("ejemplo.txt","456",F2),systemAddFile(S14,F2,S15),systemCd(S15,"/folder1",S16),systemMkdir(S16,"carpeta",S17),systemMkdir(S17,"Botellas",S18),file("ayudas.csv","7,7,7,1",F3),systemAddFile(S18,F3,S19),systemMkdir(S19,".escondido",S20),systemDir(S20,["/?"],Str).


% se formatea la unidad en la que se están realizando las operaciones.
%system("newSystem", S1), systemAddDrive(S1, "C", "OS", 10000000000, S2), systemRegister(S2, "user1", S3), systemRegister(S3, "user2", S4), systemLogin(S4, "user1", S5), systemSwitchDrive(S5, "C", S6), systemMkdir(S6, "folder1", S7), systemMkdir(S7, "folder2", S8), systemCd(S8, "folder1", S9), systemMkdir(S9, "folder11", S10), systemLogout(S10, S11), systemLogin(S11, "user2", S12), file( "foo.txt", "hello world", F1), systemAddFile(S12, F1,S13),systemCd(S13, "/folder2", S14),  file("ejemplo.txt","456",F2),systemAddFile(S14,F2,S15),systemCd(S15,"/folder1",S16),systemMkdir(S16,"carpeta",S17),systemMkdir(S17,"Botellas",S18),file("ayudas.csv","7,7,7,1",F3),systemAddFile(S18,F3,S19),systemMkdir(S19,".escondido",S20),systemFormat(S20,"c","SWAP",S21).

% se formatea una unidad que no es la actual, se cambia el nombre de esa unidad.
%system("newSystem", S1), systemAddDrive(S1, "C", "OS", 10000000000, S2), systemRegister(S2, "user1", S3), systemRegister(S3, "user2", S4), systemLogin(S4, "user1", S5), systemSwitchDrive(S5, "C", S6), systemMkdir(S6, "folder1", S7), systemMkdir(S7, "folder2", S8), systemCd(S8, "folder1", S9), systemMkdir(S9, "folder11", S10), systemLogout(S10, S11), systemLogin(S11, "user2", S12), file( "foo.txt", "hello world", F1), systemAddFile(S12, F1,S13),systemCd(S13, "/folder2", S14),  file("ejemplo.txt","otro archivo",F2),systemAddFile(S14,F2,S15),systemAddDrive(S15,"d","MEDIA",40000,S16),systemCd(S16,"..",S17),systemMove(S17,"folder1","d:/",S18),systemFormat(S18,"D","Music",S19).

% se intenta formatear una unidad que no existe, retorna false.
%system("newSystem", S1), systemAddDrive(S1, "C", "OS", 10000000000, S2), systemRegister(S2, "user1", S3), systemRegister(S3, "user2", S4), systemLogin(S4, "user1", S5), systemSwitchDrive(S5, "C", S6), systemMkdir(S6, "folder1", S7), systemMkdir(S7, "folder2", S8), systemCd(S8, "folder1", S9), systemMkdir(S9, "folder11", S10), systemLogout(S10, S11), systemLogin(S11, "user2", S12), file( "foo.txt", "hello world", F1), systemAddFile(S12, F1,S13),systemCd(S13, "/folder2", S14),  file("ejemplo.txt","otro archivo",F2),systemAddFile(S14,F2,S15),systemAddDrive(S15,"d","MEDIA",40000,S16),systemCd(S16,"..",S17),systemMove(S17,"folder1","d:/",S18),systemFormat(S18,"F","Music",S19).


