%%
[^ \n\t]*	{ invertir(yytext,yyleng); }
%%

void invertir(char *cadena, int longitud) {
	char aux;
	int i;
	
	for (i = 0; i < (longitud/2); i++) {
		aux = cadena[i];
		cadena[i] = cadena[longitud-1-i];
		cadena[longitud-1-i] = aux;
	}
	ECHO;
}