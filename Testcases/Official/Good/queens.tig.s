.globl main

.text
t_main: 
subu $sp, $sp, 64
L37: 
sw $fp, 36($sp)
add $t4, $sp, 60
move $fp, $t4
sw $ra, -28($fp)
sw $s0, -60($fp)
sw $s1, -56($fp)
sw $s2, -52($fp)
sw $s3, -48($fp)
sw $s4, -44($fp)
sw $s5, -40($fp)
sw $s6, -36($fp)
sw $s7, -32($fp)
sw $a0, 0($fp)
li $t5, 8
sw $t5, -4($fp)
add $t6, $fp, -8
move $a1, $t6
lw $t7, -4($fp)
move $a0, $t7
li $a1, 0
jal initArray
move $a0, $v0
sw $a0, ($a1)
add $t8, $fp, -12
move $a3, $t8
lw $t9, -4($fp)
move $a0, $t9
li $a1, 0
jal initArray
move $a2, $v0
sw $a2, ($a3)
add $s0, $fp, -16
move $t1, $s0
lw $s3, -4($fp)
lw $s4, -4($fp)
add $s2, $s3, $s4
sub $s1, $s2, 1
move $a0, $s1
li $a1, 0
jal initArray
move $t0, $v0
sw $t0, ($t1)
add $s5, $fp, -20
move $t3, $s5
lw $s0, -4($fp)
lw $s4, -4($fp)
add $s7, $s0, $s4
sub $s6, $s7, 1
move $a0, $s6
li $a1, 0
jal initArray
move $t2, $v0
sw $t2, ($t3)
move $a0, $fp
li $a1, 0
jal try
lw $s0, -32($fp)
move $s7, $s0
lw $s0, -36($fp)
move $s6, $s0
lw $s0, -40($fp)
move $s5, $s0
lw $s0, -44($fp)
move $s4, $s0
lw $s0, -48($fp)
move $s3, $s0
lw $s0, -52($fp)
move $s2, $s0
lw $s0, -56($fp)
move $s1, $s0
lw $s0, -60($fp)
move $s0, $s0
lw $t3, -28($fp)
move $ra, $t3
lw $t3, 36($sp)
move $fp, $t3
j L36
L36: 

addu $sp, $sp, 64
jr $ra

