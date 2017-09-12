module ctrl (IRWre,PCWE,clk,rst,op,funct,beqout,ALUctr,DMWrite,npc_sel,RegWrt,ExtOp,RegDstSel,MemToRegSel,AluSrcSel);//ALUctr[1:0]
   input      	 clk,rst;
   input       	beqout;//made by alu
   input [5:0]  op,funct;
   
   //control signal out
   output [2:0] ALUctr;
   output       DMWrite;
   output [1:0] npc_sel;
   output       RegWrt;
   output [1:0] ExtOp;
   output 	PCWE;
   output IRWre;
	
   output [1:0] RegDstSel;
   output [1:0] MemToRegSel;
   output AluSrcSel;
   
   reg 	PCWE,RegWrt,DMWrite,AluSrcSel,IRWre;
   reg [1:0] RegDstSel,MemToRegSel,ExtOp,npc_sel;
   reg [2:0] ALUctr,state, next_state;
   
   wire Rtype,add,addiu,lw,sw,j,beq,OR;//Rtype,addu,subu,ori,lw,sw,beq,lui,addi,addiu,slt,j,jal,jr,lb,lbu,lh,lhu,sb,sh,slti;   //former
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
   assign OR 	= (Rtype&&funct==6'b100101)?1:0;	//why && ？ PLZ SEE LINE 20
  

   parameter [2:0] sif = 3'b000,   // IF state
	                sid = 3'b001,   // ID state
					exe1 = 3'b110,  // add、sub、addl、or、and、ori、move、slt、sll
					exe2 = 3'b101,  // beq
					exe3 = 3'b010,  // sw、lw
					smem = 3'b011,  // MEM state
					wb1 = 3'b111,   // add、sub、addl、or、and、ori、move、slt、sll
					wb2 = 3'b100;   // lw
  
	initial begin//信号量 初值
		state = sif;
		state_out = state;
	end
	
	always @(posedge clk) begin//每个时钟周期状态转换一次
	     if (Reset == 0) begin
		      state <= sif;
		  end else begin
		      state <= next_state;
		  end
		  state_out = state;
	 end
	 
	 always @(state or op) begin//状态转换
	case(state)
	    sif: next_state = sid;
		sid: begin
			if(j==1||jal==1||jr==1)next_state=sif;
			else if (lw==1||sw==1)next_state = exe3;
			else if (beq==1||bgez==1||bgtz==1)next_state=exe2;
			else next_state=exe1;
		end
		exe1: next_state = wb1;
		exe2: next_state = sif;
		exe3: next_state = smem;
		smem: begin
		    if (lw==1) next_state = wb2; // lw指令
             else next_state = sif; // sw指令
		end
		wb1: next_state = sif;
		wb2: next_state = sif;
		default: next_state = sif;
	endcase
	end
   
   always @(state)begin
	
	//IF确定PC写使能
	if (state == sif) PCWE = 1;
    else PCWE = 0;
   
	//IF确定IR写使能
	if (state == sif) IRWre = 1;
    else IRWre = 0;
   
    //WB确定DM写使能
	if(state == wb2) DMWrite = (sw)?'b1:'b0;
	else DMWrite =0;
	
	//WB确定REG写使能
	if(state == wb1 || state == wb2) RegWrt =(add||addiu||lw||lui||OR)?'b1:'b0;
	else RegWrt 0;
	
	//EXE确定运算使能
	if(state == exe1 || state == exe2 || state ==exe3 )ALUctr = (add||addiu||lw||sw)?3'b001:(beq)?3'b010:(OR)?3'b011:3'b000;
	else ALUctr=3'b000;
	
	npc_sel= (j)?2'b01:(beq&&beqout)?2'b11:2'b00;  //singular  valuebeq?11//COMPLETE
	ExtOp =(lui)?2'b00:(lw||sw)?2'b10:2'b10;//EXT//OR DONT USE EXTOP//COMPLETE
	RegDstSel =  (addiu||lui||lw)?2'b00:2'b01;//add-regdstSel//OR SAVE DATE AT RD//COMPLETE
	AluSrcSel  = (lw||sw||addiu)?'b1:'b0;//beq-ALUSRC//complete
	MemToRegSel = (lui)?2'b11:(add||addiu||OR)?2'b00:(lw)?2'b01:2'b10;//??????pc+4????JAL-MEMTOREG//complete
   
   end
            //(add||addiu||lw||sw)?3'b001:(beq)?3'b010:3'b000;
   // assign DMWrite = (sw)?'b1:'b0;//COMPLETE
   // assign npc_sel= (j)?2'b01:(beq&&beqout)?2'b11:2'b00;  //singular  valuebeq?11//COMPLETE
   // assign RegWrt =(add||addiu||lw||lui||OR)?'b1:'b0;//JAL???????????????//COMPLETE
   // assign ExtOp =(lui)?2'b00:(lw||sw)?2'b10:2'b10;//EXT//OR DONT USE EXTOP//COMPLETE
   // assign RegDstSel =  (addiu||lui||lw)?2'b00:2'b01;//add-regdstSel//OR SAVE DATE AT RD//COMPLETE
   // assign AluSrcSel  = (lw||sw||addiu)?'b1:'b0;//beq-ALUSRC//complete
   // assign MemToRegSel = (lui)?2'b11:(add||addiu||OR)?2'b00:(lw)?2'b01:2'b10;//??????pc+4????JAL-MEMTOREG//complete
   
   // assign ALUctr = (add||addiu||lw||sw)?3'b001:(beq)?3'b010:(OR)?3'b011:3'b000;//ALUCLASS//using sub to complete beq
   
endmodule  