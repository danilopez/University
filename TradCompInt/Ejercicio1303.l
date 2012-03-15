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

{DNI}		{BEGIN(linea);}
%%
int main(void) {
	yylex();
	
	printf("Nota media: %f\n",nota);
	
	return 0;
}