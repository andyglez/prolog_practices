%
%   author  = Andy Gonzalez
%   date    = 4/17/2018
%


% Implementacion de functor utilizando =..
% Triunfa si:
%   T es el nombre de la funcion F y 
%   A es su cantidad de argumentos.
my_functor(T, F, A):-
    F =.. [T|Y],
    length(Y, A).

% Implementacion de arg utilizando =.. y predicado de apoyo
% Triunfa si:
%   El n-esimo argumento de T unifica con V.
my_arg(N, T, V):-
    T =.. [_|X],
    find(N, X, V).

% *** 0 based index *** % 
find(0, [X|_], X):-!.
find(N, [_|Y], Z):-
    M is N - 1,
    find(M, Y, Z).