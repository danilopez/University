%{
	int cont = 0;
	int maxAnidamiento = 0;
%}
%START PARENTESIS
%%
<PARENTESIS>[a-zA-Z_][a-zA-Z0-9_-]*	{printf("<id>");}
<PARENTESIS>[0-9]+"."[0-9]{1,2}		{printf("<real>");}
<PARENTESIS>[ \n\t]*				{}
<PARENTESIS>"//".*$					{}
<PARENTESIS>"("						{cont++; if (cont > maxAnidamiento) maxAnidamiento = cont;}
<PARENTESIS>")"						{cont--; if(cont == 0) BEGIN(0);}
"("									{cont++; BEGIN(PARENTESIS); maxAnidamiento = cont;}
.									{printf("Error: %s\n",yytext);}
%%
int main() {
	yylex();
	
	if (cont == 0) {
		printf("Parentesis balanceados!\n");
	} else {
		printf("Parentesis no balanceados\n");
	}
	
	printf("Maximo numero de anidamientos: %d\n", maxAnidamiento);
	return 0;
}