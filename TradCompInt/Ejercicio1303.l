%{
	#include<stdio.h>    
	float nota = 0;
	int lineas = 0;
%}

DNI		[0-9]{8,8}[a-zA-Z]
Convocatoria ["Diciembre""Febrero""Junio"]
%START linea
%%

<linea>" "					{}
<linea>[0-9]("."[0-9])?		{nota = nota + atof(yytext); BEGIN(0); }
<linea>[.\n]				{}
{DNI}" "{Convocatoria}		{BEGIN(linea);}
%%
int main(void) {
	yylex();
	
	printf("Nota media: %f\n",nota);
	
	return 0;
}