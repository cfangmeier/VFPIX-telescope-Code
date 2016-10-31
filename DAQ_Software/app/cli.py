#!env/bin/python
from __future__ import print_function
from app.daq_board import DAQBoard
from app.config import FIRMWARE_PATH
import click
import sys
from itertools import chain


def execute_tests(suite_choice):
    from unittest.runner import TextTestRunner
    from tests.hw_tests import suite as hw_suite
    from tests.assembler_tests import suite as ass_suite
    runner = TextTestRunner(verbosity=2)
    suites = {'hw': hw_suite,
              'assembler': ass_suite}
    try:
        runner.run(suites[suite_choice]())
    except KeyError:
        print('Unknown test suite: \"{}\"'.format(suite_choice))


def post_process_flash_data(blocks):
    bits_sb = []
    bits_in = []
    bits_out = []

    clk_prev = 0
    for datum in chain(*blocks):
        flash_c = (datum >> 9) & 0x01
        flash_sb = (datum >> 8) & 0x01
        flash_dq0 = (datum >> 7) & 0x01
        flash_dq1 = (datum >> 6) & 0x01
        if flash_c and flash_c != clk_prev:
            bits_sb.append(flash_sb)
            bits_in.append(flash_dq1)
            bits_out.append(flash_dq0)
        clk_prev = flash_c
    print(''.join(str(b) for b in bits_sb[:100]))
    print(''.join(str(b) for b in bits_in[:100]))
    print(''.join(str(b) for b in bits_out[:100]))


@click.command()
@click.option('--run-tests', default=None,
              type=click.Choice(['hw', 'assembler']),
              help='Run test suite')
def stf(run_tests):
    if run_tests:
        execute_tests(run_tests)
    else:
        serial = DAQBoard.enumerate_devices()[0]
        daq_board = DAQBoard(FIRMWARE_PATH, serial)
        with daq_board:
            daq_board.program()
            i = 0
            while True:
                daq_board.read_data(words=4, verbose=True)
                # print('='*80)
                print(i)
                # print('='*80)
                i += 1
                # raw_input()
            # cnt = 0
            # while True:
            #     block = daq_board.read_debug_data()
            #     # post_process_flash_data(blocks)
            #     for datum in block:
            #         state = (datum >> 0) & 0x3F
            #         cpu_state = (datum >> 155) & 0x7
            #         pc = (datum >> 6) & 0xFFFFFF
            #         ir = (datum >> 32) & 0xFFFFFFFF
            #         memory_addr = (datum >> 64) & 0x3FFFFFF
            #         local_wdata = (datum >> 90) & 0xFFFFFFFF
            #         local_rdata = (datum >> 122) & 0xFFFFFFFF
            #         local_rdata_valid = (datum >> 154) & 0x1
            #         memory_busy = (datum >> 30) & 0x1
            #         enable_aux = (datum >> 31) & 0x1
            #         r1 = (datum >> 160) & 0xFFFFFFFF
            #         r2 = (datum >> 192) & 0xFFFFFFFF
            #         ry = (datum >> 224) & 0xFFFFFFFF
            #         rz = (datum >> 256) & 0xFFFFFFFF
            #         alu_inA = (datum >> 288) & 0xFFFFFFFF
            #         alu_inB = (datum >> 320) & 0xFFFFFFFF
            #         wr_write = (datum >> 158) & 0x1
            #         fmt = '{: 3d}, {}, {:03d}, {:08X}, {:06X}, {:07X}, {}, {:08X}, {}, {:08X}, {:08X}, {:08X}, {}, {:08X}, {:08X}'
            #         args = (state, memory_busy, cpu_state, ir, pc, memory_addr, enable_aux,
            #                 local_wdata, local_rdata_valid, local_rdata, r1, r2, wr_write, ry, rz)
            #         print(fmt.format(*args))
            #     print('='*80, cnt)
            #     cnt += 1
            #     raw_input()
            #     if cnt == 8:
            #         break
