#!env/bin/python
from app.daq_board import DAQBoard
from app.config import FIRMWARE_PATH
import click


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
            out_of_idle = False
            while True:
                blocks = daq_board.read_debug_data(blocks=4)
                for block in blocks:
                    for datum in block:
                        state = (datum >> 8) & 0xFF
                        if state != 1:
                            out_of_idle = True
                        if out_of_idle:
                            print('state: {:d}'.format(state))
                    print('='*80)
