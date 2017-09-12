module ctrl (clk,rst,op,funct,beqout,bgezout,ALUctr,DMWrite,npc_sel,RegWrt,ExtOp,mux4_5sel,mux4_32sel,mux2sel);//ALUctr[1:0]
   input      	 clk,rst;
   input        beqout;//made by alu
   input        bgezout;
   input [5:0]  op,funct;
   
   //control signal out
   output [4:0] ALUctr;
   output       DMWrite;
   output [2:0] npc_sel;
   output       RegWrt;
   output [1:0] ExtOp;
   
   output [1:0] mux4_5sel;
   output [2:0] mux4_32sel;
   output mux2sel;
   
   wire Rtype,add,sub,addiu,lw,sw,xor,j,beq,AND,jr,OR,bgez,ori,jal,bgtz,slt;//Rtype,addu,subu,ori,lw,sw,beq,lui,addi,addiu,slt,j,jal,jr,lb,lbu,lh,lhu,sb,sh,slti;   //former
   //wire add,sub,sll,srl,sra,sllv,srlv,srav,AND,OR,XOR,NOR,andi,xori,sltiu,bne,blez,bgtz,bltz,bgez,jalr;//added
   //???
   assign Rtype = (op==6'b000000)?1:0;//!
   assign add   = (Rtype&&funct==6'b100000)?1:0;   	//&& ???it's better to be included in "head.v"
   assign sub   = (Rtype&&funct==6'b100010)?1:0;
   assign lw    = (op==6'b100011)?1:0;
   assign sw    = (op==6'b101011)?1:0;
   assign beq   = (op==6'b000100)?1:0;
   assign lui   = (op==6'b001111)?1:0;
   assign addiu = (op==6'b001001)?1:0;
   assign j     = (op==6'b000010)?1:0;
   assign jal   = (op==6'b000011)?1:0;
   assign OR 	 = (Rtype&&funct==6'b100101)?1:0;	//why && ？ PLZ SEE LINE 20
   assign ori   = (op==6'b001101)?1:0;
   assign bgez  = (op==6'b000001)?1:0;
   assign bgtz  = (op==6'b000111)?1:0;
   assign AND   = (Rtype&&funct==6'b100100)?1:0;
   assign jr    = (Rtype&&funct==6'b001000)?1:0;
   assign slt   = (Rtype&&funct==6'b101010)?1:0;
   assign addi  = (op==6'b001000)?1:0;
   assign xor   = (Rtype&&funct==6'b100110)?1:0;
   
            //(add||addiu||lw||sw)?3'b001:(beq)?3'b010:3'b000;
   assign DMWrite = (sw)?'b1:'b0;//COMPLETE
   assign npc_sel= (j||jal)?3'b001:((beq&&beqout)||(bgez&&bgezout)||(bgtz&&bgezout&&!beqout))?3'b011:(jr)?3'b100:3'b000;  //singular  valuebeq?11//COMPLETE
   assign RegWrt =(add||sub||addiu||lw||lui||OR||ori||xor||AND||slt||addi||jal)?'b1:'b0;//JAL???????????????//COMPLETE
   assign ExtOp =(lui)?2'b00:(lw||sw)?2'b10:(ori)?2'b01:2'b10;//EXT//OR DONT USE EXTOP//COMPLETE
   assign mux4_5sel =  (addiu||addi||lui||lw||ori)?2'b00:(jal)?2'b11:2'b01;//add-regdst//OR SAVE DATE AT RD//COMPLETE
   assign mux2sel  = (lw||sw||addiu||addi||ori)?'b1:'b0;//beq-ALUSRC//complete
   assign mux4_32sel = (lui)?3'b011:(add||sub||addiu||addi||OR||ori||AND||xor||slt)?3'b000:(lw)?3'b001:(jal)?3'b100:3'b010;//??????pc+4????JAL-MEMTOREG//complete
   
   assign ALUctr = (add||addiu||addi||lw||sw)?5'b00001:(beq||sub)?5'b00010:(OR||ori)?5'b00011:(bgez||bgtz)?5'b00100:(AND)?5'b00101:(slt)?5'b00110:(xor)?5'b00111:5'b00000;//ALUCLASS//using sub to complete beq
   
endmodule  