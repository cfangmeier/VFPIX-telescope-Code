vlog *.v ../flash_interface.v ../fifo8_256.v
vsim -L 220model_ver -L altera_mf_ver -voptargs=\"+acc\" work.flash_interface_testbench
# add wave -position insertpoint -label clk                            sim:/flash_interface_testbench/clk
# add wave -position insertpoint -label reset                          sim:/flash_interface_testbench/reset
add wave -position insertpoint -label instruction                      sim:/flash_interface_testbench/instruction
add wave -position insertpoint -label execute                          sim:/flash_interface_testbench/execute
add wave -position insertpoint -label busy                             sim:/flash_interface_testbench/busy
add wave -position insertpoint -label rd_buf_q                         sim:/flash_interface_testbench/read_buffer_q
add wave -position insertpoint -label rd_buf_empty                     sim:/flash_interface_testbench/read_buffer_empty

add wave -position insertpoint -label flash_sout                       sim:/flash_interface_testbench/sout
add wave -position insertpoint -label flash_sin                        sim:/flash_interface_testbench/sin
add wave -position insertpoint -label flash_c                          sim:/flash_interface_testbench/flash_c
add wave -position insertpoint -label flash_sb                         sim:/flash_interface_testbench/flash_sb

add wave -position insertpoint -label instr_shifter -radix Hexadecimal sim:/flash_interface_testbench/instruction_shifter
add wave -position insertpoint -label data_shifter  -radix Hexadecimal sim:/flash_interface_testbench/data_shifter
add wave -position insertpoint -label word_complete                    sim:/flash_interface_testbench/word_complete

run 4000 ns
wave zoomfull
