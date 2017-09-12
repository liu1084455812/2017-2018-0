module im_4k (addr,dout,IRWre) ;
    input [11:2]  addr ;        // address bus
    output [31:0] dout ;      // 32-bit memory output 
    
	reg [31:0] dout;
    reg   [31:0]  im[1023:0] ;
    
	always @(posedge clk) begin
	     if (IRWre) dout <= ins_out;
	 end
	
    
endmodule