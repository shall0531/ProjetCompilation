%{
    #include <math.h>
    #include <stdio.h>
    #include <stdlib.h>
    #include "symbol.h"
  #include "quad.h"

  void yyerror(char*);
  int yylex();
  FILE* yyin;
  
  struct symbol* tds = NULL;
  int temp_number = 0;
  int next_quad = 0;
  struct Symbole* nextquad = NULL;
  int tds_taille=0;
  
%}

%union {
    int valeur;
  char* string;
  char relation;
  struct symbol* quad;

  struct {
	struct symbol* result;
        struct quad* code;
    }codegen;

  struct {
    struct symbol* quad;
    struct quad* code;
    struct quad_list* next;
  } codegoto;
 
 struct {
    struct quad* code;
    struct quad_list* next;
  } codestmt;
 
 struct {
    struct quad* code;
    struct quad_list* true;
    struct quad_list* false;
  } codeexpr;
}

%token IF ELSE WHILE PRINTF MAIN RETURN FOR
%token GT LT GEQ LEQ NEQ EQ
%token OR AND NOT
%token ASSIGN
%token INT
%token <valeur> NUMBER
%token <string> ID
%type <codeexpr> condition
%type <codestmt> statement 
%type <codegen> assignment
%type <codegen> expression
%type <codestmt> list
%type <quad> tag
%type <codegoto> tagoto
%type <relation> relop
%left OR
%left AND
%left '+' '-' '*' '/' PLUSPLUS MOINSMOINS
%right NOT
%nonassoc LOWER_THAN_ELSE
%nonassoc ELSE


%%
axiom:
  		 INT MAIN'(' ')' '{' list RETURN ';' '}'	{
		    	printf("Match !!!\n");
		    //struct symbol* end = symbol_newcst(&tds, &temp_number, -1);
		    //quad_list_complete($1.next, end);
		    symbol_print(tds);
		    quad_print($6.code);
		  }
		  ;

list:
    list tag statement {
		    quad_list_complete($1.next, $2);
		    $$.next = $3.next;
		    $$.code = $1.code;
		    quad_add(&$$.code, $3.code);
			printf("aaa\n");
		  } 
  |statement     {
		    $$.next = $1.next;
		    $$.code = $1.code;
			printf("bbb\n");
		  } 
|
  ;

statement:
    IF '(' condition ')' tag '{' statement '}' %prec LOWER_THAN_ELSE {
			printf("ccc\n");
		    quad_list_complete($3.true, $5);
		    quad_list_concat($3.false, $7.next);
		    $$.next = $3.false;
		    $$.code = $3.code;
		    quad_add(&$$.code, $7.code);
		  }
  | IF '(' condition ')' tag '{' statement '}' ELSE tagoto '{' statement '}' {
		    quad_list_complete($3.true, $5);
		    quad_list_complete($3.false, $10.quad);
		    quad_list_concat($10.next, $12.next);
		    $$.next = $10.next;
		    $$.code = $3.code;
		    quad_add(&$$.code, $7.code);
		    quad_add(&$$.code, $10.code);
		    quad_add(&$$.code, $12.code);
            
		  }
  | WHILE tag '(' condition ')' tag '{'statement '}' {
		    quad_list_complete($4.true, $6);
		    quad_list_complete($8.next, $2);
		    $$.next = $4.false;
		    $$.code = $4.code;
		    quad_add(&$$.code, $8.code);
		    struct quad* new = quad_gen(&next_quad, 'G', NULL, NULL, $2);
		    quad_add(&$$.code, new);
            
		  }
|FOR tag '(' expression ';' expression ';' expression')' '{' statement '}'{
				
				}
| assignment ';'{
 		    $$.next = $1.code->next;
		    $$.code = $1.code;
			printf("ccccc\n");

		}
| PRINTF '(' expression ')' ';'{
		    $$.next = $3.code->next;
		    $$.code = $3.code;
		}
|declaration ';'{ }

  ;
  
declaration: INT ID_list {}
			;
  
ID_list: ID_list ',' ID	{}
		|ID	{}
		;


assignment:
		ID ASSIGN expression{
    		printf("ID = expression!\n");
    		$$.result = symbol_lookup(tds,$1);
    		if($$.result == NULL)
    		{
        		symbol_add(&tds,$1);
        		$$.result = symbol_lookup(tds,$1);
    		}
    		//$$.result -> value = $3.result -> value;
    		struct quad* new;
    		new = quad_gen(&next_quad,'=',$3.result, NULL, $$.result);
    		$$.code = $3.code;
    		quad_add(&$$.code,new);
		}
		| ID ASSIGN type_table{
				}
		| expression PLUSPLUS{
				/*struct quad *new;
				struct symbol* tmp = (symbol*)malloc(sizeof(symbol*));
				tmp->identifier = NULL;
				tmp->isconstant = 1;
				tmp->value = 1;
				tmp->next = NULL;
				$$.result = symbol_newtemp(&tds,&tds_taille);
				//$$.result -> value = $1.result -> value + $3.result -> value;
				new = quad_gen(&next_quad,'+',$1.result,tmp,$$.result);
				$$.code = $1.code;
				quad_add(&$$.code,$1.code);
				quad_add(&$$.code,new);*/

				}
		| expression MOINSMOINS{
				/*struct quad *new;
				struct symbol* tmp;
				tmp->identifier = NULL;
				tmp->isconstant = 1;
				tmp->value = 1;
				tmp->next = NULL;
				$$.result = symbol_newtemp(&tds,&tds_taille);
				//$$.result -> value = $1.result -> value - $3.result -> value;
				new = quad_gen(&next_quad,'-',$1.result,tmp,$$.result);
				$$.code = $1.code;
				quad_add(&$$.code,$1.code);
				quad_add(&$$.code,new);*/

				}
