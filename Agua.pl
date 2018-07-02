%
%   author  = Andy Gonzalez
%   date    = 4/21/2018
%

% Entrada sencilla para obtener el resultado deseado y nada mas.
entry(S):-
    movimientos([0, 3], [0,4], 2, S).

% En este caso, se utiliza en mayor parte la casuistica para decantar resultados
% Me apoyo en el corte de Prolog para dar resultados validos.
% Llenar y trasvasar representa que esas mismas dos operaciones se haran una vez menos que antes de hacerlas.
% Por tanto ya no tener q llenar mas indica que se ha llegado al resultado deseado.
movimientos([_, _], [_,_], 0, []):- !.
movimientos([0, T1], [C2, T2], M, [llena(primero)|H]):-
    !, movimientos([T1, T1], [C2, T2], M, H).
movimientos([C1, T1], [T2, T2], M, [vacia(segundo)|H]):-
    !, movimientos([C1, T1], [0, T2], M, H).
movimientos([C1, T1], [0, T2], M, [trasvasa(primero, segundo, C1)|H]):- 
    !, N is M - 1,
    movimientos([0, T1], [C1, T2], N, H).
movimientos([T1, T1], [C2, T2], M, [trasvasa(primero, segundo, X)|H]):-
    X is T2 - C2, Y is T1 - X, 
    movimientos([Y, T1], [T2, T2], M, H).

