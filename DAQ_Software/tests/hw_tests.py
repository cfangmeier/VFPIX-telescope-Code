import unittest
from app.daq_board import DAQBoard, InstructionSet
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


class ADCRegisterTest(unittest.TestCase):

    def __init__(self, method, adc):
        super(ADCRegisterTest, self).__init__(method)
        self.adc = adc

    def setUp(self):
        connected_devices = DAQBoard.enumerate_devices()
        self.db = DAQBoard(FIRMWARE_PATH, connected_devices[0])
        # self.write_instr = InstructionSet.write_adc_reg(adc, 0xEF)

    def test_write_reg(self):
        db = self.db
        with self.db:
            db.send_command(self.write_instr)

    def test_read_chip_id(self):
        db = self.db
        # adcs = list(InstructionSet.ADC)
        cmd = InstructionSet.read_adc_reg
        with self.db:
            # for adc in adcs:
            read_chip_id = cmd(self.adc, 0x01)
            db.send_command(read_chip_id)
            data = db.read_data(words=4)
            assert(len(data) == 4)
            assert(data[0] == 0x03)
            assert(all(d == 0 for d in data[1:]))

    def test_readback_reg(self):
        db = self.db
        with self.db:
            db.send_command(self.write_instr)
            db.send_command(self.read_instr)
            data = db.read_data(words=4)
            assert(data[0] == 0xBEEF)
            assert(all(d == 0 for d in data[1:]))


def suite():
    s = unittest.TestSuite()
    at = s.addTest
    # at(DAQConnectivity('test_device_connected'))
    # at(DAQConnectivity('test_can_program'))
    # at(InternalRegisterTest('test_write_reg'))
    # at(InternalRegisterTest('test_read_reg'))
    # at(InternalRegisterTest('test_readback_reg'))
    for adc in InstructionSet.ADC:
        at(ADCRegisterTest('test_read_chip_id', (adc,)))
    # at(ADC_SPI_Test('test_write_pattern'))
    return s
