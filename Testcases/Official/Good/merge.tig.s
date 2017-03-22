.globl main

.text
t_main: 
subu $sp, $sp, 56
L79: 
sw $fp, 36($sp)
add $t5, $sp, 52
move $fp, $t5
sw $ra, -20($fp)
sw $s0, -52($fp)
sw $s1, -48($fp)
sw $s2, -44($fp)
sw $s3, -40($fp)
sw $s4, -36($fp)
sw $s5, -32($fp)
sw $s6, -28($fp)
sw $s7, -24($fp)
sw $a0, 0($fp)
add $s2, $fp, -4
move $s6, $s2
jal getchar
move $s2, $v0
sw $s2, ($s6)
add $s2, $fp, -8
move $s6, $s2
move $a0, $fp
jal readlist
move $s2, $v0
sw $s2, ($s6)
add $s2, $fp, -12
move $s3, $s2
add $s2, $fp, -4
move $s6, $s2
jal getchar
move $s2, $v0
sw $s2, ($s6)
move $a0, $fp
jal readlist
sw $v0, ($s3)
move $s3, $fp
move $a0, $fp
lw $s2, -8($fp)
move $a1, $s2
lw $s6, -12($fp)
move $a2, $s6
jal merge
move $s2, $v0
move $a0, $s3
move $a1, $s2
jal printlist
lw $s2, -24($fp)
move $s7, $s2
lw $s2, -28($fp)
move $s6, $s2
lw $s2, -32($fp)
move $s5, $s2
lw $s2, -36($fp)
move $s4, $s2
lw $s2, -40($fp)
move $s3, $s2
lw $s2, -44($fp)
move $s2, $s2
lw $t5, -48($fp)
move $s1, $t5
lw $t5, -52($fp)
move $s0, $t5
lw $t5, -20($fp)
move $ra, $t5
lw $t5, 36($sp)
move $fp, $t5
j L78
L78: 

addu $sp, $sp, 56
jr $ra

.text
printlist:
subu $sp, $sp, 48
L81: 
sw $fp, 36($sp)
add $t8, $sp, 44
move $fp, $t8
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
lw $t8, -4($fp)
li $s1, 0
beq $t8, $s1, L76
L77: 
lw $t8, 0($fp)
move $a0, $t8
lw $s1, -4($fp)
lw $s1, 4($s1)
move $a1, $s1
jal printint
la $s1, L74
move $a0, $s1
jal print
lw $t8, 0($fp)
move $a0, $t8
lw $s1, -4($fp)
lw $s1, 8($s1)
move $a1, $s1
jal printlist
L75: 
lw $s1, -16($fp)
move $s7, $s1
lw $s1, -20($fp)
move $s6, $s1
lw $s1, -24($fp)
move $s5, $s1
lw $s1, -28($fp)
move $s4, $s1
lw $s1, -32($fp)
move $s3, $s1
lw $s1, -36($fp)
move $s2, $s1
lw $s1, -40($fp)
move $s1, $s1
lw $t8, -44($fp)
move $s0, $t8
lw $t8, -12($fp)
move $ra, $t8
lw $t8, 36($sp)
move $fp, $t8
j L80
L76: 
la $s1, L72
move $a0, $s1
jal print
j L75
L80: 

addu $sp, $sp, 48
jr $ra

.data
L74: 
.word 1
.asciiz " "
.data
L73: 
.word 1
.asciiz " "
.data
L72: 
.word 1
.asciiz "
"
.data
L71: 
.word 1
.asciiz "
"
.text
printint:
subu $sp, $sp, 48
L83: 
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
lw $s5, -4($fp)
li $s3, 0
blt $s5, $s3, L66
L67: 
lw $s5, -4($fp)
li $s3, 0
bgt $s5, $s3, L69
L70: 
la $s5, L64
move $a0, $s5
jal print
L68: 
L65: 
lw $s5, -16($fp)
move $s7, $s5
lw $s5, -20($fp)
move $s6, $s5
lw $s5, -24($fp)
move $s5, $s5
lw $s3, -28($fp)
move $s4, $s3
lw $s3, -32($fp)
move $s3, $s3
lw $t4, -36($fp)
move $s2, $t4
lw $t4, -40($fp)
move $s1, $t4
lw $t4, -44($fp)
move $s0, $t4
lw $t4, -12($fp)
move $ra, $t4
lw $t4, 36($sp)
move $fp, $t4
j L82
L66: 
la $s5, L62
move $a0, $s5
jal print
move $a0, $fp
lw $s3, -4($fp)
li $s5, 0
sub $s5, $s5, $s3
move $a1, $s5
jal f
j L65
L69: 
move $a0, $fp
lw $s5, -4($fp)
move $a1, $s5
jal f
j L68
L82: 

