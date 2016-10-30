#!env/bin/python2
# -*- coding: utf-8 -*-
from __future__ import (print_function, absolute_import,
                        division, with_statement)
from enum import IntEnum
import binascii

import ok

from app.utils import (bytes2ints, hex2bytes,
                       decode_ok_error)


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
    ADDR_PROGRAM_PIPE = 0x9C
    ADDR_DEBUG_BASE = 0xB0
    ADDR_DEBUG_SIZE = 2
    ADDR_AUXIO_OUT = 0x80
    ADDR_AUXIO_IN = 0xA0

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
        software = join(tmpdir, SOFTWARE_ARCHIVE_NAME)
        status = self.front_panel.ConfigureFPGA(firmware)
        if status != self.front_panel.NoError:
            fmt = 'Failed to configure FPGA, Error Code: \{}'
            raise RuntimeError(fmt.format(status))
        self.front_panel.ResetFPGA()
        self.soft_reset()
        self._program_software(software)

    def _program_software(self, binfile):
        fp = self.front_panel
        page_size = 64
        self._set_wire_in_value(WireState.ON, ControlBus.RESET)
        self._set_wire_in_value(WireState.ON, ControlBus.PROGRAM)
        self._set_wire_in_value(WireState.OFF, ControlBus.RESET)

        with open(binfile) as f:
            page = bytearray(page_size*4)
            instructions = f.readlines()
            num_pages = bytes2ints(hex2bytes(instructions[0]))[0]
            for pn in range(num_pages):
                page_hex = instructions[pn*page_size:(pn+1)*page_size]
                for i, word_hex in enumerate(page_hex):
                    word = hex2bytes(word_hex)
                    page[i*4+0] = word[3]
                    page[i*4+1] = word[2]
                    page[i*4+2] = word[1]
                    page[i*4+3] = word[0]
                ret = fp.WriteToBlockPipeIn(self.ADDR_PROGRAM_PIPE,
                                            page_size*4, page)
                if ret != page_size*4:
                    fmt = ('Unable to write to programming buffer, '
                           'error code: {}, {}')
                    error = decode_ok_error(ret)
                    raise RuntimeError(fmt.format(ret, error))
        self._set_wire_in_value(WireState.OFF, ControlBus.PROGRAM)

    def soft_reset(self):
        self._set_wire_in_value(WireState.ON, ControlBus.RESET)
        self._set_wire_in_value(WireState.OFF, ControlBus.RESET)

    def set_led(self, led, value=WireState.ON):
        self._set_wire_in_value(value, led)

    def _read_pipe_data(self, blocks, verbose, address, block_size=1024):
        fp = self.front_panel
        data = bytearray(blocks*block_size*4)
        ret_val = fp.ReadFromBlockPipeOut(address, block_size*4, data)
        if ret_val != len(data):
            fmt = ('Unable to read from device, '
                   'error code: {}, {}')
            error = decode_ok_error(ret_val)
            raise RuntimeError(fmt.format(ret_val, error))
        for i in range(blocks*block_size):
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
        return bytes2ints(data)

    def read_debug_data(self, verbose=False):
        data = []
        for i in range(self.ADDR_DEBUG_SIZE):
            channel_address = self.ADDR_DEBUG_BASE+i
            channel = self._read_pipe_data(1, verbose, channel_address,
                                           block_size=1024)
            if channel[-1] != 0xFFFFFFFF:
                fmt = 'Improperly formatted debug output {:08X}'
                raise ValueError(fmt.format(channel[-1]))
            else:
                data.append(channel[:-1])
        for channels in zip(*data):
            val = 0
            for x in channels:
                val = (val << 32) | x
            yield val

    def read_data(self, words=4, verbose=False):
        self._read_pipe_data(words, verbose, self.ADDR_AUXIO_IN)

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
