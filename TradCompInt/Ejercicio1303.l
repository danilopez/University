%{
	DNI				[0-9]{8,8}[a-zA-Z]
	Convocatoria	["Diciembre""Febrero""Junio"]
	Nota			[0-9]("."[0-9])?
	
	int nota = 0;
%}
%START linea
%%
<linea>" "			{}
<linea>Convocotaria {}
<linea>Nota			{nota = nota + (int) yytext; BEGIN(0)}
DNI					{BEGIN(linea)}
%%