% Problema 2. (1.0 pto.) Define el predicado suma(+Xs, -N) que dada una lista de enteros Xs devuelve en N la suma de los elementos de Xs. [Recursivo de cola]
suma(Xs,N) :- suma_cola(Xs,0,N).
suma_cola([],X,X).
suma_cola([X|Xs], Ac, N) :-
	NAc is Ac + X,
	suma_cola(Xs,NAc,N).


