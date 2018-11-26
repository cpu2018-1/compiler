OPT=
SOURCE=minrt
ASMDIR=../simu-assem3rd/assembly
SIMDIR=../simu-assem3rd/simulator


.PHONY: $(SOURCE).s

all : $(SOURCE).s simulate

assembler : $(ASMDIR)/lex.c
	gcc -o $@ $< -lfl

simulator : $(SIMDIR)/main.c $(SIMDIR)/float.c
	gcc -w -O2 -o simulator $^ -lm

$(SOURCE).s : 
	#./min-caml $(SOURCE) -inline 1 2> /dev/null
	./min-caml $(SOURCE) 2> /dev/null


bytecode.b : $(SOURCE).s
	./assembler $< > /dev/null


simulate : assembler simulator bytecode.b 
	./simulator bytecode.b $(OPT)


clean :
	rm *mine* *utop*
