preorden(nil, []).
preorden(binarytree(V,L,R), [V|Z]) :-
        preorden(L, LL),
        preorden(R, RR),
        append(LL, RR, Z).

postorden(nil, []).
postorden(binarytree(V,L,R), Z) :-
        postorden(L, LL),
        postorden(R, RR),
        append(LL, RR, Y),
        append(Y, [V], Z).

entreorden(nil, []).
entreorden(binarytree(V,L,R), Z) :-
        entreorden(L, LL),
        entreorden(R, RR),
        append(LL, [V|RR], Z).

bfs([nil|_], []).
bfs([binarytree(V, L, R)|Q], Z) :-
        append(Q, [L, R], P),
        bfs(P, Y),
        append([V], Y, Z).

abb(A):-
        entreorden(A, R),
        is_sort(R).

is_sort([]).
is_sort([X]).
is_sort([X,Y|R]):-
        X =< Y,
        is_sort([Y|R]).

pertenece(X, binarytree(X, L, R)).
pertenece(X, binarytree(V, L, R)):- X < Y, pertenece(X, L).
pertenece(X, binarytree(V, L, R)):- X > Y, pertenece(X, R).

solve(X) :-
        bfs(
                [binarytree(7,
                        binarytree(3,
                                binarytree(2, nil, nil),
                                binarytree(5, nil, nil)),
                        binarytree(8,nil,nil))], 
                X).