`timescale 1ns/1ns  
module testbench (input clk,input rst,input[4:0] RegAddr,input[1:0] ByteSel,output reg[7:0] Led);
    
    mips my_mips (clk,rst);
    
    initial begin  
       $readmemh("code.txt",my_mips.U_IM.im);//
           rst= 1 ;
           clk = 0 ;
           #30 rst=0;      
          // all executed at 19000ns
    end
       
    always
       #50 clk = ~clk ;
     
	always @ (posedge clk)
	begin
		if(RegAddr!=5'b00000)
		begin
		case(ByteSel)
			2'b00:Led = my_mips.U_IM.im[RegAddr][7:0];
			2'b01:Led = my_mips.U_IM.im[RegAddr][15:7];
			2'b10:Led = my_mips.U_IM.im[RegAddr][23:16];
			2'b11:Led = my_mips.U_IM.im[RegAddr][31:24];
		endcase
		end
	end
endmodule
           