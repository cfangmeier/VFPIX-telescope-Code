from os.path import abspath, dirname, split, join

soft_basedir = split(abspath(dirname(__file__)))[0]
firm_basedir = join(split(soft_basedir)[0], 'DAQ_Firmware/')

SOFTWARE_ARCHIVE_NAME = 'code.hex'
FIRMWARE_ARCHIVE_NAME = 'fpga.rbf'

FIRMWARE_PATH = join(soft_basedir, 'firmware.zip')
