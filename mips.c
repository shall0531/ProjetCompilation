#includ <string.h>
#include "symbol.h"
#include "quad.h"
void parseMips(struct symbole* table, struct quad* list)
{
	FILE* file = NULL;
	
	file = fopen("mips.s","w+");
	
	char* tab[100];
	int taille = 0;
	int i;
	
	for(i = 0; i < 100; i++)
	{
		tab[i] = "";
	}
	
	
	fprintf(file, ".data\n");
	fprintf(file, "\n	tds:\n");
	fprintf(file,"		.asciiz  \"affichage de la table des symboles\\n\"\n");
	
	
	if(table != NULL)
	{
		struct Symbole* symbole = table;
  		while (symbole != NULL) 
  		{
  			char* car = malloc(sizeof(char) * (strlen(symbole->id) +1));
        	strcat(car, "");
        	strcat(car, symbole->id);
        	symbole->id = car;
        	
        	char* car2 = malloc(sizeof(char) * (strlen(symbole->value) +1));
        	strcat(car2, "");
        	strcat(car2, symbole->value);
        	symbole->value = car2;
        	
        	char* car3 = "bis";

			fprintf(file, "%s:	  .asciiz	\"%s : \"\n", symbole->id, symbole->id);
			strcat(car,  car3);
         	fprintf(file, "%s:    .asciiz  \"%s\\n\"\n", car, symbole->value);
         	
         	sprintf(tab[taille], "%s", symbole->id);
         	sprintf(tab[taille+1], "%s", car);
         	taille+=2;
        	symbole = symbole->next;
  		}
  		
		fprintf(file, "\n\n");
	}
	
	fprintf(file, "\n\n.text\n");
	fprintf(file, 	"	#affichage de la table des symbole\n");
	fprintf(file, "		tds_aff :\n");
	fprintf(file, "		sw $ra,0($sp)\n");
	
	for(i = 0; i < taille; i+=2)
	{
		fprintf(file, "		la $a0, %s", tab[i]);
		fprintf(file, "		li $v0, 4\n");
 		fprintf(file, "		syscal\n");
 		fprintf(file, "		la $a0, %s", tab[i+1]);
		fprintf(file, "		li $v0, 4\n");
 		fprintf(file, "		syscal\n");
	}
	fprintf(file, "		lw $ra,0($sp)\n");
	fprintf(file, "		jr $ra\n\n");
	
	/*struct quad* scan=list;
	
	while( scan != NULL){

		fprintf(file,"\n li $a0, %d\n",scan->arg1->value);
		fprintf(file,"\n move $t0, $a0");		
		fprintf(file,"li $a1, %d\n",scan->arg2->value);
		fprintf(file,"\n move $t1, $a1");
		fprintf(file,"li $a2, %d\n",scan->res->value);
		fprintf(file,"\n move $t2, $a2");
				
				switch (scan->op){
						case '+':
								fprintf(file,"add $t2, $t0, $t1\n"); break;
$t
						case '-':
								fprintf(file,"sub $t0, $t0 , $t1\n"); break;

						case '*': fprintf(file, "mult $t0, $t0,$t1\n");break;
						
						case '/': fprintf(file, "div $t0, $t0, $t1\n"); break;	
						
						case '>': fprintf(file, "blt $t0, $t1, $t2\n");break;
						case '<': fprintf(file, "slt $t0, $t1, $t2\n");break;
						case 'e': fprintf(file, "bne $t0, $t1, $t2\n");break;
						case 'l': fprintf(file, "sge $t0, $t1, $t2\n");break;
						case 'g': fprintf(file, "bge $t0, $t1, $t2\n");break;
						case '!': break;
						case 'G': break;

				}
				fprintf(res,"\nmove $a0 $t0\n ");
				fprintf(res,"\nli $v0 1\n ");
				fprintf(res,"syscall\n");
				fprintf(res,"\nla $a0 , newline\n");
				fprintf(res,"li $v0 , 4\n");
				fprintf(res,"syscall\n");
				fprintf(res,"\nmove $a2 $t2\n ");
				fprintf(res,"li $v0 , 4\n");
				fprintf(res,"syscall\n");
				scan=scan->next;*/
		}

	fprintf(file, "\n\n.globl main\n\n");
 	fprintf(file, "		main :\n");
 	fprintf(file, "			la $a0, tds\n");
 	fprintf(file, "			li $v0, 4\n");
 	fprintf(file, "			syscal\n");
 	fprintf(file, "			addu $sp,$sp,-4)\n");
 	fprintf(file, "			j tds_aff\n");
 	
}
