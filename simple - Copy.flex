%{
#include "simple.tab.h"
extern int line_number;
%}
%option noyywrap


NUM      [0-9][0-9]*
ID       [a-zA-Z][a-zA-Z]*
COM      "/*"(.|\n)*"*/"

%%

"if"            { printf("FROM FLEX IF %s\n", yytext); return IF; }
"else"          { printf("FROM FLEX ELSE %s\n", yytext); return ELSE; }
"int"           { printf("FROM FLEX INT %s\n", yytext); return INT; }
"return"        { printf("FROM FLEX RETURN %s\n", yytext); return RETURN; }
"void"          { printf("FROM FLEX VOID %s\n", yytext); return VOID; }
"while"         { printf("FROM FLEX WHILE %s\n", yytext); return WHILE; }
"+"             { printf("FROM FLEX PLUS %s\n", yytext); return *yytext;}
"-"             { printf("FROM FLEX MINUS %s\n", yytext); return *yytext;}
"*"             { printf("FROM FLEX MUL %s\n", yytext); return *yytext;}
"/"             { printf("FROM FLEX DIV %s\n", yytext); return *yytext;}
"<"             { printf("FROM FLEX LT %s\n", yytext); return *yytext;}
"<="		        { printf("FROM FLEX LTEQ %s\n", yytext); return *yytext;}
">"		          { printf("FROM FLEX GT %s\n", yytext); return *yytext;}
">="		        { printf("FROM FLEX GTEQ %s\n", yytext); return *yytext;}
"=="            { printf("FROM FLEX EQ %s\n", yytext); return *yytext;}
"!="            { printf("FROM FLEX NEQ %s\n", yytext); return *yytext;}
"="             { printf("FROM FLEX ASSIGN %s\n", yytext); return *yytext;}
";"             { printf("FROM FLEX SEMICOLON %s\n", yytext); return *yytext;}
","		          { printf("FROM FLEX COMMA %s\n", yytext); return *yytext;}
"("             { printf("FROM FLEX LPAREN %s\n", yytext); return *yytext;}
")"             { printf("FROM FLEX RPAREN %s\n", yytext); return *yytext;}
"["             { printf("FROM FLEX LBRACKET %s\n", yytext); return *yytext;}
"]"             { printf("FROM FLEX RBRACKET %s\n", yytext); return *yytext;}
"{"             { printf("FROM FLEX LBRACE %s\n", yytext); return *yytext;}
"}"             { printf("FROM FLEX RBRACE %s\n", yytext); return *yytext;}
{ID}            { printf("FROM FLEX IDENTIFIER %s\n", yytext); return ID;}
{NUM}           { printf("FROM FLEX NUMBER %s\n", yytext); return NUM;}
"/*"            { char c; int s = 0;
                  do
                  { c = input();
		                if (c == EOF) break;
            		    if (s == 0 && c == '*') s = 1;
            		    else if (s == 1 && c == '*') s = 1;
            		    else if (s == 1 && c == '/') s = 2;
            		    else s = 0;
                  } while (s != 2);
                }
[ \t\r]+        /* eat up whitespace */
[\n]            { line_number++; }

%%
