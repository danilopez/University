/* Ejercicio 1: Cambia los LF (ASCII 10) por CRLF (ASCII 13, 10) */
%%
./\n	{
			printf("%c%c",yytext[0],13);
		}
%%