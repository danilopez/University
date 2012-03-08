%s comentario
%%
"/*"				{BEGIN(comentario);}
<comentario>[^*\n]	{ /* se come cualquier cosa que no sea un '*' */ }
<comentario>"*"+[^*/\n]* { /* se come todos los '*' que no estén seguidos de '/' */ }
<comentario>\n		{ /* se come los saltos de línea internos */ }
<comentario>"*"+"/"	{BEGIN(INITIAL);} /* Detecta el fin del comentario */

^"//".*\n			{ /* Elimina la línea completa del comentario tipo línea */ }
"//".*				{ /* Elimina el comentario tipo línea que no ocupa toda la línea */ }
%%