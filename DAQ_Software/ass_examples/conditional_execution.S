        oril $sp $r0 512
        oril $r1 $r0 1  # Initialize registers
        oril $r2 $r0 2
        oril $r4 $r0 55
LABEL1: add $r3 $r1 $r2 # Calculate next term in series
        add $r1 $r0 $r2
        add $r2 $r0 $r3
        spush $r2
        addil $r4 $r4 -1 s
        b(ne) LABEL1  # Branch back to LABEL1
        and $r1 $r0 $r0
        and $r2 $r0 $r0
        and $r3 $r0 $r0
