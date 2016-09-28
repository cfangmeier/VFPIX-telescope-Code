# This example shows how to use the stack-push and stack-pop commands

# First we need to set the stack pointer to point to memory location 128
# The stack grows from higher memory locations to lower ones.
        oril $sp $r0 512
#Now let's load up some data into registers that we push onto the stack
        orih $r2 $r0 0xDEAD
        oril $r2 $r2 0xBEEF
#Now Push the contents of $r2 onto the stack and repeat 4 times
        spush $r2
        spush $r2
        spush $r2
        spush $r2
# Now Pop the contents of the stack into registers $r3-$r6
        spop $r3
        spop $r4
        spop $r5
        spop $r6
