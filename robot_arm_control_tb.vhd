LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY robot_arm_control_tb IS
END robot_arm_control_tb;
 
ARCHITECTURE behavior OF robot_arm_control_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT robot_arm_control
    PORT(
         cmd : IN  std_logic_vector(1 downto 0);
         pos : IN  std_logic_vector(6 downto 0);
         clk : IN  std_logic;
         reset : IN  std_logic;
         servo_1 : OUT  std_logic;
         servo_2 : OUT  std_logic;
         servo_3 : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal cmd : std_logic_vector(1 downto 0) := (others => '0');
   signal pos : std_logic_vector(6 downto 0) := (others => '0');
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';

 	--Outputs
   signal servo_1 : std_logic;
   signal servo_2 : std_logic;
   signal servo_3 : std_logic;

   -- Clock period definitions
   constant clk_period : time := 50 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: robot_arm_control PORT MAP (
          cmd => cmd,
          pos => pos,
          clk => clk,
          reset => reset,
          servo_1 => servo_1,
          servo_2 => servo_2,
          servo_3 => servo_3
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
		
		reset <= '1';					-- enable servo
		wait for 100 ns;
		reset <= '0';
		
      -- insert stimulus here 
		pos <= "0101000";				-- Assign servo 1
		cmd <= "01";
		wait for 20 ms;
		
		pos <= "1010000";				-- Assign servo 2
		cmd <= "10";
		wait for 20 ms;
		
		pos <= "1111000";				-- Assign servo 3
		cmd <= "11";
		wait for 20 ms;
		wait;
   end process;

END;
