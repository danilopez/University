%%%%%%%%%%%%%%%%%%%%%
% Funciones básicas
%%%%%%%%%%%%%%%%%%%%%


% Problema 2. (1.5 ptos.) Define un predicado recursivo de cola inserta_en_orden(+X,+AsBs,-AsXBs) que inserta un término X en una lista ordenada de términos AsBs, dando como resultado la lista ordenada AsXBs. Por ejemplo:
% ?- inserta_en_orden(rex,[buzz,woody],Xs).
% Xs = [buzz,rex,woody] ;
% false.
%
% ?- inserta_en_orden(3,[1,2,4],Xs).
% Xs = [1,2,3,4] ;
% false.
inserta_en_orden(X,[],[X]).
inserta_en_orden(X,[Y|Ys],[X,Y|Ys]) :-
	X @=< Y.
inserta_en_orden(X,[Y|Ys],[Y|Zs]) :-
	X @> Y,
	inserta_en_orden(X,Ys,Zs).
	
% Problema 3. (0.25 + 0.25 + 0.75 + 0.75 ptos.) Define los predicados:
% a. esta(+X,+Xs), que verifique si X se encuentra en la lista Xs
esta(X,[X|_]).
esta(X,[Y|Ys]) :-
	esta(X,Ys),
	X \== Y.

% b. no_esta(+X,+Xs) que se verifique justo en el caso contrario.
no_esta(_,[]).
no_esta(X,[Y|Ys]) :-
	no_esta(X,Ys),
	X \== Y.

% c. concatena(?Xs,?Ys,?Zs) que se verifique cuando Zs es la concatenación de las listas Xs e Ys
concatena([],Ys,Ys).
concatena([X|Xs],Ys,[X|XsYs]) :-
	concatena(Xs,Ys,XsYs).

% d. selecciona(?X,?XsXYs,?XsYs) que se verifique cuando la lista XsYs resulta de la lista XsXYs al suprimir una aparición del elemento X.
selecciona(X,[X|Xs],Xs).
selecciona(X,[Y|Xs],[Y|Ys]) :-
	selecciona(X,Xs,Ys).
	
% Problema 4. (2.0 ptos) Define el predicado escoge_dos(+Xs,-Ys,-X,-Y) que dada una lista Xs sin elementos repetidos devuelve dos elementos extraídos en orden de la lista X e Y y el resto de la lista Ys. Por ejemplo:
% ?- escoge_dos([1,2,3,4],Ys,X,Y).
% Ys = [3,4],
% X = 1,
% Y = 2 ;
% Ys = [2,4],
% X = 1,
% Y = 3 ;
% ... [continúa]

escoge_dos(Xs,Ys,X,Y) :-
	concatena(As,[X|Bs],Xs),
	concatena(Cs,[Y|Ds],Bs),
	concatena(Cs,Ds,CsDs),
	concatena(As,CsDs,Ys).
	
% Problema 5. (0.5 + 0.5 + 2.0 ptos.) Buzz, Woody, Rex y Hamm tienen que escapar del malvado Zurg. Para ello deben cruzar un puente colgante (de izquierda a derecha). El puente es muy frágil y puede sostener como mucho a dos de ellos a la vez. Más aún, es noche cerrada y el puente está repleto de agujeros taladrados por los esbirros de Zurg, por lo que es necesario usar una linterna para atravesarlo. El problema es que los juguetes disponen sólo de una linterna con batería para 60 minutos. Cada juguete emplea el siguiente tiempo para cruzar el puente (en cualquier sentido):

% Juguete	|    Tiempo
% Buzz		|	5 minutos
% Woody		|	10 minutos
% Rex		|	20 minutos
% Hamm		|	25 minutos

% Ayuda a nuestros intrépidos juguetes a escapar de las garras de Zurg:
% a. Define el predicado tiempo(?J,?T) que se satisface si el juguete J invierte T minutos en atravesar el puente. Por ejemplo:
% ?- tiempo(buzz,T).
% T = 5 ;
% false.
% ? - tiempo(J,20).
% J = rex
% false.

tiempo(buzz,5).
tiempo(woody,10).
tiempo(rex,20).
tiempo(hamm,25).

% Define los predicados inicial(?E) y final(?E) que se satisfacen si E es el estado inicial o final, respectivamente, del problema. Los estados se representarán por términos Prolog de la forma:
% 		e(Linterna,JuguetesIz,JuguetesDr,Tiempo)
% donde Linterna es la orilla en que se encuentra la linterna (izq o der), JuguetesIz y JuguetesDr son listas ordenadas de los juguetes que se encuentran en las orillas izquierda y derecha, respectivamente, y Tiempo es un número natural que representa los minutos de vida que le quedan a la batería de la linterna. Por ejemplo, el siguiente es un estado válido:
%		e(der,[buzz,hamm],[rex,woody],32)
% que indica que la linterna, Rex y Woody se encuentran en la orilla derecha, Buzz y Hamm están en la orilla izquierda, y a la linterna le quedan 32 minutos de batería.

inicial(e(izq,[buzz,hamm,rex,woody],[],60)).
final(e(der,[],[buzz,hamm,rex,woody],Bat)) :-
	Bat >= 0.

% c. Define el predicado mover(+Ei,-Ej) que dado un estado válido Ei devuelve sus posibles estados sucesores EJ.
mover(e(izq,JugIz,JugDer,Bat),e(der,NIz,NDer,RestoBat)) :-
	escoge_dos(JugIz,NIz,Jug1,Jug2),
	tiempo(Jug1,T1),
	tiempo(Jug2,T2),
	T is max(T1,T2),
	RestoBat is Bat-T,
	RestoBat >= 0,
	inserta_en_orden(Jug1,JugDer,XOs),
	inserta_en_orden(Jug2,XOs,NDer).

mover(e(der,JugIz,JugDer,Bat),e(izq,NIz,NDer,RestoBat)) :-
	selecciona(X,JugDer,NDer),
	tiempo(X,T),
	Bat >= T,
	RestoBat is Bat-T,
	inserta_en_orden(X,JugIz,NIz).

% Nota: no es necesario definir el predicado resolver/3.
resolver(Ei,_,[]) :-
	final(Ei).
resolver(Ei,Vs,[Ej|Cs]) :-
	mover(Ei,Ej),
	no_esta(Ej, Vs),
	resolver(Ej,[Ej|Vs],Cs).
toy_story([Eini|Sol]) :-
	inicial(Eini),
	resolver(Eini,[Eini],Sol).
