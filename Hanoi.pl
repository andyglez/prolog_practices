%
%   author  = Andy Gonzalez
%   date    = 4/19/2018
%

% Entrada sencilla para el predicado Hanoi.
% En M se escribira cada paso (o cambio de posicion de discos)
% Se le llama con el reverso de la lista original debido a la recursividad, en profundidad se obtienen los mensajes en modo contrario.
hanoi(D, M):-
    reverse(D, B),
    phrase( hanoi(B, [origen, destino, otro]), M).

% La gramatica se utiliza para construir la informacion de cada paso.
% H -> HmH | (Eps).
% Donde m es el terminal q indica lo realizado en su paso.
% El no-terminal H se llama actualizando ordenes de origen, destino y otro segun el caso requiera.
% Una vez terminado de colocar todas los discos la gramatica culmina y por ende el programa.
hanoi([A|D], [S,T,R]) -->
    hanoi(D, [S,R,T]),
    [mueve(A,S-->T)], 
    hanoi(D, [R,T,S]).
hanoi([], _) --> [].