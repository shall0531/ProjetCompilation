%{
    #include <string.h>
    #include <stdio.h>
    #include <stdlib.h>
    #include <math.h>
    #include "y.tab.h"
    #include "symbol.h"
    
    struct symbol *tds;
    
%}


chiffre [0-9]

char [a-zA-Z]

mot ({char})+

entier ({chiffre})+

ident {mot}|{mot}{entier}

blank_chars ([ \f\r\t\v]+)

string \"[.]\"                

stencil \\Stencil

%%
"if"				{return IF;}
"else"				{return ELSE;}
"stencil"			{}
"while"             {return WHILE; }
{entier}  			{yylval.valeur = atoi(yytext); return NUMBER;}

{ident}             {yylval.string = yytext;
                    struct symbol* id;
                    id = symbol_lookup(tds,yytext);
                    if(id == NULL)
                    {
                        symbol_add(&tds,yytext);
                        
                    }
                    yylval.string = strdup(yytext);
                     return ID;}


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

"++"                { printf("trouver symbole:%s",yytext);}
"--"                { return yytext;}
"+="                { return yytext;}
"-="                { return yytext;}

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