;
type_table:
'[' expression ']' '['expression']'{
}
;
tagoto:
		  {
		    $$.code = quad_gen(&next_quad, 'G', NULL, NULL, NULL);
		    $$.quad = symbol_newcst(&tds, &temp_number, next_quad);
		    $$.next = quad_list_new($$.code);
		  }
  ;

condition:
    condition OR tag condition  {
            quad_list_complete($1.false, $3);
		    quad_list_concat($1.true, $4.true);
		    $$.false = $4.false;
		    $$.true = $1.true;
		    $$.code = $1.code;
		    quad_add(&$$.code, $4.code);
                  }
  | condition AND tag condition {
		    quad_list_complete($1.true, $3);
		    quad_list_concat($1.false, $4.false);
		    $$.false = $1.false;
		    $$.true = $4.true;
		    $$.code = $1.code;
		    quad_add(&$$.code, $4.code);
                  }
  | '(' condition ')'  { 
                    $$.code = $2.code;
                    $$.true = $2.true;
                    $$.false = $2.false;
                  }

| expression relop expression  { 
								
		    					struct quad* new = quad_gen(&next_quad, $2, $1.result, $3.result, NULL);
		    					$$.code = new;
		    					$$.true = quad_list_new(new);
		    					new= quad_gen(&next_quad, 'G', NULL, NULL, NULL);
		    					quad_add(&$$.code, new);
		    					$$.false = quad_list_new(new);
		    					
                                    }
| NOT condition {
			$$.true=$2.false;
            $$.false=$2.true;
            $$.code= $2.code;
            }
    
  ;
expression:
          NUMBER
{
    struct symbol *new = $$.result;
    $$.result = symbol_newtemp(&tds,&tds_taille);
    $$.result -> isconstant = 1;
    $$.result -> value = $1;
    $$.code = NULL;
    quad_print($$.code);
}


        | ID
{
    $$.result = symbol_lookup(tds,$1);
    if($$.result == NULL)
    {
        symbol_add(&tds,$1);
        $$.result = symbol_lookup(tds,$1);
    }
    $$.code = NULL;
}



        | expression '+' expression
{
    struct quad *new;
    $$.result = symbol_newtemp(&tds,&tds_taille);
    //$$.result -> value = $1.result -> value + $3.result -> value;
    new = quad_gen(&next_quad,'+',$1.result,$3.result,$$.result);
    $$.code = $1.code;
    quad_add(&$$.code,$3.code);
    quad_add(&$$.code,new);
}


        | expression '-' expression
{
    printf("exp -> exp - exp!\n");
    struct quad *new;
    $$.result = symbol_newtemp(&tds,&tds_taille);
    //$$.result -> value = $1.result -> value - $3.result -> value;
    new = quad_gen(&next_quad,'-',$1.result,$3.result,$$.result);
    $$.code = $1.code;
    quad_add(&$$.code,$3.code);
    quad_add(&$$.code,new);

}


        | expression '*' expression
{
    printf("exp -> exp * exp!\n");
    struct quad *new;
    $$.result = symbol_newtemp(&tds,&tds_taille);
    //$$.result -> value = $1.result -> value * $3.result -> value;
    new = quad_gen(&next_quad,'*',$1.result,$3.result,$$.result);
    $$.code = $1.code;
    quad_add(&$$.code,$3.code);
    quad_add(&$$.code,new);

}


        | expression '/' expression
{
    printf("exp -> exp / exp!\n");
    struct quad *new;
    $$.result = symbol_newtemp(&tds,&tds_taille);
    //$$.result -> value = $1.result -> value / $3.result -> value;
    new = quad_gen(&next_quad,'/',$1.result,$3.result,$$.result);
    $$.code = $1.code;
    quad_add(&$$.code,$3.code);
    quad_add(&$$.code,new);

}

        | '(' expression ')'
{
    $$.result = $2.result;
    $$.code = $2.code;
}
;

tag:
        {
		    $$= symbol_newcst(&tds, &temp_number, next_quad);
        }
;
relop:
    LT            { $$ = '<'; }
  | GT            { $$ = '>'; }
  | LEQ           { $$ = 'l'; }
  | GEQ           { $$ = 'g'; }
  | NEQ           { $$ = '!'; }
  | EQ            { $$ = '='; }
  ;



%%

int main(int argc, char** argv)
{
	if(argc>1)
	yyin=fopen(argv[1],"r");
	else yyin=stdin;
	return yyparse();

}

