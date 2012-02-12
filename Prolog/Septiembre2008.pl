%%%%%%%%%%%%%%%%%%%%%
% Funciones básicas
%%%%%%%%%%%%%%%%%%%%%


% Problema 2. (1.5 ptos.) Define un predicado recursivo de cola inserta_en_orden(+X,+AsBs,-AsXBs) que inserta un término X en una lista ordenada de términos AsBs, dando como resultado la lista ordenada AsXBs. Por ejemplo:
% ?- inserta_en_orden(rex,[buzz,woody],Xs).
% Xs = [buzz,rex,woody] ;
% false.
%
% ?- inserta_en_orden(3,[1,2,4],Xs).
% Xs = [1,2,3,4] ;
% false.
inserta_en_orden(X,[],[X]).
inserta_en_orden(X,[Y|Ys],[X,Y|Ys]) :-
	X @=< Y.
inserta_en_orden(X,[Y|Ys],[Y|Zs]) :-
	X @> Y,
	inserta_en_orden(X,Ys,Zs).
	
% Problema 3. (0.25 + 0.25 + 0.75 + 0.75 ptos.) Define los predicados:
% a. esta(+X,+Xs), que verifique si X se encuentra en la lista Xs
esta(X,[X|_]).
esta(X,[Y|Ys]) :-
	esta(X,Ys),
	X \== Y.

% b. no_esta(+X,+Xs) que se verifique justo en el caso contrario.
no_esta(_,[]).
no_esta(X,[Y|Ys]) :-
	no_esta(X,Ys),
	X \== Y.

% c. concatena(?Xs,?Ys,?Zs) que se verifique cuando Zs es la concatenación de las listas Xs e Ys
concatena([],Ys,Ys).
concatena([X|Xs],Ys,[X|XsYs]) :-
	concatena(Xs,Ys,XsYs).

% d. selecciona(?X,?XsXYs,?XsYs) que se verifique cuando la lista XsYs resulta de la lista XsXYs al suprimir una aparición del elemento X.
selecciona(X,[X|Xs],Xs).
selecciona(X,[Y|Xs],[Y|Ys]) :-
	selecciona(X,Xs,Ys).