library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY step_curve IS
    PORT(
        clk: IN std_logic;
        
        LE   : OUT std_logic;
        RBI  : OUT std_logic;
        RP1  : OUT std_logic;
        RP2  : OUT std_logic;
        SEB  : OUT std_logic;
        SBI  : OUT std_logic;
        SP1  : OUT std_logic;
        SP2  : OUT std_logic;
        CAL  : OUT std_logic;
        IS1  : OUT std_logic;
        IS2  : OUT std_logic;
        SR   : OUT std_logic;
        CS   : OUT std_logic;
        RES  : OUT std_logic;
        R12  : OUT std_logic
    );
END step_curve;

ARCHITECTURE step_curve_arch OF step_curve IS
SHARED VARIABLE phase: integer := 0;
SHARED VARIABLE counter: integer := 0;
BEGIN
    PROCESS (clk)
    BEGIN
        IF(rising_edge(clk)) THEN
        
        CASE phase IS
            WHEN 0 => --Charge Injection Phase
                LE   <= '0';
                SR   <= '1';
                CS   <= '0';
                RES  <= '0';
                R12  <= '1';
                RBI  <= '0';
                RP1  <= '0';
                RP2  <= '0';
                     
                IS1  <= '1';
                IS2  <= '1';
                     
                SEB  <= '0';
                     
                IF (counter = 0) THEN
                    CAL <= '1';
                    SBI <= '0';
                    SP1 <= '0';
                    SP2 <= '0';
                END IF;
                
                IF (counter = 1) THEN
                    SBI <= '1';
                ELSIF (counter = 2) THEN
                    SBI <= '0';
                END IF;
                
                IF (counter > 1 AND counter < 65) THEN
                    IF (counter MOD 2 = 0) THEN
                        SP1 <= '0';
                        SP2 <= '1';
                    ELSE
                        SP1 <= '1';
                        SP2 <= '0';
                    END IF;
                END IF;
                
                IF (counter = 17) THEN
                    CAL <= '0';
                END IF;
                
                IF (counter = 65) THEN
                    phase := 1;
                    counter := 0;
                ELSE 
                    counter := counter + 1;
                END IF;
             
             WHEN 1 => --Charge arithmetic/loading stage
                 RBI  <= '0';
                 RP1  <= '0';
                 RP2  <= '0';
                 CAL  <= '0';
                 SR   <= '0';
                 CS   <= '0';
                 R12  <= '0';
                 
                 IS1  <= '0';
                 IS2  <= '0';
                 
                 IF (counter = 0) THEN
                     SBI <= '0';
                     SP1 <= '0';
                     SP2 <= '0';
                     SEB <= '1';
                     RES <= '1';
                     LE  <= '1';
                 END IF;
                 
                 IF (counter = 1) THEN
                     SBI <= '1';
                 ELSIF (counter = 4) THEN
                     SBI <= '0';
                 END IF;
                 
                 IF (counter > 0 AND counter < 17) THEN
                     IF(counter MOD 2 = 0) THEN
                         SP1 <= '0';
                         SP2 <= '1';
                     ELSE
                         SP1 <= '1';
                         SP2 <= '0';
                     END IF;
                 END IF;
                 
                 IF (counter = 17) THEN
                     SP2 <= '0';
                     RES <= '0';
                 END IF;
                 
                 IF (counter = 23) THEN
                     SEB <= '0';
                 ELSIF (counter = 24) THEN
                     SEB <= '1';
                 END IF;

                 IF (counter = 29) THEN
                     LE  <= '0';
                 END IF;

                 IF (counter = 30) THEN
                     RES <= '1';
                 END IF;
                 
                 IF (counter > 35 AND counter < 40) THEN
                     IF(counter MOD 2 = 0) THEN
                         SP1 <= '1';
                         SP2 <= '0';
                     ELSE
                         SP1 <= '0';
                         SP2 <= '1';
                     END IF;
                 END IF;
                 IF (counter = 40) THEN
                     SP2 <= '0';
                 END IF;
                 
                 IF (counter = 45) THEN
                     RES <= '0';
                 END IF;

                 IF (counter = 57) THEN
                     SEB <= '0';
                 ELSIF (counter = 58) THEN
                     SEB <= '1';
                 END IF;

                 IF (counter = 60) THEN
                     phase := 2;
                     counter := 0;
                 ELSE
                     counter := counter + 1;
                 END IF;

             WHEN 2 => --Readout stage


                 LE   <= '1';
                 SEB  <= '1';
                 SBI  <= '0';
                 SP1  <= '0';
                 SP2  <= '0';
                 CAL  <= '0';
                 IS1  <= '1'; --Check This!
                 IS2  <= '1'; -- Ditto
                 SR   <= '0';
                 CS   <= '1';
                 RES  <= '0';
                 R12  <= '0';
            
                 IF (counter = 0) THEN
                     RBI <= '1';
                 ELSIF (counter = 2) THEN
                     RBI <= '0';
                 END IF;

                 IF (counter < 258) THEN
                     IF (counter MOD 2 = 0) THEN
                         RP1 <= '1';
                         RP2 <= '0';
                     ELSE
                         RP1 <= '0';
                         RP2 <= '1';
                     END IF;
                     counter := counter + 1;
                 ELSE
                     counter := 0;
                     phase := 0;
                 END IF;
            
            WHEN OTHERS =>
       END CASE;
        
        

            
        END IF; -- clk
    END PROCESS;
END step_curve_arch;
