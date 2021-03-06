module mips (clk,rst);
    input       clk;
    input       rst;
    
    wire        zero;
    wire       	BIG,SMAL;
    wire [1:0]  RegDst;
    wire [1:0]  ALUsrc;
    wire [1:0]  WDsel;
    wire        GPRwrite;
    wire      	 DMwrite;
    wire [1:0]  nPCop;
    wire [3:0]  ALUop;
    wire [1:0]  EXTop;
    wire [5:0]  op;
    wire [5:0]  funct;
    wire [31:0] extended_imm;
    wire [31:0] nPC;
    wire [31:0] PC_add_4;
    wire [4:0]  RS;
    wire [4:0]  RT;
    wire [4:0]  RD;
    wire [4:0]  SA;
    wire [15:0] imm_16;
    wire [25:0] imm_26;
    wire [31:0] Mout1;
    wire [4:0]  Mout2;
    wire [31:0] toPC;
    wire [31:0] ALUout;
    wire [31:0] RD1;
    wire [31:0] Mout3;
    wire [31:0] RD2;
    wire [31:0] Dout;
    wire [31:0] instr;
    wire [31:0] IRout;
    wire [31:0] PC;
    wire        PCwirte;
    wire [31:0] Aout,Bout;
    wire [31:0] DRout;
    wire [31:0] extout;
    wire [3:0]  din;
    wire [3:0]  dout;
    wire [31:0] saved_ALUout;
    
     
    assign op = IRout[31:26];
    assign RS = IRout[25:21];
    assign RT = IRout[20:16];
    assign RD = IRout[15:11];
    assign SA =  IRout[10:6];       //shamt
    assign funct = IRout[5:0];
    assign imm_16 = IRout[15:0];
    assign imm_26 = IRout[25:0];
    
    //module Mux_4_32 (addr,in1,in2,in3,in4,Mout);
    Mux_4_32 Mux_4_32bits(WDsel,saved_ALUout,DRout,PC_add_4,saved_ALUout,Mout1);   
    
    //module Mux_4_5 (addr,in1,in2,in3,in4,Mout);
    Mux_4_5 Mux_4_5bits(RegDst,RT,RD,5'b11111,RD,Mout2);
    
    //module Mux_4_32 (addr,in1,in2,in3,in4,Mout);             
    Mux_4_32 Mux_4_32bits2(ALUsrc,Bout,extended_imm,32'b0,Bout,Mout3);  
    
    //module Extender ( EXTop,imm,extended);                    
    Extender extender_16to32(EXTop,imm_16,extended_imm);    
        
    //module nPC (rs,imm_26,imm_16,PC,nPCop,nPC,PC_add_4);
    nPC U_nPC(toPC,imm_26,imm_16,PC,nPCop,nPC,PC_add_4);   
    
    //module PC (rst,clk,PCWrite,nPC,PC);
    PC U_PC (rst,clk,PCwrite,nPC,PC);
    
    //module im_4k (addr,dout) ;
    im_4k U_IM(PC[11:2],instr);
    
    //module enable_single_register (clk,din,dout,enable);
    enable_single_register U_IR(clk,instr,IRout,IRwrite);
    
    //module RegFile(A1,A2,A3,WD,RD1,RD2,toPC,clk,rst,enable);
    RegFile U_RF (RS,RT,Mout2,Mout1,RD1,RD2,toPC,clk,rst,GPRwrite);
    
    //module enable_single_register (clk,din,dout,enable);
    enable_single_register reg_A(clk,RD1,Aout,1'b1);
    enable_single_register reg_B(clk,RD2,Bout,1'b1);
    
    //module ALU(A,B,sa,C,ALUop,zero,big,smal);
    ALU U_ALU(Aout,Mout3,SA,ALUout,ALUop,zero,BIG,SMAL);
    enable_single_register U_ALUout(clk,ALUout,saved_ALUout,1'b1);
    
    //module dm_4k (addr,be,din,we,clk,dout );
    dm_4k U_DM(saved_ALUout[11:2],din,Bout,DMwrite,clk,Dout);
    
    //module Dout_extender (Dout,extop,extout);
    Dout_extender U_Dout_extender(Dout,dout,extout);
    
    //module enable_single_register (clk,din,dout,enable);
    enable_single_register U_DR(clk,extout,DRout,1'b1);
    
    //module ctrl (clk,rst,zero,big,smal,op,funct,rt,ALUout,PCwrite,IRwrite,WDsel,RegDst,EXTop,GPRwrite,ALUsrc,ALUop,nPCop,DMwrite,din,dout);
    ctrl U_CTRL(clk,rst,zero,BIG,SMAL,op,funct,RT,saved_ALUout[1:0],PCwrite,IRwrite,WDsel,RegDst,EXTop,GPRwrite,ALUsrc,ALUop,nPCop,DMwrite,din,dout);

endmodule