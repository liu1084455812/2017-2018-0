`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/09/05 14:22:31
// Design Name: 
// Module Name: flow_led
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module flow_led(
    input clk, 
    input clk_pulse, //100MHz
    output reg[15:0] led_r
    );
    
    reg[15:0] led_r = 16'h00f;
    
    always @(posedge clk)begin
        if(clk_pulse==1)    
            led_r<={led_r[11:0],led_r[15:12]};
        else
            led_r<=led_r;
        end     
endmodule
