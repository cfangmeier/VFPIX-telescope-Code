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
    bits_clk = []
    bits_sb = []
    bits_in = []
    bits_out = []

    clk_prev = 0
    for datum in chain(*blocks):
        flash_c = (datum >> 26) & 0x01
        flash_dq1 = (datum >> 23) & 0x01
        flash_dq0 = (datum >> 24) & 0x01
        flash_sb = (datum >> 25) & 0x01
        if flash_c and flash_c != clk_prev:
            bits_clk.append(flash_c)
            bits_sb.append(flash_sb)
            bits_in.append(flash_dq1)
            bits_out.append(flash_dq0)
        clk_prev = flash_c
    print(''.join(str(b) for b in bits_clk))
    print(''.join(str(b) for b in bits_sb))
    print(''.join(str(b) for b in bits_in))
    print(''.join(str(b) for b in bits_out))


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
            # flash_c_last = 0
            cnt = 0
            while True:
                blocks = daq_board.read_debug_data(blocks=10)
                # post_process_flash_data(blocks)
                for datum in chain(*blocks):
                    state = (datum >> 8) & 0x3F
                    # flash_data = (datum >> 14) & 0xFF
                    # flash_empty = (datum >> 22) & 0x01
                    # flash_dq1 = (datum >> 23) & 0x01
                    # flash_dq0 = (datum >> 24) & 0x01
                    # flash_sb = (datum >> 25) & 0x01
                    # flash_c = (datum >> 26) & 0x01
                    # if not flash_empty:
                    #     print('{:08b}'.format(flash_data))
                    if state not in  set([4,5]):
                        print(state)
                    # if state != 1:
                    #     out_of_idle = True
                    # if out_of_idle and flash_c != flash_c_last and not flash_c:
                    # fmt = 'state: {:d}|{:d}{:d}{:d}{:d}'
                    # print(fmt.format(state, flash_c, flash_sb,
                    #                  flash_dq0, flash_dq1))
                    # flash_c_last = flash_c
                cnt += 1
                print('='*80, cnt)
