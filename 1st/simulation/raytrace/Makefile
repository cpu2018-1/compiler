OPT=
SOURCE=minrt
INPUT=contest.bin
ASMDIR=../simu-assem/assembler
SIMDIR=../simu-assem/simulator



all : simulate

assembler : $(ASMDIR)/assembler.c
	gcc -o $@ $< -lfl

simulator : $(SIMDIR)/main.c $(SIMDIR)/float.c
	gcc -w -O3 -o simulator $^ -lm

$(SOURCE).s : min-caml $(SOURCE).ml
	./min-caml $(SOURCE) -inline 10 2> /dev/null


bytecode.b : $(SOURCE).s
	./assembler $< > /dev/null


simulate : assembler simulator bytecode.b 
	./simulator bytecode.b -i $(INPUT) $(OPT)
