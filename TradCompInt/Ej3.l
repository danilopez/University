%{
	char c;
	int i = 0;
%}

PALABRA		[^ \n\t]

%%

{PALABRA}	{
				for (i = 0; i < yyleng/2; i++) {
					c = yytext[i];
					yytext[i] = yytext[yyleng-1-i];
					yytext[yyleng-1-i] = yytext[i];
				}
			}
.			{}
\n			{}
%%
int main () {
	
}