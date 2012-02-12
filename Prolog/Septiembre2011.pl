% Funciones básicas
% miembro/2
miembro(X,[X|_]).
miembro(X,[Y|Ys]) :-
	miembro(X,Ys),
	X \== Y.

% concatena/3
concatena([], Ys, Ys).
concatena([X|Xs], Ys, [X|XsYs]) :-
	concatena(Xs,Ys,XsYs).

% selecciona/3
selecciona(X,[X|Bs],Bs).
selecciona(X,[Y|YsXBs],[Y|YsBs]) :-
	selecciona(X,YsXBs,YsBs).

% suma/2
suma([X],X).
suma([X|Xs],T) :-
	suma(Xs,Suma),
	T is Suma + X.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Problema 2. (1.0 + 1.5 + 1.0 ptos.) Representaremos los enteros por términos de acuerdo con la siguiente sintaxis:
%		Ent ::= c | s(Ent) | p(Ent)
% donde c representa el cero, s/1 al sucesor de un entero y p/1 al predecesor de un entero. Los functores s/1 y p/1 pueden mezclarse libremente en un mismo término; es decir, los enteros no están normalizados. Por ejemplo, los siguientes términos son todos representaciones del entero 2:
%	s(s(c))						s(s(p(s(c))))
%	p(p(p(s(s(s(s(s(c))))))))	p(s(p(s(s(s(c))))))

% a. Define el predicado separa(+E,-P,-S) que dado un entero E devuelva en P sus functores predecesor p/1 y en S sus functores sucesor s/1. Por ejemplo:
% ?- separa(p(s(p(s(s(s(p(s(c)))))))),P,S).
% P = p(p(p(c))),
% S = s(s(s(s(s(c))))).
% ?- separa(s(s(c)),P,S).
% P = c,
% S = s(s(c)).
separa(c,c,c).
separa(s(E),P,s(S)) :-
	separa(E,P,S).
separa(p(E),p(P),S) :-
	separa(E,P,S).

% b. Define el predicado suma(+P,+S,-X) que dados un entero P que sólo tiene functores predecesor p/1 y otro entero S que sólotiene functores sucesor s/1 devuelve en X su suma. Por ejemplo:
% ?- suma(p(p(c)),s(s(c)),X).
% x = c ;
% false.
% ?- suma(p(p(c)), s(s(s(c))), X).
% X = s(c).
suma(c,c,c).
suma(p(P),c,p(P)).
suma(c,s(S),s(S)).
suma(p(P),s(S),X) :-
	suma(P,S,X).

% c. Define el predicado normaliza(+E, -EN) que dado un entero E devuelve en EN su representación normalizada; es decir, que sólo emplea functores p/1 o s/1, según el entero sea positivo o negativo. Por ejemplo:
% ?- normaliza(p(p(p(s(s(s(s(s(c)))))))), EN).
% EN = s(s(c)).
% ?- normaliza(c,EN).
% EN = c.
% ?- normaliza(p(s(p(p(c)))),EN).
% EN = p(p(c)).
normaliza(c,c).
normaliza(E,EN) :-
	separa(E,P,S),
	suma(P,S,EN).

% Problema 3. (1.5 ptos.) Las incógnitas A,B,C y D de la figura de abajo pueden reemplazarse por números distintos entre 1 y 4, de forma que los cuatro números contenidos en cada círculo sumen la misma cantidad. Define un predicado circulos(A, B, C, D) que calcule el valor de las incógnitas.
circulos(A, B, C, D) :-
	ABCD = [1,2,3,4],
	selecciona(A,ABCD,BCD),
	selecciona(B,BCD, CD),
	selecciona(C,CD,[D]),
	S is 5 + A + B + C,
	S =:= 6 + A + C + D,
	S =:= 7 + B + C + D.

% Problema 4. (1.5 ptos.) Define el predicado diccionario(+Alfabeto,+N,-Palabra) que dados una lista de símbolos Alfabeto y una cantidad N, genera en Palabra todas las palabras que se pueden formar con N símbolos de Alfabeto. Las palabras deben generarse ordenadas según el orden del alfabeto. Por ejemplo:
% ?- diccionario([tau, pi, xi], 2, Ps).
% Ps = [tau, tau] ;
% Ps = [tau, pi] ;
% Ps = [tau, xi] ;
% Ps = [pi, tau] ;
% Ps = [pi, pi] ;
% Ps = [pi, xi] ;
% Ps = [xi, tau] ;
% Ps = [xi, pi] ;
% Ps = [xi, xi] ;
% false.
diccionario(_,0,[]).
diccionario(Alfabeto,N,[P|Ps]) :-
	N > 0,
	miembro(P,Alfabeto),
	N1 is N-1,
	diccionario(Alfabeto,N1,Ps).

% Problema 5. (2.0 puntos) Define el predicado divide(+Xs, -Ps) que dada una lista de enteros Xs la divide en N sublistas no vacías -siendo N par- de manera que la suma de los elementos de la primera es igual a la suma de los elementos de la última, la suma de los elementos de la segunda es igual a la suma de los elementos de la penúltima y, en general, la suma de los elementos de la iésima (i <= N/2) es igual a la suma de los elementos de de la N-i+1 -ésima. Las sublistas se devuelven emparejadas en la lista de pares de listas Ps. Por ejemplo:
% ?- divide([1,2,3,7,4,1,9,1,4,2],S).
% S = [([1,2,3],[4,2]),([7,4],[1,9,1])] ;
% S = [([1,2,3,7,4],[1,9,1,4,2])] ;
% false.
