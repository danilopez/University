%%%%%%%%%%%%%%%%%%%%%%%%%
%     Febrero 2010
%%%%%%%%%%%%%%%%%%%%%%%%%

% Problema 3. (1.0 pto.) Define el predicado aplana(+Xss, -Xs) que "aplana" una lista de listas. Por ejemplo:
% ?- aplana([[a,b,c], [d], [], [e,f]], Xs).
% Xs = [a, b, c, d, e, f].
%
% ?- aplana([[a,b]], Xs).
% Xs = [a,b].
%
% ?- aplana([[]], Xs).
% Xs = [].
%
% ?- aplana([], Xs).
% Xs = [].

aplana([],[]).
aplana([Xs|Xss],Zs) :-
	aplana(Xss,Ys),
	concatena(Xs, Ys, Zs).

% Problema 4. (1.0 + 0.5 ptos.) Define el predicado trocea(+Xs, -As, Bs, -Cs) que, dada una lista Xs, la separa en tres trozos As, Bs y Cs, tales que Bs no es vacío y los tres juntos forman Xs. Por ejemplo:
% ?- trocea([a,b,c], As, Bs, Cs).
% As = [],		Bs = [a],		Cs = [b,c] ;
% As = [],		Bs= [a,b],		Cs = [c] ;
% As = [],		Bs= [a,b,c],	Cs = [] ;
% As = [a],		Bs = [b],		Cs = [c] ;
% As = [a],		Bs= [b,c],		Cs = [] ;
% As = [a, b],	Bs = [c],		Cs = []
% false.

trocea(Xs, As, [B|Bs], Cs) :-
	concatena(As,[B|BsCs],Xs),
	concatena(Bs, Cs, BsCs).

% Problema 5.
% Define el predicado inicial(-E0) que devuelve en E0 un casillero en el estado inicial.
inicial([v,v,v,v,v,v,b,n,b,n,b]).

% Define el predicado final(+Ei) que tiene éxito si Ei es un casillero reorganizado. Por ejemplo:
% ?- final([v,v,b,b,b,n,n,v,v,v,v]).
% true.
% ?- final([v,v,b,b,b,v,n,n,v,v,v]).
% false.
% ?- final([v,v,b,b,n,b,n,v,v,v,v]).
% false.

contiguas([b,b,b,n,n]).
contiguas([n,n,b,b,b]).

% sin comprobar si el estado es válido
final(Fs) :-
	contiguas(Fichas),
	trocea(Fs, _, Fichas, _).

% comprobando si el estado es válido
final(Fs) :-
	contiguas(Fichas),
	trocea(Fs, Xs, Fichas, Ys),
	concatena(Xs, Ys, [v,v,v,v,v,v,v]).