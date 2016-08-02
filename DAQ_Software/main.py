#!env/bin/python2
# -*- coding: utf-8 -*-
from __future__ import (print_function, absolute_import,
                        division, with_statement)
# from time import sleep
import binascii

import ok

FP = None


def enumerate_devices():
    print("Connected Devices:")
    print("==================")
    dev_count = FP.GetDeviceCount()
    devices = []
    for i in range(dev_count):
        serial = FP.GetDeviceListSerial(i)
        device = (i, serial)
        print("{:02d}:{}".format(*device))
        devices.append(device)
    print('-'*80)
    return devices


def program_device(filename):
    status = FP.ConfigureFPGA(filename)
    if status == FP.NoError:
        print("Download Success")
    else:
        print("Download Error: ", status)
    FP.ResetFPGA()


def test():
    # data buffer in Python (mutable type bytearray) must be initialized
    # upon declaration
    dataout = bytearray(1024)
    for i in range(len(dataout)):
        dataout[i] = i % 256
        # dataout[i] = 1
    datain = bytearray(2048)

    # Send brief reset signal to initialize the FIFO.
    FP.SetWireInValue(0x10, 0xff, 0x01)
    FP.UpdateWireIns()
    FP.SetWireInValue(0x10, 0x00, 0x01)
    FP.UpdateWireIns()

    # Send buffer to PipeIn endpoint with address 0x80
    FP.WriteToPipeIn(0x80, dataout)
    # Read to buffer from PipeOut endpoint with address 0xA0
    FP.ReadFromPipeOut(0xA0, datain)
    h = binascii.hexlify(datain)
    for i in range(len(h)//4):
        print(h[i*4:i*4+4], end=' ')
        if i % 8 == 7:
            print()


def main():
    global FP
    FP = ok.okCFrontPanel()
    devs = enumerate_devices()
    if len(devs) == 0:
        return

    serial = FP.GetDeviceListSerial(0)
    if FP.IsOpen():
        FP.Close()
    FP.OpenBySerial(serial)
    filename = ("/home/caleb/Sources/Telescope_Project/VFPIX-telescope-Code/"
                "DAQ_Firmware/output_files/daq_firmware.rbf")
    program_device(filename)
    test()
    FP.Close()

if __name__ == '__main__':
    main()
