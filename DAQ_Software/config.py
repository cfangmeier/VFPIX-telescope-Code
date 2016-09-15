from os.path import abspath, dirname, split, join

soft_basedir = abspath(dirname(__file__))
firm_basedir = join(split(soft_basedir)[0], 'DAQ_Firmware/')

FIRMWARE_PATH = join(firm_basedir, 'output_files/daq_firmware.rbf')
