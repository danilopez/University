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

% Problema 4. (2.5 ptos.) Representaremos una fila de platos con cerezas como una lista de números donde cada número indica el número de cerezas contenidas en el plato. Define el predicado salta(+Xs,+K,-Ys) que a partir de la lista Xs produzca la lista Ys, obtenida como resultado de pasar una cereza de un plato a otro tal que entre ellos hay otros platos que en total contienen exactamente K cerezas (da igual el número de platos). Así, el objetivo salta([1,2,1,2,0,3],3,Ys) produce para Ys los siguientes éxitos:
% Ys = [0,2,1,3,0,3] ;	Pasa una cereza del primer plato al cuarto
% Ys = [1,1,1,2,1,3] ;	Pasa una cereza del segundo plato al quinto
% Ys = [1,1,1,2,0,4] ;	Pasa una cereza del segundo plato al sexto
% Ys = [2,2,1,1,0,3] ;	Pasa una cereza del cuarto plato al primero
% Ys = [1,3,1,2,0,2] ;	Pasa una cereza del sexto plato al segundo
% SUGERENCIA: Utilizar el predicado separa/5 del ejercicio anterior.
salta(Xs,K,Ys) :-
	separa(Xs,K,As,[B|Bs],[C|Cs]),
	pasa(B,C,NB,NC),
	concatenar([NB|Bs],[NC|Cs],NBBsNCCs),
	concatenar(As,NBBsNCCs,Ys).

pasa(B,C,NB,NC) :-
	B > 0,
	NB is B-1,
	NC is C+1.

pasa(B,C,NB,NC) :-
	C > 0,
	NB is B + 1,
	NC is C - 1.
	
% Problema 5. (2.0 ptos.) Define el predicado sol(+E0, +K, +H, -Cs) al que se le pasa una fila de platos con cerezas inicial E0, un salto K (número de cerezas a saltar en cada movimiento) y un número H, y encuentra los movimientos necesarios Cs para trasvasar cerezas de forma que queden solo platos vacíos o con H cerezas.
sol(E0,K,H,[E0|Es]) :-
	sol_aux(E0,K,H,[E0],Es).

sol_aux(Ei,_H,_,[]) :-
	todos(Ei,H).
sol_aux(Ei,K,H,Vs,[Ej|Es]).
	salta(Ei,K,Ej),
	no_esta(Ej,Vs),
	sol_aux(Ej,K,H,[Ej|Vs],Es).