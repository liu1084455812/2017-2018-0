ADDI $t0,$zero,0x0000
ADDI $t5,$zero,0x0054
LW $t5,0($t5)
ADDIU $t2,$zero,0x0001
SW $t2,0($t0)
SW $t2,4($t0)
ORI $t6,$zero,0x0002
SUB $t1,$t5,$t6
ORI $t7,$zero,0x0001
SLT $t4,$t1,$t7
BEQ $t4,$t7,0x0007
LW $a0,0($t0)
LW $a1,4($t0)
JAL 0x0000C16
SW $v0,8($t0)
ADDI $t0,$t0,0x0004
ADDI $t1,$t1,0xFFFF
J 0x0000C09
LUI $t6,0xABCD
ADDI $t0,$t0,0x0008
SW $t6,0($t0)
J 0x0000C15
ADD $v0,$a0,$a1
JR $ra