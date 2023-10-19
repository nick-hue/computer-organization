----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:56:52 03/13/2023 
-- Design Name: 
-- Module Name:    Regi - Behavioral 
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

entity Regi is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           Data : in  STD_LOGIC_VECTOR (31 downto 0);
           WE : in  STD_LOGIC;
           Dout : out  STD_LOGIC_VECTOR (31 downto 0));
end Regi;

architecture Behavioral of Regi is
signal temp : STD_LOGIC_VECTOR(31 downto 0);
begin
		process(clk, Data, WE, rst)
		begin
		if rising_edge(clk) then

			if rst = '1' then 
				temp <= x"0000_0000"; 
			else 
				if WE = '1' then
					temp <= Data;											
				else	
					temp <= temp;	
				end if;
			end if;
		end if;
		end process;
		
		Dout <= temp;
end Behavioral;

