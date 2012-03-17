%{
	int caracteres = 0;
	int palabras = 0;
	int lineas = 0;
%}
%%
\n			{lineas++;}

[^ \n\t]*	{caracteres += yyleng; palabras++;}
.			{}
%%
int main() {
	yylex();
	
	if (caracteres > 0) lineas++;
	
	printf("Numero de caracteres: %d\n",caracteres);
	printf("Numero de palabras: %d\n",palabras);
	printf("Numero de lineas: %d\n",lineas);
	
	return 0;
}