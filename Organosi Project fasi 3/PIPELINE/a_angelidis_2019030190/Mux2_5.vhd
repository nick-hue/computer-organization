----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:35:16 03/23/2023 
-- Design Name: 
-- Module Name:    Mux2_5 - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Mux2_5 is
    Port ( din1 : in  STD_LOGIC_VECTOR (4 downto 0);
           din2 : in  STD_LOGIC_VECTOR (4 downto 0);
           sel : in  STD_LOGIC;
           dout : out  STD_LOGIC_VECTOR (4 downto 0));
end Mux2_5;

architecture Behavioral of Mux2_5 is

begin
	process(din1, din2, sel)
	begin
		case sel is
			when '0' => dout <= din1;
			when others => dout <= din2;
		end case;
	end process;
end Behavioral;

