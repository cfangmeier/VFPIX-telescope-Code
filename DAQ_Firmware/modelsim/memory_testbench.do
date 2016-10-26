
set files {}
lappend files "memory_testbench.v"
lappend files "../memory.v"
lappend files "../testbench/ram_controller_mem_model.v"
lappend files "../flash_interface.v"
lappend files "../fifo8_256.v"

lappend files "../ram_controller.v"
lappend files "../ram_controller_controller_phy.v"
lappend files "../ram_controller_alt_mem_ddrx_controller_top.v"
lappend files "../alt_mem_ddrx_mm_st_converter.v"
lappend files "../alt_mem_ddrx_controller_st_top.v"
lappend files "../alt_mem_ddrx_controller.v"
lappend files "../alt_mem_ddrx_input_if.v"
lappend files "../alt_mem_ddrx_cmd_gen.v"
lappend files "../alt_mem_ddrx_tbp.v"
lappend files "../alt_mem_ddrx_arbiter.v"
lappend files "../alt_mem_ddrx_burst_gen.v"
lappend files "../alt_mem_ddrx_addr_cmd.v"
lappend files "../alt_mem_ddrx_addr_cmd_wrap.v"
lappend files "../alt_mem_ddrx_rdwr_data_tmg.v"
lappend files "../alt_mem_ddrx_wdata_path.v"
lappend files "../alt_mem_ddrx_rdata_path.v"
lappend files "../alt_mem_ddrx_sideband.v"
lappend files "../alt_mem_ddrx_rank_timer.v"
lappend files "../alt_mem_ddrx_timing_param.v"
lappend files "../alt_mem_ddrx_list.v"
lappend files "../alt_mem_ddrx_burst_tracking.v"
lappend files "../alt_mem_ddrx_dataid_manager.v"
lappend files "../alt_mem_ddrx_fifo.v"
lappend files "../alt_mem_ddrx_ecc_encoder_decoder_wrapper.v"
lappend files "../alt_mem_ddrx_ecc_encoder.v"
lappend files "../alt_mem_ddrx_ecc_encoder_32_syn.v"
lappend files "../alt_mem_ddrx_ecc_decoder.v"
lappend files "../alt_mem_ddrx_ecc_decoder_32_syn.v"
lappend files "../alt_mem_ddrx_odt_gen.v"
lappend files "../alt_mem_ddrx_ddr2_odt_gen.v"
lappend files "../alt_mem_ddrx_ddr3_odt_gen.v"
lappend files "../alt_mem_ddrx_buffer.v"

lappend files "../ram_controller_phy.v"
lappend files "../ram_controller_phy_alt_mem_phy.v"
lappend files "../ram_controller_phy_alt_mem_phy_pll.v"
lappend files "../ram_controller_phy_alt_mem_phy_seq_wrapper.vo"

# First remove all files from project
foreach elem [project filenames] {
  project removefile $elem
}
# Then re-add files specified above
foreach elem $files {
  project addfile $elem
}
# Then compile all files in project
project compileall
# Finally, start the simulation
vsim -L 220model_ver -L altera_mf_ver -L sgate_ver -L cycloneive_ver -L altera_ver -voptargs=\"+acc\" work.memory_testbench



add wave -position insertpoint -label clk                                  sim:/memory_testbench/clk
# add wave -position insertpoint -label clk_cnt           -radix Decimal     sim:/memory_testbench/clk_cnt
# add wave -position insertpoint -label reset                                sim:/memory_testbench/reset
# add wave -position insertpoint -label mem_dq            -radix Hexadecimal sim:/memory_testbench/mem_dq
# add wave -position insertpoint -label mem_addr          -radix Hexadecimal sim:/memory_testbench/mem_addr


add wave -position insertpoint -label mem_state         -radix Decimal     sim:/memory_testbench/memory_inst/state

add wave -position insertpoint -label local_address                        sim:/memory_testbench/memory_inst/local_address
add wave -position insertpoint -label local_write_req                      sim:/memory_testbench/memory_inst/local_write_req
# add wave -position insertpoint -label local_read_req                       sim:/memory_testbench/memory_inst/local_read_req
# add wave -position insertpoint -label local_burstbegin                     sim:/memory_testbench/memory_inst/local_burstbegin
add wave -position insertpoint -label local_wdata                          sim:/memory_testbench/memory_inst/local_wdata
add wave -position insertpoint -label local_ready                          sim:/memory_testbench/memory_inst/local_ready
# add wave -position insertpoint -label local_rdata                          sim:/memory_testbench/memory_inst/local_rdata
# add wave -position insertpoint -label local_rdata_valid                    sim:/memory_testbench/memory_inst/local_rdata_valid
# add wave -position insertpoint -label local_init_done                      sim:/memory_testbench/memory_inst/local_init_done

