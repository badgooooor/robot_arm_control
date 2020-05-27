LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY decoder_2to4_tb IS
END decoder_2to4_tb;
 
ARCHITECTURE behavior OF decoder_2to4_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT decoder_2to4
    PORT(
         a : IN  std_logic_vector(1 downto 0);
         b : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal a : std_logic_vector(1 downto 0) := (others => '0');

 	--Outputs
   signal b : std_logic_vector(3 downto 0);

BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: decoder_2to4 PORT MAP (
          a => a,
          b => b
        );

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

		-- insert stimulus here 
		a <= "00";
		wait for 100 ns;
		
		a <= "01";
		wait for 100 ns;
		
		a <= "10";
		wait for 100 ns;
		
		a <= "11";
		wait for 100 ns;
		
      wait;
   end process;

END;
