module Mux_4_32 (addr,in1,in2,in3,in4,Mout);
    input [1:0]    addr;
    input [31:0]   in1,in2,in3,in4;
    output [31:0]  Mout;
    reg [31:0]     Mout;
    always@(addr or in1 or in2 or in3 or in4 ) 
    begin
        case(addr)
            2'b00: Mout <= in1;
            2'b01: Mout <= in2;
            2'b10: Mout <= in3;
            2'b11: Mout <= in4;
        endcase
    end
endmodule

module Mux_4_5 (addr,in1,in2,in3,in4,Mout);
    input [1:0]     addr;
    input [4:0]     in1,in2,in3,in4;
    output [4:0]    Mout;
    reg [4:0]       Mout;
    always@(addr or in1 or in2 or in3 or in4 ) 
    begin
        case(addr)
            2'b00: Mout <= in1;
            2'b01: Mout <= in2;
            2'b10: Mout <= in3;
            2'b11: Mout <= in4;
        endcase
    end
endmodule

module Mux_2 (addr,in1,in2,Mout);    //it's deserted
    input  addr;
    input [31:0] in1,in2;
    output [31:0] Mout;
    reg [31:0] Mout;
    always@(addr or in1 or in2 ) 
    begin
        case(addr)
            1'b0: Mout <= in1;
            1'b1: Mout <= in2;
        endcase
    end
endmodule