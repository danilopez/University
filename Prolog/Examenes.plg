%%%%%%%%%%%%%%%%%%%%%%%
% Funciones básicas
%%%%%%%%%%%%%%%%%%%%%%%
concatena([],Ys,Ys).
concatena([X|Xs],Ys,[X|XsYs]) :-
	concatena(Xs,Ys,XsYs).

%%%%%%%%%%%%%%%%%%%%
%   Febrero 2011
%%%%%%%%%%%%%%%%%%%%
% (0.5 + 0.5 puntos) Ejercicio 2: Define mediante recursión los siguientes predicados:
% no_esta/2
no_esta(_,[]).
no_esta(X,[Y|Ys]) :-
	X \== Y,
	no_esta(X,Ys).

% selecciona/3
selecciona(X,[X|Ys],Ys).
selecciona(X,[Y|Ys],[Y|Zs]) :-
	selecciona(X,Ys,Zs).

% (0.5 puntos) Ejercicio 3: Define un predicado recursivo de cola producto(+Xs, -N) que dada una lista de enteros Xs devuelva en N el producto de sus elementos. Por ejemplo:
% ?- producto([1,2,3,4,5],N).
% N = 120.

producto(Xs,P) :-
	producto(Xs,1,P).

producto([],P,P).
producto([X|Xs],Ac,P) :-
	NAc is Ac*X,
	producto(Xs,NAc,P).

%  (1.0 punto) Ejercicio 4: Define el predicado interseccion(+Xs, +Ys, -Zs) que devuelve en Zs la interseccion de las listas Xs e Ys. Por ejemplo:
% ?- interseccion([a,b,c,d,e,f],[1,a,2,3,e,f,4],Zs).
% Zs = [a,e,f] ;
% false.
%
% ?- interseccion([a,X,b,Y,c],[A,Z,w,Y,b], Zs).
% Zs = [b,Y] ;
% false.

esta(X,[X|Xs]).
esta(X,[Y|Ys]) :-
	esta(X,Ys).

interseccion([], _, []).
interseccion([X|Xs], Ys, [X|Zs]) :-
	esta(X,Ys),
	interseccion(Xs,Ys, Zs).
interseccion([X|Xs], Ys, Zs) :-
	no_esta(X,Ys),
	interseccion(Xs, Ys, Zs).

% (1.5 puntos) Ejercicio 5: Define el predicado suma_demas(+Xs) que se satisface si la lista de enteros Xs contiene un elemento que es igual a la suma de los demás elementos. Por ejemplo:
% ?- suma_demas([1,2,3,10,4]).
% true ;
% false.

suma([],0).
suma([X|Xs],N) :-
	suma(Xs,M),
	N is M+X.

suma_demas(XsNYs) :-
	selecciona(N,XsNYs,XsYs),
	suma(XsYs,N).
	
% (1.5 puntos) Ejercicio 6: Define el predicado pareja_sp(+Xs,-A,-B) que dada una lista de enteros Xs devuelve dos elementos de la lista A y B tales que A aparece antes que B, la suma de ambos es menor que la suma de los elementos que preceden a A y el producto de ambos es mayor que el producto de los elementos que suceden a B. Por ejemplo:
% ?- pareja_sp([30,8,12,6,34],A,B).
% A = 8,
% B = 6 ;
% A = 12,
% B = 6 ;
% A = 6,
% B = 34 ;
% false.

pareja_sp(Xs, A, B) :-
	concatena(Antes, [A|Ts], Xs),
	concatena(_, [B|Despues], Ts),
	suma(Antes,S),
	S > A+B,
	producto(Despues,P),
	A*B > P.
	
% (1.5 + 1.5 puntos) Las relaciones de amistad de una red social están represantadas por el predicdo amigos(?P,?As), donde P es una persona y As es una lista con las personas que son amigos de P. El predicado amigos/2 está definido por un conjunto de hechos como el siguiente:
amigos(juan,[pedro]).
amigos(pedro,[juan, manuel, antonio,laura]).
amigos(manuel, [pedro, antonio, sonia]).
amigos(antonio, [manuel, sonia, pedro, sandra]).
amigos(laura, [sandra, pedro, sonia]).
amigos(sonia, [laura antonio, sandra, manuel]).
amigos(sandra, [antonio, sonia, laura]).

sugerido(X,K,S,Comunes) :-
	amigos(X,Ax),
	amigos(S,AS),
	S \== X,
	no_esta(S,Ax),
	interseccion(Ax, As, Comunes),
	longitud(Comunes,N),
	N >= K.