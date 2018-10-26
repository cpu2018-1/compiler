#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

#define CODENUM 131072
#define MEMSIZE 131072

void print_info(void);
union uv { float f; int i; };

int debug = 0;
int jump = 0;
char jumpop[16];
char currop[16];
int last = 0;

//データ構造
   int mem_code[CODENUM];
   int reg[32] = {0};
   float freg[32];
   int pc = 0;
   int mem[MEMSIZE];
   int io;  


int main (int argc, char *argv[]){
  
    FILE *fp;
    FILE *infp;
    int num;
    char name[64];
    char inname[64];
    union uv v = {0};
    

    if(argc > 1){
        strcpy(name, argv[1]);        
    }

    if(argc > 2){

        if(strcmp(argv[2], "-d") == 0){
            printf("<debug mode>\n");
            debug = 1;    
        
        }else{

            strcpy(inname, argv[2]);
            infp = fopen(inname,"rb");
            if( infp == NULL ){
                fputs( "ファイルオープンに失敗しました。\n", stderr );
                exit( EXIT_FAILURE );
            } 

            if(argc > 3){

                if(strcmp(argv[argc-1], "-d") == 0){
                    printf("<debug mode>\n");
                    debug = 1;    
                }
            }

        }

    }

    fp = fopen(name,"rb");
    if( fp == NULL ){
        fputs( "ファイルオープンに失敗しました。\n", stderr );
        exit( EXIT_FAILURE );
    } 
    
    if( (num = fread(mem_code, sizeof(int), CODENUM, fp )) < 1 ){
        fputs( "読み込み中にエラーが発生しました。\n", stderr );
        exit( EXIT_FAILURE );
    }


    //処理を書く
    while(0 <= pc && pc < num){

//        printf("%d\n", pc);

        int code = mem_code[pc];

        int opecode = (code >> 26) & 0b111111;
        int fopecode = code & 0b11111111111;
        int rd = (code >> 21) & 0b11111;
        int rs = (code >> 16) & 0b11111;
        int rt = (code >> 11) & 0b11111;
        int imm = code & 0xffff;
          if(imm >> 15)
            imm = imm | 0xffff0000;
        int divimm = (((code >> 21) & 0b11111) << 11) + (code & 0b11111111111);
          if(divimm >> 15)
            divimm = divimm | 0xffff0000;
        int jaddr = code & 0x3ffffff;
          if(jaddr >> 25)
             jaddr = jaddr | 0xfc000000;
        reg[0] = 0;
        freg[0] = 0;
      
        if(code == 0)
          break;

        switch (opecode){

            int tmp;
            case 0b110000:
                //LUI
                reg[rd] = (imm << 16) | (reg[rs] & 0b1111111111111111);
                pc++;
                strcpy(currop, "lui");
                printf("lui r%d r%d %d\n", rd, rs, imm);
                break;
            case 0b001100:
                //ADD
                reg[rd] = reg[rs] + reg[rt];
                pc++;
                strcpy(currop, "add");
                printf("add r%d r%d r%d\n", rd, rs, rt);
                //printf("\tr%d <= %d (= %d + %d)\n", rd, reg[rd], reg[rs], reg[rt]);
                break;
            case 0b001000:
                //ADDI
                reg[rd] = reg[rs] + imm;
                pc++;
                strcpy(currop, "addi");
                printf("addi r%d r%d %d\n", rd, rs, imm);
                break;
            case 0b010100:
                //SUB
                reg[rd] = reg[rs] - reg[rt];
                pc++;
                strcpy(currop, "sub");
                printf("sub r%d r%d r%d\n", rd, rs, rt);
                break;
            case 0b011100:
                //SLL
                reg[rd] = reg[rs] << (reg[rt] & 0b11111);
                pc++;
                strcpy(currop, "sll");
                printf("sll r%d r%d r%d\n", rd, rs, rt);  
                break;
            case 0b011000:
                //SLLI
                reg[rd] = reg[rs] << (imm & 0b11111);
                pc++;
                strcpy(currop, "slli");
                printf("slli r%d r%d %d\n", rd, rs, imm);  
                break;
            case 0b100100:
                //SRL
                reg[rd] = (int)((unsigned)reg[rs] >> (reg[rt] & 0b11111));
                pc++;
                strcpy(currop, "srl");
                printf("srl r%d r%d r%d\n", rd, rs, rt);  
                break;
            case 0b100000:
                //SRLI
                reg[rd] = (int)((unsigned)reg[rs] >> (imm & 0b11111));
                pc++;
                strcpy(currop, "srli");
                printf("srli r%d r%d %d\n", rd, rs, imm);  
                break;
            case 0b101100:
                //SRA
                reg[rd] = reg[rs] >> (reg[rt] & 0b11111);
                pc++;
                strcpy(currop, "sra");
                printf("sra r%d r%d r%d\n", rd, rs, rt);  
                break;
            case 0b101000:
                //SRAI
                reg[rd] = reg[rs] >> (imm & 0b11111);
                pc++;
                strcpy(currop, "srai");
                printf("srai r%d r%d %d\n", rd, rs, imm);  
                break;
            case 0b000110:
                //JAL
                reg[31] = pc + 1;
                pc = pc + jaddr;
                strcpy(currop, "jal");
                printf("jal %d\n", pc);
                break;
            case 0b100010:
                //J
                pc = pc + jaddr;
                strcpy(currop, "j");
                printf("j %d\n", pc);
                break;
            case 0b001110:
                //JALR
                tmp = pc;
                pc = reg[rs];
                reg[31] = tmp + 1;
                strcpy(currop, "jalr");
                printf("jalr %d\n", rs);
                break;
            case 0b101010:
                //JR
                pc = reg[rs];
                strcpy(currop, "jr");
                printf("jr %d\n", rs);
                break;
            case 0b000010:
                //BEQ
                strcpy(currop, "beq");
                printf("beq r%d[%d] r%d[%d] %d\n", rs, reg[rs], rt, reg[rt], divimm);
                if(reg[rs] == reg[rt]){
                    pc = pc + divimm;
                    printf("\tbranch to %d\n", pc+reg[rt]);
                }else
                  pc++;
                break;
            case 0b001010:
                //BNE
                strcpy(currop, "bne");
                printf("bne r%d r%d %d\n", rs, rt, divimm);
                if(reg[rs] != reg[rt])
                    pc = pc + divimm;
                else
                  pc++;
                break;
            case 0b010010:
                //BLT
                strcpy(currop, "blt");
                printf("blt r%d r%d %d\n", rs, rt, divimm);
                if(reg[rs] < reg[rt])
                    pc = pc + divimm;
                else
                  pc++;
                break;
            case 0b011010:
                //BLE
                strcpy(currop, "ble");
                printf("ble r%d r%d %d\n", rs, rt, divimm);
                if(reg[rs] <= reg[rt])
                    pc = pc + divimm;
                else
                  pc++;
                break;
            case 0b001111:
                //LW
                reg[rd] = mem[reg[rs] + imm];
                pc++;
                strcpy(currop, "lw");
                printf("lw r%d r%d %d\n", rd, rs, imm);
                break;
            case 0b000111:
                //SW
                mem[reg[rs] + divimm] = reg[rt];
                pc++;
                strcpy(currop, "sw");
                printf("sw r%d r%d %d\n", rs, rt, divimm);
                break;
            case 0b000011:
                //OUT
                io = reg[rs] & 0b11111111;
                fputc(io, stderr);
                pc++;
                strcpy(currop, "out");
                printf("out\n");
                break;
            case 0b001011:
                //IN
                if( fread(&io, sizeof(char), 1, infp ) < 1 ){
                     fputs( "読み込み中にエラーが発生しました。\n", stderr );
                    // exit( EXIT_FAILURE );
                }
                reg[rd] = 0xffffff & (io & 0xff);
                pc++;
                strcpy(currop, "in");
                printf("in\n");
                break;
            case 0b000001:
                //FLOAT
                switch (fopecode) {

                    case 0b100:
                      //FADD
                      freg[rd] = freg[rs] + freg[rt];
                      pc++;
                      strcpy(currop, "fadd");
                      printf("fadd f%d f%d f%d\n", rd, rs, rt);
                      break;
                    case 0b1000:
                      //FSUB
                      freg[rd] = freg[rs] - freg[rt];
                      pc++;
                      strcpy(currop, "fsub");
                      printf("fsub f%d f%d f%d\n", rd, rs, rt);
                      break;
                    case 0b1100:
                      //FMUL
                      freg[rd] = freg[rs] * freg[rt];
                      pc++;
                      strcpy(currop, "fmul");
                      printf("fmul f%d f%d f%d\n", rd, rs, rt);
                      break;
                    case 0b10000:
                      //FDIV
                      freg[rd] = freg[rs] / freg[rt];
                      pc++;
                      strcpy(currop, "fdiv");
                      printf("fdiv f%d f%d f%d\n", rd, rs, rt);
                      break;
                    case 0b10101:
                      //FEQ
                      reg[rd] = (freg[rs] == freg[rt] ? 1 : 0);
                      pc++;
                      strcpy(currop, "feq");
                      printf("feq r%d f%d f%d\n", rd, rs, rt);
                      break;
                    case 0b11001:
                      //FLT
                      reg[rd] = (freg[rs] < freg[rt] ? 1 : 0);
                      pc++;
                      strcpy(currop, "flt");
                      printf("flt r%d f%d f%d\n", rd, rs, rt);
                      break;
                    case 0b11101:
                      //FLE
                      reg[rd] = (freg[rs] <= freg[rt] ? 1 : 0);
                      pc++;
                      strcpy(currop, "fle");
                      printf("fle r%d f%d f%d\n", rd, rs, rt);
                      break;
                    case 0b100000:
                      //FSQRT
                      freg[rd] = sqrt(freg[rs]);
                      pc++;
                      strcpy(currop, "fsqrt");
                      printf("fsqrt f%d f%d\n", rd, rs);
                      break;
                    case 0b100100:
                      //FNEG
                      freg[rd] = -freg[rs];
                      pc++;
                      strcpy(currop, "fneg");
                      printf("fneg f%d f%d\n", rd, rs);
                      break;
                    case 0b101010:
                      //ITOF
                      freg[rd] = (float) reg[rs];
                      pc++;
                      strcpy(currop, "itof");
                      printf("itof f%d r%d\n", rd, rs);
                      break;
                    case 0b101101:
                      //FTOI
                      reg[rd] = (int) freg[rs];
                      pc++;
                      strcpy(currop, "ftoi");
                      printf("ftoi r%d f%d\n", rd, rs);
                      break;
                    case 0b110010:
                      //FMVFR
                      v.i = reg[rs];
                      freg[rd] = v.f;
                      pc++;
                      strcpy(currop, "fmvfr");
                      printf("fmvfr f%d r%d\n", rd, rs);
                      break;
                    case 0b110101:
                      //FMVTR
                      v.f = freg[rs];
                      reg[rd] = v.i;
                      pc++;
                      strcpy(currop, "fmtvr");
                      printf("fmvtr r%d f%d\n", rd, rs);
                      break;
                   default:
                      break; 

                }
                break;
            default:
                break;

            }

            if(debug){

                if(jump == 0 && last == 0){
                  print_info();
                }else if(jump == 1){
                
                  if(strcmp(jumpop, currop) == 0){
                      jump = 0;
                      print_info();
                  }
                
                }
            }
    }

    if(debug && last)
      print_info();

    printf("\nr1 = %d\n", reg[1]);
    printf("\nf1 = %f\n", freg[1]);

    if(fclose( fp ) == EOF ){
        fputs( "ファイルクローズに失敗しました。\n", stderr );
        exit( EXIT_FAILURE );
    }   
    
    return 0;
    
}



