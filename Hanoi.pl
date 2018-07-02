%
%   author  = Andy Gonzalez
%   date    = 4/19/2018
%

% Simple entry.
% M is basically a list of logs
% Due to recursivity the reverse is needed
hanoi(D, M):-
    reverse(D, B),
    phrase( hanoi(B, [origen, destino, otro]), M).

% Use of grammar for building the logs
% H -> HmH | (Eps).
% Where m is a terminal symbol that indicates the performed operation.
% The non-terminal H is used relocating origin, destination and other according to case.
% Once all disks are relocated predicate will finish.
hanoi([A|D], [S,T,R]) -->
    hanoi(D, [S,R,T]),
    [mueve(A,S-->T)], 
    hanoi(D, [R,T,S]).
hanoi([], _) --> [].