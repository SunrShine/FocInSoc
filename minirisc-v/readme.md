# 基本整数子集，以及相关指令介绍

通用寄存器 ：x0 ~ x31；

基本指令格式：
    寄存器所处同样位置的指令： R2:[24:20] ; R1[19:15] ; Rd[11:7]


## 整数计算指令

### 整数寄存器-立即数指令
    I立即数[11:0] src ADDI/SLTI[U] dest OP-IMM

ADDI / SLTI[U] / ANDI / ORI / XORI

SLTI（set less than immediate） rd, r1, imm : rd = (r1 < imm)? 1: 0; 比较r1和立即数imm， 结果置入rd

SLLI / SRLI / SRAI ：将源寄存器移位置imm[5:0]，放入目的寄存器当中。用来进行移位操作。

    U立即数[31:12] dest LUI
LUI(load upper immediate) / AUIPC(add upper immediate to pc) : 


### 整数寄存器-寄存器指令

    funct7[31:25] src2 src1 funct3[14:12] dest OP
ADD /SUB :加法减法 溢出忽略。
SLT(set less than) / SLTU :比较 
* 示例：SLTU rd,x0,rs2 : 无符号数之间比较，又因为x0一直设置为1， 所以次指令实现 rd = (rs2!=0) ? 1 : 0
* SLT rd, r1,r2 :有符号数比较 rd = (r1 < r2) ? 1: 0

AND / OR / XOR : 按位逻辑操作
SLL / SRL / SRA  : 逻辑左移、逻辑右移、算术右移，

    0 0 ADDI 0 OP-IMM  用来实现NOP指令：ADDI x0,x0,0

## 转移控制指令

### 无条件跳转指令
    偏移量[20:1] dest JAL
JAL（跳转并连接）：将pc+imm（偏移量）后边的地址保存到rd当中，  rd = pc+imm+4

    偏移量[11:0] 基址 0 dest JALR
JALR（间接跳转指令）： JALR rd, r1, imm : rd = pc+imm+r1+4 ,注意地址对齐。

### 条件分支
    偏移量[12,10:5] src2 src1 BEQ/BNE 偏移量[11,4:1] BRANCH
BEQ / BNE : 比较r1和r2，相等或者不相等进行跳转。  
BLT[U] / BGE[U]  ： r1 < r2 跳转  /  r1 > r2 跳转

## Load，Store指令
RV32I是一个load-store体系结构，也就是说，只有load和store指令可以访问存储器，而
算术指令只在CPU寄存器上进行操作运算。

    偏移量[11:0] 基址 宽度 dest LOAD
    偏移量[11:5] src 基址 宽度 偏移量[4:0] STORE
LW / LH / LHU /

## 存储器模型
多线程， FENCE

## 控制和状态寄存器

### CSR指令
