PALABRA [a-zA-Z]+
%%
{PALABRA}	{ invertir(yytext, yyleng); }
%%
void invertir(char *cadena, int longitud) {
	char aux;
	int cont;
	
	for (cont = 1; cont <= (longitud/2); cont++) {
		aux = cadena[cont-1];
		cadena[cont-1] = cadena[longitud-cont];
		cadena[longitud-cont] = aux;
	}
	ECHO;
}