.text
try:
subu $sp, $sp, 56
L39: 
sw $fp, 36($sp)
add $t9, $sp, 52
move $fp, $t9
sw $ra, -20($fp)
sw $s0, -52($fp)
sw $s1, -48($fp)
sw $s2, -44($fp)
sw $s3, -40($fp)
sw $s4, -36($fp)
sw $s5, -32($fp)
sw $s6, -28($fp)
sw $s7, -24($fp)
sw $a1, -4($fp)
sw $a0, 0($fp)
lw $t9, -4($fp)
lw $s5, 0($fp)
lw $s5, -4($s5)
beq $t9, $s5, L19
L20: 
li $s5, 0
sw $s5, -8($fp)
lw $s5, 0($fp)
lw $s5, -4($s5)
sub $s5, $s5, 1
sw $s5, -12($fp)
lw $s5, -8($fp)
lw $t9, -12($fp)
ble $s5, $t9, L21
L17: 
L18: 
lw $s5, -24($fp)
move $s7, $s5
lw $s5, -28($fp)
move $s6, $s5
lw $s5, -32($fp)
move $s5, $s5
lw $t9, -36($fp)
move $s4, $t9
lw $t9, -40($fp)
move $s3, $t9
lw $t9, -44($fp)
move $s2, $t9
lw $t9, -48($fp)
move $s1, $t9
lw $t9, -52($fp)
move $s0, $t9
lw $t9, -20($fp)
move $ra, $t9
lw $t9, 36($sp)
move $fp, $t9
j L38
L19: 
lw $s5, 0($fp)
move $a0, $s5
jal printboard
j L18
L21: 
lw $s5, 0($fp)
lw $t9, -8($s5)
lw $s5, -8($fp)
mul $s5, $s5, 4
add $s5, $t9, $s5
lw $t9, ($s5)
li $s5, 0
beq $t9, $s5, L30
L31: 
li $ra, 0
L29: 
li $s5, 0
bne $ra, $s5, L27
L28: 
li $sp, 0
L26: 
li $s5, 0
bne $sp, $s5, L24
L25: 
L23: 
lw $s5, -8($fp)
lw $t9, -12($fp)
bge $s5, $t9, L17
L22: 
lw $s5, -8($fp)
add $s5, $s5, 1
sw $s5, -8($fp)
j L21
L30: 
li $v0, 1
lw $s5, 0($fp)
lw $t2, -16($s5)
lw $s5, -8($fp)
lw $t9, -4($fp)
add $s5, $s5, $t9
mul $s5, $s5, 4
add $s5, $t2, $s5
lw $t9, ($s5)
li $s5, 0
beq $t9, $s5, L32
L33: 
li $v0, 0
L32: 
move $ra, $v0
j L29
L27: 
li $zero, 1
lw $s5, 0($fp)
lw $t2, -20($s5)
lw $s5, -8($fp)
add $t9, $s5, 7
lw $s5, -4($fp)
sub $s5, $t9, $s5
mul $s5, $s5, 4
add $s5, $t2, $s5
lw $s5, ($s5)
li $t9, 0
beq $s5, $t9, L34
L35: 
li $zero, 0
L34: 
move $sp, $zero
j L26
L24: 
li $t2, 1
lw $s5, 0($fp)
lw $t9, -8($s5)
lw $s5, -8($fp)
mul $s5, $s5, 4
add $s5, $t9, $s5
sw $t2, ($s5)
li $t1, 1
lw $s5, 0($fp)
lw $t2, -16($s5)
lw $s5, -8($fp)
lw $t9, -4($fp)
add $s5, $s5, $t9
mul $s5, $s5, 4
add $s5, $t2, $s5
sw $t1, ($s5)
li $t1, 1
lw $s5, 0($fp)
lw $t2, -20($s5)
lw $s5, -8($fp)
add $s5, $s5, 7
lw $t9, -4($fp)
sub $s5, $s5, $t9
mul $s5, $s5, 4
add $s5, $t2, $s5
sw $t1, ($s5)
lw $t2, -8($fp)
lw $s5, 0($fp)
lw $t9, -12($s5)
lw $s5, -4($fp)
mul $s5, $s5, 4
add $s5, $t9, $s5
sw $t2, ($s5)
lw $t9, 0($fp)
move $a0, $t9
lw $s5, -4($fp)
add $s5, $s5, 1
move $a1, $s5
jal try
li $t2, 0
lw $s5, 0($fp)
lw $t9, -8($s5)
lw $s5, -8($fp)
mul $s5, $s5, 4
add $s5, $t9, $s5
sw $t2, ($s5)
li $t1, 0
lw $s5, 0($fp)
lw $t2, -16($s5)
lw $t9, -8($fp)
lw $s5, -4($fp)
add $s5, $t9, $s5
mul $s5, $s5, 4
add $s5, $t2, $s5
sw $t1, ($s5)
li $t1, 0
lw $s5, 0($fp)
lw $t2, -20($s5)
lw $s5, -8($fp)
add $t9, $s5, 7
lw $s5, -4($fp)
sub $s5, $t9, $s5
mul $s5, $s5, 4
add $s5, $t2, $s5
sw $t1, ($s5)
j L23
L38: 

addu $sp, $sp, 56
jr $ra

.text
printboard:
subu $sp, $sp, 60
L41: 
sw $fp, 36($sp)
add $t4, $sp, 56
move $fp, $t4
sw $ra, -24($fp)
sw $s0, -56($fp)
sw $s1, -52($fp)
sw $s2, -48($fp)
sw $s3, -44($fp)
sw $s4, -40($fp)
sw $s5, -36($fp)
sw $s6, -32($fp)
sw $s7, -28($fp)
sw $a0, 0($fp)
li $t4, 0
sw $t4, -4($fp)
lw $t4, 0($fp)
lw $t4, -4($t4)
sub $t4, $t4, 1
sw $t4, -16($fp)
lw $t1, -4($fp)
lw $t4, -16($fp)
ble $t1, $t4, L13
L0: 
la $t4, L16
move $a0, $t4
jal print
lw $t4, -28($fp)
move $s7, $t4
lw $t4, -32($fp)
move $s6, $t4
lw $t4, -36($fp)
move $s5, $t4
lw $t4, -40($fp)
move $s4, $t4
lw $t4, -44($fp)
move $s3, $t4
lw $t4, -48($fp)
move $s2, $t4
lw $t4, -52($fp)
move $s1, $t4
lw $t4, -56($fp)
move $s0, $t4
lw $t4, -24($fp)
move $ra, $t4
lw $t4, 36($sp)
move $fp, $t4
j L40
L13: 
li $t4, 0
sw $t4, -8($fp)
lw $t4, 0($fp)
lw $t4, -4($t4)
sub $t4, $t4, 1
sw $t4, -12($fp)
lw $t1, -8($fp)
lw $t4, -12($fp)
ble $t1, $t4, L9
L1: 
la $t4, L12
move $a0, $t4
jal print
lw $t1, -4($fp)
lw $t4, -16($fp)
bge $t1, $t4, L0
L14: 
lw $t4, -4($fp)
add $t4, $t4, 1
sw $t4, -4($fp)
j L13
L9: 
lw $t4, 0($fp)
lw $t1, -12($t4)
lw $t4, -4($fp)
mul $t4, $t4, 4
add $t4, $t1, $t4
lw $t1, ($t4)
lw $t4, -8($fp)
beq $t1, $t4, L7
L8: 
la $t4, L5
move $fp, $t4
L6: 
move $a0, $fp
jal print
lw $t4, -8($fp)
lw $t1, -12($fp)
bge $t4, $t1, L1
L10: 
lw $t4, -8($fp)
add $t4, $t4, 1
sw $t4, -8($fp)
j L9
L7: 
la $t4, L4
move $fp, $t4
j L6
L40: 

