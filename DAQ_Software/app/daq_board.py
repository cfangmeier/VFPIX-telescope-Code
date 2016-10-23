#!env/bin/python2
# -*- coding: utf-8 -*-
from __future__ import (print_function, absolute_import,
                        division, with_statement)
from enum import IntEnum
import binascii

import ok

from app.utils import bytes_to_ints


class ControlBus(IntEnum):
    RESET = 0x00000001
    PROGRAM = 0x00000002
    LED0 = 0x00000004
    LED1 = 0x00000008
    EXT_LED0 = 0x00000010
    EXT_LED1 = 0x00000020


class WireState(IntEnum):
    ON = 0xFFFFFFFF
    OFF = 0x00000000


class DAQBoard:
    ADDR_CONTROL_WIRE = 0x10
    ADDR_PROGRAM_PIPE = 0xA1
    ADDR_DEBUG_PIPE = 0xB2
    ADDR_AUXIO_OUT = 0xB0
    ADDR_AUXIO_IN = 0xB1

    def __init__(self, firmware_path, serial):
        front_panel = ok.okCFrontPanel()
        self.serial = serial

        self.front_panel = front_panel
        self.firmware_path = firmware_path

    def __enter__(self):
        self.front_panel.OpenBySerial(self.serial)
        if self.firmware_path is not None:
            self._program_device()
        self.welcome()

    def __exit__(self, exc_type, exc_value, traceback):
        self.front_panel.Close()

    def _set_wire_in_value(self, value, mask, update_now=True):
        fp = self.front_panel
        fp.SetWireInValue(self.ADDR_CONTROL_WIRE, value, mask)
        if update_now:
            fp.UpdateWireIns()

    def _get_wire_out_value(self, address):
        fp = self.front_panel
        fp.UpdateWireOuts()
        return fp.GetWireOutValue(address)

    def _get_debug_output(self):
        fp = self.front_panel
        fp.UpdateWireOuts()
        values = []
        for addr in self.DEBUG_OUTPUT_ADDRS:
            single_value = self._get_wire_out_value(addr)
            values.insert(0, '{:016b}'.format(single_value))
        return ''.join(values)

    @staticmethod
    def enumerate_devices():
        front_panel = ok.okCFrontPanel()
        dev_count = front_panel.GetDeviceCount()
        devices = []
        for i in range(dev_count):
            serial = front_panel.GetDeviceListSerial(i)
            devices.append(serial)
        return devices

    def _program_device(self):
        from tempfile import mkdtemp
        from zipfile import ZipFile
        from os.path import join
        from app.config import (FIRMWARE_ARCHIVE_NAME,
                                SOFTWARE_ARCHIVE_NAME)
        tmpdir = mkdtemp()
        fw_zip = ZipFile(self.firmware_path)
        fw_zip.extractall(path=tmpdir)
        firmware = join(tmpdir, FIRMWARE_ARCHIVE_NAME)
        # software = join(tmpdir, SOFTWARE_ARCHIVE_NAME)
        status = self.front_panel.ConfigureFPGA(firmware)
        if status != self.front_panel.NoError:
            fmt = 'Failed to configure FPGA, Error Code: \{}'
            raise RuntimeError(fmt.format(status))
        self.front_panel.ResetFPGA()
        self.soft_reset()
        # self._program_software(software)

    def _program_software(self, binfile):
        fp = self.front_panel
        page_size = 64
        self._set_wire_in_value(WireState.ON, ControlBus.RESET)
        self._set_wire_in_value(WireState.ON, ControlBus.PROGRAM)
        self._set_wire_in_value(WireState.OFF, ControlBus.RESET)

        with open(binfile) as f:
            page = bytearray(page_size*4)
            stop = False
            while not stop:
                for i in range(page_size):
                    word = f.readline().strip()
                    if not word:
                        stop = True
                        break
                    page[i*4+0] = int(word[0:2], 16)
                    page[i*4+1] = int(word[2:4], 16)
                    page[i*4+2] = int(word[4:6], 16)
                    page[i*4+3] = int(word[6:8], 16)
                fp.WriteToBlockPipeIn(self.ADDR_PROGRAM_PIPE,
                                      page_size*4, page)
        self._set_wire_in_value(WireState.OFF, ControlBus.PROGRAM)

    def soft_reset(self):
        self._set_wire_in_value(WireState.ON, ControlBus.RESET)
        self._set_wire_in_value(WireState.OFF, ControlBus.RESET)

    def set_led(self, led, value=WireState.ON):
        self._set_wire_in_value(value, led)

    def _read_pipe_data(self, blocks, verbose, address):
        fp = self.front_panel
        data = bytearray(blocks*512)
        ret_val = fp.ReadFromBlockPipeOut(address, 512, data)
        if ret_val != len(data):
            fmt = 'Error (Code: {}) reading from device'
            raise RuntimeError(fmt.format(ret_val))
        for i in range(blocks*128):
            word = data[i*4:(i+1)*4]
            word.reverse()
            for j in range(4):
                data[i*4+j] = word[j]
        if verbose:
            h = binascii.hexlify(data)
            for i in range(len(h)//4):
                print(h[i*4:i*4+4], end=' ')
                if i % 8 == 7:
                    print()
        return bytes_to_ints(data)

    def read_debug_data(self, blocks=4, verbose=False):
        data = self._read_pipe_data(blocks*512, verbose, self.ADDR_DEBUG_PIPE)
        for i in range(blocks):
            if data[512*(i+1)-1] != 0xFFFFFFFF:
                raise ValueError('Improperly formatted debug output {:08X}'.format(data[512*(i+1)-1]))
            else:
                yield data[512*i:512*(i+1)-1]

    def read_data(self, words=4, verbose=False):
        self._read_pipe_data(words, verbose, self.ADDR_AUXIO_OUT)

    def write_data(self, data):
        raise NotImplementedError
        # self._write_pipe_data(words, verbose, self.ADDR_READBACK_PIPE)

    def welcome(self):
        import time
        for _ in range(6):
            self._set_wire_in_value(WireState.ON, ControlBus.EXT_LED0, False)
            self._set_wire_in_value(WireState.ON, ControlBus.LED0, False)
            self._set_wire_in_value(WireState.OFF, ControlBus.LED1)
            time.sleep(.05)
            self._set_wire_in_value(WireState.OFF, ControlBus.EXT_LED0, False)
            self._set_wire_in_value(WireState.OFF, ControlBus.LED0, False)
            self._set_wire_in_value(WireState.ON, ControlBus.LED1)
            time.sleep(.05)
        self._set_wire_in_value(WireState.OFF, ControlBus.EXT_LED0, False)
        self._set_wire_in_value(WireState.OFF, ControlBus.LED0, False)
        self._set_wire_in_value(WireState.OFF, ControlBus.LED1)
