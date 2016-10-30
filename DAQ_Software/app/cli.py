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
        # with daq_board:
        #     post_process_flash_data(daq_board.read_debug_data(blocks=40))
        with daq_board:
            # out_of_idle = False
            # daq_board.read_data(words=4, verbose=True)
            cnt = 0
            while True:
                block = daq_board.read_debug_data()
                # post_process_flash_data(blocks)
                for datum in block:
                    # flag = datum & 0xFFFFFFFF
                    # print(flag)
                    state = (datum >> 0) & 0x3F
                    ir = (datum >> 8) & 0xFFFFFF
                    print('{}, {:06X}'.format(state, ir))
                    # val = (datum >> 0) & 0x1FFFFFFF
                    # busy = (datum >> 29) & 0x1
                    # read_req = (datum >> 30) & 0x1
                    # write_req = (datum >> 31) & 0x1
                    # if val != 0:
                    #     print('{:08X}, {}, {}, {}'.format(val, busy, read_req, write_req))
                    # prog_words = (datum >> 23) & 0xFF
                    # page_words = (datum >> 0) & 0x7F
                    # pages_written = (datum >> 14) & 0xF
                    # pages_to_write = (datum >> 18) & 0x7
                    # pages_to_write_valid = (datum >> 21) & 0x1
                    # flash_data = (datum >> 12) & 0xFF
                    # flash_input_shifter = (datum >> 21) & 0xFF
                    # flash_read_buffer_write = (datum >> 29) & 0x01
                    # flash_empty = (datum >> 20) & 0x01
                    # flash_dq1 = (datum >> 6) & 0x01
                    # flash_dq0 = (datum >> 7) & 0x01
                    # flash_sb = (datum >> 8) & 0x01
                    # flash_c = (datum >> 9) & 0x01
                    # local_write_req = (datum >> 10) & 0x01
                    # local_read_req = (datum >> 11) & 0x01
                    # local_wdata = (datum >> 12) & 0xFFFFF
                    # muxMA_sel = (datum >> 30) & 0x3
                    # if flash_read_buffer_write:
                    # print('{}, {:02X}, {:02X}, {}, {}'.format(state, flash_input_shifter, flash_data,
                    #                                           flash_empty, flash_read_buffer_write))
                    # if local_write_req:
                    #     print('{:05X}'.format(local_wdata))
                    # if not flash_empty:
                    #     print('{:08b}'.format(flash_data))
                    # print(state, prog_words, page_words, pages_written, pages_to_write, pages_to_write_valid)
                    # if state != 1:
                    #     out_of_idle = True
                    # fmt = 'state: {:d}|{:d}{:d}{:d}{:d}'
                    # print(fmt.format(state, flash_c, flash_sb,
                    #                  flash_dq0, flash_dq1))
                print('='*80, cnt)
                cnt += 1
