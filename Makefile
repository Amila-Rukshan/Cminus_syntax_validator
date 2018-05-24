compiler: lex.yy.o compiler.tab.o
	gcc -o compiler $^

compiler.tab.h: compiler.y
	bison --debug --verbose -d compiler.y

compiler.tab.c: compiler.y
	bison -d compiler.y

lex.yy.c: compiler.flex compiler.tab.h
	flex  compiler.flex
