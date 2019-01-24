OPT=-s sub.txt
SOURCE=minrt
INPUT=contest.bin
ASMDIR=../simu-assem3rd/assembly
SIMDIR=../simu-assem3rd/simulator



all : simulate

assembler : $(ASMDIR)/lex.c
	gcc -o $@ $< -lfl

simulator : $(SIMDIR)/main.c $(SIMDIR)/float.c
	gcc -w -O3 -g -o simulator $^ -lm

$(SOURCE).s : min-caml $(SOURCE).ml
	./min-caml $(SOURCE) -inline 50 2> /dev/null
#	./min-caml $(SOURCE) 2> /dev/null


bytecode.b : $(SOURCE).s
	./assembler $< > /dev/null


simulate : assembler simulator bytecode.b 
	./simulator bytecode.b -i $(INPUT) $(OPT)
