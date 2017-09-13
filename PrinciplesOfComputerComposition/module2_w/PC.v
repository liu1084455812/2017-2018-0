module PC (PCWE,rst,clk,nPC,PC);//(rst,clk,PCWrite,nPC,PC);
    input 		  PCWE;
    input         rst;
    input         clk;
    //input         PCWrite;
    input [31:0]  nPC;
    output [31:0] PC;
    
    reg [31:0]    PC;
    
    always@(posedge PCWE or posedge rst )begin
       if(rst)
          PC <= 'h00003000;
       else if (PCWE)
          PC <= nPC;
     end  
endmodule