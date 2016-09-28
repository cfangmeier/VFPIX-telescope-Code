        oril $r1 $r0 1  # Initialize registers
        oril $r2 $r0 2
LABEL1: add $r3 $r1 $r2 # Calculate next term in series
        add $r1 $r0 $r2
        add $r2 $r0 $r3
        b LABEL1  # Branch back to LABEL1
