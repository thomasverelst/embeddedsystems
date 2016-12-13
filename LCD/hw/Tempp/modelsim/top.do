onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /lcd_top_tb/DUV/SLAV/clk
add wave -noupdate /lcd_top_tb/DUV/SLAV/rst_n
add wave -noupdate /lcd_top_tb/DUV/SLAV/AS_Address
add wave -noupdate /lcd_top_tb/DUV/SLAV/AS_ChipSelect
add wave -noupdate /lcd_top_tb/DUV/SLAV/AS_Wr
add wave -noupdate /lcd_top_tb/DUV/SLAV/AS_WrData
add wave -noupdate /lcd_top_tb/DUV/SLAV/AS_Rd
add wave -noupdate /lcd_top_tb/DUV/SLAV/AS_RdData
add wave -noupdate /lcd_top_tb/DUV/SLAV/AS_IRQ
add wave -noupdate /lcd_top_tb/DUV/SLAV/AS_WaitRequest
add wave -noupdate /lcd_top_tb/DUV/SLAV/LS_Busy
add wave -noupdate /lcd_top_tb/DUV/SLAV/LS_DC_n
add wave -noupdate /lcd_top_tb/DUV/SLAV/LS_Wr_n
add wave -noupdate /lcd_top_tb/DUV/SLAV/LS_Rd_n
add wave -noupdate /lcd_top_tb/DUV/SLAV/LS_WrData
add wave -noupdate /lcd_top_tb/DUV/SLAV/LS_RdData
add wave -noupdate /lcd_top_tb/DUV/SLAV/MS_Address
add wave -noupdate /lcd_top_tb/DUV/SLAV/MS_Length
add wave -noupdate /lcd_top_tb/DUV/SLAV/MS_StartDMA
add wave -noupdate /lcd_top_tb/DUV/SLAV/state_reg
add wave -noupdate /lcd_top_tb/DUV/SLAV/state_next
add wave -noupdate /lcd_top_tb/DUV/SLAV/addr_reg
add wave -noupdate /lcd_top_tb/DUV/SLAV/addr_next
add wave -noupdate /lcd_top_tb/DUV/SLAV/len_reg
add wave -noupdate /lcd_top_tb/DUV/SLAV/len_next
add wave -noupdate /lcd_top_tb/DUV/MAST/clk
add wave -noupdate /lcd_top_tb/DUV/MAST/rst_n
add wave -noupdate /lcd_top_tb/DUV/MAST/AM_Address
add wave -noupdate /lcd_top_tb/DUV/MAST/AM_ByteEnable
add wave -noupdate /lcd_top_tb/DUV/MAST/AM_Rd
add wave -noupdate /lcd_top_tb/DUV/MAST/AM_RdDataValid
add wave -noupdate /lcd_top_tb/DUV/MAST/AM_Burstcount
add wave -noupdate /lcd_top_tb/DUV/MAST/AM_RdData
add wave -noupdate /lcd_top_tb/DUV/MAST/AM_WaitRequest
add wave -noupdate /lcd_top_tb/DUV/MAST/MS_Address
add wave -noupdate /lcd_top_tb/DUV/MAST/MS_Length
add wave -noupdate /lcd_top_tb/DUV/MAST/MS_StartDMA
add wave -noupdate /lcd_top_tb/DUV/MAST/ML_Busy
add wave -noupdate /lcd_top_tb/DUV/MAST/FIFO_Full
add wave -noupdate /lcd_top_tb/DUV/MAST/FIFO_Wr
add wave -noupdate /lcd_top_tb/DUV/MAST/FIFO_WrData
add wave -noupdate /lcd_top_tb/DUV/MAST/FIFO_Almost_Full
add wave -noupdate /lcd_top_tb/DUV/MAST/state_reg
add wave -noupdate /lcd_top_tb/DUV/MAST/state_next
add wave -noupdate /lcd_top_tb/DUV/MAST/addr_reg
add wave -noupdate /lcd_top_tb/DUV/MAST/addr_next
add wave -noupdate /lcd_top_tb/DUV/MAST/len_reg
add wave -noupdate /lcd_top_tb/DUV/MAST/len_next
add wave -noupdate /lcd_top_tb/DUV/MAST/burst_counter_reg
add wave -noupdate /lcd_top_tb/DUV/MAST/burst_counter_next
add wave -noupdate /lcd_top_tb/DUV/MAST/word_counter_reg
add wave -noupdate /lcd_top_tb/DUV/MAST/word_counter_next
add wave -noupdate /lcd_top_tb/DUV/MAST/BURST_LENGTH
add wave -noupdate /lcd_top_tb/DUV/MAST/BURST_COUNT
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {37 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
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
WaveRestoreZoom {0 ns} {1008 ns}