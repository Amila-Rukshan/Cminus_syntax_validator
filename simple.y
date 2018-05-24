%{
   #include <stdarg.h>
   #include "simple_shared.h"
   #define YYSTYPE char *
   void yyerror (char const *);
   int yydebug=1;
   int indent=0;
   char *iden_dum;
%}

%token IF
%token ELSE
%token INT
%token RETURN
%token VOID
%token WHILE
%token NUM
%token ID

%% /* Grammar rules and actions follow */

program:
  declaration-list  { printf("%3d: FROM BISON PROGRAM\n", line_number); }
;

declaration-list:
  declaration-list declaration   { printf("%3d: FROM BISON DECLARATION-LIST\n", line_number); } |
  declaration
;

declaration:
  var-declaration { printf("%3d: FROM BISON VAR-DECLARATION-LIST\n", line_number); } |
  fun-declaration { printf("%3d: FROM BISON FUN-DECLARATION-LIST\n", line_number); }
;

var-declaration:
  type-specifier ID ';' |
  type-specifier ID '[' NUM ']' ';'
;

type-specifier:
  INT |
  VOID
;

fun-declaration:
  type-specifier ID '(' params ')' compound-stmt
;

params:
  param-list |
  VOID
;

param-list:
  param-list ',' param |
  param
;

param:
  type-specifier ID |
  type-specifier ID '[' ']'
;

compound-stmt:
  '{' local-declarations statement-list '}'
;

local-declarations:
  local-declarations var-declaration |
  %empty
;

statement-list:
  statement-list statement |
  %empty
;

statement:
  expression-stmt |
  compound-stmt |
  selection-stmt |
  iteration-stmt |
  return-stmt
;

expression-stmt:
  expression ';' |
  ';'
;

selection-stmt:
  IF '(' expression ')' statement |
  IF '(' expression ')' statement ELSE statement
;

iteration-stmt:
  WHILE '(' expression ')' statement
;

return-stmt:
  RETURN ';' |
  RETURN expression ';'
;

expression:
  var '=' expression |
  simple-expression
;

var:
  ID |
  ID '[' expression ']'
;

simple-expression:
  additive-expression relop additive-expression |
  additive-expression
;

relop:
  '<' |
  "<=" |
  '>' |
  ">=" |
  "==" |
  "!="
;

additive-expression:
  additive-expression addop term |
  term
;

addop:
  '+' |
  '-'
;

term:
  term mulop factor |
  factor
;

mulop:
  '*' |
  '/'
;

factor:
  '(' expression ')' |
  var |
  call |
  NUM
;

call:
  ID '(' args ')'
;

args:
  arg-list |
  %empty
;

arg-list:
  arg-list ',' expression |
  expression
;
%%

#include <stdio.h>
void yyerror(char const *s)
{
fprintf(stderr,"%s\n",s);
}

main ()
{
  if(yyparse ()==0){
    printf("Valid syntax");
  };
}