addu $sp, $sp, 60
jr $ra

.data
L16: 
.word 1
.asciiz "
"
.data
L15: 
.word 1
.asciiz "
"
.data
L12: 
.word 1
.asciiz "
"
.data
L11: 
.word 1
.asciiz "
"
.data
L5: 
.word 2
.asciiz " ."
.data
L4: 
.word 2
.asciiz " O"
.data
L3: 
.word 2
.asciiz " ."
.data
L2: 
.word 2
.asciiz " O"# int *initArray(int size, int init)
# {int i;
#  int *a = (int *)malloc(size*sizeof(int));
#  for(i=0;i<size;i++) a[i]=init;
#  return a;
# }

.text
initArray:
sll $a0,$a0,2
li $v0,9
syscall
move $a2,$v0
b Lrunt2
Lrunt1:
sw $a1,($a2)
sub $a0,$a0,4
add $a2,$a2,4
Lrunt2:
bgtz $a0, Lrunt1
j $ra

# 
# int *allocRecord(int size)
# {int i;
#  int *p, *a;
#  p = a = (int *)malloc(size);
#  for(i=0;i<size;i+=sizeof(int)) *p++ = 0;
#  return a;
# }

allocRecord:
li $v0,9
syscall
move $a2,$v0
b Lrunt4
Lrunt3:
sw $0,($a2)
sub $a0,$a0,4
add $a2,$a2,4
Lrunt4:
bgtz $a0, Lrunt3
j $ra

# struct string {int length; unsigned char chars[1];};
# 
# int stringEqual(struct string *s, struct string *t)
# {int i;
#  if (s==t) return 1;
#  if (s->length!=t->length) return 0;
#  for(i=0;i<s->length;i++) if (s->chars[i]!=t->chars[i]) return 0;
#  return 1;
# }

stringEqual:
beq $a0,$a1,Lrunt10
lw  $a2,($a0)
lw  $a3,($a1)
addiu $a0,$a0,4
addiu $a1,$a1,4
beq $a2,$a3,Lrunt11
Lrunt13:
li  $v0,0
j $ra
Lrunt12:
lbu  $t0,($a0)
lbu  $t1,($a1)
bne  $t0,$t1,Lrunt13
addiu $a0,$a0,1
addiu $a1,$a1,1
addiu $a2,$a2,-1
Lrunt11:
bgez $a2,Lrunt12
Lrunt10:
li $v0,1
j $ra

# 
# void print(struct string *s)
# {int i; unsigned char *p=s->chars;
#  for(i=0;i<s->length;i++,p++) putchar(*p);
# }

print:
lw $a1,0($a0)
add $a0,$a0,4
add $a2,$a0,$a1
lb $a3,($a2)
sb $0,($a2)
li $v0,4
syscall
sb $a3,($a2)
j $ra

# void flush()
# {
#  fflush(stdout);
# }

flush:
j $ra

# int main()
# {int i;
#  for(i=0;i<256;i++)
#    {consts[i].length=1;
#     consts[i].chars[0]=i;
#    }
#  return t_main(0 /* static link */);
# }

.data
Runtconsts: 
.space 2048
Runtempty: .word 0

.text

main: 
li $a0,0
la $a1,Runtconsts
li $a2,1
Lrunt20:
sw $a2,($a1)
sb $a0,4($a1)
addiu $a1,$a1,8
slt $a3,$a0,256
bnez $a3,Lrunt20
li $a0,0
j t_main

