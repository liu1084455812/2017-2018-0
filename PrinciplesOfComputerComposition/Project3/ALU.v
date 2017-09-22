module ALU(A,B,sa,C,ALUop,zero,big,smal);
    input signed [31:0]  A,B;          
    input unsigned [4:0] sa;
    output signed[31:0]  C;
    input [3:0]          ALUop;
    output               zero;
    output               big,smal;
    
    integer i;
    reg [31:0] B_sra,B_srav;        
    
    assign zero = ( A == B ) ;     
    assign big  = ( A > B ) ;
    assign smal = ( A < B ) ;
    
    wire unsigned [4:0]v_sa;
    assign v_sa = A[4:0];
    
    always@(*)
      begin 
        B_sra = B;
        for(i=0;i<sa;i=i+1)
          B_sra = {B_sra[31],B_sra[31:1]};
      end
    always@(*)
      begin 
        B_srav = B;
        for(i=0;i<v_sa;i=i+1)
          B_srav = {B_srav[31],B_srav[31:1]};
      end
    assign C = (ALUop == 'b0000) ? (A - B):
               (ALUop == 'b0001) ? (A | B):
               (ALUop == 'b0010) ? (A + B):
               (ALUop == 'b1001) ? (A  &  B):
               (ALUop == 'b1010) ? (A  ^  B):
               (ALUop == 'b1100&&(A<B)) ? 32'b1:8'h12345678;           	 	   //Singular value 
endmodule