%%
^"/*"(.|\n)*"*/"\n	{} /* Elimina un comentario tipo de bloque que ocupa toda la línea (o varias líneas) */

^"//".*\n			{} /* Elimina la línea completa del comentario tipo línea */
"//".*				{} /* Elimina el comentario tipo línea que no ocupa toda la línea */
%%