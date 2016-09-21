vlog *.v
vsim -L 220model_ver -voptargs=\"+acc\" work.control_unit_testbench
add wave -position insertpoint -label clk                            sim:/control_unit_testbench/sys_clk
add wave -position insertpoint -label reset                          sim:/control_unit_testbench/reset
add wave -position insertpoint -label stage     -radix Unsigned      sim:/control_unit_testbench/control_unit_inst/cpu_stage
add wave -position insertpoint -label ir        -radix Hexadecimal   sim:/control_unit_testbench/control_unit_inst/ir
add wave -position insertpoint -label pc        -radix Unsigned      sim:/control_unit_testbench/control_unit_inst/pc
add wave -position insertpoint -label stage_next                     sim:/control_unit_testbench/control_unit_inst/cpu_stage_next
add wave -position insertpoint -label addr      -radix Hexadecimal   sim:/control_unit_testbench/addr
add wave -position insertpoint -label busy                           sim:/control_unit_testbench/busy
add wave -position insertpoint -label data_i                         sim:/control_unit_testbench/data_i
add wave -position insertpoint -label data_o                         sim:/control_unit_testbench/data_o
add wave -position insertpoint -label i         -radix Unsigned      sim:/control_unit_testbench/i
# add wave -position insertpoint -label mem     -radix Hexadecimal   sim:/control_unit_testbench/mem
add wave -position insertpoint -label wr        -radix Hexadecimal   sim:/control_unit_testbench/control_unit_inst/wr
add wave -position insertpoint -label ra        -radix Hexadecimal   sim:/control_unit_testbench/control_unit_inst/ra
add wave -position insertpoint -label rb        -radix Hexadecimal   sim:/control_unit_testbench/control_unit_inst/rb
add wave -position insertpoint -label read_req                       sim:/control_unit_testbench/read_req
add wave -position insertpoint -label write_req                      sim:/control_unit_testbench/write_req
add wave -position insertpoint -label mem       -radix Hexadecimal   sim:/control_unit_testbench/mem

run 800 ns
wave zoomfull
