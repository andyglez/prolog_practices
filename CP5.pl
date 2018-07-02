%
%   author  = Andy Gonzalez
%   date    = 3/4/2018
%   


% ***********  Interseccion **************
% Se pretende una sola respuesta por RC, de ahi el uso de corte.
% La idea es, dejo una lista como es originalmente y voy reconociendo sobre la otra.
%   1 - Si X es la cabeza del resultado y es, a su vez, la cabeza de mi primera lista,
% entonces chequeo su membresia en la segunda para luego continuar.
%   2 - Si la cabeza de la primera no tiene membresia en la segunda entonces seguimos al siguiente elemento.
% ** Limitacion ** 
% En caso de tener instanciadas los tres parametros, para la lista interseccion se debe tener en cuenta el
% orden de la primera lista, si se descuida puede dar una respuesta incorrecta y no deseada.

interseccion([], _, []).
interseccion([X|A], Y, [X|R]):-
    member(X, Y), !,
    interseccion(A, Y, R).
interseccion([_|A], Y, R):-
    interseccion(A, Y, R).

% *****************************************


% ************    Union   *****************
% Se reutiliza la idea aplicada anteriormente en la interseccion
% Con la diferencia de sus definiciones.

union([], X, X).
union([X|A], Y, R):-
    member(X, Y), !,
    union(A, Y, R).
union([X|A], Y, [X|R]):-
    union(A, Y, R).

% *****************************************


% ************ Otras operaciones sobre listas

aplanar([], []).
aplanar([X|Y], Z):-
    is_list(X), !,
    aplanar(X, R),
    aplanar(Y, S),
    append(R, S, Z).
aplanar([X|Y], [X|Z]):-
    aplanar(Y, Z).


comprimir([X], [X]):-!.
comprimir([X,Y|Z], [X|R]):-
    not(X=Y), !,
    comprimir([Y|Z], R).
comprimir([X,X|Z], R):-
    comprimir([X|Z], R).


empaquetar([X], [X]):- !.
empaquetar([X,Y|Z], [[X]|R]):-
    not(X=Y), !,
    empaquetar([Y|Z], R).
empaquetar([X,X|Z], [[X|T]|R]):-
    empaquetar([X|Z], [T|R]).


prefijo([], _, []):-!.
prefijo(_, [], []):-!.
prefijo([X|_], [Y|_], []):-
    not(X=Y), !.
prefijo([X|A], [X|B], [X|R]):-
    prefijo(A,B,R).

sufijo(A,B,R):-
    reverse(A,X),
    reverse(B,Y),
    prefijo(X,Y,Z),
    reverse(Z,R).


elimina_todos(_, [], []):-!.
elimina_todos(E, [X|Y], [X|Z]):-
    not(E=X), !,
    elimina_todos(E, Y, Z).
elimina_todos(E, [E|Y], Z):-
    elimina_todos(E, Y, Z).