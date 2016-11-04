        orih  $r1 $r0 0x0210 # Load address of ADCs
        oril  $r1 $r1 0x0100 # Load Specific address of ADC B
        orih  $r7 $r0 0x0230 # Load address of AUX output
        addil $r3 $r0 256
# Write 0xAB to user pattern register
        oril  $r2 $r0 0xAB
        stw   $r2 $r1 0x19
# Write 0x01 to device_update to update ADC registers
        oril  $r2 $r0 0x01
        stw   $r2 $r1 0xFF

START:  add   $r2 $r0 $r0
LOOP:   add   $r4 $r1 $r2
        ldw   $r5 $r4 0
        stw   $r5 $r7 0
        addil $r2 $r2 1
        sub   $r0 $r2 $r3 s
        b(ne) LOOP
        b     START