# int ord(struct string *s)
# {
#  if (s->length==0) return -1;
#  else return s->chars[0];
# }

ord:
lw $a1,($a0)
li $v0,-1
beqz $a1,Lrunt5
lbu $v0,4($a0)
Lrunt5:
j $ra



# struct string empty={0,""};

# struct string *chr(int i)
# {
#  if (i<0 || i>=256) 
#    {printf("chr(%d) out of range\n",i); exit(1);}
#  return consts+i;
# }

.data
Lrunt30: .asciiz "character out of range\n"
.text

chr:
andi $a1,$a0,255
bnez $a1,Lrunt31
sll  $a0,$a0,3
la   $v0,Runtconsts($a0)
j $ra
Lrunt31:
li   $v0,4
la   $a0,Lrunt30
syscall
li   $v0,10
syscall

# int size(struct string *s)
# { 
#  return s->length;
# }
size:
lw $v0,($a0)
j $ra

# struct string *substring(struct string *s, int first, int n)
# {
#  if (first<0 || first+n>s->length)
#    {printf("substring([%d],%d,%d) out of range\n",s->length,first,n);
#     exit(1);}
#  if (n==1) return consts+s->chars[first];
#  {struct string *t = (struct string *)malloc(sizeof(int)+n);
#   int i;
#   t->length=n;
#   for(i=0;i<n;i++) t->chars[i]=s->chars[first+i];
#   return t;
#  }
# }
# 
.data
Lrunt40:  .asciiz "substring out of bounds\n"

substring:
lw $t1,($a0)
bltz $a1,Lrunt41
add $t2,$a1,$a2
sgt $t3,$t2,$t1
bnez $t3,Lrunt41
add $t1,$a0,$a1
bne $a2,1,Lrunt42
lbu $a0,($t1)
b chr
Lrunt42:
bnez $a2,Lrunt43
la  $v0,Lruntempty
j $ra
Lrunt43:
addi $a0,$a2,4
li   $v0,9
syscall
move $t2,$v0
Lrunt44:
lbu  $t3,($t1)
sb   $t3,($t2)
addiu $t1,1
addiu $t2,1
addiu $a2,-1
bgtz $a2,Lrunt44
j $ra
Lrunt41:
li   $v0,4
la   $a0,Lrunt40
syscall
li   $v0,10
syscall


# struct string *concat(struct string *a, struct string *b)
# {
#  if (a->length==0) return b;
#  else if (b->length==0) return a;
#  else {int i, n=a->length+b->length;
#        struct string *t = (struct string *)malloc(sizeof(int)+n);
#        t->length=n;
#        for (i=0;i<a->length;i++)
# 	 t->chars[i]=a->chars[i];
#        for(i=0;i<b->length;i++)
# 	 t->chars[i+a->length]=b->chars[i];
#        return t;
#      }
# }

concat:
lw $t0,($a0)
lw $t1,($a1)
beqz $t0,Lrunt50
beqz $t1,Lrunt51
addiu  $t2,$a0,4
addiu  $t3,$a1,4
add  $t4,$t0,$t1
addiu $a0,$t4,4
li $v0,9
syscall
addiu $t5,$v0,4
sw $t4,($v0)
Lrunt52:
lbu $a0,($t2)
sb  $a0,($t5)
addiu $t2,1
addiu $t5,1
addiu $t0,-1
bgtz $t0,Lrunt52
Lrunt53:
lbu $a0,($t4)
sb  $a0,($t5)
addiu $t4,1
addiu $t5,1
addiu $t2,-1
bgtz $t2,Lrunt52
j $ra
Lrunt50:
move $v0,$a1
j $ra
Lrunt51:
move $v0,$a0
j $ra

# int not(int i)
# { return !i;
# }
# 

_not:
seq $v0,$a0,0
j $ra


# #undef getchar
# 
# struct string *getchar()
# {int i=getc(stdin);
#  if (i==EOF) return &empty;
#  else return consts+i;
# }

.data
getchbuf: .space 200
getchptr: .word getchbuf

.text
getchar:
lw  $a0,getchptr
lbu $v0,($a0)
add $a0,$a0,1
bnez $v0,Lrunt6
li $v0,8
la $a0,getchbuf
li $a1,200
syscall
la $a0,getchbuf
lbu $v0,($a0)
bnez $v0,Lrunt6
li $v0,-1
Lrunt6:
sw $a0,getchptr
j $ra




