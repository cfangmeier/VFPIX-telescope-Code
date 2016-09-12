#!env/bin/python2
# -*- coding: utf-8 -*-
from __future__ import (print_function, absolute_import,
                        division, with_statement)
from enum import IntEnum
from Queue import deque
import binascii
import time
import random

import ok
from utils import long_to_bytes
from binascii import unhexlify


class LED(IntEnum):
    LED0 = 0x00000008
    LED1 = 0x00000010
    EXT_LED0 = 0x00000020
    EXT_LED1 = 0x00000040


class WireState(IntEnum):
    ON = 0xFFFFFFFF
    OFF = 0x00000000

class InstructionSet(IntEnum):
    NOOP = 0x00
    WRITE_REG = 0x01
    READ_REG = 0x02
    WRITE_RAM = 0x03
    READ_RAM = 0x04

    @staticmethod
    def _to_bytearray(instr):
        bits = '{:032b}'.format(instr)
        bytes_ = []
        for i in range(4):
            byte = bits[i*8:(i+1)*8]
            bytes_.append(int(byte, 2))
        byte_array = bytearray(bytes_)
        byte_array.reverse()
        # byte_array = bytearray(unhexlify('{:08X}'.format(instr)))
        print(''.join(['{:02X}'.format(b) for b in byte_array]))
        return byte_array

    @staticmethod
    def noop():
        '''
        This is the no-op command. Needed for padding data in input command
        stream.
           FORMAT:
           0000 0XXX XXXX XXXX XXXX XXXX XXXX XXXX
           LSB                                   MSB
        '''
        instruction = 0x00000000
        return InstructionSet._to_bytearray(instruction)

    @staticmethod
    def write_int_reg(reg_addr, reg_data):
        '''
        Write to register. Sets one of the internal registers.
            FORMAT:
            0000 110A AAAD DDDD DDDD DDDD DDDX XXXX
            LSB                                   MSB
            A: 4-bit Register Address
            D: 16-bit Register Data
        '''
        instruction = 0x0C000000
        print('{:032b}'.format(instruction))
        instruction |= (reg_addr << 21)
        print('{:032b}'.format(instruction))
        instruction |= (reg_data << 5)
        print('{:032b}'.format(instruction))
        return InstructionSet._to_bytearray(instruction)

    @staticmethod
    def read_int_reg(reg_addr):
        '''
        Read from register. Reads one of the internal registers, and places
        its data into the readback buffer.
            FORMAT:
            0001 010A AAAX XXXX XXXX XXXX XXXX XXXX
            LSB                                   MSB
            A: 4-bit Register Address
        '''
        instruction = 0x14000000
        instruction |= (reg_addr << 21)
        return InstructionSet._to_bytearray(instruction)


