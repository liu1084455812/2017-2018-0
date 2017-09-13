module Extender ( EXTop,imm,extended);
    input [15:0]  imm;
    input [1:0]   EXTop;
    output [31:0] extended;
    
    assign extended = (EXTop == 'b00) ? { imm,16'b0}:
                      (EXTop == 'b01) ? { 16'b0,imm}:
                      (EXTop == 'b10) ? { {16{imm[15]}},imm}:
                      32'b0001001000110100;//singular value,some option can be defined of EXTop == 'b11
endmodule