        orih  $r1 $r0 0x0230 # Load address of RJ45 LED Controller
LABEL1: stw   $r2 $r1 0
        addil $r2 $r2 1
        bal   DELAY
        b     LABEL1
DELAY: addil  $r4 $r0 1
       addil  $r5 $r0 2
LOOP:  sub    $r5 $r5 $r4 s
       b(ne)  LOOP
       ret
