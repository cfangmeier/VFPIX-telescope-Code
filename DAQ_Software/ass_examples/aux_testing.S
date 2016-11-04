# Load address of Output buffer usage and pipe
        orih  $r1 $r0 0x0230
LOOP:   ldw   $r2 $r1 0x2     # Read number of words used in buffer
        stw   $r2 $r1 0       # Write usage into the pipe
        b     LOOP