addu $sp, $sp, 48
jr $ra

.data
L64: 
.word 1
.asciiz "0"
.data
L63: 
.word 1
.asciiz "0"
.data
L62: 
.word 1
.asciiz "-"
.data
L61: 
.word 1
.asciiz "-"
.text
f:
subu $sp, $sp, 48
L85: 
sw $fp, 36($sp)
add $t3, $sp, 44
move $fp, $t3
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
lw $t3, -4($fp)
li $t0, 0
bgt $t3, $t0, L59
L60: 
L58: 
lw $t3, -16($fp)
move $s7, $t3
lw $t3, -20($fp)
move $s6, $t3
lw $t3, -24($fp)
move $s5, $t3
lw $t3, -28($fp)
move $s4, $t3
lw $t3, -32($fp)
move $s3, $t3
lw $t3, -36($fp)
move $s2, $t3
lw $t3, -40($fp)
move $s1, $t3
lw $t3, -44($fp)
move $s0, $t3
lw $t3, -12($fp)
move $ra, $t3
lw $t3, 36($sp)
move $fp, $t3
j L84
L59: 
lw $t0, 0($fp)
move $a0, $t0
lw $t3, -4($fp)
div $t3, $t3, 10
move $a1, $t3
jal f
lw $t0, -4($fp)
lw $t3, -4($fp)
div $t3, $t3, 10
mul $t3, $t3, 10
sub $t3, $t0, $t3
move $s7, $t3
la $t3, L57
move $a0, $t3
jal ord
move $t3, $v0
add $t3, $s7, $t3
move $a0, $t3
jal chr
move $t3, $v0
move $a0, $t3
jal print
j L58
L84: 

addu $sp, $sp, 48
jr $ra

.data
L57: 
.word 1
.asciiz "0"
.data
L56: 
.word 1
.asciiz "0"
.data
L55: 
.word 1
.asciiz "0"
.data
L54: 
.word 1
.asciiz "0"
.data
L53: 
.word 1
.asciiz "0"
.data
L52: 
.word 1
.asciiz "0"
.data
L51: 
.word 1
.asciiz "0"
.data
L50: 
.word 1
.asciiz "0"
.data
L49: 
.word 1
.asciiz "0"
.data
L48: 
.word 1
.asciiz "0"
.data
L47: 
.word 1
.asciiz "0"
.data
L46: 
.word 1
.asciiz "0"
.data
L45: 
.word 1
.asciiz "0"
.data
L44: 
.word 1
.asciiz "0"
.data
L43: 
.word 1
.asciiz "0"
.data
L42: 
.word 1
.asciiz "0"
.text
merge:
subu $sp, $sp, 52
L87: 
sw $fp, 36($sp)
add $t9, $sp, 48
move $fp, $t9
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
lw $t9, -4($fp)
li $s7, 0
beq $t9, $s7, L34
L35: 
lw $s7, -8($fp)
li $t9, 0
beq $s7, $t9, L37
L38: 
lw $s7, -4($fp)
lw $t9, 4($s7)
lw $s7, -8($fp)
lw $s7, 4($s7)
blt $t9, $s7, L40
L41: 
li $a0, 8
jal allocRecord
move $s2, $v0
lw $s7, -8($fp)
lw $s7, 4($s7)
sw $s7, 0($s2)
add $s7, $s2, 4
move $s1, $s7
lw $t6, 0($fp)
move $a0, $t6
lw $t9, -4($fp)
move $a1, $t9
lw $s7, -8($fp)
lw $s7, 8($s7)
move $a2, $s7
jal merge
move $s7, $v0
sw $s7, ($s1)
move $s7, $s2
L39: 
move $s7, $s7
L36: 
move $s7, $s7
L33: 
move $v0, $s7
lw $s7, -20($fp)
move $s7, $s7
lw $t9, -24($fp)
move $s6, $t9
lw $t9, -28($fp)
move $s5, $t9
lw $t9, -32($fp)
move $s4, $t9
lw $t9, -36($fp)
move $s3, $t9
lw $t9, -40($fp)
move $s2, $t9
lw $t9, -44($fp)
move $s1, $t9
lw $t9, -48($fp)
move $s0, $t9
lw $t9, -16($fp)
move $ra, $t9
lw $t9, 36($sp)
move $fp, $t9
j L86
L34: 
lw $s7, -8($fp)
move $s7, $s7
j L33
L37: 
lw $s7, -4($fp)
move $s7, $s7
j L36
L40: 
li $a0, 8
jal allocRecord
move $s2, $v0
lw $s7, -4($fp)
lw $s7, 4($s7)
sw $s7, 0($s2)
add $s7, $s2, 4
move $s1, $s7
lw $t6, 0($fp)
move $a0, $t6
lw $s7, -4($fp)
lw $s7, 8($s7)
move $a1, $s7
lw $t9, -8($fp)
move $a2, $t9
jal merge
move $s7, $v0
sw $s7, ($s1)
move $s7, $s2
j L39
L86: 

