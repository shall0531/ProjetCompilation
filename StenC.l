%{
    #include <string.h>
    #include <stdio.h>
    #include <stdlib.h>
    #include <math.h>
    #include "y.tab.h"
    #include "symbol.h"
    
    struct symbol *tds;
    
%}

entier [1-9][0-9]*|[0-9]

ident [a-zA-Z_]+[0-9a-zA-Z_]*

blank_chars ([ \f\r\t\v]+)

string \"[.]\"                

stencil \\Stencil

%%
"int"				{return INT;}
"if"				{return IF;}
"else"				{return ELSE;}
"stencil"			{}
"while"             {return WHILE; }
"printf"			{return PRINTF;}
"main"				{return MAIN;}
"return 0"			{return RETURN;}
"for"				{return FOR;}
{ident}             {yylval.string = yytext;
                    struct symbol* id;
                    id = symbol_lookup(tds,yytext);
                    if(id == NULL)
                    {
                        symbol_add(&tds,yytext);
                        
                    }
                    yylval.string = strdup(yytext);
                     return ID;}
{entier}  			{yylval.valeur = atoi(yytext); return NUMBER;}


"++"                { return PLUSPLUS;}
"--"                { return MOINSMOINS;}
"+"                 { return '+';}
"-"                 { return '-';}
"*"                 { return '*';}
"/"                 { return '/';}
"="                 { return ASSIGN;}
"<"          	    { return LT; }
">"          	    { return GT; }

"<="         	    { return LEQ;}
">="                { return GEQ;}
"!="         	    { return NEQ;}
"=="         	    { return EQ; }
"&&"         	    { return AND;}
"||"         	    { return OR; }
"!"          	    { return NOT;}


"("                 { return '(';}
")"                 { return ')';}
"{"                 { return '{';}
"}"                 { return '}';}
"["                 { return '[';}
"]"                 { return ']';}



"."                 { return '.';}
";"                 { return ';';}
","                 { return ',';}

blank_chars         { }
.                   { /* ignore bad characters */ }


%%
