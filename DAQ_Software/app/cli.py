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
        try:
            serial = DAQBoard.enumerate_devices()[0]
        except IndexError:
            print('No Devices Connected')
            return
        daq_board = DAQBoard(FIRMWARE_PATH, serial)
        with daq_board:
            daq_board.program()
            while True:
                data = daq_board.read_data(words=1024, verbose=False)
                for i in range(64):
                    print(' | '.join('{:08X}'.format(data[i*16+j])
                                     for j in range(16)))
                if raw_input():
                    break
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

            #         memory_busy = (datum >> 159) & 0x1
            #         busy_ram = (datum >> 160) & 0x1
            #         busy_spi = (datum >> 161) & 0x1
            #         busy_rj45 = (datum >> 162) & 0x1
            #         busy_aux = (datum >> 163) & 0x1
            #         enable_ram = (datum >> 164) & 0x1
            #         enable_spi = (datum >> 165) & 0x1
            #         enable_rj45 = (datum >> 166) & 0x1
            #         enable_aux = (datum >> 167) & 0x1
            #         memory_program_ack = (datum >> 168) & 0x1
            #         init_finished = (datum >> 169) & 0x1


            #         memory_program = (datum >> 171) & 0x1
            #         memory_write_req = (datum >> 172) & 0x01
            #         memory_read_req = (datum >> 173) & 0x01
            #         busy_int = (datum >> 174) & 0x01

            #         # r15 = (datum >> 192) & 0xFFFFFFFF
            #         # ry = (datum >> 224) & 0xFFFFFFFF
            #         # rz = (datum >> 256) & 0xFFFFFFFF
            #         # alu_inA = (datum >> 288) & 0xFFFFFFFF
            #         # alu_inB = (datum >> 320) & 0xFFFFFFFF
            #         # wr_write = (datum >> 158) & 0x1
            #         if cpu_state == 5:
            #             fmt = ('{: 3d}, {: 3d}, {}, {}, '
            #                    '{:08X}, {:06X} || '
            #                    '{}, {}, {}, {}, '
            #                    '{}, {}, {}, {}, '
            #                    '{}, {}, {}, {}, '
            #                    '{}')
            #             args = (state, cpu_state, init_finished, memory_busy,
            #                     ir, pc,
            #                     enable_ram, enable_spi, enable_rj45, enable_aux,
            #                     busy_ram, busy_spi, busy_rj45, busy_aux,
            #                     memory_program, memory_write_req, memory_read_req, busy_int,
            #                     memory_program_ack)
            #             print(fmt.format(*args))
            #     print('='*80, cnt)
            #     cnt += 1
            #     raw_input()
            #     # if cnt == 8:
            #     #     break
