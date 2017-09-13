//Mux_4_32 U_mux4_32(mux4_32sel,ALUout,DMout,PC_add_4,extout,mux4_32out);
module Mux_4_32 (muxSel,in1,in2,in3,in4,Mout);//where the muxSel from?
    input [2:0]    muxSel;
    input [31:0]   in1,in2,in3,in4;
    output [31:0]  Mout;
    reg [31:0]     Mout;
    always@(muxSel or in1 or in2 or in3 or in4) 
    begin
        case(muxSel)
            3'b000: Mout <= in1;
            3'b001: Mout <= in2;
            3'b010: Mout <= in3;
            3'b011: Mout <= in4;
            3'b100: Mout <= in3;
        endcase
    end
endmodule

//Mux_4_5 U_mux4_5(mux4_5sel,RT,RD,mux4_5out);
module Mux_4_5 (muxSel,in1,in2,Mout);
    input [1:0]     muxSel;
    input [4:0]     in1,in2;
    output [4:0]    Mout;
    reg [4:0]       Mout;
    always@(muxSel or in1 or in2   ) 
    begin
        case(muxSel)
            2'b00: Mout <= in1;//rt
            2'b01: Mout <= in2;//rd
            2'b10: Mout <= 'h1f;
            2'b11: Mout <= 31;
        endcase
    end
endmodule

//Mux_2 U_mux2(mux2sel,RS2out,extout,mux2out);  
module Mux_2 (muxSel,in1,in2,Mout);    //it's deserted
    input  muxSel;
    input [31:0] in1,in2;
    output [31:0] Mout;
    reg [31:0] Mout;
    always@(muxSel or in1 or in2 ) 
    begin
        case(muxSel)
            1'b0: Mout <= in1;//????1?0???
            1'b1: Mout <= in2;
        endcase
    end
endmodule