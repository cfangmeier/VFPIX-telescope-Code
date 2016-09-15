#!env/bin/python
from app.daq_board import DAQBoard
from config import FIRMWARE_PATH
import click


def execute_tests():
    from unittest.runner import TextTestRunner
    from tests.hw_tests import suite as hw_suite
    runner = TextTestRunner(verbosity=2)
    runner.run(hw_suite())


@click.command()
@click.option('--run-tests', default=False, is_flag = True, help='Run test suite')
def main(run_tests):
    print('hello world')
    if run_tests:
        execute_tests()
    else:
        pass
    # _, serial = DAQBoard.enumerate_devices()[0]
    # daq_board = DAQBoard(FIRMWARE_PATH, serial)
    # with daq_board:
    #     daq_board.soft_reset()
    #     daq_board.welcome()
        # daq_board.debug()
        # adc = InstructionSet.ADC.B
        # addrs = [0x00, 0x01, 0x02, 0x05, 0x08, 0x09,
        #          0x0D, 0x14, 0x15, 0x16, 0x19, 0x1A, 
        #          0x1B, 0x1C, 0x21, 0x22]
        # for i in addrs:
        #     read_instr = InstructionSet.read_adc_reg(adc, i)
        #     daq_board.send_command(read_instr)
        # data = daq_board.read_data(words=len(addrs))
        # for addr, val in zip(addrs, data):
        #     print('0x{:02X}: {:08b}'.format(addr, val))

        # dac = InstructionSet.DAC.APC_REFERENCE
        # instructions = []
        # for i in range(2**10):
        #     instructions.append(InstructionSet.write_dac_reg(dac, 0xF, i))
        # while True:
        #         daq_board.send_commands(instructions)

if __name__ == '__main__':
    main()