# add wave -position insertpoint -label memory_write_req                     sim:/memory_testbench/memory_write_req
# add wave -position insertpoint -label memory_data_write -radix Hexadecimal sim:/memory_testbench/memory_data_write

# add wave -position insertpoint -label memory_read_req                      sim:/memory_testbench/memory_read_req
# add wave -position insertpoint -label memory_data_read  -radix Hexadecimal sim:/memory_testbench/memory_data_read
# add wave -position insertpoint -label memory_busy                          sim:/memory_testbench/memory_busy

add wave -position insertpoint -label flash_sout                           sim:/memory_testbench/sout
add wave -position insertpoint -label flash_sin                            sim:/memory_testbench/sin
add wave -position insertpoint -label flash_c                              sim:/memory_testbench/flash_c
add wave -position insertpoint -label flash_sb                             sim:/memory_testbench/flash_sb

add wave -position insertpoint -label flash_state                        sim:/memory_testbench/memory_inst/flash_interface_inst/state
add wave -position insertpoint -label flash_bit_counter                  sim:/memory_testbench/memory_inst/flash_interface_inst/bit_counter
add wave -position insertpoint -label flash_busy                           sim:/memory_testbench/memory_inst/flash_interface_inst/busy
# add wave -position insertpoint -label flash_input_shifter                sim:/memory_testbench/memory_inst/flash_interface_inst/input_shifter
add wave -position insertpoint -label flash_buffer_data -radix Hexadecimal sim:/memory_testbench/memory_inst/flash_interface_inst/read_buffer_data
add wave -position insertpoint -label flash_buffer_q    -radix Hexadecimal sim:/memory_testbench/memory_inst/flash_interface_inst/read_buffer_q
add wave -position insertpoint -label flash_buffer_wr                      sim:/memory_testbench/memory_inst/flash_interface_inst/read_buffer_write
add wave -position insertpoint -label flash_buffer_empty                   sim:/memory_testbench/memory_inst/flash_interface_inst/read_buffer_empty
add wave -position insertpoint -label flash_buffer_usedw -radix Unsigned   sim:/memory_testbench/memory_inst/flash_interface_inst/read_buffer_usedw

add wave -position insertpoint -label page_address   -radix Unsigned       sim:/memory_testbench/memory_inst/page_address
add wave -position insertpoint -label page_words     -radix Unsigned       sim:/memory_testbench/memory_inst/page_words
add wave -position insertpoint -label pages_written  -radix Unsigned       sim:/memory_testbench/memory_inst/pages_written
add wave -position insertpoint -label pages_to_write -radix Unsigned       sim:/memory_testbench/memory_inst/pages_to_write
add wave -position insertpoint -label pages_to_write_valid                 sim:/memory_testbench/memory_inst/pages_to_write_valid
add wave -position insertpoint -label pages_read     -radix Unsigned       sim:/memory_testbench/memory_inst/pages_read
add wave -position insertpoint -label pages_to_read  -radix Unsigned       sim:/memory_testbench/memory_inst/pages_to_read
add wave -position insertpoint -label pages_to_read_valid                   sim:/memory_testbench/memory_inst/pages_to_read_valid

add wave -position insertpoint -label instr_shifter -radix Hexadecimal    sim:/memory_testbench/instruction_shifter
add wave -position insertpoint -label address_shifter -radix Hexadecimal  sim:/memory_testbench/address_shifter
add wave -position insertpoint -label data_shifter  -radix Hexadecimal    sim:/memory_testbench/data_shifter
add wave -position insertpoint -label byte_complete                       sim:/memory_testbench/byte_complete
add wave -position insertpoint -label bytes_received                      sim:/memory_testbench/bytes_received

add wave -position insertpoint -label page_word -radix Hexadecimal        sim:/memory_testbench/memory_inst/page_word;

run 600 us
wave zoomfull
