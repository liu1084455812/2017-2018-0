//MemToReg U_MemToReg(MemToRegsel,ALUout,DMout,PC_add_4,extout,MemToRegout);//判断写入寄存器的数据是aluout还是dmout
module MemToReg (MemToRegsel,ALUout,DMout,PC_add_4,extout,MemToRegout);//where the muxSel from?
    input [1:0]    MemToRegsel;
    input [31:0]   ALUout,DMout,PC_add_4,extout;
    output [31:0]  MemToRegout;
    reg [31:0]     MemToRegout;
    always@(MemToRegsel or ALUout or DMout or PC_add_4 or extout ) 
    begin
        case(MemToRegsel)
            2'b00: MemToRegout <= ALUout;
            2'b01: MemToRegout <= DMout;
            2'b10: MemToRegout <= PC_add_4;
            2'b11: MemToRegout <= extout;
        endcase
    end
endmodule

//RegDst U_RegDst(RegDstsel,RT,RD,RegDstout);//判断写入的寄存器是rt还是rd
module RegDst (RegDstsel,RT,RD,RegDstout);
    input [1:0]     RegDstsel;
    input [4:0]     RT,RD;
    output [4:0]    RegDstout;
    reg [4:0]       RegDstout;
    always@(RegDstsel or RT or RD   ) 
    begin
        case(RegDstsel)
            2'b00: RegDstout <= RT;//rt
            2'b01: RegDstout <= RD;//rd
            2'b10: RegDstout <= 'h1f;
        endcase
    end
endmodule

//AluSrc U_AluSrc(AluSrcsel,RS2out,extout,AluSrcout);  //判断data2是imm还是rbout
module AluSrc (AluSrcsel,RS2out,extout,AluSrcout);    //it's deserted
    input  AluSrcsel;
    input [31:0] RS2out,extout;
    output [31:0] AluSrcout;
    reg [31:0] AluSrcout;
    always@(AluSrcsel or RS2out or extout ) 
    begin
        case(AluSrcsel)
            1'b0: AluSrcout <= RS2out;//????1?0???
            1'b1: AluSrcout <= extout;
        endcase
    end
endmodule