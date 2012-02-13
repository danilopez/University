% Problema 2. (2.0 ptos.) Define los siguientes predicados sobre listas:
% concatenar(?Xs,?Ys,?Zs)	Zs es el resultado de yuxtaponer los elementos de Xs e Ys
% suma(+Xs,-N)				la suma de los elementos de la lista Xs es N
% todos(+Xs,+N)				todos los elementos de la lista Xs son iguales a N o a 0
% no_esta(+X,+Xs)			X no está en la lista Xs
concatenar([],Ys,Ys).
concatenar([X|Xs],Ys,[X|XsYs]) :-
	concatenar(Xs,Ys,XsYs).

suma([],0).
suma([X|Xs],Ys) :-
	suma(Xs,NYs),
	Ys is X + NYs.

todos([],_).
todos([X|Xs],N) :-
	vale(X,N),
	todos(Xs,X).

vale(X,X).
vale(0,_).

no_esta(_,[]).
no_esta(X,[Y|Ys]) :-
	X \== Y,
	no_esta(X,Ys).