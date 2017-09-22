module enable_single_register (clk,din,dout,enable);
    input         clk;
    input [31:0]  din;
    input         enable;
    output [31:0] dout;
    
    reg [31:0]    register;
    
    assign dout = register;
    
    always @( posedge clk)
       if(enable)
          register <= din;
endmodule