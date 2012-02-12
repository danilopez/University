% Functores básicos
concatena([], Ys, Ys).
concatena([X|Xs], Ys, [X|XsYs]) :-
	concatena(Xs,Ys,XsYs).

% Problema 2. (1.0 pto.) Define el predicado suma(+Xs, -N) que dada una lista de enteros Xs devuelve en N la suma de los elementos de Xs. [Recursivo de cola]
suma(Xs,N) :- suma_cola(Xs,0,N).
suma_cola([],X,X).
suma_cola([X|Xs], Ac, N) :-
	NAc is Ac + X,
	suma_cola(Xs,NAc,N).

% Problema 3. (1.5 ptos) Dada la siguiente definición del predicado p/3:
p(X,Ys,Zs) :-
	concatena(As,[X|Bs],Ys),
	concatena(As,Bs,Zs).
% analiza su comportamiento y significado para los modos (+,+,-), (-,+,+) y (+,-,+):

% Solución:
% 	USO   | Comportamiento | Significado
% (+,+,-) | Generador acotado | Elimina el elemento X de la lista Ys, devolviendo Zs
% (-,+,+) | Generador acotado | Genera en X el elemento en que se diferencian Ys y Zs. Sólo tiene respuestas múltiples si aparecen varias X consecutivas.
% (+,-,+) | No termina | El primer concatena/3 es un generador no acotado. Generaría todas las listas posibles de Zs añadiendo infinitos elementos X.

% Problema 4. (1.0 pto.) Define un predicado recursivo de cola digitos(+N, -Ds) que dado un natural N devuelva en Ds la lista formada por los dígitos de N. Por ejemplo:
% ?- digitos(2371,Ds).
% Ds = [2,3,7,1].
% ?- digitos(6,Ds).
% Ds = [6].

digitos(N,Ds) :- digitos_cola(N,[],Ds).

digitos_cola(N,Ac,[N|Ac]) :-
	N // 10 =:= 0.
digitos_cola(N,Ac,Ds) :-
	N > 9,
	NAc is N mod 10,
	NewN is N // 10,
	digitos_cola(NewN,[NAc|Ac],Ds).

% Problema 5. (1.0 pto.) Define el predicado reduce(+X,?Y) que reduce un natural X sumanso sus dígitos, repitiendo esta reducción sobre las sumas obtenidas hasta llegar a un natural de un solo dígito Y. Por ejemplo: 2741 -> 2+7+4+1 -> 14 -> 1+4 -> 5
% ?- reduce(2741,Y).
% Y = 5.
% reduce(10640,2).
% true.

reduce(X,X) :-
	X >= 0,
	X <= 9.
reduce(X,Y) :-
	digitos(X,Xs),
	suma(Xs,Suma),
	reduce(Suma,Y).
	
% Problema 6. ()