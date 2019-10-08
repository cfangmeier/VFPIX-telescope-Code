        orih  $r1 $r0 0x0210 # Load address of ADC config registers
        oril  $r1 $r1 0x0100 # Load Specific address of ADC B
        orih  $r7 $r0 0x0230 # Load address of AUX output
# Write 0xAB to user pattern register
#         oril  $r2 $r0 0xAB
#         stw   $r2 $r1 0x19
#         bal UPDATE_ADC
# Configure ADC to output test pattern
        oril  $r2 $r0 0x0044
        stw   $r2 $r1 0x0D
        bal UPDATE_ADC

        orih  $r1 $r0 0x0260 # Load address of ADC data channels
        oril  $r1 $r1 0x0004 # Load Specific address of ADC B

        oril  $r3 $r0 0x1 # load a 1 into r3
        stw   $r3 $r1 0x0 # Write that 1 to the ADC data channel to start sampling
START:  ldw   $r3 $r1 0x0 # read a value from the ADC channel into r3
        stw   $r3 $r7 0   # write the value to the aux output
        b START # loop forever


# Subroutine to write 0x01 to device_update to update ADC registers
# r1 must contain the base address of the ADC to update
UPDATE_ADC: oril  $r2 $r0 0x01
            stw   $r2 $r1 0xFF
            ret