class DAQBoard:
    INSTRUCTION_PIPE_ADDR = 0x80
    READBACK_PIPE_ADDR = 0xA0
    INPUT_WIRE_ADDR = 0x10
    DEBUG_OUTPUT_ADDRS = [0x20, 0x21, 0x22, 0x23]

    DEBUG_LABELS = {
            0: 'instr_empty', 1: 'instr_ack',
            2: 'cu_state[0]', 3: 'cu_state[1]', 4: 'cu_state[2]',
            5: 'cu_instr[0]', 6: 'cu_instr[1]', 7: 'cu_instr[2]', 8: 'cu_instr[3]', 9: 'cu_instr[4]',
            32: 'instr[0]', 33: 'instr[1]', 34: 'instr[2]', 35: 'instr[3]',
            36: 'instr[4]', 37: 'instr[5]', 38: 'instr[6]', 39: 'instr[7]',
            40: 'instr[8]', 41: 'instr[9]', 42: 'instr[10]', 43: 'instr[11]',
            44: 'instr[12]', 45: 'instr[13]', 46: 'instr[14]', 47: 'instr[15]',
            48: 'instr[16]', 49: 'instr[17]', 50: 'instr[18]', 51: 'instr[19]',
            52: 'instr[20]', 53: 'instr[21]', 54: 'instr[22]', 55: 'instr[23]',
            56: 'instr[24]', 57: 'instr[25]', 58: 'instr[26]', 59: 'instr[27]',
            60: 'instr[28]', 61: 'instr[29]', 62: 'instr[30]', 63: 'instr[31]'}

    RESET = 0x00000001
    DEBUG = 0x00000002
    SINGLE_STEP = 0x00000004

    def __init__(self, firmware_path, serial):
        front_panel = ok.okCFrontPanel()
        self.serial = serial

        self.front_panel = front_panel
        self.firmware_path = firmware_path

    def __enter__(self):
        self.front_panel.OpenBySerial(self.serial)
        if self.firmware_path is not None:
            self.program_device(self.firmware_path)

    def __exit__(self, exc_type, exc_value, traceback):
        self.front_panel.Close()

    @staticmethod
    def enumerate_devices():
        front_panel = ok.okCFrontPanel()
        print("Connected Devices:")
        print("==================")
        dev_count = front_panel.GetDeviceCount()
        devices = []
        for i in range(dev_count):
            serial = front_panel.GetDeviceListSerial(i)
            device = (i, serial)
            print("{:02d}:{}".format(*device))
            devices.append(device)
        return devices

    def program_device(self, filename):
        status = self.front_panel.ConfigureFPGA(filename)
        if status == self.front_panel.NoError:
            print("Download Success")
        else:
            print("Download Error: ", status)
        self.front_panel.ResetFPGA()

    def set_wire_in_value(self, value, mask, update_now=True):
        fp = self.front_panel
        fp.SetWireInValue(self.INPUT_WIRE_ADDR, value, mask)
        if update_now:
            fp.UpdateWireIns()

    def get_wire_out_value(self, address):
        fp = self.front_panel
        fp.UpdateWireOuts()
        return fp.GetWireOutValue(address)

    def get_debug_output(self):
        fp = self.front_panel
        fp.UpdateWireOuts()
        values = []
        for addr in self.DEBUG_OUTPUT_ADDRS:
            single_value = self.get_wire_out_value(addr)
            values.insert(0,'{:16b}'.format(single_value))
        return ''.join(values)

    def soft_reset(self):
        self.set_wire_in_value(WireState.ON, self.RESET)
        self.set_wire_in_value(WireState.OFF, self.RESET)

    def set_led(self, led, value=WireState.ON):
        self.set_wire_in_value(value, led)

    def send_command(self, command):
        fp = self.front_panel
        padding = bytearray(12)
        data = command + padding
        ret_val = fp.WriteToPipeIn(self.INSTRUCTION_PIPE_ADDR, data)
        if ret_val < 0:
            print('Error: ', ret_val)

    def read_data(self, words=256):
        fp = self.front_panel
        data = bytearray(words*4)
        ret_val = fp.ReadFromPipeOut(self.READBACK_PIPE_ADDR, data)
        print('Return Value:', ret_val)
        h = binascii.hexlify(data)
        for i in range(len(h)//4):
            print(h[i*4:i*4+4], end=' ')
            if i % 8 == 7:
                print()

    def welcome(self):
        for _ in range(4):
            self.set_wire_in_value(WireState.ON, LED.LED0, False)
            self.set_wire_in_value(WireState.OFF, LED.LED1)
            time.sleep(.05)
            self.set_wire_in_value(WireState.OFF, LED.LED0, False)
            self.set_wire_in_value(WireState.ON, LED.LED1)
            time.sleep(.05)
        self.set_wire_in_value(WireState.OFF, LED.LED0, False)
        self.set_wire_in_value(WireState.OFF, LED.LED1)


    def debug(self):
        self.set_wire_in_value(WireState.ON, self.DEBUG)
        self.soft_reset()
        history = deque([], 80)
        while True:
            cmd = raw_input('>>> ').lower().strip().split()
            cmd, args = cmd[0], cmd[1:]

            if cmd == 'clk':  # clock n cycles
                n = 1 if not args else int(args[0])
                for _ in range(n):
                    self.set_wire_in_value(WireState.ON, self.SINGLE_STEP)
                    self.set_wire_in_value(WireState.OFF, self.SINGLE_STEP)
                    history.append(self.get_debug_output())
            elif cmd == 'list':  # list out debug signals
                print(self.get_debug_output())
            elif cmd == 'wave':  # outputs history waveform
                waves = [[] for _ in range(64)]
                for step in history:
                    for value, wave in zip(reversed(step), waves):
                        wave.append('-' if (value == '1') else '_')
                labels = [self.DEBUG_LABELS.get(i) for i in range(64)]
                waves = [''.join(wave) for wave in waves]
                max_label_len = max(1 if label is None else len(label) for label in labels)
                for label, wave in zip(labels, waves):
                    if label is not None:
                        fmt = '{:>'+str(max_label_len)+'}: {}'
                        print(fmt.format(label, wave))
            elif cmd == 'write':
                if len(args) == 2:
                    write_instr = InstructionSet.write_int_reg(int(args[0], 16), int(args[1], 16))
                    self.send_command(write_instr)
                else:
                    print(('usage: write {addr} {data}\n'
                           '\teg. write 0x01 0xF234'))
            elif cmd == 'read':
                if args:
                    read_instr = InstructionSet.read_int_reg(int(args[0], 16))
                    self.send_command(read_instr)
                else:
                    print('usage: write {addr}\n\teg. read 0x01')
            elif cmd == 'bufread':
                bytes_ = 256 if not args else int(args[0])
                self.read_data(bytes_)
            elif cmd in ('quit', 'exit'):
                break
            else:
                print('command unknown')
        self.set_wire_in_value(WireState.OFF, self.DEBUG)


def main():
    firmware_path = ("/home/caleb/Sources/Telescope_Project/"
                     "VFPIX-telescope-Code/DAQ_Firmware/"
                     "output_files/daq_firmware.rbf")
    _, serial = DAQBoard.enumerate_devices()[0]
    daq_board = DAQBoard(firmware_path, serial)
    with daq_board:
        daq_board.soft_reset()
        daq_board.welcome()
        daq_board.debug()
        # for i in range(10):
        #     try:
        #         daq_board.send_command(write_instr)
        #         for i in range(50):
        #             daq_board.send_command(read_instr)
        #         daq_board.read_data(words=16)
        #         time.sleep(.1)
        #     except KeyboardInterrupt:
        #         break
            # daq_board.send_command(bytearray([0x0C, 0x18, i, 0x60]))
            # daq_board.send_command(bytearray([0x14, 0x18, 0x00, 0x60]))
        # daq_board.read_data(words=16)

if __name__ == '__main__':
    main()
