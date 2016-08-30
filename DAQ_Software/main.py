#!env/bin/python2
# -*- coding: utf-8 -*-
from __future__ import (print_function, absolute_import,
                        division, with_statement)
# from time import sleep
import binascii
import time
import random

import ok


class DAQBoard:

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

    def send_command(self, command):
        padding = bytearray(1020)  # check to make this smaller
        data = command + padding
        ret_val = self.front_panel.WriteToPipeIn(0x80, data)
        print(ret_val)

    def test(self):
        # data buffer in Python (mutable type bytearray) must be initialized
        # upon declaration
        dataout = bytearray(1024)
        for i in range(len(dataout)):
            dataout[i] = i % 256
            # dataout[i] = 1
        datain = bytearray(2048)

        # Send brief reset signal to initialize the FIFO.
        self.front_panel.SetWireInValue(0x10, 0xff, 0x01)
        self.front_panel.UpdateWireIns()
        self.front_panel.SetWireInValue(0x10, 0x00, 0x01)
        self.front_panel.UpdateWireIns()

        # Send buffer to PipeIn endpoint with address 0x80
        self.front_panel.WriteToPipeIn(0x80, dataout)
        # Read to buffer from PipeOut endpoint with address 0xA0
        self.front_panel.ReadFromPipeOut(0xA0, datain)
        h = binascii.hexlify(datain)
        for i in range(len(h)//4):
            print(h[i*4:i*4+4], end=' ')
            if i % 8 == 7:
                print()


    def test2(rndm=True):
        for i in range(0x100):
            time.sleep(.05)
            addr = 0
            if rndm:
                val = random.randint(0, 0xFF)
            else:
                val = i
            FP.WriteRegister(addr, val)


def main():
    firmware_path = ("/home/caleb/Sources/Telescope_Project/"
                     "VFPIX-telescope-Code/DAQ_Firmware/"
                     "output_files/daq_firmware.rbf")
    _, serial = DAQBoard.enumerate_devices()[0]
    daq_board = DAQBoard(firmware_path, serial)
    with daq_board:
        daq_board.send_command(bytearray([0x0C, 0x18, 0x00, 0x60]))

if __name__ == '__main__':
    main()
