from __future__ import division
from binascii import unhexlify


def long_to_bytes(val, endianness='big'):
    """
    Use :ref:`string formatting` and :func:`~binascii.unhexlify` to
    convert ``val``, a :func:`long`, to a byte :func:`str`.

    :param long val: The value to pack

    :param str endianness: The endianness of the result. ``'big'`` for
      big-endian, ``'little'`` for little-endian.

    If you want byte- and word-ordering to differ, you're on your own.

    Using :ref:`string formatting` lets us use Python's C innards.
    """

    # one (1) hex digit per four (4) bits
    width = val.bit_length()

    # unhexlify wants an even multiple of eight (8) bits, but we don't
    # want more digits than we need (hence the ternary-ish 'or')
    width += 8 - ((width % 8) or 8)

    # format width specifier: four (4) bits per hex digit
    fmt = '%%0%dx' % (width // 4)

    # prepend zero (0) to the width, to zero-pad the output
    s = unhexlify(fmt % val)

    if endianness == 'little':
        # see http://stackoverflow.com/a/931095/309233
        s = s[::-1]

    return s


def hex2bytes(hex_string):
    hex_string = hex_string.strip()
    if (len(hex_string) % 2) != 0:
        raise ValueError('Non-even length hex string')
    n_bytes = len(hex_string) // 2
    bs = bytearray(n_bytes)
    for i in range(n_bytes):
        bs[i] = int(hex_string[i*2:(i+1)*2], 16)
    return bs


def bytes2ints(byte_array):
    n = len(byte_array) // 4
    ints = []
    for i in range(n):
        int_ = byte_array[i*4]
        int_ = (int_ << 8) | byte_array[i*4+1]
        int_ = (int_ << 8) | byte_array[i*4+2]
        int_ = (int_ << 8) | byte_array[i*4+3]
        ints.append(int_)
    return ints


def decode_ok_error(error_code):
    from ok import FrontPanel
    errs = []
    for attr in dir(FrontPanel):
        if getattr(FrontPanel, attr, None) == error_code:
            errs.append(attr)
            return attr
    if errs:
        return ', '.join(errs)
    else:
        return 'unknown'


class bcolors:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'
