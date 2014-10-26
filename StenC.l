chiffre [0-9]
char [a-zA-Z]
mot ({char})+

entier ({chiffre})+
indent {mot}|{mot}{entier}
string \"[.]\"
motCle "int"|"stencil"
constante "const"
operateur "+"|"-"|"*"|"/"|"++"|"--"
struct_control "if"|"else"|"while"|"for"
fonc_lib "printf"|"printi"
fonc_appel {motCle}[" "]"main"[" "]* "("
accolade "{"|"}"


%%
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