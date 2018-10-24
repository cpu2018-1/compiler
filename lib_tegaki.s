lib_print_char:
  out r1
  jr  r31
lib_print_newline:
  addi  r30, r0, 10
  out r30
  jr  r31
lib_itof:
  itof  f1, r1
  jr  r31
lib_ftoi:
  ftoi  r1, f1
  jr  r31
lib_sqrt:
  fsqrt  f1, f1
  jr  r31
lib_create_array:
  addi  r30, r1, 0
  addi  r29, r0, 1
  addi  r1, r4, 0
lib_create_array_loop:
  beq r30, r0, lib_create_array_exit
lib_create_array_cont:
  sw  r2, 0(r4)
  sub r30, r30, r29
  addi  r4, r4, 4
  j lib_create_array_loop:
lib_create_array_exit:
  jr  r31
lib_create_float_array:
  addi  r30, r1, 0
  addi  r1, r4, 0
lib_create_float_array_loop:
  beq r30, r0, lib_create_float_array_exit
lib_create_float_array_cont:
  fmvtr r29, f1
  sw  r29, 0(r4)
  addi  r29, r0, 1
  sub r30, r30, r29
  addi  r4, r4, 4
  j lib_create_float_array_loop:
lib_create_float_array_exit:
  jr  r31
lib_read_char:
  in  r1
  jr  r31
lib_buffer_add_char:
  addi  r30, r0, 30000
  add r30, r30, r30
  lw  r29, 64(r30)
  addi  r29, r29, 1
  sw  r29, 64(r30)
  addi  r29, r29, -1
  slli  r29, r29, 2
  add r30, r30, r29
  sw  r1, 0(r30)
  jr  r31  
lib_buffer_clear:
  addi  r30, r0, 30000
  add r30, r30, r30
  sw  r0, 0(r30)
  sw  r0, 4(r30)
  sw  r0, 8(r30)
  sw  r0, 12(r30)
  sw  r0, 16(r30)
  sw  r0, 20(r30)
  sw  r0, 24(r30)
  sw  r0, 28(r30)
  sw  r0, 32(r30)
  sw  r0, 36(r30)
  sw  r0, 40(r30)
  sw  r0, 44(r30)
  sw  r0, 48(r30)
  sw  r0, 52(r30)
  sw  r0, 56(r30)
  sw  r0, 60(r30)
  sw  r0, 64(r30)
  jr  r31
lib_buffer_get:
  addi  r30, r0, 30000
  add r30, r30, r30
  slli  r1, r1, 2
  add r30, r30, r1
  lw  r1, 0(r30)
  jr r31
lib_buffer_to_int:
  addi  r30, r0, 30000
  add r30, r30, r30
  lw  r2, 64(r30)
  addi  r1, r0, 0
lib_buffer_to_int_cont:
  beq r2, r0, lib_buffer_to_int_exit
  sw  r1, 0(r3)
  sw  r2, 4(r3)
  sw  r30, 8(r3)
  sw  r31, 12(r3)
  lw  r1, 0(r30)
  addi  r1, r1, -48
  addi  r2, r2, -1
  addi  r3, r3, 16
  jal lib_iter_mul10
  addi  r3, r3, -16
  lw  r5, 0(r3)
  lw  r2, 4(r3)
  lw  r30, 8(r3)
  lw  r31, 12(r3)
  addi  r30, r30, 4
  add r1, r1, r5
  addi  r2, r2, -1
  j lib_buffer_to_int_cont:
lib_buffer_to_int_exit:
  jr  r31
