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

