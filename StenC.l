chiffre [0-9]
char [a-zA-Z]
mot ({char})+

entier ({chiffre})+
indent {mot}|{mot}{entier}
string \"[.]\"
<<<<<<< HEAD
motCle "int"|"stencil"
constante "const"
operateur "+"|"-"|"*"|"/"|"++"|"--"
=======
>>>>>>> 2d1944521868c54e3ba69922ac60c259039e6a51
struct_control "if"|"else"|"while"|"for"
fonc_lib "printf"|"printi"
fonc_appel {motCle}[" "]"main"[" "]* "("
accolade "{"|"}"


%%
<<<<<<< HEAD
{mot}				{printf("trouver mot:%s\n",yytext);}
{motCle}  			{printf("trouver type:%s\n",yytext);}
{entier}  			{printf("trouver entier:%s\n",yytext);}
{indent}			{printf("trouver indent:%s\n",yytext);}
{constante}			{printf("trouver constante:%s\n",yytext);}
{operateur}			{printf("operateur:%s\n",yytext);}
{struct_control}	{printf("struct_control:%s\n",yytext);}
{fonc_lib}			{printf("fonc_lib:%s\n",yytext);}
{fonc_appel}		{printf("fonc_appel:%s\n",yytext);}
；					{printf("termineur d'instrution:",yytext);}
accolade			{printf("accolade:",yytext);}
=======
{string}			{printf("trouver un string :%s\n",yytext); return STRING;}
"int"					{printf("trouver type int:%s\n",yytext); return INT;}
"stencil"				{printf("trouver type stencil:%s\n",yytext); return STENCIL;}
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
>>>>>>> 2d1944521868c54e3ba69922ac60c259039e6a51
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