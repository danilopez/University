% Problema 2. (0.25 + 0.25 + 1.0 + 0.5 + 1.0 ptos.) Define los siguientes predicados:
% a. miembro(?X, ?Xs) que se satisface si X pertenece  la lista Xs
miembro(X,[X|_]).
miembro(X,[Y|Ys]) :-
	X \== Y,
	miembro(X,Ys).

% b. concatena(?Xs, ?Ys, ?Zs) que tiene éxito si la lista Zs es la concatenación de las listas Xs e Ys.
concatena([], Ys, Ys).
concatena([X|Xs],Ys,[X|XsYs]) :-
	concatena(Xs,Ys,XsYs).

% c. anterior(+Xs, ?X, ?Y) que se satisfaga cuando X aparezca antes que Y en la lista Xs
anterior(Xs,X,Y) :-
	concatena([X|_],[Y|_],Xs).
	
% d. no_esta(+X, +Xs) que determina si un elemento X no está en la lista Xs.
no_esta(_,[]).
no_esta(X,[Y|Ys]) :-
	X \== Y,
	no_esta(X,Ys).

% e. union(+Xs, +Ys, -Zs) que dadas dos listas sin elementos repetidos, Xs e Ys, devuelve en Zs la unión (sin elementos repetidos) de esas dos listas.
union([],Ys,Ys).
union([X|Xs],Ys,[X|Zs]) :-
	no_esta(X,Ys),
	union(Xs,Ys,Zs).
union([X|Xs],Ys,Zs) :-
	miembro(X,Ys),
	union(Xs,Ys,Zs).

% Problema 3. (1.0 + 1.0 + 1.0 + 2.5) Una ciudad dispone de un metro con tres líneas, llamadas línea azul, verde y roja, respectivamente. Las estaciones del metro están identificadas por minúsculas entre a y n. Se denomina tramo al recorrido que realiza una línea entre dos estaciones sin pasar por una tercera. El predicado tramo(?Linea, ?Estacion1, ?Estacion2, ?Tiempo), definido por el siguiente conjunto de hechos:
tramo(azul,a,b,3).
tramo(azul,b,c,3).
tramo(azul,c,d,2).
tramo(azul,d,e,6).
tramo(verde,f,g,2).
tramo(verde,g,d,4).
tramo(verde,d,h,7).
tramo(verde,h,i,3).
tramo(roja,b,k,1).
tramo(roja,k,d,3).
tramo(roja,d,l,4).
tramo(roja,l,h,2).
tramo(roja,h,m,4).
tramo(roja,m,n,3).
% indica, para cada tramo del metro, a qué línea pertenece, qué estaciones une y qué tiempo tarda en recorrerse (en minutos). Los tramos pueden recorrerse en ambos sentidos; el tiempo invertido en recorrerlos es independiente del sentido.
% Supongamos definido el predicado estaciones(-Es) que devuelve una lista de pares (Linea,Estacion) con todas las estaciones que tiene cada linea:
% ?- estaciones(Es).
% Es = [(azul, a), (azul, b), (azul, c), (azul, d), (azul, e), (verde, f), (verde, g), (verde, d), (verde, h), (verde, i), (roja, b), (roja, k), (roja, d), (roja, l), (roja, h), (roja, m), (roja, n)].

% Define el predicado trayecto(?Linea, ?Origen, ?Destino, ?Tiempo) que tiene éxito si hay un tramo en la línea Linea que une las estaciones Origen y Destino y se recorre en Tiempo minutos.
% ?- trayecto(azul,a,b,3).
% true ;
% false.
% ?- trayecto(azul,b,Destino,Tiempo).
% Destino = c,
% Tiempo = 3 ;
% Destino = a,
% Tiempo = 3 ;
% false.
trayecto(Linea,Origen,Destino,Tiempo) :-
	tramo(Linea,Origen,Destino,Tiempo).
trayecto(Linea,Origen,Destino,Tiempo) :-
	tramo(Linea,Destino,Origen,Tiempo),
	
% Se dice que entre dos líneas hay una correspondencia cuando ambas paran en la misma estación, lo que permite realizar un trasbordo de una línea a otra caminando de un andén a otro. Define el predicado correspondencia(+E,-LO,-LD) que se satisface cuando en la estación E hay una correspondencia entre las líneas LO y LD. Por ejemplo:
% ?- correspondencia(b,L0,LD).
% LO = roja,
% LD = azul ;
% LO = azul,
% LD = roja ;
% false.
correspondencia(E,LO,LD) :-
