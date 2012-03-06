%{
	int numCar = 0;
	int numPal = 0;
	int numLin = 1; /* Siempre hay al menos 1 linea */
%}
%%
\n				{numLin++;}
[^ \t\n]*		{numPal++; numCar += yyleng;}
. 				{;} /* Nos saltamos los espacios */
%%
int main() {
	yylex();
	printf("%d caracteres, %d palabras, %d lineas\n", numCar, numPal, numLin);
}