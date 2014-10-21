chiffre [0-9]
char [a-zA-Z]

type "int"
string {char}+|{char}+ \+ {char}+
entier {chiffre}+
tableau {type}\[{entier}\]
constante "const"
operateur "+"|"-"|"*"|"/"|"++"|"--"
struct_control "if"|"else"|"while"|"for"
fonc_printf "printf"|"printi"
%%
{type}  {printf(