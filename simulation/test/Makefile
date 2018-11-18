OPT=
SOURCE=minrt


.PHONY: $(SOURCE).s

all : simulate

assembler : assembler.c
	gcc -o $@ $< -lfl

simulator : main.c float.c
	gcc -w -O2 -o simulator $^ -lm

$(SOURCE).s : 
	./min-caml $(SOURCE) -inline 1 2> /dev/null


bytecode.b : $(SOURCE).s
	./assembler $< > /dev/null


simulate : assembler simulator bytecode.b 
	./simulator bytecode.b $(OPT)


clean :
	rm *mine* *utop*
