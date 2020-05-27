library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity decoder_2to4 is
    Port ( a : in  STD_LOGIC_VECTOR (1 downto 0);
           b : out  STD_LOGIC_VECTOR (3 downto 0));
end decoder_2to4;

architecture Behavioral of decoder_2to4 is

begin
	b(0) <= not a(0) and not a(1);
	b(1) <= a(0) and not a(1);
	b(2) <= not a(0) and a(1);
	b(3) <= a(0) and a(1);

end Behavioral;