void print_info(void){

    char comm[256];
    
    while(1){

      printf("\e[31m>\e[0m ");

      scanf("%s", comm);

      if(strcmp(comm, "n") == 0 || strcmp(comm, "next") == 0){
        putchar('\n');
        break;
      }

      if(strcmp(comm, "j") == 0 || strcmp(comm, "jump") == 0){
          jump = 1;
          scanf("%s", jumpop);
          putchar('\n');
          break;
      }

      if( strcmp(comm, "l") == 0 || strcmp(comm, "last") == 0){
          last = 1;
          putchar('\n');
          break;
      }

      if( strcmp(comm, "q") == 0 || strcmp(comm, "quit") == 0){
          debug = 0;
          putchar('\n');
          break;
      }

      if(strcmp(comm, "reg") == 0){
        
        for(int i = 0; i < 8; i++){
          printf("%2d = %3d   %2d = %3d   %2d = %3d   %2d = %3d\n", 4*i, reg[4*i], 4*i+1, reg[4*i+1], 4*i+2, reg[4*i+2], 4*i+3, reg[4*i+3]);
        }
      
      }else if(strcmp(comm, "freg") == 0){
        
        for(int i = 0; i < 8; i++){
          printf("%2d = %.6f   %2d = %.6f   %2d = %.6f   %2d = %.6f\n", 4*i, freg[4*i], 4*i+1, freg[4*i+1], 4*i+2, freg[4*i+2], 4*i+3, freg[4*i+3]);
        }
      
      }else if(strcmp(comm, "pc") == 0){
      
          printf("%d\n", pc);
      
      }else if(strcmp(comm, "mem") == 0){
          
          int n;
          scanf("%d", &n);
          printf("%d\n", mem[n]);

      }else if(strcmp(comm, "io") == 0){

          printf("%d\n", io);

      }

    }


}


