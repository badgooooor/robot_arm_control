LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY servo_pwm_tb IS
END servo_pwm_tb;
 
ARCHITECTURE behavior OF servo_pwm_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT servo_pwm
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         pos : IN  std_logic_vector(6 downto 0);
         servo : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal pos : std_logic_vector(6 downto 0) := (others => '0');

 	--Outputs
   signal servo : std_logic;

   -- Clock period definitions
   constant clk_period : time := 15625 ns;	-- Mock from received clk [64kHz]
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: servo_pwm PORT MAP (
          clk => clk,
          reset => reset,
          pos => pos,
          servo => servo
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      reset <= '1';
		wait for 50 ns;
		reset <= '0';
		wait for 50 ns;

      -- insert stimulus here 
		pos <= "0000000";			-- position : 0
      wait for 20 ms;
      pos <= "0101000";			-- position : 40
      wait for 20 ms;
      pos <= "1010000";			-- position : 80
      wait for 20 ms;
      pos <= "1111000";			-- position : 120
      wait for 20 ms;
      pos <= "1111111";			-- position : 127
		
		-- set back to default value;
		wait for 20 ms;
		pos <= "0000000";
      wait;
   end process;

END;
