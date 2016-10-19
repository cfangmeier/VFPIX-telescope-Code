        orih  $r1 $r0 0x9800 # Load address of AUX IO
LABEL1: stw   $r2 $r1 0
        addil $r2 $r2 1
        b     LABEL1
