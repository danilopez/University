%{
	int numCar = 0;
	int numPal = 0;
	int numLin = 0;
%}
%%
\n				{numLin++;}
[^ \t\n]*		{numPal++; numCar += yyleng;}
. 				{;} /* Nos saltamos los espacios */
%%
int main() {
	yylex();
	if (numCar > 0) numLin++; /* Esto es útil sólo para descartar los archivos vacíos, donde habría 0 líneas. En los archivos en los que hubiera al menos 1 caracter, entonces ya se contaría como 1 línea */
	printf("%d caracteres, %d palabras, %d lineas\n", numCar, numPal, numLin);
}