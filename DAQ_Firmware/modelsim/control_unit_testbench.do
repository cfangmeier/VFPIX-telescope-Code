vlog *.v
vsim -L 220model_ver -voptargs=\"+acc\" work.control_unit_testbench
add wave -position insertpoint -label clk                            sim:/control_unit_testbench/sys_clk
# add wave -position insertpoint -label reset                          sim:/control_unit_testbench/reset
add wave -position insertpoint -label stage     -radix Unsigned      sim:/control_unit_testbench/control_unit_inst/cpu_stage
add wave -position insertpoint -label cycle_start                    sim:/control_unit_testbench/control_unit_inst/cycle_start
# add wave -position insertpoint -label ir        -radix Hexadecimal   sim:/control_unit_testbench/control_unit_inst/ir
add wave -position insertpoint -label pc        -radix Unsigned      sim:/control_unit_testbench/control_unit_inst/pc
add wave -position insertpoint -label addr      -radix Hexadecimal   sim:/control_unit_testbench/addr
add wave -position insertpoint -label busy                           sim:/control_unit_testbench/busy
add wave -position insertpoint -label data_i                         sim:/control_unit_testbench/data_i
add wave -position insertpoint -label data_o                         sim:/control_unit_testbench/data_o
# add wave -position insertpoint -label i         -radix Unsigned      sim:/control_unit_testbench/i
add wave -position insertpoint -label wr        -radix Hexadecimal   sim:/control_unit_testbench/control_unit_inst/wr
add wave -position insertpoint -label ra        -radix Hexadecimal   sim:/control_unit_testbench/control_unit_inst/ra
add wave -position insertpoint -label rb        -radix Hexadecimal   sim:/control_unit_testbench/control_unit_inst/rb
add wave -position insertpoint -label alu_out   -radix Hexadecimal   sim:/control_unit_testbench/control_unit_inst/alu_out
add wave -position insertpoint -label alu_op    -radix Hexadecimal   sim:/control_unit_testbench/control_unit_inst/alu_op
add wave -position insertpoint -label N                              sim:/control_unit_testbench/control_unit_inst/N
add wave -position insertpoint -label Z                              sim:/control_unit_testbench/control_unit_inst/Z
add wave -position insertpoint -label status_pass                    sim:/control_unit_testbench/control_unit_inst/status_pass
add wave -position insertpoint -label read_req                       sim:/control_unit_testbench/read_req
add wave -position insertpoint -label write_req                      sim:/control_unit_testbench/write_req
add wave -position insertpoint -label mem       -radix Hexadecimal   sim:/control_unit_testbench/mem

run 800 ns
wave zoomfull
