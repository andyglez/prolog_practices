%
%   author  = Andy Gonzalez
%   date    = 4/17/2018
%


% functor implementation using =..
% True if:
%   T is the function name for F AND 
%   A is its number of args.
my_functor(T, F, A):-
    F =.. [T|Y],
    length(Y, A).

% arg implementation using =.. and support predicate
% True if:
%   N-th arg of T unifies with V.
my_arg(N, T, V):-
    T =.. [_|X],
    find(N, X, V).

% *** 0 based index *** % 
find(0, [X|_], X):-!.
find(N, [_|Y], Z):-
    M is N - 1,
    find(M, Y, Z).