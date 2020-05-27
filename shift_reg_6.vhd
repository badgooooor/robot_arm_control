library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity shift_reg is
    Port ( d : in  STD_LOGIC_VECTOR (6 downto 0);
           clk : in  STD_LOGIC;
           clear : in  STD_LOGIC;
           trig : in  STD_LOGIC;
           q : out  STD_LOGIC_VECTOR (6 downto 0));
end shift_reg;

architecture Behavioral of shift_reg is

begin
	process (clk, trig, clear) begin
		if (rising_edge(clk) and (trig = '1')) then
			q <= d;
		elsif (rising_edge(clear)) then
			q <= "0000000";
		end if;
	end process;

end Behavioral;

