chiffre [0-9]
char [a-zA-Z]
mot ({char})+

entier ({chiffre})+
indent {mot}|{mot}{entier}
string \"[.]\"
accolade "{"|"}"


%%
{string}			{printf("trouver un string :%s\n",yytext); return STRING;}
"int"				{printf("trouver type int:%s\n",yytext); return INT;}
"stencil"			{printf("trouver type stencil:%s\n",yytext); return STENCIL;}
{entier}  			{printf("trouver entier:%s\n",yytext);return ENTIER;}
{indent}			{printf("trouver indent:%s\n",yytext);return ID;}
"const"				{printf("trouver constante:%s\n",yytext);return CONST;}
"++"				{printf("operateur:%s\n",yytext); return PLUS2;}
"+"					{printf("operateur:%s\n",yytext); return PLUS;}
"--"				{printf("operateur:%s\n",yytext); return MOINS2;}
"-"					{printf("operateur:%s\n",yytext); return MOINS;}
"*"					{printf("operateur:%s\n",yytext); return MULT;}
"/"					{printf("operateur:%s\n",yytext); return DIV;}
"if"				{printf("struct_control:%s\n",yytext);	return IF;}
"else"				{printf("struct_control:%s\n",yytext);	return ELSE;}
"while"				{printf("struct_control:%s\n",yytext);	return WHILE;}	
"for"				{printf("struct_control:%s\n",yytext);	return FOR;}				
"printf"			{printf("fonc_lib printf:%s\n",yytext);return PRINTF;}
"main"				{printf("fonction Main:%s\n",yytext); return MAIN;}
；					{printf("termineur d'instrution:\n",yytext);}
\/\/.* 				{return ;}
\/\*(.*\n)*.*\*\/ 	{return ;}
accolade			{printf("accolade:%s\n",yytext[0]);}
\(|\)				{printf("parenthese:%s\n",yytext[0]);}
.					{printf("Symbole:%s\n",yytext);}



%%
int main(){
	
	yyin = fopen("./Sobel.c", "r");
	
	if(yyin == NULL)
	{
		fprintf(stderr, "mauvaise déclaraion de fichier\n");
	}
	yylex();
    
    return  0;
}