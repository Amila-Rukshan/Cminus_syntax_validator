%{
#include "simple.tab.h"
extern int line_number;
%}
%option noyywrap


NUM      [0-9][0-9]*
ID       [a-zA-Z0-9][a-zA-Z0-9]*
COM      "/*"(.|\n)*"*/"

%%

"if"            { col+=2; printf("%d :FROM FLEX IF %s\n",line_number, yytext); return IF; }
"else"          { col+=4; printf("%d :FROM FLEX ELSE %s\n",line_number, yytext); return ELSE; }
"int"           { col+=3; printf("%d :FROM FLEX INT %s\n",line_number, yytext); return INT; }
"return"        { col+=6; printf("%d :FROM FLEX RETURN %s\n",line_number, yytext); return RETURN; }
"void"          { col+=4; printf("%d :FROM FLEX VOID %s\n",line_number, yytext); return VOID; }
"while"         { col+=5; printf("%d :FROM FLEX WHILE %s\n",line_number, yytext); return WHILE; }
"+"             { col+=1; printf("%d :FROM FLEX PLUS %s\n",line_number, yytext); return *yytext;}
"-"             { col+=1; printf("%d :FROM FLEX MINUS %s\n",line_number, yytext); return *yytext;}
"*"             { col+=1; printf("%d :FROM FLEX MUL %s\n",line_number, yytext); return *yytext;}
"/"             { col+=1; printf("%d :FROM FLEX DIV %s\n",line_number, yytext); return *yytext;}
"<"             { col+=1; printf("%d :FROM FLEX LT %s\n",line_number, yytext); return *yytext;}
"<="		        { col+=2; printf("%d :FROM FLEX LTEQ %s\n",line_number, yytext); return *yytext;}
">"		          { col+=1; printf("%d :FROM FLEX GT %s\n",line_number, yytext); return *yytext;}
">="		        { col+=2; printf("%d :FROM FLEX GTEQ %s\n",line_number, yytext); return *yytext;}
"=="            { col+=2; printf("%d :FROM FLEX EQ %s\n",line_number, yytext); return *yytext;}
"!="            { col+=2; printf("%d :FROM FLEX NEQ %s\n",line_number, yytext); return *yytext;}
"="             { col+=1; printf("%d :FROM FLEX ASSIGN %s\n",line_number, yytext); return *yytext;}
";"             { col+=1; printf("%d :FROM FLEX SEMICOLON %s\n",line_number, yytext); return *yytext;}
","		          { col+=1; printf("%d :FROM FLEX COMMA %s\n",line_number, yytext); return *yytext;}
"("             { col+=1; printf("%d :FROM FLEX LPAREN %s\n",line_number, yytext); return *yytext;}
")"             { col+=1; printf("%d :FROM FLEX RPAREN %s\n",line_number, yytext); return *yytext;}
"["             { col+=1; printf("%d :FROM FLEX LBRACKET %s\n",line_number, yytext); return *yytext;}
"]"             { col+=1; printf("%d :FROM FLEX RBRACKET %s\n",line_number, yytext); return *yytext;}
"{"             { col+=1; printf("%d :FROM FLEX LBRACE %s\n",line_number, yytext); return *yytext;}
"}"             { col+=1; printf("%d :FROM FLEX RBRACE %s\n",line_number, yytext); return *yytext;}
{ID}            { col+=strlen(yytext); printf("%d :FROM FLEX IDENTIFIER %s\n",line_number, yytext); return ID;}
{NUM}           { col+=strlen(yytext); printf("%d :FROM FLEX NUMBER %s\n",line_number, yytext); return NUM;}
{COM}           { col+=strlen(yytext) } /* eat up comments */
[ \t\r]+        { col+=strlen(yytext) } /* eat up whitespace */
[\n]            { line_number++; }

%%
