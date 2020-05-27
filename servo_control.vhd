library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity servo_control is
	Port ( 
		clk 	: in  STD_LOGIC;
		reset : in  STD_LOGIC;
      pos 	: in  STD_LOGIC_VECTOR (6 downto 0);
      servo : out  STD_LOGIC
	);
end servo_control;

architecture Behavioral of servo_control is
	component clk_64kHz
		Port (
			clk     : in STD_LOGIC;
			reset   : in STD_LOGIC;
			clk_out : out STD_LOGIC
		);
	end component;
	
	component servo_pwm
		Port (	
			clk		: in STD_LOGIC;
			reset		: in STD_LOGIC;
			pos		: in STD_LOGIC_VECTOR (6 downto 0);
			servo		: OUT STD_LOGIC
		);
	end component;
	
	signal clk_out : STD_LOGIC := '0';
begin
	clk_64kHz_map: clk_64kHz PORT MAP(clk, reset, clk_out);

	servo_pwm_map: servo_pwm PORT MAP(clk_out, reset, pos, servo);
end Behavioral;