addu $sp, $sp, 52
jr $ra

.text
readlist:
subu $sp, $sp, 52
L89: 
sw $fp, 36($sp)
add $t4, $sp, 48
move $fp, $t4
sw $ra, -16($fp)
sw $s0, -48($fp)
sw $s1, -44($fp)
sw $s2, -40($fp)
sw $s3, -36($fp)
sw $s4, -32($fp)
sw $s5, -28($fp)
sw $s6, -24($fp)
sw $s7, -20($fp)
sw $a0, 0($fp)
add $t4, $fp, -4
move $s1, $t4
li $a0, 4
jal allocRecord
move $t4, $v0
li $t2, 0
sw $t2, 0($t4)
sw $t4, ($s1)
add $t4, $fp, -8
move $s1, $t4
lw $t2, 0($fp)
move $a0, $t2
lw $t4, -4($fp)
move $a1, $t4
jal readint
move $t4, $v0
sw $t4, ($s1)
lw $t4, -4($fp)
lw $t4, 4($t4)
li $t2, 0
bne $t4, $t2, L31
L32: 
li $t4, 0
L30: 
move $v0, $t4
lw $t4, -20($fp)
move $s7, $t4
lw $t4, -24($fp)
move $s6, $t4
lw $t4, -28($fp)
move $s5, $t4
lw $t4, -32($fp)
move $s4, $t4
lw $t4, -36($fp)
move $s3, $t4
lw $t4, -40($fp)
move $s2, $t4
lw $t4, -44($fp)
move $s1, $t4
lw $t4, -48($fp)
move $s0, $t4
lw $t4, -16($fp)
move $ra, $t4
lw $t4, 36($sp)
move $fp, $t4
j L88
L31: 
li $a0, 8
jal allocRecord
move $s1, $v0
lw $t4, -8($fp)
sw $t4, 0($s1)
add $t4, $s1, 4
move $s0, $t4
lw $t4, 0($fp)
move $a0, $t4
jal readlist
move $t4, $v0
sw $t4, ($s0)
move $t4, $s1
j L30
L88: 

addu $sp, $sp, 52
jr $ra

.text
readint:
subu $sp, $sp, 52
L91: 
sw $fp, 36($sp)
add $t5, $sp, 48
move $fp, $t5
sw $ra, -16($fp)
sw $s0, -48($fp)
sw $s1, -44($fp)
sw $s2, -40($fp)
sw $s3, -36($fp)
sw $s4, -32($fp)
sw $s5, -28($fp)
sw $s6, -24($fp)
sw $s7, -20($fp)
sw $a1, -4($fp)
sw $a0, 0($fp)
li $s3, 0
sw $s3, -8($fp)
move $a0, $fp
jal skipto
lw $s3, -4($fp)
add $s3, $s3, 4
move $s7, $s3
move $a0, $fp
lw $s3, 0($fp)
lw $s3, -4($s3)
move $a1, $s3
jal isdigit
move $s3, $v0
sw $s3, ($s7)
L28: 
move $a0, $fp
lw $s3, 0($fp)
lw $s3, -4($s3)
move $a1, $s3
jal isdigit
move $s3, $v0
li $t5, 0
bne $s3, $t5, L29
L23: 
lw $s3, -8($fp)
move $v0, $s3
lw $s3, -20($fp)
move $s7, $s3
lw $s3, -24($fp)
move $s6, $s3
lw $s3, -28($fp)
move $s5, $s3
lw $s3, -32($fp)
move $s4, $s3
lw $s3, -36($fp)
move $s3, $s3
lw $t5, -40($fp)
move $s2, $t5
lw $t5, -44($fp)
move $s1, $t5
lw $t5, -48($fp)
move $s0, $t5
lw $t5, -16($fp)
move $ra, $t5
lw $t5, 36($sp)
move $fp, $t5
j L90
L29: 
add $s3, $fp, -8
move $s7, $s3
lw $s3, -8($fp)
mul $s3, $s3, 10
move $s0, $s3
lw $s3, 0($fp)
lw $s3, -4($s3)
move $a0, $s3
jal ord
move $s3, $v0
add $s3, $s0, $s3
move $s0, $s3
la $s3, L27
move $a0, $s3
jal ord
move $s3, $v0
sub $s3, $s0, $s3
sw $s3, ($s7)
lw $s3, 0($fp)
add $s3, $s3, -4
move $s7, $s3
jal getchar
move $s3, $v0
sw $s3, ($s7)
j L28
L90: 

