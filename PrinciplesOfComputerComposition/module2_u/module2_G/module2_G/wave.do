onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /testbench/my_mips/U_IM/dout
add wave -noupdate /testbench/my_mips/U_PC/PC
add wave -noupdate /testbench/my_mips/U_CTRL/beqout
add wave -noupdate /testbench/my_mips/U_CTRL/bgezout
add wave -noupdate /testbench/my_mips/U_CTRL/ALUctr
add wave -noupdate /testbench/my_mips/U_CTRL/DMWrite
add wave -noupdate /testbench/my_mips/U_CTRL/npc_sel
add wave -noupdate /testbench/my_mips/U_CTRL/RegWrt
add wave -noupdate /testbench/my_mips/U_CTRL/ExtOp
add wave -noupdate /testbench/my_mips/U_CTRL/PCWE
add wave -noupdate /testbench/my_mips/U_CTRL/mux4_5sel
add wave -noupdate /testbench/my_mips/U_CTRL/mux4_32sel
add wave -noupdate /testbench/my_mips/U_CTRL/mux2sel
add wave -noupdate /testbench/my_mips/U_CTRL/state
add wave -noupdate /testbench/my_mips/U_CTRL/next_state
add wave -noupdate /testbench/my_mips/U_CTRL/state_out
add wave -noupdate /testbench/my_mips/U_ALU/A
add wave -noupdate /testbench/my_mips/U_ALU/B
add wave -noupdate /testbench/my_mips/U_ALU/Ctrl
add wave -noupdate /testbench/my_mips/U_ALU/C
add wave -noupdate /testbench/my_mips/U_ALU/Zero
add wave -noupdate /testbench/my_mips/U_ALU/beqout
add wave -noupdate /testbench/my_mips/U_ALU/bgezout
add wave -noupdate /testbench/my_mips/U_ALU/tmp_arith
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
quietly wave cursor active 0
configure wave -namecolwidth 231
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {643 ns}
