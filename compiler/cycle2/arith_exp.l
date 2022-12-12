%{
/* Definition section*/
#include "y.tab.h"
extern int yylval;
%}
%%
[0-9]+ {
yylval = atoi(yytext);
return NUMBER;
}
[a-zA-Z]+ { return ID; }
[ \t]+ ; /*For skipping whitespaces*/
\n { return 0; }
. { return yytext[0]; }
%%

YACC FILE

%{
/* Definition section */
#include <stdio.h>
int yylex();
int yyerror();
%}
%token NUMBER ID
// setting the precedence
// and associativity of operators
%left '+' '-'
%left '*' '/'
/* Rule Section */
%%
E : T {
printf("Result = %d\n", $$);
return 0;
}
T :
T '+' T { $$ = $1 + $3; }
| T '-' T { $$ = $1 - $3; }
| T '*' T { $$ = $1 * $3; }
| T '/' T { $$ = $1 / $3; }
| '-' NUMBER { $$ = -$2; }
| '-' ID { $$ = -$2; }
| '(' T ')' { $$ = $2; }
| NUMBER { $$ = $1; }
| ID { $$ = $1; }
%%

int main() {
    printf("Enter the expression\n");
    yyparse();
}
/* For printing error messages */
int yyerror(char* s) {
    printf("\nExpression is invalid\n");
}



COMPILATION
lex arith_exp.l
yacc -d arith_exp.y
cc lex.yy.c y.tab.c -ll
./a.out