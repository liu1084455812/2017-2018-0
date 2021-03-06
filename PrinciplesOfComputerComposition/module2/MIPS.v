//
//本实验的多周期CPU支持MIPS指令如下：
//基础运算类：add,addi,ori,sub,and,or
//内存交互类：lw,sw,
//跳转类：beq,j,jal,jr,
//
//待完成的指令：addiu,xor,bgtz,lui,slt,bgez
//
`include "datapath/ALU.v"
`include "datapath/DataLate.v"
`include "datapath/DataMemory.v"
`include "datapath/DataSelect_2.v"
`include "datapath/Extend.v"
`include "datapath/InsMemory.v"
`include "datapath/PC.v"
`include "datapath/NPC.v"
`include "datapath/RegFile.v"
`include "controller/controller.v"
`timescale 1ns / 1ps

module Top(	input clk, reset,
			output wire [2:0] state_out,
			output wire [5:0] opcode,
			output wire [4:0] rs, rt, rd,
			// output ins[31:26], ins[25:21], ins[20:16], ins[15:11],
			output wire [31:0] ins, ReadData1, ReadData2, pc0, result);
			  
	assign opcode = ins[31:26];
	assign rs = ins[25:21];
	assign rt = ins[20:16];
	assign rd = ins[15:11];

    // 数据通路
    wire [31:0] j_addr, out1, out2, result1, i_IR, extendData, LateOut1, LateOut2, DataOut;
    wire zero;
	 
    // 控制信号
    wire [2:0] ALUOp;
    wire [1:0] ExtSel, RegOut, PCSrc;
    wire PCWre, IRWre, InsMemRW, WrRegData, RegWre, ALUSrcB, DataMemRW, ALUM2Reg;

	PC pc(clk, reset, PCWre, PCSrc, extendData, j_addr, ReadData1, pc0);

	InsMemory insmemory(pc0, InsMemRW, IRWre, clk, ins);
	
	PCAddr pcaddr(ins[25:0], pc0, j_addr);
	 
	RegFile regfile(ins[25:21], ins[20:16], ins[15:11], clk, RegWre, WrRegData, RegOut, (pc0+4), LateOut2, ReadData1, ReadData2);

    DataLate ADR(ReadData1, clk, out1);
	DataLate BDR(ReadData2, clk, out2);
	
	Extend extend(ins[15:0], ExtSel, extendData);
	 
    ALU alu(out1, out2, extendData, ALUSrcB, ALUOp, zero, result);
	 
	DataLate ALUout(result, clk, result1);
	 
	DataMemory datamemory(result1, out2, DataMemRW, DataOut);
	 
	DataSelect_2 dataselect_2(result, DataOut, ALUM2Reg, LateOut1);
	
	DataLate ALUM2DR(LateOut1, clk, LateOut2);
	 
	controlUnit control(ins[31:26], zero, clk, reset,PCWre, InsMemRW, IRWre, WrRegData, RegWre, ALUSrcB, ALUM2Reg, DataMemRW, ExtSel, RegOut, PCSrc, ALUOp, state_out);
	

endmodule
