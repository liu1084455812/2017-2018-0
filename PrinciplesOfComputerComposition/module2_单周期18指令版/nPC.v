`include    "instruction_head.v"

module nPC (imm_16,imm_26,PC,nPCop,nPC,PC_add_4,RS1out);
    input [25:0]  imm_26 ;
    input [15:0]  imm_16 ;
    input [31:0]  PC;
    input  [2:0]  nPCop;          
    input [31:0] RS1out;
    output [31:0] nPC;                //output to IM
    output [31:0] PC_add_4;          //output to $31
                                     //zero and IFbeq are transmitted to Controller to effect nPCop
    
    assign PC_add_4 = PC+'h4;             // it's diffrent from single-cycle cpu
    
    assign nPC = (nPCop == 3'b000)?PC_add_4:
                 (nPCop == 3'b001)?{PC[31:28],imm_26,2'b00}://j
                 (nPCop == 3'b010)?(PC+{{14{imm_16[15]}},imm_16,2'b00}): //`DEBUG_DEV_DATA ;
                 (nPCop == 3'b011)?(PC_add_4+{{14{imm_16[15]}},imm_16,2'b00}):
                 (nPCop == 3'b100)?(RS1out):`DEBUG_DEV_DATA ; //beq,rs = pc //???//
endmodule
    