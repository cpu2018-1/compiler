OPT=
SOURCE=mandel


.PHONY: $(SOURCE).s

all : simulate

assembler : assembler.c
	gcc -o $@ $< -lfl

simulator : main.c
	gcc -o simulator $< -lm

$(SOURCE).s : 
	./min-caml $(SOURCE) 2> /dev/null


bytecode.b : $(SOURCE).s
	./assembler $<


simulate : assembler simulator bytecode.b 
	./simulator bytecode.b $(OPT)
