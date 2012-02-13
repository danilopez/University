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
	
% Problema 3. (2.25 ptos.) Aplicando generar/comprobar, define separa(+Ls,+N,-Xs,-Ys,-Zs) que dada la lista Ls la divide en tres sublistas Xs, Ys y Zs, cumpliendo las siguientes condiciones:
%	concatenadas las tres forman Ls
%	Ys y Zs son listas no vacías
% 	los elementos de la cola de Ys suman N
% Por ejemplo:
%
% ?- separa([1,2,1,3,2,1],3,Xs,Ys,Zs).
% Xs = [],
% Ys = [1,2,1],
% Zs = [3,2,1] ;
% Xs = [1, 2],
% Ys = [1, 3],
% Zs = [2, 1] ;
% false.
separa(Ls,N,Xs,[Y|Ys],[Z|Zs]) :-
	concatenar(Xs,YsZs,Ls), % genero Xs y las listas YsZs - condición 1
	concatenar([Y|Ys],[Z|Zs],YsZs), % genero las listas [Y|Ys] y [Z|Zs], y de esta manera no están vacías - condición 1 y 2
	suma(Ys,N). % compruebo la condición 3