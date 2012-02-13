% Problema 2. (0.25 + 0.25 + 1.0 + 0.5 + 1.0 ptos.) Define los siguientes predicados:
% a. miembro(?X, ?Xs) que se satisface si X pertenece  la lista Xs
miembro(X,[X|_]).
miembro(X,[Y|Ys]) :-
	X \== Y,
	miembro(X,Ys).

% b. concatena(?Xs, ?Ys, ?Zs) que tiene éxito si la lista Zs es la concatenación de las listas Xs e Ys.
concatena([], Ys, Ys).
concatena([X|Xs],Ys,[X|XsYs]) :-
	concatena(Xs,Ys,XsYs).

% c. anterior(+Xs, ?X, ?Y) que se satisfaga cuando X aparezca antes que Y en la lista Xs
anterior(Xs,X,Y) :-
	concatena([X|_],[Y|_],Xs).
	
% d. no_esta(+X, +Xs) que determina si un elemento X no está en la lista Xs.
no_esta(_,[]).
no_esta(X,[Y|Ys]) :-
	X \== Y,
	no_esta(X,Ys).

% e. union(+Xs, +Ys, -Zs) que dadas dos listas sin elementos repetidos, Xs e Ys, devuelve en Zs la unión (sin elementos repetidos) de esas dos listas.
union([],Ys,Ys).
union([X|Xs],Ys,[X|Zs]) :-
	no_esta(X,Ys),
	union(Xs,Ys,Zs).
union([X|Xs],Ys,Zs) :-
	miembro(X,Ys),
	union(Xs,Ys,Zs).