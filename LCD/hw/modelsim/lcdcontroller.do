onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /lcd_controller_tb/clk_tb
add wave -noupdate /lcd_controller_tb/rst_n_tb
add wave -noupdate /lcd_controller_tb/CS_n_tb
add wave -noupdate /lcd_controller_tb/DC_n_tb
add wave -noupdate /lcd_controller_tb/Wr_n_tb
add wave -noupdate /lcd_controller_tb/Rd_n_tb
add wave -noupdate /lcd_controller_tb/D_tb
add wave -noupdate /lcd_controller_tb/LS_DC_n_tb
add wave -noupdate /lcd_controller_tb/LS_Wr_n_tb
add wave -noupdate /lcd_controller_tb/LS_Rd_n_tb
add wave -noupdate /lcd_controller_tb/LS_WrData_tb
add wave -noupdate /lcd_controller_tb/LS_RdData_tb
add wave -noupdate /lcd_controller_tb/LS_Busy_tb
add wave -noupdate /lcd_controller_tb/ML_Busy_tb
add wave -noupdate /lcd_controller_tb/FIFO_Rd_tb
add wave -noupdate /lcd_controller_tb/FIFO_RdData_tb
add wave -noupdate /lcd_controller_tb/FIFO_Empty_tb
add wave -noupdate /lcd_controller_tb/phase_id
add wave -noupdate /lcd_controller_tb/done
add wave -noupdate /lcd_controller_tb/CLK_PER
add wave -noupdate /lcd_controller_tb/DELAY_TESTS
add wave -noupdate /lcd_controller_tb/DUV/clk
add wave -noupdate /lcd_controller_tb/DUV/rst_n
add wave -noupdate /lcd_controller_tb/DUV/CS_n
add wave -noupdate /lcd_controller_tb/DUV/DC_n
add wave -noupdate /lcd_controller_tb/DUV/Wr_n
add wave -noupdate /lcd_controller_tb/DUV/Rd_n
add wave -noupdate /lcd_controller_tb/DUV/D
add wave -noupdate /lcd_controller_tb/DUV/LCD_ON
add wave -noupdate /lcd_controller_tb/DUV/RESET_N
add wave -noupdate /lcd_controller_tb/DUV/LS_DC_n
add wave -noupdate /lcd_controller_tb/DUV/LS_Wr_n
add wave -noupdate /lcd_controller_tb/DUV/LS_WrData
add wave -noupdate /lcd_controller_tb/DUV/LS_RdData
add wave -noupdate /lcd_controller_tb/DUV/LS_Rd_n
add wave -noupdate /lcd_controller_tb/DUV/LS_Busy
add wave -noupdate /lcd_controller_tb/DUV/ML_Busy
add wave -noupdate /lcd_controller_tb/DUV/FIFO_Rd
add wave -noupdate /lcd_controller_tb/DUV/FIFO_RdData
add wave -noupdate /lcd_controller_tb/DUV/FIFO_Empty
add wave -noupdate /lcd_controller_tb/DUV/curr_word_reg
add wave -noupdate /lcd_controller_tb/DUV/curr_word_next
add wave -noupdate /lcd_controller_tb/DUV/state_reg
add wave -noupdate /lcd_controller_tb/DUV/state_next
add wave -noupdate /lcd_controller_tb/DUV/phase_reg
add wave -noupdate /lcd_controller_tb/DUV/phase_next
add wave -noupdate /lcd_controller_tb/DUV/dcn_reg
add wave -noupdate /lcd_controller_tb/DUV/dcn_next
add wave -noupdate /lcd_controller_tb/DUV/wrn_next
add wave -noupdate /lcd_controller_tb/DUV/wrn_reg
add wave -noupdate /lcd_controller_tb/DUV/rdn_next
add wave -noupdate /lcd_controller_tb/DUV/rdn_reg
add wave -noupdate /lcd_controller_tb/DUV/csn_next
add wave -noupdate /lcd_controller_tb/DUV/csn_reg
add wave -noupdate /lcd_controller_tb/DUV/fiford_reg
add wave -noupdate /lcd_controller_tb/DUV/fiford_next
add wave -noupdate /lcd_controller_tb/DUV/d_next
add wave -noupdate /lcd_controller_tb/DUV/d_reg
add wave -noupdate /lcd_controller_tb/DUV/lsrddata_reg
add wave -noupdate /lcd_controller_tb/DUV/lsrddata_next
add wave -noupdate /lcd_controller_tb/DUV/flipper
add wave -noupdate /lcd_controller_tb/DUV/NEW_FRAME_CMD
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {47 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 61
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
WaveRestoreZoom {0 ns} {578 ns}
