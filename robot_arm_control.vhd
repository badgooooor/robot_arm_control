library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity robot_arm_control is
    Port ( cmd : in  STD_LOGIC_VECTOR (1 downto 0);
           pos : in  STD_LOGIC_VECTOR (6 downto 0);
           clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           servo_1 : out  STD_LOGIC;
           servo_2 : out  STD_LOGIC;
           servo_3 : out  STD_LOGIC);
end robot_arm_control;

architecture Behavioral of robot_arm_control is
	component decoder_2to4
		Port (
			a : in  STD_LOGIC_VECTOR (1 downto 0) := "00";
         b : out  STD_LOGIC_VECTOR (3 downto 0)
		);
	end component;
	
	component shift_reg
		Port (
			d : in  STD_LOGIC_VECTOR (6 downto 0);
         clk : in  STD_LOGIC;
         clear : in  STD_LOGIC;
         trig : in  STD_LOGIC;
         q : out  STD_LOGIC_VECTOR (6 downto 0)
		);
	end component;
	
	component servo_control
		Port (
			clk 	: in  STD_LOGIC;
			reset : in  STD_LOGIC;
			pos 	: in  STD_LOGIC_VECTOR (6 downto 0);
			servo : out  STD_LOGIC
		);
	end component;
	
	signal decoded_cmd : STD_LOGIC_VECTOR (3 downto 0);
	
	signal servo1_pos : STD_LOGIC_VECTOR (6 downto 0);
	signal servo2_pos : STD_LOGIC_VECTOR (6 downto 0);
	signal servo3_pos : STD_LOGIC_VECTOR (6 downto 0);
begin
	command_decoder: decoder_2to4 
		PORT MAP(cmd, decoded_cmd);

	register_servo_1: shift_reg 
		PORT MAP(pos, clk, reset, decoded_cmd(1), servo1_pos);
	register_servo_2: shift_reg 
		PORT MAP(pos, clk, reset, decoded_cmd(2), servo2_pos);
	register_servo_3: shift_reg 
		PORT MAP(pos, clk, reset, decoded_cmd(3), servo3_pos);
	
	servo_1_controller: servo_control 
		PORT MAP(clk, reset, servo1_pos, servo_1);
	servo_2_controller: servo_control 
		PORT MAP(clk, reset, servo2_pos, servo_2);
	servo_3_controller: servo_control 
		PORT MAP(clk, reset, servo3_pos, servo_3);
end Behavioral;


