%{
    #include "y.tab.h"
%}
%%
[a-zA-Z_][a-zA-Z_0-9]* return letter;
[0-9] return digit;
. return yytext[0];
\n return 0;
%%
int yywrap() {
    return 1;
}

YACC FILE

%{
    #include<stdio.h>
    int valid=1;
%}
%token digit letter
%%
start : letter s
s: letter s | digit s | ;
%%
int yyerror() {
    printf("\nIts not a identifier!\n");
    valid=0;
    return 0;
}
int main() {
    printf("\nEnter a name to tested for identifier: ");
    yyparse();
    if(valid) {
        printf("\nIt is a identifier!\n");
    }
}


COMPILING
lex valid_id.l
yacc -d valid_id.y
cc lex.yy.c y.tab.c -ll
./a.out