%%%%%%%%%%%%%%%%%%%%%
%   Febrero 2009
%%%%%%%%%%%%%%%%%%%%%
% Funtores básicos
%%%%%%%%%%%%%%%%%%%%%

concatena([],Ys,Ys).
concatena([X|Xs],Ys,[X|XsYs]) :-
	concatena(Xs,Ys,XsYs).
no_esta(_,[]).
no_esta(X,[Y|Ys]) :-
	no_esta(X,Ys).
	X \== Y.

%%%%%%%%%%%%%%%%%%%%%%
% Problema 2. (1.0 pto.) Define el predicado todos_iguales(+Xs) que se satisface si la lista Xs tiene todos los elementos iguales entre sí. Por ejemplo:
todos_iguales([]).
todos_iguales([_]).
todos_iguales([X,Y|Xs]) :-
	todos_iguales([Y|Xs]),
	X == Y.
	
% Problema 3. (0.25 + 0.25 + 1.0 ptos.) Tenemos bolas de colores rojo, verde y azul. Los colores están ordenados circularmente de manera que el sucesor del rojo es el verde, el del verde el azul, y el del azul el rojo.
% a. Define el predicado sucesor(?X, ?Y) que se satisface si Y es el color sucesor de X. Por ejemplo:
sucesor(rojo,verde).
sucesor(verde,azul).
sucesor(azul,rojo).

% b. Define el predicado sucesores(+Xs, -Ys) que dada una lista de bolas de colores Xs devuelve la lista Ys donde cada bola de Xs ha sido reemplazada por su sucesora. Por ejemplo:
% ?- sucesores([rojo, verde, verde, rojo, azul], Ys).
% Ys = [verde, azul, azul, verde, rojo].
sucesores([],[]).
sucesores([X|Xs],[Y|Ys]) :-
	sucesor(X,Y),
	sucesores(Xs,Ys).

% c. Define un predicado recursivo de cola cuenta(+Xs, -R, -V, -A) que dada una lista de bolas de colores Xs devuelva en R, V y A el número de bolas rojas, verdes y azules que contiene. Por ejemplo:
% ?- cuenta([rojo, verde, verde, azul, rojo, azul, rojo, verde], R, V, A).
% R = 3,
% V = 3,
% A = 2 ;
% false.

cuenta(Xs,R,V,A) :- cuenta_cola(Xs,0,0,0,R,V,A).
cuenta_cola([],R,V,A,R,V,A).
cuenta_cola([rojo|Xs],Acr,Acv,Aca,R,V,A) :- % caso bola roja
	NAc is Acr + 1,
	cuenta_cola(Xs,NAc,Acv,Aca,R,V,A).
cuenta_cola([verde|Xs],Acr,Acv,Aca,R,V,A) :- % caso bola verde
	NAc is Acv + 1,
	cuenta_cola(Xs,Acr,NAc,Aca,R,V,A).
cuenta_cola([azul|Xs],Acr,Acv,Aca,R,V,A) :- % caso bola azul
	NAc is Aca + 1,
	cuenta_cola(Xs,Acr,Acv,NAc,R,V,A).

% Problema 4. (2.0 ptos.) Define el predicado tres(+Xs) que tiene éxito si la lista de bolas Xs está formada por tres segmentos consecutivos no vacíos monocromos, tales que el color de cada segmento es diferente del de los demás. Por ejmplo:
% ?- tres([rojo,rojo,azul,azul,verde]).
% true ;
% false.
% ?- tres([rojo,verde,verde,rojo]).
% false.
tres(XsYsZs) :-
	concatena([X|Xs],[Y|YsZs],XsYsZs),
	X \== Y,
	todos_iguales([X|Xs]),
	concatena(Ys,[Z|Zs],YsZs),
	Y \== Z,
	X \== Z,
	todos_iguales([Y|Ys]),
	todos_iguales([Z|Zs]).
	
% Problema 5. (1.0 + 2.0 + 1.5 ptos) El juego del bolyx consiste en partir de una lista de bolas de colores rojo, verde y azul, e ir reemplazando las bolas de un color por bolas de otro hasta obtener una lista que contenga bolas de tres colores, sin que el número de bolas de un color llegue a superar al de otro color en más de dos unidades, y tal que todas las bolas de un mismo color aparezcan consecutivas. La siguiente es una lista de bolas para la que el juego acaba (estado final):
% [azul, azul, verde, verde, verde, rojo]
% a. Define el predicado estado_final(Ei) que se satisface si Ei es un estado final del juego.
estado_final(Ei) :-
	tres(Ei),
	cuenta(Ei,R,V,A),
	abs(R-V) =< 2,
	abs(R-A) =< 2,
	abs(V-A) =< 2.
	
% b. La regla para reemplazar bolas es la siguiente: dadas dos bolas no consecutivas del mismo color entre las cuales no aparece ninguna bola de ese color, se reemplaza cada bola que aparezca entre ellas por una bola de su color sucesor. Por ejemplo, dada la fila de bolas:
% [rojo, verde, verde, azul, rojo, azul]
% solo es posible efectuar los siguientes dos reemplazamientos:
% [rojo, verde, verde, azul, rojo, azul] -> [rojo, azul, azul, rojo, rojo, azul]
% [rojo, verde, verde, azul, rojo, azul] -> [rojo, verde, verde, azul, verde, azul]
% Define el predicado separa(+Xs, -Primero, -Medio, -Final) que separe, si es posible, la lista de bolas Xs en tres segmentos consecutivos no vacíos, tales que el primero acaba en el color en que comienza el último, y ese color no aparece en el de enmedio. Por ejemplo:
% ?- separa([rojo, verde, verde, azul, rojo, azul], Primero, Medio, Final).
% Primero = [rojo],
% Medio = [verde, verde, azul],
% Final = [rojo, azul] ;
%
% Primero = [rojo, verde, verde, azul],
% Medio = [rojo],
% Final = [azul] ;
% false.
separa(PrimeroXMedioXFinal,[P|PrimeroX],[M|Medio],[X|Final]) :-
	concatena([P|PrimeroX],MedioXFinal,PrimeroXMedioXFinal),
	concatena(_, [X],[P|PrimeroX]),
	concatena([M|Medio],[X|Final],MedioXFinal),
	no_esta(X,[M|Medio]).

% c. Define el predicado mover(+Ei, -Ej) que dado un estado Ei devuelve sus estados sucesores Ej. Por ejemplo:
% ?- mover([rojo, verde, verde, azul, rojo, azul], Ej).
% Ej = [rojo, azul, azul, rojo, rojo, azul] ;
% Ej = [rojo, verde, verde, azul, verde, azul] ;
% false.

mover(Ei,Ej) :-
	separa(Ei,Primero,Medio,Final),
	sucesores(Medio,NMedio),
	concatena(NMedio,Final,NMedioFinal),
	concatena(Primero,NMedioFinal,Ej).