#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include "float.h"

#define CODENUM 131072
#define MEMSIZE 131072
#define OPNUM 35

void print_info(void);
union uv { float f; int i; };
typedef struct {

  int linenum;
  int l_linenum;
  char *label;

} ssubinfo;

ssubinfo subinfo[CODENUM]; 

char *opdata[OPNUM] = {"lui", "add", "addi", "sub", "sll", "slli", "srl", 
                  "srli", "sra", "srai", "jal", "j", "jalr", "jr",
                  "beq", "bne", "blt", "ble", "lw", "sw", "out", "in",
                  "fadd", "fsub", "fmul", "fdiv", "feq", "flt", "fle", 
                  "fsqrt", "fneg", "itof", "ftoi", "fmvfr", "fmvtr"};
long opcount[OPNUM] = {0};

int debug = 0;
int sub = 0;
int op = 0;
int line = 0;
int label = 0;
int count = 0;
int last = 0;

char jumpop[16];
char currop[16];
int jumpline = 0;
char jumplabel[64];
int jumpcount = 0;
int currcount = 0;

//データ構造
   int mem_code[CODENUM];
   int mem[MEMSIZE];
   int reg[32] = {0};
   float freg[32];
   int pc = 0;
   char io;  


int main (int argc, char *argv[]){
  
    FILE *fp;
    FILE *subfp;
    FILE *infp;
    FILE *stfp;
    char name[64];
    char subname[64];
    char inname[64];
    long num;
    union uv v = {0};
    

    //引数処理およびファイルオープン
    if(argc > 1){

        strcpy(name, argv[1]);
        fp = fopen(name,"rb");
        if( fp == NULL ){
          fputs( "ファイルオープンに失敗しました。\n", stderr );
          exit( EXIT_FAILURE );
        } 
                
    }

    if( argc > 2 ){

        int i = 2;
        while( i < argc ){

              if( strcmp(argv[i], "-s") == 0 ){
                  
                  sub = 1;  
                  strcpy(subname, argv[i+1]);
                  subfp = fopen(subname,"r");
                  if( subfp == NULL ){
                    fputs( "サブファイルオープンに失敗しました。\n", stderr );
                    exit( EXIT_FAILURE );
                  } 
                  i += 2;
              
              }else if( strcmp(argv[i], "-i") == 0 ){
                  
                  strcpy(inname, argv[i+1]);
                  infp = fopen(inname,"rb");
                  if( infp == NULL ){
                    fputs( "入力用ファイルオープンに失敗しました。\n", stderr );
                    exit( EXIT_FAILURE );
                  } 
                  i += 2;

              }else if( strcmp(argv[i], "-d") == 0 ){

                  printf("\n");
                  debug = 1;    
                  i++;
              
              }
        }

    }

    stfp = fopen("statistics.txt", "w");
    

    //ファイル読み込み
    if( (num = fread(mem_code, sizeof(int), CODENUM, fp )) < 1 ){
        fputs( "読み込み中にエラーが発生しました。\n", stderr );
        exit( EXIT_FAILURE );
    }

    if(sub){
      int subcodeN;
      int sublabelN;
      fscanf(subfp, "%d", &subcodeN);
      fscanf(subfp, "%d", &sublabelN);
      for(int i = 0; i < subcodeN; i++){
          fscanf(subfp, "%d", &(subinfo[i].linenum));
      }
      for(int i = 0; i < sublabelN; i++){
      
          int pos;
          int selfln;
          fscanf(subfp, "%d", &pos);
          fscanf(subfp, "%d", &selfln);
          char *cp = (char *) malloc(sizeof(char) * 64);
          fscanf(subfp, "%s", cp);
          subinfo[pos].l_linenum = selfln;
          subinfo[pos].label = cp;

      }
    }

    //処理開始
    while(0 <= pc && pc < num){

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
      
        int tmppc = pc;
        if(code == 0)
          break;
        
        if(debug && sub){

            char *cp = subinfo[pc].label;
            if( cp != NULL )
                printf("\e[33m<%s> \e[0m\n", cp);
            
            printf("%d:\t ", subinfo[pc].linenum); 
        
        }

    
        switch (opecode){

            int tmp;
            case 0b110000:
                //LUI
                reg[rd] = (imm << 16) | (reg[rs] & 0b1111111111111111);
                pc++;
                opcount[0]++;
                if(debug){
                  strcpy(currop, "lui");
                  printf("lui r%d r%d %d\n", rd, rs, imm);
                }
                break;
            case 0b001100:
                //ADD
                reg[rd] = reg[rs] + reg[rt];
                pc++;
                opcount[1]++;
                if(debug){
                  strcpy(currop, "add");
                  printf("add r%d r%d r%d\n", rd, rs, rt);
                }
                break;
            case 0b001000:
                //ADDI
                reg[rd] = reg[rs] + imm;
                pc++;
                opcount[2]++;
                if(debug){
                  strcpy(currop, "addi");
                  printf("addi r%d r%d %d\n", rd, rs, imm);
                }
                break;
            case 0b010100:
                //SUB
                reg[rd] = reg[rs] - reg[rt];
                pc++;
                opcount[3]++;
                if(debug){
                  strcpy(currop, "sub");
                  printf("sub r%d r%d r%d\n", rd, rs, rt);
                }
                break;
            case 0b011100:
                //SLL
                reg[rd] = reg[rs] << (reg[rt] & 0b11111);
                pc++;
                opcount[4]++;
                if(debug){
                  strcpy(currop, "sll");
                  printf("sll r%d r%d r%d\n", rd, rs, rt);  
                }
                break;
            case 0b011000:
                //SLLI
                reg[rd] = reg[rs] << (imm & 0b11111);
                pc++;
                opcount[5]++;
                if(debug){
                  strcpy(currop, "slli");
                  printf("slli r%d r%d %d\n", rd, rs, imm);  
                }
                break;
            case 0b100100:
                //SRL
                reg[rd] = (int)((unsigned)reg[rs] >> (reg[rt] & 0b11111));
                pc++;
                opcount[6]++;
                if(debug){
                  strcpy(currop, "srl");
                  printf("srl r%d r%d r%d\n", rd, rs, rt);  
                }
                break;
            case 0b100000:
                //SRLI
                reg[rd] = (int)((unsigned)reg[rs] >> (imm & 0b11111));
                pc++;
                opcount[7]++;
                if(debug){
                  strcpy(currop, "srli");
                  printf("srli r%d r%d %d\n", rd, rs, imm);  
                }
                break;
            case 0b101100:
                //SRA
                reg[rd] = reg[rs] >> (reg[rt] & 0b11111);
                pc++;
                opcount[8]++;
                if(debug){
                  strcpy(currop, "sra");
                  printf("sra r%d r%d r%d\n", rd, rs, rt);  
                }
                break;
            case 0b101000:
                //SRAI
                reg[rd] = reg[rs] >> (imm & 0b11111);
                pc++;
                opcount[9]++;
                if(debug){
                  strcpy(currop, "srai");
                  printf("srai r%d r%d %d\n", rd, rs, imm);  
                }
                break;
            case 0b000110:
                //JAL
                reg[31] = pc + 1;
                pc = pc + jaddr;
                opcount[10]++;
                if(debug){
                  strcpy(currop, "jal");
                  if(sub){
                    if(subinfo[pc].label != NULL){
                        printf("jal \e[33m%s(line %d)\e[0m\n", subinfo[pc].label, subinfo[pc].l_linenum);   
                    }else{
                        printf("jal \e[33m(line %d)\e[0m\n", subinfo[pc].l_linenum);
                    }
                  }else{
                        printf("jal %d\n", jaddr);
                  }
                }
                break;
            case 0b100010:
                //J
                pc = pc + jaddr;
                opcount[11]++;
                if(debug){
                  strcpy(currop, "j");
                  if(sub){
                    if(subinfo[pc].label != NULL){
                        printf("j \e[33m%s(line %d)\e[0m\n", subinfo[pc].label, subinfo[pc].l_linenum);   
                    }else{
                        printf("j \e[33m(line %d)\e[0m\n", subinfo[pc].l_linenum);
                    }
                  }else{
                        printf("j %d\n", jaddr);
                  }
                }
                break;
            case 0b001110:
                //JALR
                tmp = pc;
                pc = reg[rs];
                reg[31] = tmp + 1;
                opcount[12]++;
                if(debug){
                  strcpy(currop, "jalr");
                  if(sub)
                    printf("jalr \e[33mr%d(line %d)\e[0m\n", rs, subinfo[pc].linenum);
                  else
                    printf("jalr r%d\n", rs);
                }
                break;
            case 0b101010:
                //JR
                pc = reg[rs];
                opcount[13]++;
                if(debug){
                  strcpy(currop, "jr");
                  if(sub)
                    printf("jr \e[33mr%d(line %d)\e[0m\n", rs, subinfo[pc].linenum);
                  else
                    printf("jr r%d\n", rs);
                }
                break;
            case 0b000010:
                //BEQ
                opcount[14]++;
                if(debug){
                  strcpy(currop, "beq");
                  if(sub == 0)
                    printf("beq r%d r%d %d\n", rs, rt, divimm);
                }
                if(reg[rs] == reg[rt]){
                    pc = pc + divimm;
                    if(debug && sub)
                       printf("beq r%d r%d \e[33m%s(line %d)\e[0m\n",rs ,rt, subinfo[pc].label, subinfo[pc].l_linenum);   
                }
                else{
                  if(debug && sub)
                    printf("beq r%d r%d %s(line %d)\n",rs ,rt, subinfo[pc+divimm].label, subinfo[pc+divimm].l_linenum);   
                  pc++;
                }
                break;
            case 0b001010:
                //BNE
                opcount[15]++;
                if(debug){
                  strcpy(currop, "bne");
                  if(sub == 0)
                    printf("bne r%d r%d %d\n", rs, rt, divimm);
                }
                if(reg[rs] != reg[rt]){
                    pc = pc + divimm;
                    if(debug && sub)
                       printf("bne r%d r%d \e[33m%s(line %d)\e[0m\n",rs ,rt, subinfo[pc].label, subinfo[pc].l_linenum);   
                }
                else{
                  if(debug && sub)
                    printf("bne r%d r%d %s(line %d)\n",rs ,rt, subinfo[pc+divimm].label, subinfo[pc+divimm].l_linenum);   
                  pc++;
                }
                break;
            case 0b010010:
                //BLT
                opcount[16]++;
                if(debug){
                  strcpy(currop, "blt");
                  if(sub == 0)
                    printf("blt r%d r%d %d\n", rs, rt, divimm);
                }
                if(reg[rs] < reg[rt]){
                    pc = pc + divimm;
                    if(debug && sub)
                       printf("blt r%d r%d \e[33m%s(line %d)\e[0m\n",rs ,rt, subinfo[pc].label, subinfo[pc].l_linenum);   
                }
                else{
                  if(debug && sub)
                    printf("blt r%d r%d %s(line %d)\n",rs ,rt, subinfo[pc+divimm].label, subinfo[pc+divimm].l_linenum);   
                  pc++;
                }
                break;
            case 0b011010:
                //BLE
                opcount[17]++;
                if(debug){
                  strcpy(currop, "ble");
                  if(sub == 0)
                    printf("ble r%d r%d %d\n", rs, rt, divimm);
                }
                if(reg[rs] <= reg[rt]){
                    pc = pc + divimm;
                    if(debug && sub)
                       printf("ble r%d r%d \e[33m%s(line %d)\e[0m\n",rs ,rt, subinfo[pc].label, subinfo[pc].l_linenum);   
                }
                else{
                  if(debug && sub)
                    printf("ble r%d r%d %s(line %d)\n",rs ,rt, subinfo[pc+divimm].label, subinfo[pc+divimm].l_linenum);   
                  pc++;
                }
                break;
            case 0b001111:
                //LW
                reg[rd] = mem[reg[rs] + imm];
                pc++;
                opcount[18]++;
                if(debug){
                  strcpy(currop, "lw");
                  printf("lw r%d r%d %d\n", rd, rs, imm);
                }
                break;
            case 0b000111:
                //SW
                mem[reg[rs] + divimm] = reg[rt];
                pc++;
                opcount[19]++;
                if(debug){
                  strcpy(currop, "sw");
                  printf("sw r%d r%d %d\n", rs, rt, divimm);
                }
                break;
            case 0b000011:
                //OUT
                opcount[20]++;
                if(debug){
                  strcpy(currop, "out");
                  printf("out\e[35m\n");
                }
                io = reg[rs] & 0b11111111;
                fputc(io, stderr);
                pc++;
                if(debug)
                  printf("(stderr)\e[0m\n");
                break;
            case 0b001011:
                //IN
                if( fread(&io, sizeof(char), 1, infp ) < 1 ){
                     fputs( "読み込み中にエラーが発生しました。\n", stderr );
                     exit( EXIT_FAILURE );
                }
                reg[rd] = 0x000000ff & (int) io;
                pc++;
                opcount[21]++;
                if(debug){
                  strcpy(currop, "in");
                  printf("in\n");
                }
                break;
            case 0b000001:
                //FLOAT
                switch (fopecode) {

                    case 0b100:
                      //FADD
                      freg[rd] = fadd(freg[rs], freg[rt]);
                      pc++;
                      opcount[22]++;
                      if(debug){
                        strcpy(currop, "fadd");
                        printf("fadd f%d f%d f%d\n", rd, rs, rt);
                      }
                      break;
                    case 0b1000:
                      //FSUB
                      freg[rd] = fsub(freg[rs], freg[rt]);
                      pc++;
                      opcount[23]++;
                      if(debug){
                        strcpy(currop, "fsub");
                        printf("fsub f%d f%d f%d\n", rd, rs, rt);
                      }
                      break;
                    case 0b1100:
                      //FMUL
                      freg[rd] = fmul(freg[rs], freg[rt]);
                      pc++;
                      opcount[24]++;
                      if(debug){
                        strcpy(currop, "fmul");
                        printf("fmul f%d f%d f%d\n", rd, rs, rt);
                      }
                      break;
                    case 0b10000:
                      //FDIV
                      freg[rd] = fdiv(freg[rs], freg[rt]);
                      pc++;
                      opcount[25]++;
                      if(debug){
                        strcpy(currop, "fdiv");
                        printf("fdiv f%d f%d f%d\n", rd, rs, rt);
                      }
                      break;
                    case 0b10101:
                      //FEQ
                      reg[rd] = feq(freg[rs], freg[rt]);
                      pc++;
                      opcount[26]++;
                      if(debug){
                        strcpy(currop, "feq");
                        printf("feq r%d f%d f%d\n", rd, rs, rt);
                      }
                      break;
                    case 0b11001:
                      //FLT
                      reg[rd] = flt(freg[rs], freg[rt]);
                      pc++;
                      opcount[27]++;
                      if(debug){
                        strcpy(currop, "flt");
                        printf("flt r%d f%d f%d\n", rd, rs, rt);
                      }
                      break;
                    case 0b11101:
                      //FLE
                      reg[rd] = fle(freg[rs], freg[rt]);
                      pc++;
                      opcount[28]++;
                      if(debug){
                        strcpy(currop, "fle");
                        printf("fle r%d f%d f%d\n", rd, rs, rt);
                      }
                      break;
                    case 0b100000:
                      //FSQRT
                      freg[rd] = fsqrt(freg[rs]);
                      pc++;
                      opcount[29]++;
                      if(debug){
                        strcpy(currop, "fsqrt");
                        printf("fsqrt f%d f%d\n", rd, rs);
                      }
                      break;
                    case 0b100100:
                      //FNEG
                      freg[rd] = fneg(freg[rs]);
                      pc++;
                      opcount[30]++;
                      if(debug){
                        strcpy(currop, "fneg");
                        printf("fneg f%d f%d\n", rd, rs);
                      }
                      break;
                    case 0b101010:
                      //ITOF
                      freg[rd] = itof(reg[rs]);
                      pc++;
                      opcount[31]++;
                      if(debug){
                        strcpy(currop, "itof");
                        printf("itof f%d r%d\n", rd, rs);
                      }
                      break;
                    case 0b101101:
                      //FTOI
                      reg[rd] = ftoi(freg[rs]);
                      pc++;
                      opcount[32]++;
                      if(debug){
                        strcpy(currop, "ftoi");
                        printf("ftoi r%d f%d\n", rd, rs);
                      }
                      break;
                    case 0b110010:
                      //FMVFR
                      v.i = reg[rs];
                      freg[rd] = v.f;
                      pc++;
                      opcount[33]++;
                      if(debug){
                        strcpy(currop, "fmvfr");
                        printf("fmvfr f%d r%d\n", rd, rs);
                      }
                      break;
                    case 0b110101:
                      //FMVTR
                      v.f = freg[rs];
                      reg[rd] = v.i;
                      pc++;
                      opcount[34]++;
                      if(debug){
                        strcpy(currop, "fmtvr");
                        printf("fmvtr r%d f%d\n", rd, rs);
                      }
                      break;
                   default:
                      break; 

                }
                break;
            default:
                break;

            }

            if(debug){

                if(op == 0 && line == 0 && label == 0 && count == 0 && last == 0){
                  print_info();
                }else if(op == 1){
                  
                  if(strcmp(jumpop, currop) == 0){
                      op = 0;
                      print_info();
                  }
                
                }else if(line == 1){

                  if(jumpline == subinfo[tmppc].linenum || jumpline == subinfo[tmppc].l_linenum){
                      line = 0;
                      print_info();
                  }

                }else if(label == 1){
                  
                   if(subinfo[tmppc].label != NULL && strcmp(jumplabel, subinfo[tmppc].label) == 0){
                      label = 0;
                      print_info();
                   }

                }else if(count == 1){

                  if(jumpcount == currcount){
                      count = 0;
                      print_info();
                  }

                }

                currcount++;

            }

    }

    if(debug && last)
      print_info();


    //統計機能
    for(int i = 0; i < OPNUM; i++){
          
          fprintf(stfp, "%s\t%6.3f\n", opdata[i], opcount[i]/(float)num * 100);

    }


    if(fclose( fp ) == EOF ){
        fputs( "ファイルクローズに失敗しました。\n", stderr );
        exit( EXIT_FAILURE );
    }   
    
    return 0;
    
}



