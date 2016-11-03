        orih  $r1 $r0 0x0250 # Load address of RJ45 LED Controller
        orih  $r3 $r0 0x0230 # Load address of AUX Output
LABEL1: stw   $r2 $r1 0
        stw   $r2 $r3 0
        addil $r2 $r2 1
        bal   DELAY
        b     LABEL1
DELAY: addil  $r4 $r0 1
#       orih   $r5 $r0 0x0002
       oril   $r5 $r0 0x4000
LOOP:  sub    $r5 $r5 $r4 s
       b(ne)  LOOP
       ret
