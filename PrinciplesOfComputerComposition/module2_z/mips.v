module mips (clk,rst);
    input       clk;
    input       rst;
   //output [31:0] instrout;
    wire        zero;
    wire beqout;
    wire [2:0]  ALUctr;
    wire [1:0]  ExtOp;
   // wire [31:0] nPC;
    wire [31:0] PC_add_4;
    wire [4:0]  RS;
    wire [4:0]  RT;
    wire [4:0]  RD;
    wire [4:0]  SA;
    wire [15:0] imm_16;
    wire [25:0] imm_26;
   // wire [31:0] PC;
    wire [31:0] ALUout;
	wire [31:0] ALULateOut;
    wire [31:0] RS1out;
    wire [31:0]RS1Lateout;
   // wire [31:0] RS2out;
    wire [31:0] instr;
    wire [31:0] PCout;
    wire [31:0] PCin;
    wire [31:0] DMout;
    wire [31:0] extout;
     wire [31:0] RS2out;
     wire [1:0] npc_sel;
     wire RegWrt;
     wire DMWrite;
     wire [5:0] op,funct;
      
      wire [4:0] RegDstout;
      wire [31:0] MemToRegout;
      wire [31:0] MemToRegLateout;
      wire [31:0] AluSrcout;
      wire [31:0] DB2Lateout;
      
      wire [1:0] MemToRegsel,RegDstSel;
      wire AluSrcsel;
     
    assign instrout = instr;  
    assign op = instr[31:26];
    assign RS = instr[25:21];
    assign RT = instr[20:16];
    assign RD = instr[15:11];
    assign SA =  instr[10:6];       //shamt
    assign funct = instr[5:0];
    assign imm_16 = instr[15:0];
    assign imm_26 = instr[25:0];
    
    //module im_4k (addr,dout) ;
    im_4k U_IM(PCout[11:2],instr);
    
    //module dm_4k (addr,din,we,clk,dout );
    dm_4k U_DM( ALULateOut[11:2],RS2out,DMWrite,clk,DMout);
    
    //module nPC (imm_16,imm_26,PC,nPCop,nPC,PC_add_4);
    
    nPC U_nPC(imm_16,imm_26,PCout,npc_sel,PCin,PC_add_4); 
    
    
    //module PC (rst,clk,nPC,PC);
    PC U_PC (rst,clk,PCin,PCout);
    
    //module RegFile( CLK_I, RS1_I, RS2_I, RD_I, RegWr_I,WData_I,RS1_O, RS2_O);
    RegFile U_RF (clk,RS,RT,RegDstout,RegWrt,MemToRegLateout,RS1out,RS2out);
    
    //module Alu( A, B, Ctrl, C, Zero,beqout );
    ALu U_ALU(RS1Lateout,DB2Lateout,ALUctr,ALUout,zero,beqout);
    
    //module Extender ( EXTop,imm16,extout);
    sign_Ext U_signExt(ExtOp,imm_16,extout);

     MemToReg U_MemToReg(MemToRegsel,ALULateOut,DMout,PC_add_4,extout,MemToRegout);
    
     RegDst U_RegDst(RegDstSel,RT,RD,RegDstout);
    
     AluSrc U_AluSrc(AluSrcsel,RS2out,extout,AluSrcout);  
    
    
    //module ctrl (clk,rst,op,funct,beqout,ALUctr,DMWrite,npc_sel,RegWrt,ExtOp,RegDstSel,MemToRegsel,AluSrcsel);
    ctrl U_CTRL(clk,rst,op,funct,beqout,ALUctr,DMWrite,npc_sel,RegWrt,ExtOp,RegDstSel,MemToRegsel,AluSrcsel);
    
    //多周期部分：
    DataLate U_ALULateOut(ALUout, clk, ALULateOut);
    DataLate U_ADR(RS1out, clk, RS1Lateout);
    DataLate U_BDR(AluSrcout, clk, DB2Lateout);
    DataLate U_ALUM2DR(MemToRegout, clk, MemToRegLateout);
       

endmodule