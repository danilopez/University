%%
^([+-]?[0-9]+"."[0-9]+([eE][+-]?[0-9]+)?)	{printf("El numero es valido: %s", yytext);}
^([0-9]*"."[0-9]+([eE][+-]?[0-9]+)?)	{printf("El numero es valido: %s", yytext);}
.
%%