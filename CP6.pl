regalo(coche).
regalo(casa).
regalo(viaje).
regalo(barco).

compatible(juan, eva).
compatible(rafael, ana).
compatible(ana, eva).

repartir([], []) :- !.
repartir([P|Y], [P:R|Z]) :-
    repartir(Y, Z),
    regalo(R),
    factible(P, R, Z).

factible(_, _, []) :- !.
factible(P, R, [N:R|Y]) :-
    (compatible(P,N) ; compatible(N,P)), !,
    factible(P, R, Y).
factible(P, R, [_:Z|Y]) :-
    R \= Z,
    factible(P, R, Y).

% Determinar cuantas soluciones factibles existen regalandole un viaje a ana
% :- findall(R, (repartir([ana,eva,juan,pepe,concha,rafael], R), member(ana:viaje, R)), LC), length(LC, C).

% Hallar una reparticion y de ella determinar los q recibiran un coche como regalo.
% :- repartir([ana, eva, juan, pepe, concha, rafael], R), findall(X, member(X:coche, R), L).

% Indica al usuario cuantos regalos de cada tipo debe comprar
% :- repartir([ana, eva, juan, pepe, concha, rafael], R), findall(X:Y, (regalo(X), findall(Z, member(Z:X, R), L), length(L, Y)), C).

% ============= Ejercicio 2 ===============

libro(libro_100, 8).
libro(libro_25, 2).
libro(libro_59, 0).

libro_prestado('Ana', libro_100).
libro_prestado('Pedro', libro_25).

libro_en_consulta('Miguel', libro_100).
libro_en_consulta('Miguel', libro_25).

fotocopiando(libro_59).

% *** Predicados a definir ***

% ** Queries basicas **

info_prestamos(LP):-
    findall(X, libro_prestado(_, X), LP).
info_consultas(LC):-
    findall(X, libro_en_consulta(_, X), LC).
info_libros(M, R):-
    findall(L:C, (libro(L, C), C > M), R).

% ****
% ** Queries de 'facilidad' **

basica(_, referencia).
basica(U, consulta):-
    findall(^, libro_en_consulta(U, _), LC),
    length(LC, C),
    C < 2.

adicional(U, prestamo):-
    findall(^, libro_prestado(U, _), LP),
    length(LP, C),
    C = 0.
adicional(_, fotocopia):-
    findall(^, fotocopiando(_), L),
    length(L, C),
    C = 0.

facilidad(U, basica:F):-
    basica(U, F).
facilidad(U, adicional:F):-
    adicional(U, F).

% ****

% ********** Operaciones ****************
prestar(U, L):-
    libro(L, E), E > 0,
    facilidad(U, adicional:prestamo),
    assert(libro_prestado(U, L)).

consultar(U, L):-
    libro(L, E), E > 0,
    facilidad(U, basica:consulta),
    assert(libro_en_consulta(U, L)).

fotocopiar(U, L):-
    libro(L, E), E > 0,
    facilidad(U, adicional:fotocopia),
    assert(fotocopiando(L)).

% ************* Inversas *****************

devolver(U, L):-
    % -- No se puede modificar un predicado estatico :( 
    % libro(L, E),
    % N is E + 1,
    % retract(libro(L, E)),
    % assert(libro(L, N)),
    % -- Solo esto se puede hacer
    retract(libro_prestado(U, L)).

terminar_consulta(U, L):-
    retract(libro_en_consulta(U,L)).

fotocopia_terminada(L):-
    retract(fotocopiando(L)).

% ================= Ejercicio 3 =======================

% familia(P, M, H)

fecha(_, _, _).
trabaja(_, _).
persona(_, _, _, fecha(_, _, _), trabaja(_, _)).
persona(_, _, _, fecha(_, _, _), desempleado).

familia(persona(_, _, _, _, _), persona(_, _, _, _, _), [persona(_, _, _, _, _) | _]).

datos_persona(P, L):-
    P =.. [_|L].

datos_marido(familia(M, _, _), L):-
    datos_persona(M, L).

datos_esposa(familia(_, E, _), L):-
    datos_persona(E, L).

lista_hijos(familia(_, _, L), L).
indiza_lista(0, [X|_], X):-!.
indiza_lista(N, [_|Y], Z):-
    M is N-1,
    indiza_lista(M, Y, Z).

datos_n_hijo(familia(_,_ ,H), N, L):-
    lista_hijos(H, R),
    indiza_lista(N, R, X),
    datos_persona(X, L).

datos_todos(L):-
    findall(X, X =.. [persona, _, _, _, fecha(_, _, _), trabaja(_, _)], L).

nacimiento_todos(L):-
    datos_todos(R),
    

