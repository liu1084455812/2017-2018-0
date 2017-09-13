`timescale 1ns/1ns  // `timescale 仿真时间单位/�
module testbench ( );
    reg clk;
    reg rst;
   
   integer i;
    mips my_mips (clk,rst);
    
    initial begin  
       $readmemh("code.txt",my_mips.U_IM.im);
   
           rst= 1 ;
           clk = 0 ;
           i=0;
           #30 rst=0;      
           my_mips.U_DM.dm[21] = 20;
  end
   
    always
       #20 clk = ~clk ;


always @(my_mips.U_PC.PC)
begin
if(my_mips.U_DM.dm[20]==32'habcd0000)
	begin
        i=0;
	while(i<20)
	begin
   	$display("dm[%d]= %d",i,my_mips.U_DM.dm[i]);
	i=i+1;
	end
        $display("Simulation is successfull!");
  	$stop;
end

end
       
endmodule
           