void print_info(void){

    char comm[256];
    char head;
    
    while(1){

      printf("\e[31m>\e[0m ");
      
      head = fgetc(stdin);
      ungetc(head, stdin);
      if(head == '\n'){
          fgetc(stdin);
          putchar('\n');
          break;
      }

      scanf("%s", comm);
      fgetc(stdin);

      if(strcmp(comm, "n") == 0 || strcmp(comm, "next") == 0){
        putchar('\n');
        break;
      }

      if(strcmp(comm, "j") == 0 || strcmp(comm, "jump") == 0){
        
        char arg[32];
        scanf("%s", arg);
        fgetc(stdin);

        int ln = atoi(arg);
        if(ln != 0){
            line = 1;
            jumpline = ln;
            printf("line = %d\n", ln);
            putchar('\n');
            break;
        }else{

            for(int i = 0; i < OPNUM; i++){
                
                if(strcmp(arg, opdata[i]) == 0){
                      op = 1;
                      strcpy(jumpop, arg);
                      goto escape;
                }

            }

            label = 1;
            strcpy(jumplabel, arg);

            escape:
            putchar('\n');
            break;

        }

      }

      if(strcmp(comm, "o") == 0 || strcmp(comm, "opecode") == 0){
          op = 1;
          scanf("%s", jumpop);
          fgetc(stdin);
          putchar('\n');
          break;
      }

      if((strcmp(comm, "l") == 0 || strcmp(comm, "line") == 0) && sub == 1){
          line = 1;
          scanf("%d", &jumpline);
          fgetc(stdin);
          putchar('\n');
          break;
      }

      if((strcmp(comm, "lb") == 0 || strcmp(comm, "label") == 0) && sub == 1){
          label = 1;
          scanf("%s", jumplabel);
          fgetc(stdin);
          putchar('\n');
          break;
      }

      if(strcmp(comm, "c") == 0 || strcmp(comm, "count") == 0){
          count = 1;
          scanf("%d", &jumpcount);
          fgetc(stdin);
          putchar('\n');
          break;
      }

      if( strcmp(comm, "ll") == 0 || strcmp(comm, "last") == 0){
          last = 1;
          putchar('\n');
          break;
      }

      if( strcmp(comm, "q") == 0 || strcmp(comm, "quit") == 0){
          debug = 0;
          putchar('\n');
          exit(0);
      }

      if(strcmp(comm, "reg") == 0){
        
        for(int i = 0; i < 8; i++){
          printf("%2d = %5d      %2d = %5d      %2d = %5d      %2d = %5d\n", 4*i, reg[4*i], 4*i+1, reg[4*i+1], 4*i+2, reg[4*i+2], 4*i+3, reg[4*i+3]);
        }
      
      }else if(strcmp(comm, "freg") == 0){
        
        for(int i = 0; i < 8; i++){
          printf("%2d = %3.6f   %2d = %3.6f   %2d = %3.6f   %2d = %3.6f\n", 4*i, freg[4*i], 4*i+1, freg[4*i+1], 4*i+2, freg[4*i+2], 4*i+3, freg[4*i+3]);
        }
      
      }else if(strcmp(comm, "pc") == 0){
      
          printf("%d\n", pc);
      
      }else if(strcmp(comm, "mem") == 0){
          
          int n;
          scanf("%d", &n);
          fgetc(stdin);
          printf("%d\n", mem[n]);

      }else if(strcmp(comm, "io") == 0){

          printf("%d\n", io);

      }

    }


}


