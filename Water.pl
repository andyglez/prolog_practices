%
%   author  = Andy Gonzalez
%   date    = 4/21/2018
%

% Simple entry point that represents just another example
entry(S):-
    movimientos([0, 3], [0,4], 2, S).

% In this case, prolog cut feature is mostly used
% Based on different cases for different unifications
% Fill y move are almost the same thing in every case.
% But fill will be no longer needed once the second has the required amount.
water([_, _], [_,_], 0, []):- !.
water([0, T1], [C2, T2], M, [fill(first)|H]):-
    !, water([T1, T1], [C2, T2], M, H).
water([C1, T1], [T2, T2], M, [empty(second)|H]):-
    !, water([C1, T1], [0, T2], M, H).
water([C1, T1], [0, T2], M, [move(first, secund, C1)|H]):- 
    !, N is M - 1,
    water([0, T1], [C1, T2], N, H).
water([T1, T1], [C2, T2], M, [move(first, second, X)|H]):-
    X is T2 - C2, Y is T1 - X, 
    water([Y, T1], [T2, T2], M, H).

