%{
	int pares = 0;
%}

%%
[0-9]*/[02468]	{pares++;
						input();}
.			{;}
%%
int main() {
	yylex();
	
	printf("Números pares: %d\n",pares);
	
	return 0;
}