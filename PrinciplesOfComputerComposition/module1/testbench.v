`timescale 1ns/1ns  // `timescale 仿真时间单位/�
module testbench ( );
    reg clk;
    reg rst;
   reg [31:0]  result;
   // integer i;
    mips my_mips (clk,rst);
    
    initial begin  
       $readmemh("code.txt",my_mips.U_IM.im);
   
           rst= 1 ;
           clk = 0 ;
           #30 rst=0;      
         result = my_mips.U_IM.im[1000];
         $monitor("Time %t,R16= %h",$time, my_mips.U_RF.gpr[16]);
    end
   
    always
       #20 clk = ~clk ;


always @ (negedge clk) 
#200
   if ( result == my_mips.U_RF.gpr[16] ) 
begin
$display("Simulation finished Successfully.");
#40 $stop;
end
else 
begin

end

       
endmodule
           