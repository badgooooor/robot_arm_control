LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY shift_reg_tb IS
END shift_reg_tb;
 
ARCHITECTURE behavior OF shift_reg_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT shift_reg
    PORT(
         d : IN  std_logic_vector(6 downto 0);
         clk : IN  std_logic;
         clear : IN  std_logic;
         trig : IN  std_logic;
         q : OUT  std_logic_vector(6 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal d : std_logic_vector(6 downto 0) := (others => '0');
   signal clk : std_logic := '0';
   signal clear : std_logic := '0';
   signal trig : std_logic := '0';

 	--Outputs
   signal q : std_logic_vector(6 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: shift_reg PORT MAP (
          d => d,
          clk => clk,
          clear => clear,
          trig => trig,
          q => q
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
		d <= "0000000";
		
      -- insert stimulus here 
		d <= "0000001";			-- Changed value & trigger shifting
		trig <= '1';				-- Expected q changed
      wait for 100 ns;
		
		d <= "0000010";			-- Changed value & trigger still HIGH
		wait for 100 ns;			-- Expected q unchanged
		
		trig <= '0';				-- Trigger LOW & input changed
		d <= "0000011";			-- Expected q unchanged
		wait for 100 ns;
		
		clear <= '1';				-- Clear HIGH
		wait for 100 ns;			-- Expected q = 0
		
		clear <= '0';
		wait for 100 ns;
		wait;
   end process;

END;
