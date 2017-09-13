module Dout_extender (Dout,extop,extout);
    input [31:0]   Dout;
    input [3:0]    extop;
    output [31:0]  extout;
    
    assign extout = (extop==4'b0001)?Dout:                        //lw
                    (extop==4'b0010)?{{24{Dout[7]}},Dout[7:0]}:     //lb 0
                    (extop==4'b0011)?{{24{Dout[15]}},Dout[15:8]}:    //lb 1
                    (extop==4'b0100)?{{24{Dout[23]}},Dout[23:16]}:  //lb 2
                    (extop==4'b0101)?{{24{Dout[31]}},Dout[31:24]}:  //lb 3
                    (extop==4'b0110)?{{16{Dout[15]}},Dout[15:0]}:   //lh 1,0
                    (extop==4'b0111)?{{16{Dout[31]}},Dout[31:16]}:  //lh 3,2
                    (extop==4'b1000)?{24'b0,Dout[7:0]}:           //lbu 0
                    (extop==4'b1001)?{24'b0,Dout[15:8]}:          //lbu 1
                    (extop==4'b1010)?{24'b0,Dout[23:16]}:         //lbu 2
                    (extop==4'b1011)?{24'b0,Dout[31:24]}:         //lbu 3
                    (extop==4'b1100)?{16'b0,Dout[15:0]}:          //lhu 1,0
                    (extop==4'b1101)?{16'b0,Dout[31:16]}:         //lhu 3,2
                    32'b0;
endmodule