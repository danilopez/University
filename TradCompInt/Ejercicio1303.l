%{
	#include<stdio.h>    
	float notas = 0.0;
	float nueva_nota = 0.0;
	int lineas = 0;
%}

DNI		[0-9]{8,8}[a-zA-Z]" "
MES 	("Diciembre "|"Febrero "|"Junio ")
NOTA	[0-9]+(\.[0-9])?
%START primero segundo tercero
%%
<primero>{MES}		{BEGIN(segundo);} /* Sigue bien */
<segundo>{NOTA}		{nueva_nota = atof(yytext); BEGIN(tercero);}
<tercero>\n			{notas = notas + nueva_nota; lineas = lineas++; BEGIN(0);}
<tercero><<EOF>>	{notas = notas + nueva_nota; lineas = lineas++; BEGIN(0);}
<tercero>.*			{printf("Error en la linea %d: No deberia haber nada despues de la nota\n",lineas+1,notas);}
<segundo>.*			{printf("Error en la linea %d: La convocatoria es incorrecta\n",lineas+1); }
{DNI}				{BEGIN(primero);} /* Empieza bien */
%%
int main(void) {
	yylex();
	
	printf("Nota media: %.2f\n",notas/lineas);
	
	return 0;
}