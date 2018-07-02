pow(_, N, 1):- N = 0, !.
pow(X, N, P):-
    M is N - 1,
    pow(X, M, Q),
    P is Q * X.

mcd(X, Y, X):- X = Y, !.
mcd(X, Y, Z):-
    X < Y, !,
    N is Y - X,
    mcd(X, N, Z).
mcd(X, Y, Z):-
    X > Y,
    N is X - Y,
    mcd(N, Y, Z).

factorial(N, 1):- N = 0, !.
factorial(N, F):-
    M is N - 1,
    factorial(M, R),
    F is R * N.

sumalista([], 0).
sumalista([X|Y], R):-
    sumalista(Y, S),
    R is X + S.    

producto_escalar([], [], 0).
producto_escalar([A|B], [C|D], R):-
    producto_escalar(B, D, S),
    T is A * C,
    R is T + S.
