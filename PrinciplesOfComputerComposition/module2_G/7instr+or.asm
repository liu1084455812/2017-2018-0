#MIPS-C2: addiu，add，ori，lw，sw，beq，lui
#or rd,rs,rt，执行完后$16= 0xFFF,否则0xf0f
    
    

    # test or
    addiu   $18, $0, 0xF     # $18 = 0xF     
    addiu   $17, $0, 0x0F00     # $17 = 0xF00     
    or      $16, $18, $17           # $16 = 0x0000F0F    
    addiu   $17, $0,0xFFF      # $17 = 0xFFF     
    
    beq   $16,$17,L_End
    or   $16,0xF0                    #16= 0xFFF     

L_End :
    j L_End     
