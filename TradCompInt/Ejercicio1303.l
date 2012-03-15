%{
	#include<stdio.h>    
	float notas = 0.0;
	int lineas = 0;
%}

DNI		[0-9]{8,8}[a-zA-Z]
MES 	["Diciembre""Febrero""Junio"]
NOTA	[0-9]("."[0-9])?
%START primero
%START segundo
%%
<primero>" "{MES}		{BEGIN(segundo);} /* Sigue bien */
<segundo>" "{NOTA}\n	{nota = nota + atof(yytext); linea = linea++; BEGIN(0);}
{DNI}				{BEGIN(primero);} /* Empieza bien */
%%
int main(void) {
	yylex();
	
	printf("Nota media: %f\n",nota);
	
	return 0;
}