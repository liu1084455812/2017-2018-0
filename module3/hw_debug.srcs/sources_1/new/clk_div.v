`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/09/05 14:22:31
// Design Name: 
// Module Name: clk_div
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


module clk_div(
    input clk, //100MHz
    output clk_pulse //1Hz
    );
    
    reg clk_pulse = 0;
    reg [25:0] div_counter = 0;
    
    always @(posedge clk) begin
        if(div_counter>=50000000) begin
            clk_pulse<=1;
            div_counter<=0;
        end else begin
            clk_pulse<=0;
            div_counter <= div_counter + 1;
        end
    end
endmodule
