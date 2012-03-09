%%
[a-zA-Z]+	{
				char aux;
				int cont;
				
				for (cont = 1; cont <= (yyleng/2); cont++) {
					aux = yytext[cont-1];
					yytext[cont-1] = yytext[yyleng-cont];
					yytext[yyleng-cont] = aux;
				}
				ECHO;
			}
%%