addu $sp, $sp, 52
jr $ra

.data
L27: 
.word 1
.asciiz "0"
.data
L26: 
.word 1
.asciiz "0"
.data
L25: 
.word 1
.asciiz "0"
.data
L24: 
.word 1
.asciiz "0"
.text
skipto:
subu $sp, $sp, 44
L93: 
sw $fp, 36($sp)
add $t7, $sp, 40
move $fp, $t7
sw $ra, -8($fp)
sw $s0, -40($fp)
sw $s1, -36($fp)
sw $s2, -32($fp)
sw $s3, -28($fp)
sw $s4, -24($fp)
sw $s5, -20($fp)
sw $s6, -16($fp)
sw $s7, -12($fp)
sw $a0, 0($fp)
L16: 
lw $s4, 0($fp)
lw $s4, 0($s4)
lw $s4, -4($s4)
move $a0, $s4
la $s0, L13
move $a1, $s0
jal stringEqual
move $s4, $v0
li $s0, 1
beq $s4, $s0, L19
L20: 
li $s0, 1
lw $s4, 0($fp)
lw $s4, 0($s4)
lw $s6, -4($s4)
move $a0, $s6
la $s4, L14
move $a1, $s4
jal stringEqual
move $s4, $v0
li $s6, 1
beq $s4, $s6, L21
L22: 
li $s0, 0
L21: 
move $s4, $s0
L18: 
li $s0, 0
bne $s4, $s0, L17
L15: 
lw $s4, -12($fp)
move $s7, $s4
lw $s4, -16($fp)
move $s6, $s4
lw $s4, -20($fp)
move $s5, $s4
lw $s4, -24($fp)
move $s4, $s4
lw $s0, -28($fp)
move $s3, $s0
lw $s0, -32($fp)
move $s2, $s0
lw $s0, -36($fp)
move $s1, $s0
lw $s0, -40($fp)
move $s0, $s0
lw $t7, -8($fp)
move $ra, $t7
lw $t7, 36($sp)
move $fp, $t7
j L92
L19: 
li $s4, 1
j L18
L17: 
lw $s4, 0($fp)
lw $s4, 0($s4)
add $s4, $s4, -4
move $s0, $s4
jal getchar
move $s4, $v0
sw $s4, ($s0)
j L16
L92: 

addu $sp, $sp, 44
jr $ra

.data
L14: 
.word 1
.asciiz "
"
.data
L13: 
.word 1
.asciiz " "
.text
isdigit:
subu $sp, $sp, 48
L95: 
sw $fp, 36($sp)
add $t3, $sp, 44
move $fp, $t3
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
lw $t3, 0($fp)
lw $t3, 0($t3)
lw $t3, -4($t3)
move $a0, $t3
jal ord
move $t3, $v0
move $s6, $t3
la $t3, L3
move $a0, $t3
jal ord
move $t3, $v0
bge $s6, $t3, L9
L10: 
li $t3, 0
L8: 
move $v0, $t3
lw $t3, -16($fp)
move $s7, $t3
lw $t3, -20($fp)
move $s6, $t3
lw $t3, -24($fp)
move $s5, $t3
lw $t3, -28($fp)
move $s4, $t3
lw $t3, -32($fp)
move $s3, $t3
lw $t3, -36($fp)
move $s2, $t3
lw $t3, -40($fp)
move $s1, $t3
lw $t3, -44($fp)
move $s0, $t3
lw $t3, -12($fp)
move $ra, $t3
lw $t3, 36($sp)
move $fp, $t3
j L94
L9: 
li $s6, 1
lw $t3, 0($fp)
lw $t3, 0($t3)
lw $t3, -4($t3)
move $a0, $t3
jal ord
move $t3, $v0
move $s2, $t3
la $t3, L7
move $a0, $t3
jal ord
move $t3, $v0
ble $s2, $t3, L11
L12: 
li $s6, 0
L11: 
move $t3, $s6
j L8
L94: 

addu $sp, $sp, 48
jr $ra

.data
L7: 
.word 1
.asciiz "9"
.data
L6: 
.word 1
.asciiz "9"
.data
L5: 
.word 1
.asciiz "9"
.data
L4: 
.word 1
.asciiz "9"
.data
L3: 
.word 1
.asciiz "0"
.data
L2: 
.word 1
.asciiz "0"
.data
L1: 
.word 1
.asciiz "0"
.data
L0: 
.word 1
.asciiz "0"# int *initArray(int size, int init)
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




