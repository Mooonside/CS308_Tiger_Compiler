.globl main

.text
t_main: 
subu $sp, $sp, 48
L6: 
sw $fp, 36($sp)
add $fp, $sp, 44
move $fp, $fp
sw $ra, -12($fp)
sw $s0, -44($fp)
sw $s1, -40($fp)
sw $s2, -36($fp)
sw $s3, -32($fp)
sw $s4, -28($fp)
sw $s5, -24($fp)
sw $s6, -20($fp)
sw $s7, -16($fp)
sw $a0, 0($fp)
li $sp, 0
sw $sp, -4($fp)
move $a0, $fp
li $a1, 0
la $ra, L4
move $a2, $ra
jal do_nothing1
lw $v0, -16($fp)
move $s7, $v0
lw $zero, -20($fp)
move $s6, $zero
lw $a0, -24($fp)
move $s5, $a0
lw $a1, -28($fp)
move $s4, $a1
lw $a2, -32($fp)
move $s3, $a2
lw $a3, -36($fp)
move $s2, $a3
lw $t0, -40($fp)
move $s1, $t0
lw $t1, -44($fp)
move $s0, $t1
lw $t2, -12($fp)
move $ra, $t2
lw $t3, 36($sp)
move $fp, $t3
j L5
L5: 

addu $sp, $sp, 48
jr $ra

.data
L4: 
.word 4
.asciiz "str2"
.data
L3: 
.word 4
.asciiz "str2"
.text
do_nothing2:
subu $sp, $sp, 48
L8: 
sw $fp, 36($sp)
add $t4, $sp, 44
move $fp, $t4
sw $ra, -12($fp)
sw $s0, -44($fp)
sw $s1, -40($fp)
sw $s2, -36($fp)
sw $s3, -32($fp)
sw $s4, -28($fp)
sw $s5, -24($fp)
sw $s6, -20($fp)
sw $s7, -16($fp)
sw $a1, -4($fp)
sw $a0, 0($fp)
lw $t5, 0($fp)
move $a0, $t5
lw $t6, -4($fp)
move $a1, $t6
la $t7, L1
move $a2, $t7
jal do_nothing1
la $t8, L2
move $v0, $t8
lw $t9, -16($fp)
move $s7, $t9
lw $s0, -20($fp)
move $s6, $s0
lw $s1, -24($fp)
move $s5, $s1
lw $s2, -28($fp)
move $s4, $s2
lw $s3, -32($fp)
move $s3, $s3
lw $s4, -36($fp)
move $s2, $s4
lw $s5, -40($fp)
move $s1, $s5
lw $s6, -44($fp)
move $s0, $s6
lw $s7, -12($fp)
move $ra, $s7
lw $t3, 36($sp)
move $fp, $t3
j L7
L7: 

addu $sp, $sp, 48
jr $ra

.data
L2: 
.word 1
.asciiz " "
.data
L1: 
.word 3
.asciiz "str"
.data
L0: 
.word 3
.asciiz "str"
.text
do_nothing1:
subu $sp, $sp, 52
L10: 
sw $fp, 36($sp)
add $t8, $sp, 48
move $fp, $t8
sw $ra, -16($fp)
sw $s0, -48($fp)
sw $s1, -44($fp)
sw $s2, -40($fp)
sw $s3, -36($fp)
sw $s4, -32($fp)
sw $s5, -28($fp)
sw $s6, -24($fp)
sw $s7, -20($fp)
sw $a2, -8($fp)
sw $a1, -4($fp)
sw $a0, 0($fp)
lw $t8, 0($fp)
move $a0, $t8
lw $s5, -4($fp)
add $s5, $s5, 1
move $a1, $s5
jal do_nothing2
li $v0, 0
lw $s5, -20($fp)
move $s7, $s5
lw $s5, -24($fp)
move $s6, $s5
lw $s5, -28($fp)
move $s5, $s5
lw $t8, -32($fp)
move $s4, $t8
lw $t8, -36($fp)
move $s3, $t8
lw $t8, -40($fp)
move $s2, $t8
lw $t8, -44($fp)
move $s1, $t8
lw $t8, -48($fp)
move $s0, $t8
lw $t8, -16($fp)
move $ra, $t8
lw $t8, 36($sp)
move $fp, $t8
j L9
L9: 

addu $sp, $sp, 52
jr $ra
# int *initArray(int size, int init)
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




