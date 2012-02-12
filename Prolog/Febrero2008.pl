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

