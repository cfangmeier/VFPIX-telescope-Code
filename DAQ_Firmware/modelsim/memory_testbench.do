
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



add wave -position insertpoint -label clk                            sim:/memory_testbench/clk
add wave -position insertpoint -label reset                          sim:/memory_testbench/reset
add wave -position insertpoint -label mem_dq   -radix Hexadecimal    sim:/memory_testbench/mem_dq


add wave -position insertpoint -label local_address                  sim:/memory_testbench/memory_inst/local_address
add wave -position insertpoint -label local_write_req                sim:/memory_testbench/memory_inst/local_write_req
add wave -position insertpoint -label local_read_req                 sim:/memory_testbench/memory_inst/local_read_req
add wave -position insertpoint -label local_burstbegin               sim:/memory_testbench/memory_inst/local_burstbegin
add wave -position insertpoint -label local_wdata                    sim:/memory_testbench/memory_inst/local_wdata
add wave -position insertpoint -label local_ready                    sim:/memory_testbench/memory_inst/local_ready
add wave -position insertpoint -label local_rdata                    sim:/memory_testbench/memory_inst/local_rdata
add wave -position insertpoint -label local_rdata_valid              sim:/memory_testbench/memory_inst/local_rdata_valid
add wave -position insertpoint -label local_init_done                sim:/memory_testbench/memory_inst/local_init_done


run 100000 ns
wave zoomfull
