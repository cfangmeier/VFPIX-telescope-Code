import unittest
from app.daq_board import DAQBoard
from config import FIRMWARE_PATH


class DAQConnectivity(unittest.TestCase):

    def test_device_connected(self):
        connected_devices = DAQBoard.enumerate_devices()
        assert(len(connected_devices) > 0)

    def test_can_program(self):
        connected_devices = DAQBoard.enumerate_devices()
        db = DAQBoard(FIRMWARE_PATH, connected_devices[0])
        with db:
            pass


class InternalRegisterTest(unittest.TestCase):

    def setUp(self):
        from app.daq_board import InstructionSet
        connected_devices = DAQBoard.enumerate_devices()
        self.db = DAQBoard(FIRMWARE_PATH, connected_devices[0])
        self.read_instr = InstructionSet.read_int_reg(0x01)
        self.write_instr = InstructionSet.write_int_reg(0x01, 0xBEEF)

    def test_write_reg(self):
        db = self.db
        with self.db:
            db.send_command(self.write_instr)

    def test_read_reg(self):
        db = self.db
        with self.db:
            db.send_command(self.read_instr)
            data = db.read_data(words=4)
            assert(len(data) == 4)
            assert(all(d == 0 for d in data))

    def test_readback_reg(self):
        db = self.db
        with self.db:
            db.send_command(self.write_instr)
            db.send_command(self.read_instr)
            data = db.read_data(words=4)
            assert(data[0] == 0xBEEF)
            assert(all(d == 0 for d in data[1:]))

class ADCSPITest(unittest.TestCase):
    def setUp(self):
        print('setting up test.')

    def tearDown(self):
        print('tearing down test.')

    def test_board_can_connect(self):
        pass

    def test_read_id(self):
        pass

    def test_write_pattern(self):
        pass


def suite():
    s = unittest.TestSuite()
    at = s.addTest
    at(DAQConnectivity('test_device_connected'))
    at(DAQConnectivity('test_can_program'))
    at(InternalRegisterTest('test_write_reg'))
    at(InternalRegisterTest('test_read_reg'))
    at(InternalRegisterTest('test_readback_reg'))
    # at(ADC_SPI_Test('test_read_id'))
    # at(ADC_SPI_Test('test_write_pattern'))
    return s
