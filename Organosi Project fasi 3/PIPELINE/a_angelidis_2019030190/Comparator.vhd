----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:57:03 03/13/2023 
-- Design Name: 
-- Module Name:    Comparator - Behavioral 
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

entity Comparator is
    Port ( Awr : in  STD_LOGIC_VECTOR (4 downto 0);
           Ard : in  STD_LOGIC_VECTOR (4 downto 0);
           equal : out  STD_LOGIC);
end Comparator;

architecture Behavioral of Comparator is

begin
	process(Awr , Ard)
	begin
		if Awr = Ard then 
			equal <= '1';
		else 
			equal <= '0';	
		end if;
	end process;
end Behavioral;

